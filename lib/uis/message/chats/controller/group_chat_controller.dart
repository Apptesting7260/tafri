import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:plusone/uis/message/chats/modal/all_message_modal.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:plusone/utils/tostmsg.dart';

class GroupChatController extends GetxController{

  final SocketController sc = Get.find<SocketController>();

  final StreamController<List<Data>> _stream = StreamController.broadcast();
  Stream<List<Data>> get streamResponse => _stream.stream;

  ScrollController scrollController = ScrollController();

  final focusNode = FocusNode();


  @override
  void onInit() {
    super.onInit();
    var gpData = Get.arguments;
    gpID.value = gpData['gpID'] ?? '';
    fetchMessage(
        groupID: gpID.value,
        userId: int.parse(userID),
        page: pageNo.value,
        limit: limit.value,
        // members: int.parse(members.value.toString())
    );
    _stream.stream.listen((event) {
      log('data from stream == ${event}');
    },);
    sc.socket.on('group-receive-message', (data) {
      log('message data == ${data}');

      // allMessage.value.data!.removeWhere((test) => test.id == '0');
      // allMessage.value.data?.insert(0, Data.fromJson(data));

      // if(allMessage.value.message!.isNotEmpty) {
        allMessage.value.message?[0].data?.removeWhere((e) => e.id == '0');
      // }
      allMessage.value.message?[0].data?.insert(0, Data.fromJson(data));
      allMessage.refresh();
    },);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        pagination();
      }
    },);

    sc.socket.on('SeenAboveMsg', (data) {
      log(' === ${data}');
      // allMessage.value.data?.forEach((e) {
      //   e.messageStatus = 'seen';
      // },);
      allMessage.value.message?.forEach((e) {
        e.data?.forEach((f){
          f.messageStatus = 'seen';
        },);
      },);
      allMessage.refresh();
    },);

    sc.socket.on('singelMessageDelete', (data) {
      log('delete data == ${data}');
      allMessage.value.message?.forEach((e) {
        e.data?.removeWhere((f) => f.id.toString() == data['messageid'],);
        allMessage.refresh();
      },);
    },);


    pageStatus(pageStatus: true);

  }

  @override
  void onClose() {
    super.onClose();
    _stream.close();
    pageStatus(pageStatus: false);
    sc.socket.off('group-receive-message');
    sc.socket.off('SeenAboveMsg');
    pageNo.value = 1;
  }


  var gpID = ''.obs;
  var userID = LocalStorage.getUid().toString();
  TextEditingController msgController = TextEditingController();
  var pageNo = 1.obs;
  var limit = 35.obs;

  /// fetch messages
  var allMessage = AllMessageModal().obs;
  // List<Data> msgList = [];
  var msgLoading = false.obs;
  void fetchMessage({required String groupID,required int userId,required int page,required int limit}){
    log('fetching msg');

    if(page == 1) {
      msgLoading.value = true;
    }
    sc.socket.emit('fatchAllMessage',{
      'chatGroupId': groupID,
      'seenUserId': userId,
      'page': page,
      'limit': limit,
      // 'members': members
    });
    sc.socket.on('fatchAllMessage', (data) {
      log('page no == ${page}');
      log('msg == ${data}');
      var fetchedData = AllMessageModal.fromJson(data);
      if(page == 1) {
        log('first page');
        allMessage.value = fetchedData;
        msgLoading.value = false;
      } else {
        for (var newData in fetchedData.message!) {
          var exist = allMessage.value.message?.firstWhere(
                (group) => group.name == newData.name,
              orElse: () => MessageElement(name: '', data: [])
          );
          if (exist!.name!.isNotEmpty) {
            exist.data?.addAll(newData.data!);
          } else {
            allMessage.value.message?.add(newData);
          }
        }

        if (pageNo.value == fetchedData.totalPages || pageNo.value > fetchedData.totalPages!) {
          log('Stop pagination == ${fetchedData.totalPages} == ${fetchedData.message!.length}');
          stopPagination.value = true;
        }

        allMessage.refresh();
        paginationLoading.value = false;
      }
      // else{
      //   log('page == ${page}');
      //   var msg = AllMessageModal.fromJson(data);
      //   // allMessage.value.data?.addAll(msg.data!);
      //   // allMessage.value.message?.addAll(msg.message!);
      //   allMessage.value.message?.forEach((e) {
      //     msg.message?.forEach((f) {
      //       if(e.name == f.name){
      //         e.data?.addAll(f.data!);
      //       }
      //     },);
      //   },);
      //   if(pageNo.value == msg.totalPages || msg.message!.length < 15){
      //     log('stop pagination');
      //     stopPagination.value = true;
      //   }
      //   allMessage.refresh();
      //   paginationLoading.value = false;
      // }
    },);
    Future.delayed(const Duration(seconds: 10),() => msgLoading.value = false,);
  }
  /// fetch messages


  /// send message
  void sendMsg({String? message}){
    try{
      log('sending msg');
      sc.socket.emit('createMessage',{
        'sender_id': int.parse(userID),
        'message': {
          'textmessage': message,
        },
        'chatGroupId': gpID.value,
      });

      var dataMsg = Data(
        username: sc.profileController.profileData.value.result?.firstName ?? '',
        createdAt: DateTime.now(),
        chatGroupId: gpID.value,
        message: Message(
          textmessage: message,
        ),
        messageStatus: '',
        senderId: int.parse(userID),
        loading: true,
        id: '0',
      );
      print('ms == ${dataMsg}');
      allMessage.value.message?[0].data?.insert(0, dataMsg);
      allMessage.refresh();
      msgController.clear();
    }catch(e){
      log('send msg error == ${e.toString()}');
    }
  }
  /// send message



  /// send image and video

  final selectedImages = <File>[].obs;

  Future<void> openGallery() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
      allowCompression: true,
      compressionQuality: 100,
    );

    if (res != null) {
      for (var element in res.files) {
        if (element.path != null) {
          int sizeInBytes = File(element.path!).lengthSync();

          double sizeInMb = sizeInBytes / (1024 * 1024);
          if (sizeInMb > 50) {
            showTostMsg('Size cannot be greater than 50 Mb');
          } else {
            selectedImages.add(File(element.path!));
          }
        }
      }
    }
    log('image == ${selectedImages}');
  }


  Future<void> sendImage({String? message,File? file}) async{
    try{
      final url = Uri.parse('${EndPoints.chatUrl}/message-create');
      var request = http.MultipartRequest('POST', url);
      request.fields['sender_id'] = userID.toString();
      request.fields['chatGroupId'] = gpID.value;
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

      if(file != null){
        var dataMsg = Data(
          username: sc.profileController.profileData.value.result?.firstName ?? '',
          createdAt: DateTime.now(),
          chatGroupId: gpID.value,
          message: Message(
            file: file.path,
            textmessage: message,
          ),
          messageStatus: '',
          senderId: int.parse(userID),
          loading: true,
          id: '0',
        );
        // allMessage.value.data?.insert(0, dataMsg);
        allMessage.value.message?[0].data?.insert(0, dataMsg);
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
        // allMessage.value.data!.removeWhere((test) => test.id == '0');
        allMessage.value.message?[0].data?.removeWhere((e) => e.id == '0',);
        allMessage.refresh();
      }
    }catch(e){
      showTostMsg('Failed to upload');
      // allMessage.value.data!.removeWhere((test) => test.id == '0');
      allMessage.value.message?[0].data?.removeWhere((e) => e.id == '0',);
      allMessage.refresh();
      print('send image error == ${e.toString()}');
    }
  }
  /// send image and video



  /// page status
  void pageStatus({bool? pageStatus}){
    sc.socket.emit('samePageMessageStatusUpdate',{
      'onPageStatus': pageStatus,
      'userid': int.parse(userID),
      'chatGroupId': gpID.value,
    });
  }
  /// page status


  /// pagination
  var stopPagination = false.obs;
  var paginationLoading = false.obs;
  void pagination(){
    if(!stopPagination.value && !paginationLoading.value) {
      sc.socket.off('fatchAllMessage');
      paginationLoading.value = true;
      pageNo.value++;
      log('===== ${pageNo.value}');
      fetchMessage(groupID: gpID.value,
          userId: int.parse(userID),
          page: pageNo.value,
          limit: limit.value,
          // members: int.parse(members.value.toString())
      );
    }
  }
  /// pagination


  /// delete message
  void deleteMessage({required String msgId}){
    sc.socket.emit('singelMessageDelete',{
      'messageid': msgId,
    });
  }
  /// delete message

  deletePopUp(BuildContext context,String msgId){
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete, color: clrRed),
                title: Text('Delete'),
                onTap: () {
                  Get.back();
                  focusNode.unfocus();
                  deleteMessage(msgId: msgId);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.cancel, color: clrYellow),
                title: Text('Cancel'),
                onTap: () {
                  Get.back();
                  focusNode.unfocus();
                },
              ),

            ],
          ),
        );
      },
    );
  }


}