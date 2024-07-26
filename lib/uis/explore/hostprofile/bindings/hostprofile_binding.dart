import 'package:get/get.dart';
import 'package:plusone/uis/explore/hostprofile/controller/hostprofile_controller.dart';

class HostProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>HostProfileController());
  }

}