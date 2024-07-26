import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/pushnotification/controller/pushnotisetting_controller.dart';

class PushnotifisettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>PushnotisettingController());
  }

}