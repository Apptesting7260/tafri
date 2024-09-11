import 'package:get/get.dart';
import 'package:plusone/uis/myactivity/repeatactivity/controller/repeatactivity_contoller.dart';


class RepeatcreativityBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>Repeatcreativitycontroller());
  }

}