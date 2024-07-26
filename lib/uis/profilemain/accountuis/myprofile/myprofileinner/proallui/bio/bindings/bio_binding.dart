import 'package:get/get.dart';
import '../controller/bio_controller.dart';

class BioBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>BioController());
  }

}