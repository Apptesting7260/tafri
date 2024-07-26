import 'package:get/get.dart';
import '../controller/VerifySocialMe_controller.dart';

class VerifySocMedBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>VerifySocialMeController());
  }

}