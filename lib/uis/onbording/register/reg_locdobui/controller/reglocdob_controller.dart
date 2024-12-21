import 'dart:convert';
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
import 'package:http/http.dart' as http;

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

  final focusNode = FocusNode();

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

    if(latitude.value.isEmpty && longitude.value.isEmpty && timeZone.value.isEmpty){
      showTostMsg('Please select complete location');
      return;
    }

    loading.value = true;

    Map body = {
      'location': locationController.value.text,
      'dob': dobForCalender.value,
      'mobile': introController.mobnoController.value.text.trim(),
      'country_code':  introController.countryCode.value,
      'time_zone': timeZone.value
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
//   RxList<String?> places = <String?>[].obs;
  RxString _searchTerm = ''.obs;
  RxList<Map<String, dynamic>> places = <Map<String,dynamic>>[].obs;
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

  Future<List<Map<String,dynamic>>> searchPlaces(String searchTerm) async {
    final response = await placesApi.autocomplete(searchTerm);
    if (response.isOkay) {
      print('location == ${response.predictions}');
      return response.predictions.map((e) => {'des':e.description,'id':e.placeId},).toList();
    } else {
      return [];
    }
  }

  final String apiKey = 'AIzaSyAP3QLpyPPT0ba8RnZCCEIHpMLnh_hPNRM';
  var latitude = ''.obs;
  var longitude = ''.obs;
  var timeZone = ''.obs;

  Future<void> getLatLang(var placeId) async {
    if (placeId != null) {
      var placeDetails = await getPlaceDetails(placeId!);
      updateLatLong(placeDetails['lat'], placeDetails['lng']);
      getTimeZone(lat: latitude.value,long: longitude.value);
      print("place Id ${placeId}");
      print('Latitude: ${placeDetails['lat']}');
      print('Longitude: ${placeDetails['lng']}');
      print('House Number: ${placeDetails['houseNumber']}');
      print('Street Name: ${placeDetails['streetName']}');
      print('Street Type: ${placeDetails['streetType']}');
      print('City: ${placeDetails['city']}');
      print('Postal Code: ${placeDetails['postalCode']}');
      print(
          'State (Administrative Area): ${placeDetails['administrativeArea']}');

      print('Country: ${placeDetails['country']}');
    }
  }

  Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyCPAaERVd6ZlHs_EVKdaBixFIoYWW_-SL0';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['result'];
      final geometry = result['geometry']['location'];
      final addressComponents = result['address_components'];

      print('Full Address Components: $addressComponents');

      double lat = geometry['lat'];
      double lng = geometry['lng'];
      String houseNumber = '';
      String streetName = '';
      String streetType = '';
      String city = '';
      String postalCode = '';
      String administrativeArea = '';
      String country = '';

      // Loop through addressComponents to extract the details
      addressComponents.forEach((component) {
        List types = component['types'];

        print('Component Types: $types'); // Print types for each component

        if (types.contains('street_number')) {
          houseNumber = component['long_name'];
        } else if (types.contains('route')) {
          streetName = component['long_name'];
        } else if (types.contains('locality')) {
          city = component['long_name'];
        } else if (types.contains('postal_code')) {
          postalCode = component['long_name'];
        } else if (types.contains('administrative_area_level_1')) {
          administrativeArea = component['long_name'];
        } else if (types.contains('country')) {
          country = component['long_name'];
        }
      });

      return {
        'lat': lat,
        'lng': lng,
        'houseNumber': houseNumber,
        'streetName': streetName,
        'streetType': streetType, // Optional if you extract it
        'city': city,
        'postalCode': postalCode,
        'administrativeArea': administrativeArea,
        'country': country,
      };
    } else {
      throw Exception('Failed to load place details');
    }
  }

  Future<void> getTimeZone({required String lat,required String long}) async{

    var timeStamp = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    final url = 'https://maps.googleapis.com/maps/api/timezone/json?location=$lat,$long&timestamp=$timeStamp&key=$apiKey';

    try{
      final response = await api.get(url);
      print('timezone == ${response.statusCode}    ${response.body}');
      if(response.statusCode == 200){
        var data = response.body;
        timeZone.value = data['timeZoneId'];
        print('time zone == ${timeZone.value}');
      }
    }catch(e){
      print('timezone error == ${e.toString()}');
    }

  }

  void updateLatLong(double lat, double long) {
    latitude.value = lat.toString();
    longitude.value = long.toString();
    print('lat == ${latitude.value}   lon == ${longitude.value}');
  }


  // submitlocDob(){
  //   GlobalData.regData['location']=locationController.text.trim();
  //   GlobalData.regData['dob']=dobForCalender.value.trim();
  //   debugPrint("gk================== location and dob===${ GlobalData.regData}");
  //   Get.toNamed(Routes.regEmailui);
  // }
}