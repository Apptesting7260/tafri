import 'package:get/get.dart';
import '../controller/exploreview_controller.dart';

class ExploreViewBindings extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut(()=>ExploreViewController());
  }

}