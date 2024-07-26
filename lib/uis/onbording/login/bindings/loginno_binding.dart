import 'package:get/get.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';

import '../controller/loginno_controller.dart';

class LoginnoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>LoginnoController());
  }

}