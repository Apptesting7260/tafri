import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/myactivity/myactivitylist/controller/myacti_controller.dart';

class MyactBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>MyactiController());
  }

}