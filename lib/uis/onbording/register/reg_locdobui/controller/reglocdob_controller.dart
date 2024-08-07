import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/onbording/introone/controller/intro_controller.dart';
import 'package:plusone/uis/onbording/register/reg_locdobui/model/location_dob_model.dart';
import 'package:plusone/utils/tostmsg.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/globaldeta.dart';

class ReglocdobController extends GetxController{

  TextEditingController locationController=TextEditingController();
  final IntroController introController = Get.find<IntroController>();
  final api = ApiServices();

  @override
  void onInit() {
    isShowDobErr.value=false;
    super.onInit();
  }

  Rx<String?> dob = ''.obs;
  Rx<String> dobForCalender = "".obs;
  var isOld = false.obs;

  changeDob(DateTime newDob){
    log("gk newDob=${newDob}");
    dob.value=DateFormat("dd/MM/yyyy").format(newDob);
    dobForCalender.value=DateFormat("yyyy-MM-dd").format(newDob);
    DateTime todayDate = DateTime.now();
    DateTime selectedDate = DateTime.parse(DateFormat("yyyy-MM-dd").format(newDob));
    int differenceInDays = todayDate.difference(selectedDate).inDays;
    int daysIn18Years = 365 * 18 + 4;
    if (differenceInDays < daysIn18Years) {
      isOld.value = true;
    }else{
      isOld.value = false;
    }
    print('days == ${differenceInDays}');
  }

  RxBool isShowDobErr=false.obs;
  var loading = false.obs;

  changeShowDobVal(boolval){
    isShowDobErr.value = boolval;
  }

  Future<void> registerLocation() async{

    loading.value = true;

    Map body = {
      'location': locationController.value.text,
      'dob': dobForCalender.value,
      'mobile': introController.mobnoController.value.text.trim(),
      'country_code':  introController.countryCode.value
    };

    print('body == ${body}');

    try{
      final response = await api.post(EndPoints.signupStep3, body);
      var data = LocAndDobAddModel.fromJson(response.body);
      if(data.status == true){
        loading.value = false;
        Get.toNamed(Routes.regEmailui);
      }else{
        loading.value = false;
        showTostMsg(data.message.toString());
      }
    }catch(e){
      loading.value = false;
      print('error == ${e.toString()}');
    }

  }



// places api
  RxList<PlacesSearchResult> places = <PlacesSearchResult>[].obs;
  RxString _searchTerm = ''.obs;
  final placesApi = GoogleMapsPlaces(apiKey: 'AIzaSyAP3QLpyPPT0ba8RnZCCEIHpMLnh_hPNRM');

  void onSearchChanged(String value, BuildContext context) async {
    print(value);
    _searchTerm.value = value;
    if (_searchTerm.isNotEmpty) {
      final results = await searchPlaces(
        _searchTerm.value,
      );
      places.value = results;
    }
  }

  Future<List<PlacesSearchResult>> searchPlaces(String searchTerm) async {
    final response = await placesApi.searchByText(
      searchTerm,
    );
    if (response.isOkay) {
      print('location == ${response.results}');
      return response.results;
    } else {
      return [];
    }
  }


  // submitlocDob(){
  //   GlobalData.regData['location']=locationController.text.trim();
  //   GlobalData.regData['dob']=dobForCalender.value.trim();
  //   debugPrint("gk================== location and dob===${ GlobalData.regData}");
  //   Get.toNamed(Routes.regEmailui);
  // }
}