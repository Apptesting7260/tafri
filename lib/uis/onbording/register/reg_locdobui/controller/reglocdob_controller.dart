import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/globaldeta.dart';

class ReglocdobController extends GetxController{
  TextEditingController locationController=TextEditingController();
  @override
  void onInit() {
    isShowDobErr.value=false;
    super.onInit();
  }
  Rx<String> dob="".obs;
  Rx<String> dobForCalender="".obs;
  changeDob(DateTime newDob){
    log("gk newDob=${newDob}");
    dob.value=DateFormat("dd/MM/yyyy").format(newDob);
    dobForCalender.value=DateFormat("yyyy-MM-dd").format(newDob);
  }
  RxBool isShowDobErr=false.obs;
  changeShowDobVal(boolval){
    isShowDobErr.value=boolval;
  }
  submitlocDob(){
    GlobalData.regData['location']=locationController.text.trim();
    GlobalData.regData['dob']=dobForCalender.value.trim();
    debugPrint("gk================== location and dob===${ GlobalData.regData}");
    Get.toNamed(Routes.regEmailui);
  }
}