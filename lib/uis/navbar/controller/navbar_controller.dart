import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/utils/local_storage.dart';

class NavBarController extends GetxController{
  final api = ApiServices();

  RxInt navIndex=0.obs;
  changeNavIndex(index){
    navIndex.value=index;
    update();
  }

  Future<void> updateFcmToken({required String oldFcmToken,required String  fcmToken})async{

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    try{
      var dataBody = {
        "old_fcm_token" : oldFcmToken,
        "fcm_token" : fcmToken,
      };
      debugPrint('dataBody == $dataBody');
      final response = await api.post(EndPoints.updateFcmTokenUrl, dataBody,headers: header);
      if(response.statusCode == 200){
        LocalStorage.removeFcmToken();
        LocalStorage.saveFcmToken(fcmToken.toString());
        debugPrint("Token updated successfully>>>>>>>>>>>> ${response.body}");
      }else {
        debugPrint("Token not updated >>>>>>>>>>>> ${response.statusCode} :  ${ response.body}");
      }
    }catch (e) {
      debugPrint("update fcm error==$e");
    }

  }

}
