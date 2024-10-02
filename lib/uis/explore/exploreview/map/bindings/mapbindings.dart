import 'package:get/get.dart';
import 'package:plusone/uis/explore/exploreview/map/controller/mapcontroller.dart';

class MapExploreBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut(()=>MapExploreController());
  }

}