import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/utils/size.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';

class ExploreListController extends GetxController {

  RxList<Widget> wrapWidList = <Widget>[].obs;

  RxList<Map> categoryFilter = [
    {
      "img": "assets/icons/sportsicon.png",
      "lable": "Sports",
      "isChecked": 0,
      "value": ""
    },
    {
      "img": "assets/icons/artsicon.png",
      "lable": "Arts",
      "isChecked": 0,
      "value": ""
    },
  ].obs;

  RxInt isReqSent = 0.obs;

  changeReqSent(intval) {
    isReqSent.value = intval;
  }

  RxList<Map> exploreListData = [
    {
      "img": ["assets/images/cofee.png", "assets/images/cofee.png"],
      "lable": "Coffee",
      "isFav": false,
      "title": "Picnic in the park",
      "location": "Vondelpark",
      "time": "13 March 2024 | 2:30 PM - 6:00PM",
      "poststotal": "3",
      "leftposts": "2",
      "hostname": "Jenny",
      "hostImg": "assets/images/girldp.png",
      "des":
          "Hey guys! Looking for 2 others who would like to join me for a picnic in the park today ,we all do games and dinner",
      "controller": CarouselController(),
      "currentCroIndex": 0,
    },
    {
      "img": ["assets/images/cofee.png"],
      "lable": "Coffee",
      "isFav": false,
      "title": "Picnic in the park",
      "location": "Vondelpark",
      "time": "13 March 2024 | 2:30 PM - 6:00PM",
      "poststotal": "3",
      "leftposts": "2",
      "hostname": "Jenny",
      "hostImg": "assets/images/girldp.png",
      "des":
          "Hey guys! Looking for 2 others who would like to join me for a picnic in the park today ,we all do games and dinner",
      "controller": CarouselController(),
      "currentCroIndex": 0,
    },
    {
      "img": ["assets/images/cofee.png"],
      "lable": "Coffee",
      "isFav": false,
      "title": "Picnic in the park",
      "location": "Vondelpark",
      "time": "13 March 2024 | 2:30 PM - 6:00PM",
      "poststotal": "3",
      "leftposts": "2",
      "hostname": "Jenny",
      "hostImg": "assets/images/girldp.png",
      "des":
          "Hey guys! Looking for 2 others who would like to join me for a picnic in the park today ,we all do games and dinner",
      "controller": CarouselController(),
      "currentCroIndex": 0,
    },
  ].obs;

  changeFav(index) {
    exploreListData.value[index]['isFav'] =
        !exploreListData.value[index]['isFav'];
    exploreListData.refresh();
  }

  changeIndicator(index, currentIndex) {
    exploreListData.value[index]['currentCroIndex'] = currentIndex;
    exploreListData.refresh();
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
                              Image.asset('assets/icons/arrow right.png')
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
                              Image.asset('assets/icons/arrow right.png')
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

//******************************--- explore filter ----*************
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

  RxList categryList = [
    {
      "id": 0,
      'image': "assets/icons/sportsicon.png",
      'lbl': "Sports",
      'isSelected': false,
    },
    {
      "id": 1,
      'image': "assets/icons/artsicon.png",
      'lbl': "Arts",
      'isSelected': false,
    },
    {
      "id": 2,
      'image': "assets/icons/learningicon.png",
      'lbl': "Learning",
      'isSelected': false,
    },
    {
      "id": 3,
      'image': "assets/icons/mp3icon.png",
      'lbl': "Entertainment",
      'isSelected': false,
    },
    {
      "id": 4,
      'image': "assets/icons/eatdrinkicon.png",
      'lbl': "Eats & drinks",
      'isSelected': false,
    },
    {
      "id": 5,
      'image': "assets/icons/eatdrinkicon.png",
      'lbl': "Eats & drinks",
      'isSelected': false,
    },
    {
      "id": 6,
      'image': null,
      'lbl': "All",
      'isSelected': false,
    }
  ].obs;

  selectCategory(id) {
    print("id=$id)");
    for (int i = 0; i < categryList.value.length; i++) {
      if (categryList.value[i]['id'] == id) {
        categryList.value[i]['isSelected'] =
            !categryList.value[i]['isSelected'];
      }
    }
    categryList.refresh();
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
  }

  //******************************--- clear filter ----*************
  resetForm() {
    categryList.value = <Map<String, Object?>>[
      {
        "id": 0,
        'image': "assets/icons/sportsicon.png",
        'lbl': "Sports",
        'isSelected': false,
      },
      {
        "id": 1,
        'image': "assets/icons/artsicon.png",
        'lbl': "Arts",
        'isSelected': false,
      },
      {
        "id": 2,
        'image': "assets/icons/learningicon.png",
        'lbl': "Learning",
        'isSelected': false,
      },
      {
        "id": 3,
        'image': "assets/icons/mp3icon.png",
        'lbl': "Entertainment",
        'isSelected': false,
      },
      {
        "id": 4,
        'image': "assets/icons/eatdrinkicon.png",
        'lbl': "Eats & drinks",
        'isSelected': false,
      },
      {
        "id": 5,
        'image': "assets/icons/eatdrinkicon.png",
        'lbl': "Eats & drinks",
        'isSelected': false,
      },
      {
        "id": 6,
        'image': null,
        'lbl': "All",
        'isSelected': false,
      }
    ];
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
  }
}
