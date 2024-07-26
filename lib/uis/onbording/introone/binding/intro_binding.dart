import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/onbording/introone/controller/intro_controller.dart';

class IntroBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>IntroController());
  }

}