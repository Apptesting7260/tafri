
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:plusone/networking/firebase_api.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/message/chats/modal/all_group_modal.dart';
import 'package:plusone/uis/message/chats/modal/all_message_modal.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxService {


  // String baseUrl = 'https://21qkztxl-8000.inc1.devtunnels.ms/';
  String baseUrl = 'http://188.245.228.111:8000';

  late IO.Socket socket;

  final ProfilemainController profileController =
      Get.put(ProfilemainController());

  @override
  void onInit() async {
    super.onInit();
    await connectSocket();

    socket.on('disconnect', (handler) {
      log('socket disconnected $handler');
      pageStatus(pageStatus: false);
    });
    socket.on('connect_error', (handler) {
      log('socket error $handler');
    });
    socket.on('reconnect_attempt', (handler) {
      ('socket reconnect $handler');
    });
    socket.on('reconnect_failed', (handler) {
      log('socket reconnect failed$handler');
    });

    socket.on('refreshPage', (data) {
      log('refresh == ${data}');
      fetchGroup();
    },);

    // fetchGroup();

  }

  @override
  void onClose() {
    socket.close();
    socket.disconnect();
    super.onClose();
  }

  void pageStatus({bool? pageStatus}){
    socket.emit('samePageMessageStatusUpdate',{
      'onPageStatus': pageStatus,
      'userid': int.parse(userID),
    });
  }

  /// socket connection
  Future<void> connectSocket() async {
    socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build());

    socket.connect();
    socket.onConnect((_) async{
      log('socket connected');

      await profileController.viewProfile();

      socket.emit('joinuser', {
        'userid':
        int.parse(profileController.profileData.value.result!.id.toString())
      });
      socket.emit('GetUserData', {
        'id':
        int.parse(profileController.profileData.value.result!.id.toString()),
        'first_name':
        profileController.profileData.value.result!.firstName.toString(),
        'last_name':
        profileController.profileData.value.result!.lastName.toString(),
        'profile_photo': profileController
            .profileData.value.result!.profile?.profilePhoto
            .toString(),
        'fcmToken': FirebaseApi.fcmToken
      });
      fetchGroup();

    });

    log("Connecting socket id ", name: "Socket type");
  }
  /// socket connection



  /// create group
  var groupLoading = false.obs;
  void createGroup(
      {required String groupName,
      required int creatorID,
      required String des,
      required String image,
      required List<int> admin,
      required int actID}) async {
    log('group creating');
    groupLoading.value = true;
    try {
      socket.emit('createGroup', {
        'groupName': groupName,
        'createdBy': creatorID,
        'discription': des,
        'members': [],
        'admin': admin,
        'groupImage': image,
        'activityId': actID,
      });
      socket.on(
        'createGroup',
        (data) {
          log('group data == ${data}');
        },
      );
      log('group created');
    } catch (e) {
      print('group error == ${e.toString()}');
    }
    groupLoading.value = false;
  }
  /// create group


  RefreshController chatRefreshController = RefreshController(initialRefresh: false);
  String userID = LocalStorage.getUid().toString();

  /// fetch all group
  var allGroup = AllGroupModal().obs;
  var gpLoading = false.obs;
  void fetchGroup(){
    log('fetching group');
    gpLoading.value = true;
    log('st == ${DateTime.now()}');
    log('user id == ${userID}');
    try{
      socket.emit('fatchAllFriendsList',{
        'userId': int.parse(userID)
      });
      socket.on('fatchAllFriendsList', (data){
        allGroup.value = AllGroupModal.fromJson(data);
        log('all group data == ${data}');
        socket.off('fatchAllFriendsList');
        gpLoading.value = false;
        log('et == ${DateTime.now()}');
      });
      // if(gpLoading.value = true){
      //   Future.delayed(Duration(seconds: 10),() => allGroup.value = AllGroupModal());
      // }
    }catch(e){
      log('fetch group error == ${e.toString()}');
    }
  }
  /// fetch all group



  /// add member
  void addMember({required String groupID,required List<int> members,required int hostID,String? gpImage,String? gpName}){
    log('adding member');
    log('group id == ${groupID}');
    log('st == ${DateTime.now()}');
    try{
      socket.emit('addnewMemeberOfGropup',{
        'groupId': groupID,
        'members': members,
        'creator': hostID,
      });
      socket.on('addnewMemeberOfGropup', (data) {
        log('add member == ${data.runtimeType}');
        if(data['status'] == true){
          Get.toNamed(Routes.chatUi,arguments: {
            'gpImage': gpImage,
            'gpName': gpName,
            'gpID': data['groupId'],
          });
        }else if(data['status'] == false){
          Get.toNamed(Routes.chatUi,arguments: {
            'gpImage': gpImage,
            'gpName': gpName,
            'gpID': data['groupId'],
          });
        }
        // if(response[''])
        socket.off('addnewMemeberOfGropup');
        log('et == ${DateTime.now()}');
      },);
    }catch(e){
      log('add member error == ${e.toString()}');
    }
  }
  /// add member





}
