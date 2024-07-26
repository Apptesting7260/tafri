import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/youractivities/hostactivity_upcomming/controller/host_upcomiacti_controller.dart';

class HostUpcommiActiBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(()=>HostUpcomiActiController());
  }

}