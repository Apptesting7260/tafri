import 'package:get/get.dart';
import 'package:plusone/uis/myactivity/upcommingactivity/controller/upcommingactiuser_controller.dart';

class UpCommingActiUserBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>UpCommingActiUserController());
  }
}