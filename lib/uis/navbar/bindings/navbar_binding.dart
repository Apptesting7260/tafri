import 'package:get/get.dart';
import 'package:plusone/uis/navbar/controller/navbar_controller.dart';

class NavbarBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>NavBarController());
  }

}