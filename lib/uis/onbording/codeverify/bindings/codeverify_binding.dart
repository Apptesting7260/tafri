import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/onbording/codeverify/controller/codeverify_controller.dart';

class CodeverifyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>CodeverifyController());
  }

}