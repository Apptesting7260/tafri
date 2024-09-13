import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:plusone/uis/creativity/model/category_model.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';

class Creativitycontroller extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    desController.value.addListener(() {
      currentLength.value = desController.value.text.length;
    });
    getCategory();
    getMaxOcc();
    super.onInit();
  }


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

  // List daysList = ['monday','tuesday','wednesday','thursday','friday','staurday','sunday'];
  //
  // RxString repeatday = ''.obs;
  //
  // changeday(val) {
  //   daysList[val] = repeatday.value;
  //   debugPrint("dayslist==>${repeatday.value}");
  // }


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

  changeStime(TimeOfDay stime) {
    sTime.value = "${stime.hour}:${stime.minute}";
    sTimeForApi.value = '${stime.hour > 12 ? stime.hour - 12 : stime.hour}:${stime.minute} ${stime.period == DayPeriod.am ? "AM" : "PM"}';
  }

  RxString eTime = "".obs;
  var eTimeForAPi = ''.obs;

  changeEtime(TimeOfDay etime) {
    eTime.value = "${etime.hour}:${etime.minute}";
    eTimeForAPi.value = '${etime.hour > 12 ? etime.hour - 12 : etime.hour}:${etime.minute} ${etime.period == DayPeriod.am ? "AM" : "PM"}';
  }

  bool checkTime(TimeOfDay stime, TimeOfDay etime) {
    int startTimeInMinutes = stime.hour * 60 + stime.minute;
    int endTimeInMinutes = etime.hour * 60 + etime.minute;
    return endTimeInMinutes > startTimeInMinutes;
  }

  var date = ''.obs;
  var dateForPicker = ''.obs;
  changeDate(DateTime dateTime) {
    dateForPicker.value = dateTime.toString();

    String formattedMonth = dateTime.month.toString().padLeft(2, '0');
    String formattedDay = dateTime.day.toString().padLeft(2, '0');

    date.value = '${dateTime.year}-$formattedMonth-$formattedDay';
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

  RxList<File> galleryImages = <File>[].obs;

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
    subCatID.value = '';
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


  bool isValidImageFormat(File imageFile) {
    String extension = imageFile.path.split('.').last.toLowerCase();
    return extension == 'jpg' || extension == 'jpeg' || extension == 'png';
  }

  bool checkGalleryImagesFormat(List<File> galleryImages) {
    var isValid = true.obs;
    for (var image in galleryImages) {
      if (!isValidImageFormat(image)) {
        isValid.value = false;
        return isValid.value;
      }
    }
    return isValid.value;
  }

  Future<void> createActivity() async {
    loading.value = true;

    try {
      print("=== ${checkGalleryImagesFormat(galleryImages)}");
      if(!choosePhotoCheck.value && galleryImages.isEmpty) {
          showTostMsg('Please select Image',gravity: ToastGravity.CENTER);
      }else if(!checkGalleryImagesFormat(galleryImages)){
        showTostMsg('Image should be in .png, .jpg format.',gravity: ToastGravity.CENTER);
      } else if(catID.value.isEmpty){
        showTostMsg('Please select Category',gravity: ToastGravity.CENTER);
      }else if(subCatID.value.isEmpty){
        showTostMsg('Please select SubCategory',gravity: ToastGravity.CENTER);
      }else if(titleController.value.value.text.isEmpty){
        showTostMsg('Please Enter title',gravity: ToastGravity.CENTER);
      }else if(desController.value.text.isEmpty){
        showTostMsg('Please Enter Description',gravity: ToastGravity.CENTER);
      }else if(desController.value.text.length < 30){
        showTostMsg('Description length should be greater than 30 character.',gravity: ToastGravity.CENTER);
      }else if(locController.value.value.text.isEmpty){
        showTostMsg('Please Enter Location',gravity: ToastGravity.CENTER);
      }else if(date.value.isEmpty){
        showTostMsg('Please Select date',gravity: ToastGravity.CENTER);
      }else if(sTimeForApi.value.isEmpty){
        showTostMsg('Please Select start time',gravity: ToastGravity.CENTER);
      }else if(eTimeForAPi.value.isEmpty){
        showTostMsg('Please Select end time',gravity: ToastGravity.CENTER);
      }else if(
        !checkTime(TimeOfDay(
        hour: int.parse(sTime.value.split(":")[0]),
        minute: int.parse(sTime.value.split(":")[1]),
        ),TimeOfDay(
        hour: int.parse(eTime.value.split(":")[0]),
        minute: int.parse(eTime.value.split(":")[1]),
        ))
      ){
        showTostMsg("Please select valid end time.",gravity: ToastGravity.CENTER);
      }else if(groupSize.value < 2){
        showTostMsg('Please add more people',gravity: ToastGravity.CENTER);
      }else if(repeats.value == true){
        if(wmValue.value == 1){
          if(repeatday.value.isEmpty){
            showTostMsg('Please select the weekday',gravity: ToastGravity.CENTER);
          }
        }else if(wmValue.value == 2){
          if(repeatMonth.value.isEmpty){
            showTostMsg('Please select the month',gravity: ToastGravity.CENTER);
          }
        }else if(groupValue.value == 0){
            showTostMsg('Please select the ends',gravity: ToastGravity.CENTER);
        }else if(groupValue.value == 2){
          if(Rdate.value.isEmpty){
            showTostMsg('Please select the date',gravity: ToastGravity.CENTER);
          }
        }
      }else {
        var url = Uri.parse(EndPoints.createActivity);
        var request = await http.MultipartRequest('POST', url);
        if(!choosePhotoCheck.value) {
          if (galleryImages.isNotEmpty) {
            for (File image in galleryImages) {
              var stream = http.ByteStream(image.openRead());
              var length = await image.length();
              var multipartFile = http.MultipartFile(
                  'gallery_img[]', stream, length,
                  filename: image.path
                      .split('/')
                      .last);
              request.files.add(multipartFile);
              print(
                  'File name: ${multipartFile.filename}, Length: ${multipartFile
                      .length}');
            }
          }
        }

        if (!choosePhotoCheck.value) {
          if (galleryImages.isNotEmpty) {
            File image = galleryImages.first;
            var stream = http.ByteStream(image.openRead());
            var length = await image.length();
            var multipartFile = http.MultipartFile(
              'feature_img', stream, length,
              filename: image.path.split('/').last,
            );
            request.files.add(multipartFile);
          }
        }

        request.fields["category_id"] = catID.value;
        request.fields['subcategory_id'] = subCatID.value;
        request.fields['pick_photo_for_me'] = choosePhotoCheck.value ? '1' : '0';
        request.fields['description'] = desController.value.value.text.trim();
        request.fields['location'] = locController.value.value.text.trim();
        request.fields['date'] = date.value;
        request.fields['name'] = titleController.value.value.text.trim();
        request.fields['start_at'] = sTimeForApi.value;
        request.fields['end_at'] = eTimeForAPi.value;
        request.fields['max_people'] = groupSize.value.toString();
        request.fields['gender'] = gender.value == 1 ? 'same' : 'all';
        request.fields['repeat_status'] = repeats.value ? 'repeats' : 'not_repeat';
        request.fields['join_instantly'] = joinInstant.value ? '1' : '0';
        if(repeats.value == true){
          request.fields['repeat_every'] = counter.value.toString();
          request.fields['repeat_type'] = wmValue.value == 1 ? 'Week' : 'Month' ;
          request.fields['repeat_on'] = wmValue.value == 1 ? repeatday.value : repeatMonth.value;
          if(groupValue.value == 1){
            request.fields['end_type'] = 'never';
            debugPrint("end_type set to 'never'");
          }
          else if(groupValue.value == 2){
            request.fields['end_type'] = 'on_date';
            request.fields['end_date'] = Rdate.value;
            debugPrint("end_type set to 'on_date'");
            debugPrint("end_date set to: ${Rdate.value}");
          }
          else if(groupValue.value == 3){
            request.fields['end_type'] = 'after_occurrences';
            request.fields['occurrences'] = occs.value.toString();
            debugPrint("end_type set to 'after_occurrences'");
            debugPrint("occurrences set to: ${occs.value.toString()}");
          }
        }
        request.fields["host_id"] = uid;
        request.headers['Authorization'] = "Bearer $token";

        print("Category ID: ${catID.value}");
        print("Subcategory ID: ${subCatID.value}");
        print("Pick Photo For Me: ${choosePhotoCheck.value ? '1' : '0'}");
        print("Description: ${desController.value.value.text.trim()}");
        print("Location: ${locController.value.value.text.trim()}");
        print("Date: ${date.value}");
        print("Name: ${titleController.value.value.text.trim()}");
        print("Start At: ${sTimeForApi.value}");
        print("End At: ${eTimeForAPi.value}");
        print("Max People: ${groupSize.value}");
        print("Gender: ${gender.value == 1 ? 'same' : 'all'}");
        print("Repeat Status: ${repeats.value ? 'repeats' : 'not_repeat'}");
        print("Repeat Every: ${counter.value}");
        print("Repeat Type: ${wmValue.value == 1 ? 'Week' : 'Month'}");
        print("groupValue: ${groupValue.value}");



        // Send the request and get the response
        final streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        var responseBody = jsonDecode(response.body);

        print(responseBody);
        // Check the response status
        if (response.statusCode == 200) {
          loading.value = false;
          showTostMsg('Activity created successfully.Your activity is under review.');
          Get.back();
        } else {
          showTostMsg('Something went wrong');
          loading.value = false;
        }
      }


    } catch (e) {
      showTostMsg('Something went wrong');
      loading.value = false;
      print(e);
    } finally {
      loading.value = false;
    }
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



  /// place api
  RxList<String?> places = <String?>[].obs;
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

  Future<List<String?>> searchPlaces(String searchTerm) async {
    // final response = await placesApi.searchByText(
    //   searchTerm,
    // );
    final response = await placesApi.autocomplete(searchTerm);
    // if(data.isOkay){
    //   print("=== ${data.predictions[0].id}  ${data.predictions[0].description}  ${data.predictions[0].matchedSubstrings}");
    // }
    if (response.isOkay) {
      print('location == ${response.predictions}');
      return response.predictions.map((e) => e.description,).toList();
    } else {
      return [];
    }
  }
///

}
