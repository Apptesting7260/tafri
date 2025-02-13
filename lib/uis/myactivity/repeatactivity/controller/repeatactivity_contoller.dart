import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/creativity/model/category_model.dart';
import 'package:plusone/uis/myactivity/myactivitylist/controller/myacti_controller.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';
import '../../myactivitylist/model/hosting_model.dart';

class Repeatcreativitycontroller extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  ActivityElement? activities;
  final MyactiController myactiController = Get.find<MyactiController>();


  @override
  void onInit() {
    activities = Get.arguments;
    print('act == ${activities!.categoryId}');
    print('act == ${activities!.subcategoryId}');
    tabController = TabController(length: 2, vsync: this);
    desController.value.addListener(() {
      currentLength.value = desController.value.text.length;
    });
    getCategory();
    getMaxOcc();
    repeatadd();
    super.onInit();
  }

  void repeatadd(){
    if (activities != null) {
      desController.value.text = activities?.description ?? '';
      catID.value = activities?.categoryId.toString() ?? '';
      subCatID.value = activities?.subcategoryId.toString() ?? '';
      print('Selected subcategoryssss ID: ${subCatID.value}');
      getSubCatid(subCatID.value);
      // getSubCatName(int.parse(subCatID.value));
      titleController.value.text = activities?.name ?? '';
      locController.value.text = activities?.location ?? '';
      sTimeForApi.value = changeTime(activities!.startAt.toString()) ?? '';
      sTime.value = schangeTime(activities!.startAt.toString()) ?? '';
      eTimeForAPi.value = changeTime(activities!.endAt.toString()) ?? '';
      eTime.value = schangeTime(activities!.endAt.toString()) ?? '';
      groupSize.value = activities?.maxPeople ?? 1;
      groupSizeController.text = (activities?.maxPeople ?? 1).toString();
      gender.value = activities?.gender == 'same' ? 1 : activities?.gender == 'all' ? 2 : 0;
      // repeats.value = activities?.repeatStatus == 'repeats' ? true : false;
      print('repet == ${repeats.value}');
      joinInstant.value = activities?.joinInstantly == "1" ? true : false;
      latitude.value = activities?.latitude.toString() ?? '';
      longitude.value = activities?.longitude.toString() ?? '';
      // timeZone.value.text = activities?.timezone?.timeZone ?? '';
      // country.value.text = activities?.timezone?.countryName ?? '';
      print('lat and long ${latitude.value} ${longitude.value}');
      updateGalleryImages();
    }
  }

  Future<void> getSubCatid(String val) async {
    subCatID.value = val;
    print('Current subCatID in Controller: ${subCatID.value}');
  }

  void updateGalleryImages() {
    if (activities?.banners != null) {
      galleryImages.clear();
      for (var banner in activities!.banners!) {
        galleryImages.add(banner);
      }
      containerList.length = activities!.banners!.length - 1;
      debugPrint("galleryImages updated: ${galleryImages.length} images added");
      debugPrint("container updated: ${containerList.length} images added");
    } else {
      debugPrint("No banners available in activities.");
    }
  }


  var groupSizeController = TextEditingController();


  RxInt counter = 1.obs;

  var Rdate = ''.obs;
  var RdateForPicker = ''.obs;
  RchangeDate(DateTime dateTime) {
    RdateForPicker.value = dateTime.toString();

    String formattedMonth = dateTime.month.toString().padLeft(2, '0');
    String formattedDay = dateTime.day.toString().padLeft(2, '0');

    Rdate.value = '${dateTime.year}-$formattedMonth-$formattedDay';
  }

  void increment() {
    counter.value++ ;
  }

  void decrement() {
    if(counter >1){
      counter.value-- ;
    }
  }

  RxInt occs = 1.obs;

  void occsincrement() {
    if(occs < 3){
      occs.value++ ;
    }
  }

  void occsdecrement() {
    if(occs >1){
      occs.value-- ;
    }
  }


  List dayList = ['M','T','W','T','F','S','S'];

  List daysList = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
  RxString repeatday = ''.obs;

  changeday(int val) {
    switch (val) {
      case 0:
        repeatday.value = 'monday';
        break;
      case 1:
        repeatday.value = 'tuesday';
        break;
      case 2:
        repeatday.value = 'wednesday';
        break;
      case 3:
        repeatday.value = 'thursday';
        break;
      case 4:
        repeatday.value = 'friday';
        break;
      case 5:
        repeatday.value = 'saturday';
        break;
      case 6:
        repeatday.value = 'sunday';
        break;
      default:
        repeatday.value = 'Invalid day';
    }

    if (val < daysList.length) {
      daysList[val] = repeatday.value;
      debugPrint("daysList updated at index $val: ${repeatday.value}");
    } else {
      debugPrint("Invalid index: $val");
    }
  }

  List monthsList = [
    'january', 'february', 'march', 'april', 'may', 'june',
    'july', 'august', 'september', 'october', 'november', 'december'
  ];

  RxString repeatMonth = ''.obs;

  changemonth(int val) {
    switch (val) {
      case 0:
        repeatMonth.value = 'january';
        break;
      case 1:
        repeatMonth.value = 'february';
        break;
      case 2:
        repeatMonth.value = 'march';
        break;
      case 3:
        repeatMonth.value = 'april';
        break;
      case 4:
        repeatMonth.value = 'may';
        break;
      case 5:
        repeatMonth.value = 'june';
        break;
      case 6:
        repeatMonth.value = 'july';
        break;
      case 7:
        repeatMonth.value = 'august';
        break;
      case 8:
        repeatMonth.value = 'september';
        break;
      case 9:
        repeatMonth.value = 'october';
        break;
      case 10:
        repeatMonth.value = 'november';
        break;
      case 11:
        repeatMonth.value = 'december';
        break;
      default:
        repeatMonth.value = 'Invalid month';
    }

    if (val < monthsList.length) {
      monthsList[val] = repeatMonth.value;
      debugPrint("monthsList updated at index $val: ${repeatMonth.value}");
    } else {
      debugPrint("Invalid index: $val");
    }
  }

  List monthList = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  var monthIndex = (-1).obs;
  var dayIndex = (-1).obs;
  var groupValue = 0.obs;
  var wmValue = 0.obs;
  var currentLength = 0.obs;

  RxInt groupSize = 1.obs;

  incGroupSize() {
    if (groupSize.value < 9) {
      groupSize.value += 1;
    }
  }

   decGroupSize() {
    if (groupSize.value > 1) {
      groupSize.value -= 1;
    }
  }

  RxInt gender = 0.obs;

  changeGenderFilter(val) {
    gender.value = val;
    debugPrint("gender=${gender.value}");
  }

  RxInt? repeat;

  changeRepeatVal(val) {
    repeat?.value = val;
    debugPrint("repeat=${repeat?.value}==incomming=${val}");
    if(val == 2){
      changerepeats();
    }
  }

  RxBool joinInstant = false.obs;
  RxBool repeats = false.obs;

  changejoinInstant() {
    joinInstant.value = !joinInstant.value;
  }

  changerepeats() {
    repeats.value = !repeats.value;
  }

  RxString sTime = "".obs;
  var sTimeForApi = ''.obs;


  changeTime(String time24){
    final DateTime time = DateFormat("HH:mm:ss").parse(time24);

    final String FormattedTime = DateFormat("h:mm a").format(time);

    return FormattedTime;
  }

  schangeTime(String time24){
    final DateTime time = DateFormat("HH:mm:ss").parse(time24);

    final String FormattedTime = DateFormat("h:mm").format(time);
    print(FormattedTime);
    return FormattedTime;
  }



  changeStime(TimeOfDay stime) {
    sTime.value = "${stime.hour}:${stime.minute}";
    sTimeForApi.value = '${stime.hour > 12 ? stime.hour - 12 : stime.hour == 0 ? 12 : stime.hour}:${stime.minute.toString().padLeft(2,'0')} ${stime.period == DayPeriod.am ? "AM" : "PM"}';
  }

  RxString eTime = "".obs;
  var eTimeForAPi = ''.obs;

  changeEtime(TimeOfDay etime) {
    eTime.value = "${etime.hour}:${etime.minute}";
    eTimeForAPi.value = '${etime.hour > 12 ? etime.hour - 12 : etime.hour == 0 ? 12 : etime.hour}:${etime.minute.toString().padLeft(2,'0')} ${etime.period == DayPeriod.am ? "AM" : "PM"}';
  }

  bool checkTime(TimeOfDay stime, TimeOfDay etime) {
    int startTimeInMinutes = stime.hour * 60 + stime.minute;
    int endTimeInMinutes = etime.hour * 60 + etime.minute;
    return endTimeInMinutes > startTimeInMinutes;
  }

  var date = ''.obs;
  var dateForPicker = ''.obs;

  var endDate = ''.obs;
  var endDateForPicker = ''.obs;

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date); // Assuming date is in yyyy-MM-dd format
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    return formattedDate;
  }

  changeDate(DateTime dateTime) {
    dateForPicker.value = dateTime.toString();

    String formattedMonth = dateTime.month.toString().padLeft(2, '0');
    String formattedDay = dateTime.day.toString().padLeft(2, '0');

    date.value = '${dateTime.year}-$formattedMonth-$formattedDay';
  }


  changeEndDate(DateTime dateTime){
    endDateForPicker.value = dateTime.toString();

    String formattedMonth = dateTime.month.toString().padLeft(2, '0');
    String formattedDay = dateTime.day.toString().padLeft(2, '0');

    endDate.value = '${dateTime.year}-$formattedMonth-$formattedDay';
  }



  // changeDate(DateTime dateTime){
  //   dateForPicker.value = dateTime.toString();
  //   date.value = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  // }

  Rx<bool> choosePhotoCheck = false.obs;

  changeChoosePhotoVal() {
    choosePhotoCheck.value = !choosePhotoCheck.value;
  }

  var text = ''.obs;
  final int maxLength = 500;

  RxList galleryImages = [].obs;
  RxList glryImage = [].obs;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    galleryImages.add(File(photo!.path));
    print(galleryImages);
  }

  var containerList = [].obs;

  void addContainer() {
    containerList.length++;
    print(containerList.length);
  }

  void removeContainer(){
    if(galleryImages.length > 1) {
      containerList.length--;
    }
  }

  var circleIndex = 0.obs;
  changeIndicator(int currentIndex) {
    circleIndex.value = currentIndex;
  }

  var loading = false.obs;

  String uid = LocalStorage.getUid().toString();
  String token = LocalStorage.getToken().toString();

  final api = ApiServices();
  var catData = CategoryModel().obs;
  RxList<DropdownMenuItem<int>> categoryList = <DropdownMenuItem<int>>[].obs;
  RxList<DropdownMenuItem<int>> subcategoryList = <DropdownMenuItem<int>>[].obs;
  var subcategoryNameList = <Map<String, dynamic>>[].obs;

  void getSubCat(int catID){
    // subCatID.value = '';
    subcategoryList.clear();
    subcategoryNameList.clear();
    for(int i = 0; i<catData.value.result!.length;i++){
      if(catData.value.result![i].id == catID){
        catData.value.result![i].subcategories?.forEach((e) {
          subcategoryList.add(DropdownMenuItem(value: e.id,child: Text(e.title.toString())));
          subcategoryNameList.add({
            'id':e.id,
            'title':e.title
          });
        },);
      }
    }
  }

  var subCatName = ''.obs;

  void getSubCatName(int subCatID){
    subCatName.value = '';
    subcategoryNameList.forEach((element) {
      if(element['id'] == subCatID){
        subCatName.value = element['title'];
      }
    },);
  }

  var catLoading = false.obs;
  var catError = ''.obs;
  Future<void> getCategory() async{
    catLoading.value = true;
    var header = {
      'Authorization': 'Bearer $token'
    };
    try{
      final response = await api.get("${EndPoints.getCategoryApiUrl}$uid",headers: header);
      if(response.statusCode == 200){
        catError.value = '';
        categoryList.clear();
        catData.value = CategoryModel.fromJson(response.body);
        catData.value.result?.forEach((e) {
          categoryList.add(DropdownMenuItem(
            value: e.id,
            child: Text(e.title.toString()),
          ));
        });
        getSubCat(int.parse(activities!.categoryId.toString()));
      }else{
        catError.value = 'Error';
      }
    }catch(e){
      catError.value = e.toString();
      print('error == ${e.toString()}');
    }
    catLoading.value = false;
  }

  var catID = ''.obs;
  var subCatID = ''.obs;
  var titleController = TextEditingController().obs;
  var locController = TextEditingController().obs;
  var desController = TextEditingController().obs;
  // var timeZone = TextEditingController().obs;
  // var country = TextEditingController().obs;


  // bool isValidImageFormat(File imageFile) {
  //   String extension = imageFile.path.split('.').last.toLowerCase();
  //   return extension == 'jpg' || extension == 'jpeg' || extension == 'png';
  // }

  bool isValidImageFormat(dynamic imageFile) {
    if (imageFile is String) {
      String extension;

      if (imageFile.startsWith('http') || imageFile.startsWith('https')) {
        Uri uri = Uri.parse(imageFile);
        extension = uri.pathSegments.last.split('.').last.toLowerCase();
      } else {
        extension = imageFile.split('.').last.toLowerCase();
      }
      return extension == 'jpg' || extension == 'jpeg' || extension == 'png';
    } else {
      return false;
    }
  }


  // bool checkGalleryImagesFormat(List galleryImages) {
  //   var isValid = true.obs;
  //   for (var image in galleryImages) {
  //     if (!isValidImageFormat(image)) {
  //       isValid.value = false;
  //       return isValid.value;
  //     }
  //   }
  //   return isValid.value;
  // }

  // bool checkGalleryImagesFormat(List<dynamic> galleryImages) {
  //   var isValid = true.obs;
  //   for (var image in galleryImages) {
  //     String imagePath;
  //
  //     if (image is String) {
  //       imagePath = image;
  //     } else if (image is File) {
  //       imagePath = image.path;
  //     } else {
  //       print('Invalid image type: $image');
  //       isValid.value = false;
  //       return isValid.value;
  //     }
  //
  //     print('Checking image: $imagePath');
  //
  //
  //     if (!isValidImageFormat(imagePath)) {
  //       print('Invalid image format: $imagePath');
  //       isValid.value = false;
  //       return isValid.value;
  //     }
  //   }
  //   print('All images are valid.');
  //   return isValid.value;
  // }

  bool checkGalleryImagesFormat(List<dynamic> galleryImage) {
    var isValid = true.obs;
    var newList = [].obs;
    for (var image in galleryImage) {
      String imagePath;

      if (image is String) {
        Uri uri = Uri.parse(image);
        imagePath = uri.pathSegments.last;
      } else if (image is File) {
        imagePath = image.path.split('/').last;
      } else {
        print('Invalid image type: $image');
        isValid.value = false;
        return isValid.value;
      }

      print('Checking image: $imagePath');
      newList.add(imagePath);
      glryImage = newList;
      print(glryImage);

      if (!isValidImageFormat(imagePath)) {
        print('Invalid image format: $imagePath');
        isValid.value = false;
        return isValid.value;
      }
    }

    print('All images are valid.');
    return isValid.value;
  }

  // bool checkDateTime(String sDate, String eDate, TimeOfDay sTime, TimeOfDay eTime) {
  //   DateTime startDate = DateTime.parse(sDate);
  //   DateTime endDate = DateTime.parse(eDate);
  //
  //   if (startDate.year == endDate.year && startDate.month == endDate.month && startDate.day == endDate.day) {
  //     int startTimeInMinutes = sTime.hour * 60 + sTime.minute;
  //     int endTimeInMinutes = eTime.hour * 60 + eTime.minute;
  //     return endTimeInMinutes > startTimeInMinutes;
  //   }
  //   return true;
  // }


  bool checkDateTime(String sDate, String eDate, TimeOfDay sTime, TimeOfDay eTime) {
    DateTime startDate = DateTime.parse(sDate);
    DateTime endDate = DateTime.parse(eDate);
    DateTime now = DateTime.now();

    int startTimeInMinutes = sTime.hour * 60 + sTime.minute;
    int endTimeInMinutes = eTime.hour * 60 + eTime.minute;
    int currentTimeInMinutes = now.hour * 60 + now.minute + 60; // One hour after current time

    if (startDate.year == now.year && startDate.month == now.month && startDate.day == now.day) {
      if (startTimeInMinutes < currentTimeInMinutes) {
        showTostMsg('Start time should be at least one hour after current time.',gravity: ToastGravity.CENTER);
        return false;
      }
    }

    if (startDate.year == endDate.year && startDate.month == endDate.month && startDate.day == endDate.day) {
      if(endTimeInMinutes > startTimeInMinutes){
        return true;
      }else {
        showTostMsg(
            'Please select valid end time.', gravity: ToastGravity.CENTER);
        return false;
      }
    }

    return true;
  }


  Future<void> repeatActivity() async {
    loading.value = true;
    print("Latitude: ${latitude.value}");
    print("Longitude: ${longitude.value}");
    groupSize.value = int.parse(groupSizeController.value.text.isEmpty ? '0' : groupSizeController.value.text.toString());


    print('test == ${groupValue.value}  ${repeats.value}  ${wmValue.value}  ${repeatday.value}  ${wmValue.value}  ${repeatMonth.value}');

    try {
      print("=== ${checkGalleryImagesFormat(galleryImages)}");
      print("iamges gal == ${galleryImages}");

      if(!checkDateTime(date.value, endDate.value, TimeOfDay(
        hour: int.parse(sTime.value.split(":")[0]),
        minute: int.parse(sTime.value.split(":")[1]),
      ), TimeOfDay(
        hour: int.parse(eTime.value.split(":")[0]),
        minute: int.parse(eTime.value.split(":")[1]),
      ))){
        return;
      }

        var body = {
          'id': activities?.id.toString(),
          'date': date.value,
          'activity_end_date': endDate.value,
          'start_at': sTimeForApi.value,
          'end_at': eTimeForAPi.value,
        };
        var header = {
          'Authorization': 'Bearer ${LocalStorage.getToken()}'
        };
        var response = await api.post(EndPoints.repeatActivity, body,headers: header);
        print('repeat res == ${response.body} \n ${response.statusCode}');
        if(response.statusCode == 200){
          showTostMsg('Activity created successfully.');
          Get.back();
        }else if(response.statusCode == 401){
          // LocalStorage.removeToken();
          // Get.offAllNamed(Routes.initialPage);
          var data = response.body;
          showTostMsg('${data['message']}');
        }else if(response.statusCode == 499){
          LocalStorage.removeToken();
          Get.offAllNamed(Routes.initialPage);
          var data = response.body;
          showTostMsg('${data['message']}');
        }else{
          showTostMsg('Something went wrong.Please try again');
        }


      myactiController.hostingActivity();

    } catch (e) {
      showTostMsg('Something went wrong');
      loading.value = false;
      print(e);
    } finally {
      loading.value = false;
    }
    loading.value = false;
  }


  repeatRefresh(){
    counter.value = 1;
    wmValue.value = 1;
    repeatday.value = '';
    repeatMonth.value = '';
    groupValue.value = 0;
    Rdate.value = '';
    occs.value = 1;
    dayIndex.value = -1;
    monthIndex.value = -1;
  }


  var maxOcc = 0.obs;
  Future<void> getMaxOcc() async{

    var header = {
      'Authorization': 'Bearer $token'
    };
    try{
      var response = await api.get('${EndPoints.maxOcc}',headers: header);
      if(response.statusCode == 200){
        maxOcc.value = response.body['max_occurrences'];
        print('max==> ${maxOcc.value}');
      }else{

      }
    }catch(e){
      print('occ error == ${e.toString()}');
    }

  }



  // /// place api
  // RxList<String?> places = <String?>[].obs;
  // RxString _searchTerm = ''.obs;
  // final placesApi = GoogleMapsPlaces(apiKey: 'AIzaSyAP3QLpyPPT0ba8RnZCCEIHpMLnh_hPNRM');
  //
  // void onSearchChanged(String value, BuildContext context) async {
  //   print(value);
  //   _searchTerm.value = value;
  //   if (_searchTerm.isNotEmpty) {
  //     final results = await searchPlaces(
  //       _searchTerm.value,
  //     );
  //     places.value = results;
  //   }
  // }
  //
  // Future<List<String?>> searchPlaces(String searchTerm) async {
  //   // final response = await placesApi.searchByText(
  //   //   searchTerm,
  //   // );
  //   final response = await placesApi.autocomplete(searchTerm);
  //   // if(data.isOkay){
  //   //   print("=== ${data.predictions[0].id}  ${data.predictions[0].description}  ${data.predictions[0].matchedSubstrings}");
  //   // }
  //   if (response.isOkay) {
  //     print('location == ${response.predictions}');
  //     return response.predictions.map((e) => e.description,).toList();
  //   } else {
  //     return [];
  //   }
  // }




  /// place api
  RxList<Map<String, dynamic>> places = <Map<String,dynamic>>[].obs;
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

  Future<List<Map<String,dynamic>>> searchPlaces(String searchTerm) async {
    // final response = await placesApi.searchByText(
    //   searchTerm,
    // );
    final response = await placesApi.autocomplete(searchTerm);
    // if(data.isOkay){
    //   print("=== ${data.predictions[0].id}  ${data.predictions[0].description}  ${data.predictions[0].matchedSubstrings}");
    // }
    if (response.isOkay) {
      print('location == ${response.predictions}');
      print('location id == ${response.predictions.map((e) => e.placeId,)}');
      return response.predictions.map((e) => {'des':e.description,'id':e.placeId},).toList();
    } else {
      return [];
    }
  }
  ///

