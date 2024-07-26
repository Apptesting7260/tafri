import 'package:get/get.dart';
import 'package:plusone/uis/membership/plans/controller/plan_controller.dart';

class PlanBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>PlanController());
  }

}