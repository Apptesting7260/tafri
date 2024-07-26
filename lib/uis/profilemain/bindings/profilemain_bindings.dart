import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';

class ProfilemainBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ProfilemainController());
  }

}