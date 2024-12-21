import 'package:get/get.dart';
import 'package:plusone/uis/message/posupportchat/controller/posupportchat_controller.dart';

class PoSupportChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>PoSupportChatController());
  }
}