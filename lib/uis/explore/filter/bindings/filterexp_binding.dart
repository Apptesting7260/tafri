import 'package:get/get.dart';
import 'package:plusone/uis/explore/filter/controller/filterexp_controller.dart';

class FilterExpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>FilterExpController());
  }

}