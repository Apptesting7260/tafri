import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/onbording/register/regemail/controller/regemail_controller.dart';

class RegemailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>RegemailController());
  }

}