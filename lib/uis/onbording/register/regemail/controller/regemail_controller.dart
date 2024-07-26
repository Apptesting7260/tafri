import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/onbording/introone/controller/intro_controller.dart';
import 'package:plusone/uis/onbording/register/regemail/model/register_email_model.dart';

import '../../../../../networking/apiservices.dart';
import '../../../../../networking/checkconnection.dart';
import '../../../../../networking/endpoints.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/globaldeta.dart';
import '../../../../../utils/tostmsg.dart';

class RegemailController extends GetxController{

  final api = ApiServices();

  final TextEditingController emailController = TextEditingController();
  final IntroController introController = Get.find<IntroController>();

  var loading = false.obs;

  Future<void> registerEmail() async{
    loading.value  = true;

    Map body = {
      'email': emailController.value.text.trim(),
      'mobile': introController.mobnoController.value.text.trim(),
      'country_code': introController.countryCode.value
    };

    try{
      final response = await api.post(EndPoints.signupStep4, body);
      var data = RegisterEmailModel.fromJson(response.body);
      if(data.status == true){
        loading.value = false;
        Get.offAllNamed(Routes.navbarUi);
      }else{
        loading.value = false;
      }
    }catch(e){
      loading.value = false;
      print('error == ${e.toString()}');
    }

  }

}