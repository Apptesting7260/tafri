
import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/activity/attendlist/controller/attendlist_controller.dart';

class AttendlistBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>AttendlistController());
  }

}