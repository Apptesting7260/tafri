import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/utils/tostmsg.dart';

import '../../../../networking/apiservices.dart';
import '../../../../networking/endpoints.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/local_storage.dart';
import '../../../../utils/size.dart';
import '../../../creativity/model/category_model.dart';
import '../../explorelist/controller/explorelist_controller.dart';
import '../filteractivity/model/filteractivity_model.dart';

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
      print(response.body);
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



  TextEditingController locController = TextEditingController();
  var groupSizeController = TextEditingController();

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
    "Pick a date": false,
    "today": false,
    "tomorrow": false,
    "week": false,
    "weekend": false,
  }.obs;

  // changeDateFilter(name) {
  //   dateFilter.value[name] = true;
  //   dateFilter.refresh();
  // }

  void changeDateFilter(String name) {
    dateFilter.updateAll((key, value) => false);
    if (dateFilter.containsKey(name)) {
      dateFilter[name] = true;
    }
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

  var filterDate = "".obs;

  var selectedTime = ''.obs;


  var filterLoading = false.obs;
  var filterError = "".obs;
  var filterActData = FilteractivityModel().obs;



  changeIndicator(index, currentIndex) {
    filterActData.value.result!.activities?[index].circleIndex?.value = currentIndex;
  }


  Future<void> filterActivity() async{

    var date = '';


    if (dateFilter['Pick a date'] == true) {
      date = filterDate.value;
    } else if (dateFilter['today'] == true) {
      date = 'today';
    } else if (dateFilter['tomorrow'] == true) {
      date = 'tomorrow';
    } else if (dateFilter['week'] == true) {
      date = 'this_week';
    } else if (dateFilter['weekend'] == true) {
      date = 'this_weekend';
    }

    print('date ==> ${date}');

    // Validation to ensure at least one of the fields has a value
    if (selected.isEmpty && locController.text.isEmpty && date.isEmpty
        && groupSizeController.text.isEmpty && categoryid == false
        && genderFilter.value == 0 && selectedTime.isEmpty
    ) {
      showTostMsg('Please select at least one filter.');
      return;
    }

    // Map body;

    // if(selected.isEmpty && locController.text.isEmpty && date.isEmpty
    //     && groupSize.value <= 1 && categoryid == true
    //     && genderFilter.value == 0 && selectedTime.isEmpty){
    //    body = {
    //     'user_id': LocalStorage.getUid(),
    //      'category_id': ''
    //    };
    // } else{
    //    body = {
    //     'user_id': LocalStorage.getUid(),
    //     'category_id': categoryid == true ? '' : selected,
    //      locController.value.text.isNotEmpty ? 'location': locController.value.text.toString() : null,
    //     'max_people': groupSize.value <2 ? '' : groupSize.value.toString(),
    //     'date': date,
    //     'time_slot': selectedTime.value,
    //     'gender': genderFilter.value == 1 ? 'same' : genderFilter.value == 2 ? 'all' : '',
    //     'hide_waitlist': hideWaitListAct.value == true ? '1' : '0',
    //   };
    // }

     Map body = {
      'user_id': LocalStorage.getUid(),
       if(categoryid == true) 'category_id': categoryid == true ? '' : selected,
       if(locController.value.text.isNotEmpty) 'location': locController.value.text.toString(),
       if(groupSizeController.value.text.isNotEmpty) 'max_people': groupSizeController.value.text.toString(),
       if(date.isNotEmpty) 'date': date,
       if(selectedTime.value.isNotEmpty) 'time_slot': selectedTime.value,
       if(genderFilter.value != 0) 'gender': genderFilter.value == 1 ? 'same' : genderFilter.value == 2 ? 'all' : '' ,
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
        filterError.value = '';
        print('home data == ${response.body}');
        filterActData.value = FilteractivityModel.fromJson(response.body);
        // resetForm();
        Get.toNamed(Routes.filterActUi);
      }else{
        filterError.value = 'ERROR';
        print('error == ${response.body}');

      }
    }catch(e){
      print('filter api error == ${e.toString()}');

    }
    filterLoading.value = false;
  }


  resetForm() {
    for (var category in catData.value.result!) {
      category.isSelected = false;
    }
    catData.refresh();
    categoryid.value = false;
    categryList.value = catData.value.result!;
    selectedList.value = List.filled(catData.value.result!.length, false);
    selected.clear();
    dateFilter.value = <String, bool>{
      "Pick a date": false,
      "today": false,
      "tomorrow": false,
      "week": false,
      "weekend": false,
    };
    // groupSize.value = 1;
    timeFilter.value = 0;
    genderFilter.value = 0;
    hideWaitListAct.value = false;
    filterDateStart.value = "";
    filterDateCalenderStart.value = "";
    filterDateEnd.value = "";
    filterDateCalenderEnd.value = "";
    selectedTime.value = "";
    locController.clear();
    groupSizeController.clear();
  }



  bool? isFavs = false;

  Future<bool?> changeFavApi(String? id) async{

    Map body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    try{
      final response = await api.post(EndPoints.changeFavurl, body,headers: header);
      if(response.statusCode == 200){
        isFavs = true;
        print('change data == ${response.body}');
        log(isFavs.toString());
        return isFavs;
      }else{
        print('error == ${response.body}');
        return false;
      }
    }catch(e){
      print('changeFav api error == ${e.toString()}');
      return false;
    }
  }

  showHomePop() async {
    Future.delayed(Duration.zero, () {
      return Get.dialog(AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          contentPadding:
          const EdgeInsets.only(left: 18,right: 18, top: 20,bottom: 30),
          content: SizedBox(
            width: Get.width * 0.87,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 35,
                    )),
                Center(
                  child: Image.asset(
                    "assets/icons/hifyicon.png",
                    height: 49,
                    width: 90,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                const Center(
                    child: Text(
                      "Welcome! Let’s get started",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    )),
                SizedBox(
                  height: Get.height * 0.012,
                ),
                const Center(
                  child: Text(
                    "To join activities, please become a PlusOnes member and complete your profile.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Nunito'),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.planMemUi);
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 18,right: 10,top: 12,bottom: 12,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: clrGreyLight),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/tajicon.png",
                          height: Get.height * 0.03,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  child: Text(
                                    "Become a member",
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                                  )),
                              Image.asset('assets/icons/arrow right.png',height: 14,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.myprofileInnUi);
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 18,right: 10,top: 12,bottom: 12,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: clrGreyLight),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/person.png",
                          height: Get.height * 0.03,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  child: Text("Complete profile",
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400))),
                              Image.asset('assets/icons/arrow right.png',height: 14)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )));
    });
  }


}