//
// ///////////////     Google Map     /////////////////////
//
//
//   GoogleMapController? mapController;
//   Rxn<loc.LocationData> currentLocation = Rxn<loc.LocationData>();
//
//   // Initial map position (default to somewhere)
//   final LatLng initialPosition = LatLng(52.3731, 4.8922);
//   RxSet<Marker> markers = <Marker>{}.obs;
//
//
//   Future<void> getUserLocation() async {
//     loc.Location location = loc.Location();
//
//     bool serviceEnabled;
//     loc.PermissionStatus permissionGranted;
//
//
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }
//
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == loc.PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != loc.PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     final userLocation = await location.getLocation();
//       currentLocation.value = userLocation;
//
//     // Move the camera to the user's location
//     mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(userLocation.latitude!, userLocation.longitude!),
//           zoom: 15,
//         ),
//       ),
//     );
//   }
//
//
//
//   void handleTap(LatLng tappedPoint) {
//       markers.clear();
//       markers.add(
//         Marker(
//           markerId: MarkerId(tappedPoint.toString()),
//           position: tappedPoint,
//           infoWindow: InfoWindow(
//             title: 'Selected Location',
//             snippet: '${tappedPoint.latitude}, ${tappedPoint.longitude}',
//           ),
//         ),
//       );
//   }

  GoogleMapController? mapController;
  Rxn<loc.LocationData> currentLocation = Rxn<loc.LocationData>();
  final LatLng initialPosition = LatLng(52.3731, 4.8922);
  RxSet<Marker> markers = <Marker>{}.obs;

  Future<void> getUserLocation() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    final userLocation = await location.getLocation();
    currentLocation.value = userLocation;

    // Move the camera to the user's location
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(userLocation.latitude!, userLocation.longitude!),
          zoom: 15,
        ),
      ),
    );
  }

  Rx<String> address =  ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  void handleTap(LatLng tappedPoint) async{
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        infoWindow: InfoWindow(
          title: 'Selected Location',
          snippet: '${tappedPoint.latitude}, ${tappedPoint.longitude}',
        ),
      ),
    );

    latitude.value = tappedPoint.latitude.toString();
    longitude.value = tappedPoint.longitude.toString();

    String apiKey = 'AIzaSyAP3QLpyPPT0ba8RnZCCEIHpMLnh_hPNRM'; // Add your API key here
    String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${tappedPoint.latitude},${tappedPoint.longitude}&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          // address.value = data['results'][0]['formatted_address'];
          address.value = data['results'][0]['formatted_address'];
          print(address.value);
          print('lat and long ${tappedPoint.latitude}, ${tappedPoint.longitude}');
        } else {

        }
      } else {
        print('Failed to fetch place details.');
      }
    } catch (e) {
      print('Error fetching place details: $e');
    }

    update(); // Notify listeners
  }




  final String apiKey = 'AIzaSyAP3QLpyPPT0ba8RnZCCEIHpMLnh_hPNRM';

  Future<void> getLatLang(var placeId) async {
    if (placeId != null) {
      var placeDetails = await getPlaceDetails(placeId!);
      updateLatLong(placeDetails['lat'], placeDetails['lng']);
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

  void updateLatLong(double lat, double long) {
    latitude.value = lat.toString();
    longitude.value = long.toString();
    print('lat == ${latitude.value}   lon == ${longitude.value}');
  }






}
