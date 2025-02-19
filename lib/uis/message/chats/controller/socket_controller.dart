
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/networking/firebase_api.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/message/chats/modal/all_group_modal.dart';
import 'package:plusone/uis/message/chats/modal/all_message_modal.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxService {

  late IO.Socket socket;

  final ProfilemainController profileController =
      Get.put(ProfilemainController());

  TextEditingController searchController = TextEditingController();
  final focusNode = FocusNode();

  var filteredGroups = <Friend>[].obs;
  void filterGroups({String? search}) {
    final query = search?.toLowerCase();
    if (query!.isEmpty) {
      filteredGroups.assignAll(allGroup.value.friend ?? []);
    } else {
      filteredGroups.assignAll(
        allGroup.value.friend?.where((group) {
          return group.groupName?.toLowerCase().contains(query) ?? false;
        }).toList() ?? [],
      );
    }
    log('filtered group == ${filteredGroups}');
  }

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
    socket.disconnect();
    socket.close();
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
        EndPoints.chatUrl,
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
        print('all group data == ${data}');
        socket.off('fatchAllFriendsList');
        filteredGroups.assignAll(allGroup.value.friend ?? []);
        gpLoading.value = false;
        unreadMsg();
        log('et == ${DateTime.now()}');

        socket.off('fatchAllFriendsList');

      });
      // if(gpLoading.value = true){
      //   Future.delayed(Duration(seconds: 10),() => allGroup.value = AllGroupModal());
      // }
    }catch(e){
      log('fetch group error == ${e.toString()}');
    }
  }


  var unReadMsg = 0.obs;
  void unreadMsg() async{
    print('here');
    var count = 0.obs;

    if(allGroup.value.support != null) {
      if (allGroup.value.support!.friendUnSeenMessage! > 0) {
        count.value += allGroup.value.support!.friendUnSeenMessage ?? 0;
      }
    }

    for (var i in allGroup.value.friend!) {
      count.value += i.groupUnSennMessage ?? 0;
    }

    unReadMsg.value = count.value;
    print('unread count == ${count.value}');

    // for(var i in allGroup.value.friend!){
    //   if(i.groupUnSennMessage! > 0){
    //     print('unread');
    //     unReadMsg.value = true;
    //   }else{
    //     print('read');
    //
    //   }
    // }

  }


  /// fetch all group



  /// add member
  void addMember({required String groupID,required List<int> members,required int hostID,required String actId,bool? fromHost}){
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
        bool fH = fromHost ?? false;
        log('from host == ${fH}');
        if(fH != true) {
          if (data['status'] == true) {
            Get.toNamed(Routes.chatUi, arguments: {
              'gpID': data['groupId'],
              'activityId': actId,
              'hostId': hostID.toString()
            });
          } else if (data['status'] == false) {
            Get.toNamed(Routes.chatUi, arguments: {
              'gpID': data['groupId'],
              'activityId': actId,
              'hostId': hostID.toString()
            });
          }
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


  
  /// leave group///
  void leaveGroup({required String gpID,required String memberId}){
    socket.emit('removeMemeberOfGropup',{
      'groupId': gpID,
      'membersId': memberId,
    });
  }
  /// leave group///


  /// delete user
  bool deleteUser(){
    socket.emit('delete-user-account',{
      'userId': int.parse(LocalStorage.getUid().toString())
    });
    socket.on('delete-user-account', (data) {
      print('delete account data   ${data}');
      return true;
    },);
    return false;
  }
  /// delete user


}
