import 'package:get/get.dart';
import '../controller/activinterest_controller.dart';

class ActivinterestBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ActivinterestController());
  }

}