import 'package:get/get.dart';
import '../controller/languagepro_controller.dart';

class LanguageproBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>LanguageproController());
  }

}