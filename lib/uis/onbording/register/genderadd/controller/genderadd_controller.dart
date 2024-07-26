import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:plusone/uis/onbording/introone/controller/intro_controller.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/globaldeta.dart';

class GenderaddController extends GetxController{

  Rx<String?> genderValue = ''.obs;
  TextEditingController genderController = TextEditingController();

  final IntroController introController = Get.find<IntroController>();

  changeGenderVal(val){
    genderValue.value = val;
  }

  Future<void> registerGender() async{

  }

  // submitName(){
  //   GlobalData.regData['gender']=gentervalue.value==1?"male":gentervalue.value==2?'female':gentervalue.value==3?'none-binary':'other';
  //   debugPrint("gk==================gender===${ GlobalData.regData}");
  //   Get.toNamed(Routes.regLocDobui);
  // }

}