import 'package:get/get.dart';

class NavBarController extends GetxController{

  RxInt navIndex=0.obs;
  changeNavIndex(index){
    navIndex.value=index;
    update();
  }

}