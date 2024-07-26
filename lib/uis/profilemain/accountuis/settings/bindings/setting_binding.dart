import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/controller/setting_controller.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>SettingController());
  }

}