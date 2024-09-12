import 'dart:ffi';

import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/activityvisibility/controller/activityvisibility_controller.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';

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