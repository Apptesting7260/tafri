import 'package:get/get.dart';
import 'package:plusone/uis/message/chats/controller/group_chat_controller.dart';

class ChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>GroupChatController());
  }

}