import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';

class CreativityBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>Creativitycontroller());
  }

}