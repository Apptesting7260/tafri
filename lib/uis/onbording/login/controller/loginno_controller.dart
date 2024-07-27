import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/onbording/login/model/LoginModel.dart';
import 'package:plusone/utils/tostmsg.dart';

import '../../../../networking/apiservices.dart';
import '../../../../routes/routes.dart';

class LoginnoController extends GetxController{
  TextEditingController mobNoCon=TextEditingController();
  final api = ApiServices();
  Rx<String> countryCode = '+39'.obs;
  RxString initialSelection = 'IT'.obs;

  changeCountryCode(CountryCode code) {
    countryCode.value = code.toString();
    print('${countryCode.value}');
    initialSelection.value = code.code.toString();
    print('${initialSelection.value}');
  }
  Rx<bool> isLoadingLogin=false.obs;
 Future<void> loginApi()async{
    isLoadingLogin.value=true;
    try{
      Map detaBody={
        'mobile':mobNoCon.value.text.trim(),
        "country_code":countryCode.value
      };
      final response = await api.post(EndPoints.loginApiUrl, detaBody);
      LoginModel body=LoginModel.fromJson(response.body);
    if(response.statusCode==200){
      if(body.status==true){
        debugPrint("gk======token==${body.token}");
        Get.toNamed(Routes.codeVerify,arguments: {'current step':5,'token':body.token,'uid':body.uId});
      }else{
        showTostMsg(body.message);
      }
    }else{
      showTostMsg(body.message);
    }
    }catch(e){
      debugPrint("error==$e");
      showTostMsg("Something went wrong");
    }
    isLoadingLogin.value=false;
  }
}