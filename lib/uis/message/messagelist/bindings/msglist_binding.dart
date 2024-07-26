import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/message/messagelist/controller/messagelist_controller.dart';

class MsglistBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>MessagelistController());
  }

}