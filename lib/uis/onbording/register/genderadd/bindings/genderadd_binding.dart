import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/onbording/register/genderadd/controller/genderadd_controller.dart';

class GenderaddBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>GenderaddController());
  }

}