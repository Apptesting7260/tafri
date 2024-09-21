import 'dart:async';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/networking/firebase_api.dart';
import 'package:plusone/uis/onbording/login/model/LoginModel.dart';
import 'package:plusone/uis/onbording/login/model/social_login_model.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../networking/apiservices.dart';
import '../../../../routes/routes.dart';

class LoginnoController extends GetxController {
  TextEditingController mobNoCon = TextEditingController();
  final api = ApiServices();
  Rx<String> countryCode = '+31'.obs;
  RxString initialSelection = 'NL'.obs;

  changeCountryCode(CountryCode code) {
    countryCode.value = code.toString();
    print('${countryCode.value}');
    initialSelection.value = code.code.toString();
    print('${initialSelection.value}');
  }

  bool validatePhoneNumber(String phoneNumber, String countryCode) {
    Map<String, int> countryPhoneLengths = {
      'AF': 9, // Afghanistan
      'AL': 9, // Albania
      'DZ': 9, // Algeria
      'US': 10, // United States
      'AD': 6, // Andorra
      'AO': 9, // Angola
      'AR': 10, // Argentina
      'AM': 8, // Armenia
      'AU': 9, // Australia
      'AT': 10, // Austria
      'AZ': 9, // Azerbaijan
      'BH': 8, // Bahrain
      'BD': 10, // Bangladesh
      'BY': 9, // Belarus
      'BE': 9, // Belgium
      'BZ': 7, // Belize
      'BJ': 8, // Benin
      'BT': 8, // Bhutan
      'BO': 8, // Bolivia
      'BA': 8, // Bosnia and Herzegovina
      'BW': 7, // Botswana
      'BR': 11, // Brazil
      'BN': 7, // Brunei
      'BG': 9, // Bulgaria
      'BF': 8, // Burkina Faso
      'BI': 8, // Burundi
      'KH': 9, // Cambodia
      'CM': 9, // Cameroon
      'CA': 10, // Canada
      'CV': 7, // Cape Verde
      'CF': 8, // Central African Republic
      'TD': 8, // Chad
      'CL': 9, // Chile
      'CN': 11, // China
      'CO': 10, // Colombia
      'KM': 7, // Comoros
      'CG': 9, // Congo
      'CD': 9, // Congo, Democratic Republic of the
      'CK': 5, // Cook Islands
      'CR': 8, // Costa Rica
      'HR': 9, // Croatia
      'CU': 8, // Cuba
      'CY': 8, // Cyprus
      'CZ': 9, // Czech Republic
      'DK': 8, // Denmark
      'DJ': 6, // Djibouti
      'DM': 10, // Dominica
      'DO': 10, // Dominican Republic
      'EC': 9, // Ecuador
      'EG': 10, // Egypt
      'SV': 8, // El Salvador
      'GQ': 9, // Equatorial Guinea
      'ER': 7, // Eritrea
      'EE': 7, // Estonia
      'ET': 9, // Ethiopia
      'FJ': 7, // Fiji
      'FI': 10, // Finland
      'FR': 9, // France
      'GA': 7, // Gabon
      'GM': 7, // Gambia
      'GE': 9, // Georgia
      'DE': 10, // Germany
      'GH': 9, // Ghana
      'GR': 10, // Greece
      'GL': 6, // Greenland
      'GT': 8, // Guatemala
      'GN': 9, // Guinea
      'GW': 7, // Guinea-Bissau
      'GY': 7, // Guyana
      'HT': 8, // Haiti
      'HN': 8, // Honduras
      'HK': 8, // Hong Kong
      'HU': 9, // Hungary
      'IS': 7, // Iceland
      'IN': 10, // India
      'ID': 10, // Indonesia
      'IR': 10, // Iran
      'IQ': 10, // Iraq
      'IE': 9, // Ireland
      'IL': 9, // Israel
      'IT': 10, // Italy
      'CI': 8, // Ivory Coast
      'JM': 7, // Jamaica
      'JP': 10, // Japan
      'JO': 9, // Jordan
      'KZ': 10, // Kazakhstan
      'KE': 10, // Kenya
      'KI': 8, // Kiribati
      'KW': 8, // Kuwait
      'KG': 9, // Kyrgyzstan
      'LA': 9, // Laos
      'LV': 8, // Latvia
      'LB': 8, // Lebanon
      'LS': 8, // Lesotho
      'LR': 7, // Liberia
      'LY': 10, // Libya
      'LI': 7, // Liechtenstein
      'LT': 8, // Lithuania
      'LU': 9, // Luxembourg
      'MO': 8, // Macau
      'MK': 8, // Macedonia
      'MG': 9, // Madagascar
      'MW': 9, // Malawi
      'MY': 10, // Malaysia
      'MV': 7, // Maldives
      'ML': 8, // Mali
      'MT': 8, // Malta
      'MH': 7, // Marshall Islands
      'MR': 8, // Mauritania
      'MU': 8, // Mauritius
      'MX': 10, // Mexico
      'FM': 7, // Micronesia
      'MD': 8, // Moldova
      'MC': 8, // Monaco
      'MN': 8, // Mongolia
      'ME': 8, // Montenegro
      'MA': 9, // Morocco
      'MZ': 9, // Mozambique
      'MM': 9, // Myanmar
      'NA': 9, // Namibia
      'NR': 7, // Nauru
      'NP': 10, // Nepal
      'NL': 9, // Netherlands
      'NZ': 8, // New Zealand
      'NI': 8, // Nicaragua
      'NE': 8, // Niger
      'NG': 10, // Nigeria
      'NO': 8, // Norway
      'OM': 8, // Oman
      'PK': 10, // Pakistan
      'PW': 7, // Palau
      'PA': 8, // Panama
      'PG': 8, // Papua New Guinea
      'PY': 9, // Paraguay
      'PE': 9, // Peru
      'PH': 10, // Philippines
      'PL': 9, // Poland
      'PT': 9, // Portugal
      'QA': 8, // Qatar
      'RO': 10, // Romania
      'RU': 10, // Russia
      'RW': 9, // Rwanda
      'WS': 7, // Samoa
      'SM': 9, // San Marino
      'ST': 7, // Sao Tome and Principe
      'SA': 9, // Saudi Arabia
      'SN': 9, // Senegal
      'RS': 9, // Serbia
      'SC': 7, // Seychelles
      'SL': 8, // Sierra Leone
      'SG': 8, // Singapore
      'SK': 9, // Slovakia
      'SI': 9, // Slovenia
      'SB': 7, // Solomon Islands
      'SO': 7, // Somalia
      'ZA': 9, // South Africa
      'KR': 10, // South Korea
      'SS': 9, // South Sudan
      'ES': 9, // Spain
      'LK': 9, // Sri Lanka
      'SD': 9, // Sudan
      'SR': 7, // Suriname
      'SZ': 8, // Eswatini
      'SE': 9, // Sweden
      'CH': 9, // Switzerland
      'SY': 9, // Syria
      'TW': 9, // Taiwan
      'TJ': 9, // Tajikistan
      'TZ': 9, // Tanzania
      'TH': 9, // Thailand
      'TG': 8, // Togo
      'TO': 7, // Tonga
      'TN': 8, // Tunisia
      'TR': 10, // Turkey
      'TM': 8, // Turkmenistan
      'TV': 6, // Tuvalu
      'UG': 9, // Uganda
      'UA': 9, // Ukraine
      'AE': 9, // United Arab Emirates
      'GB': 10, // United Kingdom
      'UY': 9, // Uruguay
      'UZ': 9, // Uzbekistan
      'VU': 7, // Vanuatu
      'VE': 10, // Venezuela
      'VN': 9, // Vietnam
      'YE': 9, // Yemen
      'ZM': 9, // Zambia
      'ZW': 9 // Zimbabwe
    };

    int? expectedLength = countryPhoneLengths[countryCode];
    if (expectedLength != null) {
      return phoneNumber.length == expectedLength;
    }
    return false;
  }

