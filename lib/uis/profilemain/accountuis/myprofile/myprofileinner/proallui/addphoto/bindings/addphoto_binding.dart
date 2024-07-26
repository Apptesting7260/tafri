import 'package:get/get.dart';
import '../controller/addphoto_controller.dart';

class AddphotoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>AddphotoController());
  }

}