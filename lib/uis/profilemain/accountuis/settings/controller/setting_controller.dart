import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/networking/firebase_api.dart';
import 'package:plusone/uis/onbording/login/model/social_login_model.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/activityvisibility/controller/activityvisibility_controller.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SettingController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  static ProfilemainController profilemainController = Get.find<ProfilemainController>();
  final api = ApiServices();



  RxBool googleVal= (profilemainController.profileData.value.result?.googleId != null
      ? true
      : false).obs;

  RxBool appleVal=(profilemainController.profileData.value.result?.appleId != null
      ? true
      : false).obs;

  changeGoogleVal(){
    if(googleVal.value != true){
      googleVal.value=true;
    }
  }
  changeAppleVal(){
    if(appleVal.value != true) {
      appleVal.value = true;
    }
  }


  var googleLoading = false.obs;

  Future<void> signInWithGoogle(BuildContext context) async {
    googleLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print('user crediental -------------${credential}');
      print(
          'details------${googleUser?.displayName}---${googleUser
              ?.email}---${googleUser?.photoUrl}---${googleUser
              ?.id}----${googleUser?.serverAuthCode}  ===   ${googleAuth
              ?.accessToken}');
      await FirebaseAuth.instance.signInWithCredential(credential);

      Map body = {
        'socailite_type': 'google',
        'socailite_id': '${googleUser?.id}',
      };

      final response = await api.post(EndPoints.googleLoginUrl, body);
      print('===>${response.body}');
      print('===>${response.statusCode}');
      if(response.statusCode == 200){
        // var data = SocialLoginModel.fromJson(response.body);
        if(response.body['status'] == true){
          changeGoogleVal();
          // LocalStorage.saveToken(data.data!.accessToken.toString());
          // LocalStorage.saveUid(data.data!.userId.toString());
          // Get.offAllNamed(Routes.navbarUi);
        }else{
          showTostMsg('Login failed.');
        }
      }else{
        showTostMsg('Login failed.');
      }

      googleLoading.value = false;

    } catch (e) {
      googleLoading.value = false;
      print('error == ${e.toString()}');
      showTostMsg('Login failed. Please try again.');
    }
  }


  RxBool appleLoading = false.obs;
  Future<void> appleSignIn(BuildContext context) async {
    appleLoading.value = true;
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ]);

      print('credientals');
      print(
          '${credential.email} , ${credential.givenName} , ${credential.familyName} , ${credential.identityToken} , ${credential.userIdentifier} , ${credential.authorizationCode}');
      print('credientals');

      Map body = {
        'socailite_type': 'apple',
        'socailite_id': '${credential.userIdentifier}',
      };

      final response = await api.post(EndPoints.googleLoginUrl, body);
      print(response.body);
      if(response.statusCode == 200){
        if(response.body['status'] == true){
          changeAppleVal();
          // LocalStorage.saveToken(data.data!.accessToken.toString());
          // LocalStorage.saveUid(data.data!.userId.toString());
          // Get.offAllNamed(Routes.navbarUi);
        }else{
          showTostMsg('Login failed.');
        }
      }else{
        showTostMsg('Login failed.');
      }

    } catch (e) {
      appleLoading.value = false;
      showTostMsg('Login failed. Please try again.');
      print('apple error ---  ${e.toString()}');
    }
    appleLoading.value = false;
  }



}