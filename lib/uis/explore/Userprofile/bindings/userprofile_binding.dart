import 'package:get/get.dart';
import 'package:plusone/uis/explore/Userprofile/controller/userprofile_controller.dart';

class UserProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>UserProfileController());
  }

}