import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/onbording/introone/controller/intro_controller.dart';
import 'package:plusone/uis/onbording/register/genderadd/model/gender_model.dart';
import 'package:plusone/utils/tostmsg.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/globaldeta.dart';

class GenderaddController extends GetxController{

  Rx<String?> genderValue = ''.obs;
  TextEditingController genderController = TextEditingController();
  var loading = false.obs;
  final api = ApiServices();

  final IntroController introController = Get.find<IntroController>();

  changeGenderVal(val){
    genderValue.value = val;
  }

  var genderlist = [
    {'id' : 'male' , 'value' : 'Male'},
    {'id' : 'female' , 'value' : 'Female'},
    {'id' : 'none-binary' , 'value' : 'Non-binary'},
    {'id' : 'other' , 'value' : 'Other'},
  ].obs;

  Future<void> registerGender() async{

    loading.value = true;

    Map body = {
      'gender': genderValue.value == 'other' ? genderController.value.text.trim() : genderValue.value,
      'mobile': introController.mobnoController.value.text.trim(),
      'country_code': introController.countryCode.value
    };

    print('send data == ${body}');

    try{
      final response = await api.post(EndPoints.signupStep2, body);
      var data = GenderAddModel.fromJson(response.body);
      if(data.status == true){
        loading.value = false;
        Get.toNamed(Routes.regLocDobui);
      }else{
        loading.value = false;
        showTostMsg(data.message.toString());
      }
    }catch(e){
      loading.value = false;
      print('error ==  ${e.toString()}');
    }

  }

}