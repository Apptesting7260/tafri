import 'package:get/get.dart';
import 'package:plusone/uis/message/viewnotification/controller/viewnotifi_controller.dart';

class ViewnotifiBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ViewNotifiController());
  }
}