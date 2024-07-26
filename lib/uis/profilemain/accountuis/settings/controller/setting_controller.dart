import 'package:get/get.dart';

class SettingController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  RxBool googleVal=false.obs;
  RxBool appleVal=false.obs;
  changeGoogleVal(){
    googleVal.value=!googleVal.value;
  }
  changeAppleVal(){
    appleVal.value=!appleVal.value;
  }
}