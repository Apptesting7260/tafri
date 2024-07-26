import 'package:get/get.dart';
import '../controller/referfrnd_controller.dart';

class ReferFrndBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ReferFrndController());
  }

}