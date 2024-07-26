import 'package:get/get.dart';
import 'package:plusone/uis/message/chats/controller/chat_controller.dart';

class PoSupportChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ChatController());
  }
}