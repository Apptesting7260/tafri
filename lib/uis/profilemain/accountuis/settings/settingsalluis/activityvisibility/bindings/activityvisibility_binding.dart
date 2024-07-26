import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/activityvisibility/controller/activityvisibility_controller.dart';

class ActivityvisibilityBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ActivityvisibilityController());
  }

}