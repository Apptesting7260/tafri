import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/checkconnection.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/onbording/introone/model/intro_model.dart';
import 'package:plusone/utils/tostmsg.dart';

import '../../../../routes/routes.dart';

class IntroController extends GetxController {
  final api = ApiServices();

  TextEditingController mobnoController = TextEditingController();
  Rx<String> countryCode = '+39'.obs;
  RxString initialSelection = 'IT'.obs;

  changeCountryCode(CountryCode code) {
    countryCode.value = code.toString();
    print('${countryCode.value}');
    initialSelection.value = code.code.toString();
    print('${initialSelection.value}');
  }

  var loading = false.obs;

  Future<void> checkMobNoApi() async {

    Map data = {
      "mobile": mobnoController.value.text.trim(),
      "country_code": countryCode.value
    };

    log("send body==$data");
    loading.value = true;
    bool isNetAval = await checkInternetConnection();
    if (isNetAval) {
      try {
        final response = await api.post(EndPoints.checkNuExist, data);
        var body = PhoneNumberModel.fromJson(response.body);
        log('code == ${response.statusCode}');
        log("data == ${response.body}");
        if(body.status == true){
          loading.value = false;
          if(body.message == 'Mobile number exists' && body.currentStep == '4'){
            showTostMsg('Mobile number exists. Please login to continue');
            Get.back();
            mobnoController.clear();
          }else if(body.message == 'Mobile number exists' && int.parse(body.currentStep.toString()) < 4){
            Get.toNamed(Routes.codeVerify, arguments: {'current step': int.parse(body.currentStep.toString())});
          }else {
            Get.toNamed(Routes.codeVerify, arguments: {'current step': 0});
          }
        }else{
          loading.value = false;
          showTostMsg("${body.message}");
        }
      }catch(e){
        loading.value = false;
        print(e.toString());
      }
    } else {
      loading.value = false;
      showTostMsg("No internet connection found");
    }
  }
}
