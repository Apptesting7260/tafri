import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/switchplan/controller/switchplan_controller.dart';

class SwitchplanBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>SwitchplanController());
  }
}