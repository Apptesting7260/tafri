import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/restart%20membership/restart_membership_controller.dart';

class ReStartBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ReStartMembershipController(),);
  }
}