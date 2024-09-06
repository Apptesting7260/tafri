import 'package:get/get.dart';
import 'package:plusone/uis/explore/filter/filteractivity/controller/filteractivity_controller.dart';

class FilterActBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>FilterActController());
  }

}