  Rx<bool> isLoadingLogin = false.obs;

  Future<void> loginApi() async {
    isLoadingLogin.value = true;
    try {
      Map detaBody = {
        'mobile': mobNoCon.value.text.trim(),
        "country_code": countryCode.value,
        'fcm_token': FirebaseApi.fcmToken
      };
      final response = await api.post(EndPoints.loginApiUrl, detaBody);
      LoginModel body = LoginModel.fromJson(response.body);
      if (response.statusCode == 200) {
        if (body.status == true) {
          debugPrint("gk======token==${body.token}");
          await sendOtp().then((value){
            if(value == true){
              Get.back();
              Get.toNamed(Routes.codeVerify, arguments: {
                'from': 'login',
                'token': body.token,
                'uid': body.uId
              });
            }
          });
        } else {
          showTostMsg(body.message);
        }
      } else {
        showTostMsg(body.message);
      }
    } catch (e) {
      debugPrint("error==$e");
      showTostMsg("Something went wrong");
    }
    isLoadingLogin.value = false;
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

      String? displayName = googleUser?.displayName;
      String firstName = '';
      String lastName = '';

      if (displayName != null) {
        List<String> nameParts = displayName.split(' ');
        print(nameParts);
        if (nameParts.length > 1) {
          firstName = nameParts.first;
          lastName = nameParts.sublist(1).join(' ');
        } else {
          firstName = displayName;
        }
      }

      Map body = {
        'socailite_type': 'google',
        'socailite_id': '${googleUser?.id}',
        'first_name': firstName,
        'last_name': lastName,
        'email': '${googleUser?.email}',
        'fcm_token': FirebaseApi.fcmToken
      };

      final response = await api.post(EndPoints.socialLoginUrl, body);
      print(response.body);
      if(response.statusCode == 200){
        var data = SocialLoginModel.fromJson(response.body);
        if(data.status == true){
          LocalStorage.saveToken(data.data!.accessToken.toString());
          LocalStorage.saveUid(data.data!.userId.toString());
          Get.offAllNamed(Routes.navbarUi);
        }else if(response.statusCode == 401){
          showTostMsg('Login failed.It seems your account has been deleted.');
        }
      }else{
        showTostMsg('Login failed.');
      }

      googleLoading.value = false;

    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
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
        'first_name': credential.givenName,
        'last_name': credential.familyName,
        'email': '${credential.email}',
        'fcm_token': FirebaseApi.fcmToken
      };

