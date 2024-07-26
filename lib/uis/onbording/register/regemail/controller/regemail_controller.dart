import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../networking/apiservices.dart';
import '../../../../../networking/checkconnection.dart';
import '../../../../../networking/endpoints.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/globaldeta.dart';
import '../../../../../utils/tostmsg.dart';

class RegemailController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  final TextEditingController emailController = TextEditingController();

  submitemail(){
    GlobalData.regData['email']=emailController.value.text.trim();
    debugPrint("gk================== email ===${ GlobalData.regData}");
    addNewUser();
  }
  addNewUser()async{
    log("send body==${ GlobalData.regData}");
    Map deta= GlobalData.regData;
    bool isNetAval=await checkInternetConnection();
    if(isNetAval){
      var response=await ApiServices().post(EndPoints.addNewUserUrl,deta );
      var body=response.body;
      log("gk======statuscoe=${response.statusCode}====api checkmobno res===${body} =====");
      if(response.statusCode==200){
        if(body['status']=="success"){
          showTostMsg("${body['message']}");
          Get.offAllNamed(Routes.loginWithMobNo);
        }else{
          showTostMsg("${body['message']}");
        }
      }else{
        showTostMsg("${body['message']}");
      }
    }else{
      showTostMsg("No internet connection found");
    }
  }
}