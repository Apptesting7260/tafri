import 'package:get/get.dart';
import '../controller/myprofileinn_controller.dart';

class MyprofileInnbinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>MyprofileInnController());
  }

}