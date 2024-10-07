import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';

class ContactSupportController extends GetxController {

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  Rx<String> countryCode = '+31'.obs;
  RxString initialSelection = 'NL'.obs;

  changeCountryCode(CountryCode code) {
    countryCode.value = code.toString();
    print('${countryCode.value}');
    initialSelection.value = code.code.toString();
    print('${initialSelection.value}');
  }

  final api = ApiServices();

  var conloading = false.obs;

  Future<void> contactsupport() async {
    conloading.value = true;

    try{
      var body = {
        'first_name' : firstnameController.value.text.trim(),
        'last_name' : lastnameController.value.text.trim(),
        'country_code' : countryCode.value,
        'mobile' : phoneController.value.text.trim(),
        'email' : emailController.value.text.trim(),
        'description' : messageController.value.text.trim(),
      };

      print('body ==> $body');

      var header = {
        'Authorization': 'Bearer ${LocalStorage.getToken()}'
      };
      var response = await api.post(EndPoints.contactSupport, body,headers: header);
      if(response.statusCode == 200){
        // Get.snackbar(
        //   'Success',
        //   'Your request has been submitted',
        //   snackPosition: SnackPosition.TOP,
        // );
        showTostMsg('Your query has been submitted.');
        Get.back();
      }else{
        showTostMsg('Something went wrong.Please try again');
      }

    }catch(e){
      showTostMsg('Something went wrong');
      conloading.value = false;
      print(e);
    }

    conloading.value = false;

  }

}