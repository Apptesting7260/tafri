import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/explore/map/controller/mapactivity_controller.dart';

class MapActivityBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>MapActivityController());
  }

}