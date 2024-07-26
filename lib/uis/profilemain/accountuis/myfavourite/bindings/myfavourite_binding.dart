import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/myfavourite/controller/myfavourite_controller.dart';

class MyfavouriteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>MyfavouriteController());
  }

}