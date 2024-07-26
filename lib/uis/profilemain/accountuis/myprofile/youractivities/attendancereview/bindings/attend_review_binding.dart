import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/youractivities/attendancereview/controller/attend_review_controller.dart';

class AttendReviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>AttendReviewController());
  }

}