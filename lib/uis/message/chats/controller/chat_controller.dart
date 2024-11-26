import 'dart:developer';

import 'package:get/get.dart';
import 'package:plusone/networking/firebase_api.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ChatController extends GetxController{

  // String baseUrl = 'https://21qkztxl-8000.inc1.devtunnels.ms/';
  String baseUrl = 'http://188.245.228.111:8000';
  late IO.Socket socket;
  
  final ProfilemainController profileController = Get.put(ProfilemainController());
  
  @override
  void onInit() async{
    super.onInit();
    await connectSocket();

    socket.on('disconnect', (handler) {
      log('socket disconnected $handler');
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
  }

  @override
  void onClose() {
    socket.close();
    socket.disconnect();
    super.onClose();
  }



  Future<void> connectSocket() async {
    log("connecting socket");
    socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build());

    socket.connect();

    await profileController.viewProfile();

    socket.emit('joinuser', {
      'userid': int.parse(profileController.profileData.value.result!.id.toString())
    });
    socket.emit('GetUserData',{
      'id': int.parse(profileController.profileData.value.result!.id.toString()),
      'first_name': profileController.profileData.value.result!.firstName.toString(),
      'last_name': profileController.profileData.value.result!.lastName.toString(),
      'profile_photo': profileController.profileData.value.result!.profile?.profilePhoto.toString(),
      'fcmToken': FirebaseApi.fcmToken
    });
    log("connected ${socket.connected}");
    log("Connecting socket id ", name: "Socket type");

  }



}