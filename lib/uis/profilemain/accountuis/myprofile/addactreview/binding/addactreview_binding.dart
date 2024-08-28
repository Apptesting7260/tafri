import 'package:get/get.dart';
import '../controller/addactreview_controller.dart';

class AddactreviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>AddactreviewController());
  }

}