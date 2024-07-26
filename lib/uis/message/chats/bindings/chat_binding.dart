import 'package:get/get.dart';
import 'package:plusone/uis/message/chats/controller/chat_controller.dart';

class ChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ChatController());
  }

}