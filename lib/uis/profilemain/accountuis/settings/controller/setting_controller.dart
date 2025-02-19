import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/networking/firebase_api.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:plusone/uis/onbording/login/model/social_login_model.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/activityvisibility/controller/activityvisibility_controller.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SettingController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    googleVal.value = (profilemainController.profileData.value.result?.googleId != null
        ? true
        : false);
    appleVal.value = (profilemainController.profileData.value.result?.appleId != null
        ? true
        : false);
  }
  static ProfilemainController profilemainController = Get.find<ProfilemainController>();
  final api = ApiServices();



  RxBool googleVal= false.obs;

  RxBool appleVal= false.obs;

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
      var header = {
        'Authorization': 'Bearer $token'
      };
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

      final response = await api.post(EndPoints.googleLoginUrl, body,headers: header);
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
          showTostMsg('${response.body['message']}');
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

  String token = LocalStorage.getToken().toString();


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

      var header = {
        'Authorization': 'Bearer $token'
      };

      final response = await api.post(EndPoints.googleLoginUrl, body,headers: header);
      print(response.body);
      print(response.statusCode);
      if(response.statusCode == 200){
        if(response.body['status'] == true){
          changeAppleVal();
          // LocalStorage.saveToken(data.data!.accessToken.toString());
          // LocalStorage.saveUid(data.data!.userId.toString());
          // Get.offAllNamed(Routes.navbarUi);
        }else{
          showTostMsg('${response.body['message']}');
        }
      }else{
        showTostMsg('${response.body['message']}');
      }

    } catch (e) {
      appleLoading.value = false;
      showTostMsg('Login failed. Please try again.');
      print('apple error ---  ${e.toString()}');
    }
    appleLoading.value = false;
  }



  /// delete account


  alertDeleteAccount() {
    Future.delayed(Duration.zero, () {
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Delete Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                    "Are you sure you want to delete your account?",
                    style: TextStyle(
                        color: clrGreyTextLight,
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
              SizedBox(
                height: Get.height * .024,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Expanded(
                      child: SizedBox(
                        height: Res.h_btn,
                        child: CustoFilterBtn(
                            ontap: () {
                              Get.back();
                              deleteUser();
                            },
                            borderClr: clrBlacke,
                            lable: Text(
                              "Yes",
                              style: TextStyle(
                                  color: clrBlacke,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            backgroundClr: Get.theme.scaffoldBackgroundColor),
                      )
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  Expanded(
                    child: SizedBox(
                        width: double.maxFinite,
                        height: Res.h_btn,
                        child: CustomElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            backgroundClr: clrBlacke,
                            child: Text(
                              "No",
                              style: TextStyle(
                                  color: clrWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ))),
                  ),
                ]),
              ),
              SizedBox(
                height: Get.height * .014,
              ),
            ],
          ),
        ),
      ));
    });
  }


  var deleteloading = false.obs;

  Future<void> deleteUser() async{

    var header = {"Authorization": "Bearer $token"};

    deleteloading.value = true;
    try{
      final response = await api.delete(EndPoints.deleteUser, headers: header);
      print(response.body);
      if(response.statusCode == 200){
        GoogleSignIn().signOut();
        Get.find<SocketController>().deleteUser();
        LocalStorage.removeToken();
        debugPrint("gk==getUid=${LocalStorage.getUid()}=token=${LocalStorage.getToken()}=");
        if (LocalStorage.getToken() == null || LocalStorage.getUid() == null) {
          Get.offAllNamed(Routes.initialPage);
        }
      }
    }catch(e){
      showTostMsg('Something went wrong');
      deleteloading.value = false;
      print('error == ${e.toString()}');
    }

  }


  /// delete account

}