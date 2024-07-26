import 'package:get/get.dart';

class NavBarController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  RxInt navIndex=0.obs;
  changeNavIndex(index){
    navIndex.value=index;
    update();
  }

}