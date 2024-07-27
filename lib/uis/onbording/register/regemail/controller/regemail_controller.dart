import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/onbording/introone/controller/intro_controller.dart';
import 'package:plusone/uis/onbording/register/regemail/model/register_email_model.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';
import '../../../../../networking/apiservices.dart';
import '../../../../../networking/endpoints.dart';
import '../../../../../routes/routes.dart';

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
    print('body == ${body}');
    try{
      final response = await api.post(EndPoints.signupStep4, body);
      var data = RegisterEmailModel.fromJson(response.body);
      if(data.status == true){
        loading.value = false;
        LocalStorage.saveToken(data.accessToken.toString());
        Get.offAllNamed(Routes.navbarUi);
      }else{
        loading.value = false;
        showTostMsg(data.message);
      }
    }catch(e){
      loading.value = false;
      print('error == ${e.toString()}');
    }

  }

}