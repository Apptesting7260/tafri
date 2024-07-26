import 'package:get/get.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';

class ExploreListBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ExploreListController());
  }

}