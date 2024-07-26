import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/onbording/register/reg_locdobui/controller/reglocdob_controller.dart';

class ReglocdobBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ReglocdobController());
  }

}