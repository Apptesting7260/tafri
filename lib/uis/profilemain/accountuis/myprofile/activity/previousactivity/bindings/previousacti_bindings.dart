import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/activity/previousactivity/controller/previousacti_controller.dart';

class PreviousActiBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>PreviousActiController());
  }
}