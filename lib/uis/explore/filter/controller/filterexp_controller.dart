import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import '../../../../networking/apiservices.dart';
import '../../../../networking/endpoints.dart';
import '../../../../utils/local_storage.dart';
import '../../../creativity/model/category_model.dart';
import '../../explorelist/controller/explorelist_controller.dart';

class FilterExpController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    getCategory();
    super.onInit();
  }

  var currentPage = 0.obs;
  var focusedDay = DateTime.now().obs;
  var daysInMonth = <int>[].obs;

  void updatePage(int index) {
    currentPage.value = index;
    final year = (index ~/ 12);
    final month = (index % 12) + 1;
    focusedDay.value = DateTime(year, month);
    _updateDaysInMonth(focusedDay.value);
  }

  void _updateDaysInMonth(DateTime date) {
    int daysInMonthCount = DateUtils.getDaysInMonth(date.year, date.month);
    daysInMonth.value = List.generate(daysInMonthCount, (index) => index + 1);
  }


  String uid = LocalStorage.getUid().toString();
  String token = LocalStorage.getToken().toString();

  final api = ApiServices();
  var catData = CategoryModel().obs;


  var catLoading = false.obs;
  var catError = ''.obs;

  var selectedList =[].obs;
  RxList<Result> categryList = <Result>[].obs;

  Future<void> getCategory() async{
    categryList.clear();
    catLoading.value = true;
    var header = {
      'Authorization': 'Bearer $token'
    };
    try{
      final response = await api.get("${EndPoints.getCategoryApiUrl}$uid",headers: header);
      if(response.statusCode == 200){
        catError.value = '';
        catData.value = CategoryModel.fromJson(response.body);
        if (catData.value.result != null) {
          categryList.addAll(catData.value.result!);
          selectedList.addAll(List<bool>.filled(categryList.length, false));
        }
      }else{
        catError.value = 'Error';
      }
    }catch(e){
      catError.value = e.toString();
      print('error == ${e.toString()}');
    }
    catLoading.value = false;
  }



  // selectCategory(int id) {
  //   for (var category in categryList) {
  //     if (category.id == id) {
  //       category.isSelected = true;
  //       print('object == ${category.isSelected}');
  //     } else {
  //       category.isSelected = false;
  //       print('object 2 == ${category.isSelected}');
  //     }
  //   }
  //   categryList.refresh();  // Trigger a UI update
  // }

  var selected =[].obs;

  void selectCategory(int id) {
    for (int i = 0; i < categryList.length; i++) {
      if (categryList[i].id == id) {
        categryList[i].isSelected = !categryList[i].isSelected;
        // selectedList[i] = !selectedList[i];
        if(categryList[i].isSelected == true){
          selected.add(categryList[i].id);
        }else{
          selected.remove(categryList[i].id);
        }
        print('id==>${selected}');
      } else {}
      categryList.refresh();
      selectedList.refresh();
      catData.refresh();
    }
  }


  ExploreListController exploreListController =
  Get.find<ExploreListController>();

  var categoryid = false.obs;

  var filterLoading = false.obs;

  TextEditingController locController = TextEditingController();

  RxInt groupSize = 1.obs;

  incGroupSize() {
    if (groupSize.value < 10) {
      groupSize.value += 1;
    }
  }

  decGroupSize() {
    if (groupSize.value > 1) {
      groupSize.value -= 1;
    }
  }

  Rx<String> filterDateStart = "".obs;
  Rx<String> filterDateCalenderStart = "".obs;

  Rx<String> filterDateEnd = "".obs;
  Rx<String> filterDateCalenderEnd = "".obs;

  changeFilterDate(DateTimeRange newDob) {
    log("gk newDob=${newDob}");
    filterDateStart.value = DateFormat("dd/MM/yyyy").format(newDob.start);
    filterDateCalenderStart.value =
        DateFormat("yyyy-MM-dd").format(newDob.start);

    filterDateEnd.value = DateFormat("dd/MM/yyyy").format(newDob.end);
    filterDateCalenderEnd.value = DateFormat("yyyy-MM-dd").format(newDob.end);
  }

  RxBool hideWaitListAct = false.obs;

  changeHideWaitListAct() {
    hideWaitListAct.value = !hideWaitListAct.value;
  }

  RxMap dateFilter = {
    "pickRange": false,
    "today": false,
    "tomorrow": false,
    "week": false,
    "weekend": false,
  }.obs;

  changeDateFilter(name) {
    dateFilter.value[name] = !dateFilter.value[name];
    dateFilter.refresh();
  }

  RxInt timeFilter = 0.obs;

  changeTimeFilter(val) {
    timeFilter.value = val;
  }

  RxInt genderFilter = 0.obs;

  changeGenderFilter(val) {
    genderFilter.value = val;
    print(genderFilter.value);
  }

  Future<void> filterActivity() async{


    Map body = {
      'user_id': LocalStorage.getUid(),
      'category_id': categoryid == true ? '' : selected,
      'location': locController.text.toString(),
      'max_people': groupSize.value,
      'date': LocalStorage.getUid(),
      'start_at': LocalStorage.getUid(),
      'end_at': LocalStorage.getUid(),
      'gender': genderFilter.value == 1 ? 'same' : genderFilter.value == 2 ? 'all' : '',
      'hide_waitlist': hideWaitListAct.value == true ? '1' : '0',
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    filterLoading.value = true;

    try{
      final response = await api.post(EndPoints.filter, body, headers: header);
      if(response.statusCode == 200){
        print('home data == ${response.body}');

      }else{
        print('error == ${response.body}');

      }
    }catch(e){
      print('home api error == ${e.toString()}');

    }

    filterLoading.value = false;

  }


  resetForm() {
    catData.value.result?.map((e) {
      e.isSelected = false;
      print(e.isSelected);
    });
    catData.refresh();
    categryList.value = catData.value.result!;
    selectedList.value = List.filled(catData.value.result!.length, false);
    selected.clear();
    dateFilter.value = <String, bool>{
      "pickRange": false,
      "today": false,
      "tomorrow": false,
      "week": false,
      "weekend": false,
    };
    groupSize.value = 1;
    timeFilter.value = 0;
    genderFilter.value = 0;
    hideWaitListAct.value = false;
    filterDateStart.value = "";
    filterDateCalenderStart.value = "";
    filterDateEnd.value = "";
    filterDateCalenderEnd.value = "";
    print('id==>${selectedList.value}');
    print('id==>${categryList[2].isSelected}');
  }



}