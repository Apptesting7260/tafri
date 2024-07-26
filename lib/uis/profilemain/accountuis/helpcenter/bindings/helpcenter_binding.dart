import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/helpcenter/controller/helpcenter_controller.dart';

class HelpcenterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>HelpcenterController());
  }

}