      final response = await api.post(EndPoints.socialLoginUrl, body);
      print(response.body);
      if(response.statusCode == 200){
        var data = SocialLoginModel.fromJson(response.body);
        if(data.status == true){
          LocalStorage.saveToken(data.data!.accessToken.toString());
          LocalStorage.saveUid(data.data!.userId.toString());
          Get.offAllNamed(Routes.navbarUi);
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




  FirebaseAuth auth = FirebaseAuth.instance;
  RxString verificationID = ''.obs;

  var resendToken = 0.obs;

  Future<bool> sendOtp() async {
    Completer<bool> completer = Completer<bool>();
    print('re == ${resendToken.value}');
    print('no == ${countryCode.value.toString()}${mobNoCon.value.text.trim().toString()}');
    try {
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 59),
        phoneNumber: '${countryCode.value.toString()}${mobNoCon.value.text.trim().toString()}',
        // forceResendingToken: !Platform.isIOS ? (resendToken.value != 0 ? resendToken.value : null) : null,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('${e.code}');
            showTostMsg('The provided phone number is not valid.');
          }else{
            showTostMsg('Something went wrong');
          }
          print(e.toString());

          completer.complete(false);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          print('codesent');
          if(!Platform.isIOS){
            print(forceResendingToken);
            resendToken.value = forceResendingToken!;
            Timer(const Duration(seconds: 59), () {
              resendToken.value = 0;
              print('token == ${resendToken.value}');
            },);
          }
          verificationID.value = verificationId;
          completer.complete(true);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      completer.complete(false);
      print('error == ${e.toString()}');
    }
    return completer.future;

  }


  var otpVerify = false.obs;

  Future<bool> verifyOtp(String verificationId,String smsCode) async{
    otpVerify.value = true;
    try{
      var credential = await auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode));
      otpVerify.value = false;
      return credential.user == null ? false : true;
    }on FirebaseAuthException catch (e){
      print('otp error == ${e.code}');
      if(e.code == 'invalid-verification-code'){
        showTostMsg('Invalid otp.');
      }else{
        showTostMsg('Please check your otp and try again.');
      }
      otpVerify.value = false;
      return false;
    }
  }


  OtpTimerButtonController otpTimerButtonController =
  OtpTimerButtonController();

  Future<bool> resendOtp() async {
    Completer<bool> completer = Completer<bool>();
    otpTimerButtonController.loading();
    try {
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 59),
        phoneNumber: '${countryCode.value.toString()}${mobNoCon.value.text.trim().toString()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('${e.code}');
            showTostMsg('The provided phone number is not valid.');
          }else{
            showTostMsg('Something went wrong');
          }
          otpTimerButtonController.enableButton();
          completer.complete(false);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          print('codesent');
          showTostMsg('otp has been send successfully.');
          verificationID.value = verificationId;
          otpTimerButtonController.startTimer();
          completer.complete(true);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      otpTimerButtonController.enableButton();
      completer.complete(false);
      print('error == ${e.toString()}');
    }
    return completer.future;

  }



}



