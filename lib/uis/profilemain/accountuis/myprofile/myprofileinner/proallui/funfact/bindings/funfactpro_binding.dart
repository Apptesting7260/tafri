import 'package:get/get.dart';
import '../controller/funfactpro_controller.dart';

class FunFactProBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>FunFactProController());
  }

}