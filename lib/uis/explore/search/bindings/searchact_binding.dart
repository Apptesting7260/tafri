import 'package:get/get.dart';
import 'package:plusone/uis/explore/search/controller/searchact_controller.dart';

class SearchActBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>SearchActController());
  }

}