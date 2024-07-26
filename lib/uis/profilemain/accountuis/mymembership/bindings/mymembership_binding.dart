import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/controller/mymembership_controller.dart';

class MymembershipBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>MymembershipController());
  }

}