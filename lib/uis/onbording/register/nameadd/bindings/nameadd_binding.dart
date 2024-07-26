import 'package:get/get.dart';
import 'package:plusone/uis/onbording/register/nameadd/controller/nameadd_controller.dart';

class NameaddBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>NameAddController());
  }

}