import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:plusone/uis/message/posupportchat/modal/support_modal.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:plusone/utils/tostmsg.dart';

class PoSupportChatController extends GetxController{


  @override
  void onInit() {
    super.onInit();
    var id = Get.arguments;
    gpID.value = id;
    if(gpID.value.isNotEmpty) {
      fetchMsg(groupID: gpID.value, page: pageNo.value, limit: limit.value);
    }
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        pagination();
      }
    },);
    if(gpID.value.isNotEmpty) {
      pageStatus(true);
    }

    sc.socket.on('support-receive-message', (data) {
      log('recieve == ${data}');
      supportMsg.value.message?[0].data?.removeWhere((e) => e.id == '0');
      supportMsg.value.message?[0].data?.insert(0, Message.fromJson(data));
      if(gpID.value.isEmpty) {
        gpID.value = data['friendsAndConversationId'];
        pageStatus(true);
      }
      supportMsg.refresh();
    },);

  }

  @override
  void onClose() {
    super.onClose();
    if(gpID.value.isNotEmpty) {
      pageStatus(false);
    }
    sc.socket.off('support-receive-message');
    sc.socket.off('fetchAllSupportMessage');
  }

  final SocketController sc = Get.find<SocketController>();
  ScrollController scrollController = ScrollController();
  var msgController = TextEditingController();
  var focusNode = FocusNode();
  final api = ApiServices();
  var userId = LocalStorage.getUid().toString();
  var gpID = ''.obs;


  /// fetch support message
  
  var supportMsg = SupportMessage().obs;
  var loading = false.obs;
  var pageNo = 1.obs;
  var limit = 15.obs;
  var lastID = ''.obs;
  
  void fetchMsg({required String groupID,required int page,required int limit}){
    try{
      if (page == 1) {
        loading.value = true;
      }
      sc.socket.emit('fetchAllSupportMessage', {
        "chatGroupId": groupID,
        "seenUserId": userId,
        if(lastID.value.isEmpty)"page": page,
        "limit": limit,
        'lastMessageId': lastID.value.isEmpty ? null : lastID.value
      });
      log('page == ${page}');
      sc.socket.on('fetchAllSupportMessage', (data) {
          log('support all data == ${data}');
          log('page == ${page}');
          var fetchedData = SupportMessage.fromJson(data);
          if (page == 1) {
            log('first page');
            supportMsg.value = fetchedData;
            loading.value = false;
            if (pageNo.value == fetchedData.totalPages ||
                pageNo.value > fetchedData.totalPages!) {
              log('Stop pagination == ${fetchedData.totalPages} == ${fetchedData.message!.length}');
              stopPagination.value = true;
            }
            lastID.value = supportMsg.value.message!.last.data!.last.id!;
            print('last msg id == ${supportMsg.value.message?.last.data?.last.id}');
          } else {
            log('else');
            for (var newData in fetchedData.message!) {
              log('new data == ${newData.name}    ${newData.data}');
              var exist = supportMsg.value.message?.firstWhere(
                  (group) => group.name == newData.name,
                  orElse: () => MessageElement(name: '', data: []));
              log('exist == ${exist?.data}   ${exist?.name}');
              if (exist!.name!.isNotEmpty) {
                exist.data?.addAll(newData.data!);
              } else {
                supportMsg.value.message?.add(newData);
              }
            }

            lastID.value = supportMsg.value.message!.last.data!.last.id!;

            if (pageNo.value == fetchedData.totalPages ||
                pageNo.value > fetchedData.totalPages!) {
              log('Stop pagination == ${fetchedData.totalPages} == ${fetchedData.message!.length}');
              stopPagination.value = true;
            }

            supportMsg.refresh();
            paginationLoading.value = false;
          }
        },
      );
      Future.delayed(
        const Duration(seconds: 10),
        () => loading.value = false,
      );
    }catch(e){
      log('error == ${e.toString()}');
    }
  }
  
  /// fetch support message


  /// pagination
  var stopPagination = false.obs;
  var paginationLoading = false.obs;
  void pagination(){
    if(!stopPagination.value && !paginationLoading.value) {
      sc.socket.off('fetchAllSupportMessage');
      paginationLoading.value = true;
      pageNo.value++;
      log('===== ${pageNo.value}');
      fetchMsg(
        groupID: gpID.value,
        page: pageNo.value,
        limit: limit.value,
        // members: int.parse(members.value.toString())
      );
    }
  }
  /// pagination


  ///send message
  final selectedImages = <File>[].obs;
  final ImagePicker picker = ImagePicker();

  imagePopUp(BuildContext context){
    showCupertinoModalPopup(context: context, builder: (context){
      return
        CupertinoActionSheet(actions: [CupertinoActionSheetAction(onPressed: () async{
          final XFile? image = await picker.pickMedia();
          if(image != null){
            int sizeInBytes = File(image.path).lengthSync();

            double sizeInMb = sizeInBytes / (1024 * 1024);
            if (sizeInMb > 50) {
              showTostMsg('Size cannot be greater than 50 Mb');
            } else {
              selectedImages.add(File(image.path));
              print('image == ${selectedImages}');
            }
            Get.back();
          }
        }, child: Center(
          child: Text('Select from library',style: TextStyle(
              fontSize: 18,
              color: clrBlacke,
              fontWeight: FontWeight.w500
          ),),
        )),CupertinoActionSheetAction(onPressed: () async{
          final XFile? image = await picker.pickImage(source: ImageSource.camera);
          if(image != null){
            int sizeInBytes = File(image.path).lengthSync();

            double sizeInMb = sizeInBytes / (1024 * 1024);
            if (sizeInMb > 50) {
              showTostMsg('Size cannot be greater than 50 Mb');
            } else {
              selectedImages.add(File(image.path));
              print('image == ${selectedImages}');
            }
            Get.back();
          }
        }, child: Center(
          child: Text('Take a photo',style: TextStyle(
              fontSize: 18,
              color: clrBlacke,
              fontWeight: FontWeight.w500
          ),),
        ))],cancelButton: CupertinoActionSheetAction(onPressed: () {
          Get.back();
        },child: Center(
          child: Text('Cancel',style: TextStyle(
              color: clrBlacke,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),),
        ),));
    });
  }

  Future<void> sendImage({String? message,File? file}) async{
    try{
      final url = Uri.parse('${EndPoints.chatUrl}/message-create-support');
      var request = http.MultipartRequest('POST', url);
      request.fields['sender_id'] = userId.toString();
      request.fields['reciever_id'] = '0';
      request.fields['message[textmessage]'] = message.toString();

      if(file != null){
        var fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
        var length = await file.length();
        var multipartFile = http.MultipartFile(
          'file',
          fileStream,
          length,
          filename: file.path.split('/').last,
        );
        request.files.add(multipartFile);
      }


      if(supportMsg.value.message == null) {
        print('here');
        supportMsg.value.message = [MessageElement(
            name: 'Today',
            data: []
        )];
        if(file != null){
          var dataMsg = Message(
            loading: true,
            message: MessageData(
                file: file.path,
                textmessage: message
            ),
            username: sc.profileController.profileData.value.result?.firstName ??
                '',
            createdAt: DateTime.now(),
            messageStatus: '',
            senderId: int.parse(userId),
            id: '0',
          );
          supportMsg.value.message?[0].data?.insert(0, dataMsg);
          supportMsg.refresh();
        }
      }else if(file != null){
        print('else su');
        var dataMsg = Message(
          loading: true,
          message: MessageData(
              file: file.path,
              textmessage: message
          ),
          username: sc.profileController.profileData.value.result?.firstName ??
              '',
          createdAt: DateTime.now(),
          messageStatus: '',
          senderId: int.parse(userId),
          id: '0',
        );
        supportMsg.value.message?[0].data?.insert(0, dataMsg);
        supportMsg.refresh();
      }



      selectedImages.clear();
      msgController.clear();

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      log('send image response == ${responseBody.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('image uploaded');
      }else{
        showTostMsg('Failed to upload');
        supportMsg.value.message?[0].data?.removeWhere((e) => e.id == '0',);
        supportMsg.refresh();
      }
    }catch(e){
      showTostMsg('Failed to upload');
      supportMsg.value.message?[0].data?.removeWhere((e) => e.id == '0',);
      supportMsg.refresh();
      print('send image error == ${e.toString()}');
    }
  }
  
  void sendMsg({required String message}){
    sc.socket.emit('createMessageAdmin',{
      'sender_id': userId,
      'reciever_id': '0',
      'message': {
        'textmessage': message
      }
    });
    if(supportMsg.value.message == null) {
      print('here');
      supportMsg.value.message = [MessageElement(
        name: 'Today',
        data: []
      )];
      var dataMsg = Message(
        username: sc.profileController.profileData.value.result?.firstName ??
            '',
        createdAt: DateTime.now(),
        friendsAndConversationId: gpID.value,
        message: MessageData(
          textmessage: message,
        ),
        messageStatus: '',
        senderId: int.parse(userId),
        loading: true,
        id: '0',
      );
      msgController.clear();
      supportMsg.value.message?[0].data?.insert(0, dataMsg);
      supportMsg.refresh();
    }else{
      var dataMsg = Message(
        username: sc.profileController.profileData.value.result?.firstName ??
            '',
        createdAt: DateTime.now(),
        friendsAndConversationId: gpID.value,
        message: MessageData(
          textmessage: message,
        ),
        messageStatus: '',
        senderId: int.parse(userId),
        loading: true,
        id: '0',
      );
      msgController.clear();
      supportMsg.value.message?[0].data?.insert(0, dataMsg);
      supportMsg.refresh();
    }
  }
  
  ///send message



  void pageStatus(bool status){
    sc.socket.emit('supportPageStatusUpdate',{
    "id": gpID.value,
    "onPageStatus": status,
    "userid": userId
    });
  }


}