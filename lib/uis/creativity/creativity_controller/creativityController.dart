import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:plusone/uis/creativity/model/category_model.dart';
import 'package:plusone/utils/local_storage.dart';

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
    super.onInit();
  }

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
  }

  RxBool joinInstant = false.obs;

  changejoinInstant() {
    joinInstant.value = !joinInstant.value;
  }

  RxString sTime = "".obs;

  changeStime(TimeOfDay stime) {
    sTime.value = "${stime.hour}:${stime.minute}";
  }

  RxString eTime = "".obs;

  changeEtime(TimeOfDay etime) {
    eTime.value = "${etime.hour}:${etime.minute}";
  }

  var date = ''.obs;
  var dateForPicker = ''.obs;
  changeDate(DateTime dateTime){
    dateForPicker.value = dateTime.toString();
    date.value = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }

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

  var loading = false.obs;

  String uid = LocalStorage.getUid().toString();
  String token = LocalStorage.getToken().toString();

  final api = ApiServices();
  var catData = CategoryModel().obs;
  RxList<DropdownMenuItem<int>> categoryList = <DropdownMenuItem<int>>[].obs;
  RxList<DropdownMenuItem<int>> subcategoryList = <DropdownMenuItem<int>>[].obs;

  void getSubCat(int catID){
    subCatID.value = null;
    subcategoryList.clear();
    for(int i = 0; i<catData.value.result!.length;i++){
      if(catData.value.result![i].id == catID){
        catData.value.result![i].subcategories?.forEach((e) {
          subcategoryList.add(DropdownMenuItem(value: e.id,child: Text(e.title.toString())));
        },);
      }
    }
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
  Rx<String?> subCatID = Rx<String?>(null);
  var titleController = TextEditingController();
  var locController = TextEditingController();
  var desController = TextEditingController().obs;


  Future<void> createActivity() async {
    loading.value = true;
    try {
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

      request.fields["category_id"] = catID.value;
      request.fields['subcategory_id'] = subCatID.value!;
      request.fields['pick_photo_for_me'] = choosePhotoCheck.value ? '1' : '0';
      request.fields['description'] = desController.value.value.text.trim();
      request.fields['location'] = locController.value.text.trim();
      request.fields['date'] = date.value;
      request.fields['name'] = titleController.value.text.trim();
      request.fields['start_at'] = sTime.value;
      request.fields['end_at'] = eTime.value;
      request.fields['max_people'] = groupSize.value.toString();
      request.fields['gender'] = gender.value == 1 ? 'Same gender as me' : 'all';
      request.fields['repeat_status'] = 'repeats';
      request.fields['join_instantly'] = joinInstant.value ? '1' : '0';
      request.fields["host_id"] = uid;
      request.headers['Authorization'] = "Bearer $token";

      // Send the request and get the response
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var responseBody = jsonDecode(response.body);

      print(responseBody);
      // Check the response status
      if (response.statusCode == 200) {
        loading.value = false;
        Get.back();
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      print(e);
    } finally {
      loading.value = false;
    }
  }



  /// place api
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
///



}
