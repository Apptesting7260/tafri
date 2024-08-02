import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custodropdownbtn.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'controller/filterexp_controller.dart';

class ExploreFilterUi extends GetWidget<FilterExpController> {
  ExploreFilterUi({super.key});

  ExploreListController exploreListController =
      Get.find<ExploreListController>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonUi.appBar(),
                          const Text(
                            "Filter",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      const Text(
                        "Category",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Obx(() {
                        List listCat = exploreListController.categryList;
                        // debugPrint("listCat=${listCat[1]}");
                        return Wrap(
                          spacing: 8,
                          runSpacing: 10,
                          children: listCat.map((e) {
                            return SizedBox(
                              height: Res.h_filter_btn,
                              child: CustoFilterBtn(
                                borderClr: clrBlacke,
                                lable: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                        child: e['image'] == null
                                            ? null
                                            : Image.asset(
                                                e['image'],
                                                height: Res.h_filter_btImg,
                                                color: e['isSelected']
                                                    ? clrWhite
                                                    : clrBlacke,
                                              )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(e['lbl'],
                                        style: TextStyle(
                                            color: e['isSelected']
                                                ? clrWhite
                                                : clrBlacke,
                                            fontSize: 13,
                                            fontWeight: e['isSelected']
                                                ? FontWeight.w700
                                                : FontWeight.w400))
                                  ],
                                ),
                                ontap: () {
                                  exploreListController.selectCategory(e['id']);
                                },
                                backgroundClr:
                                    e['isSelected'] ? clrBlacke : clrWhite,
                              ),
                            );
                          }).toList(),
                        );
                      }),
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      const Text(
                        "Location",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      SizedBox(
                        height: Res.h_btn,
                        child: CustoTextFormField(
                          hintText: "Search Location",
                          sufixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              "assets/icons/locationicon.png",
                              height: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      const Text(
                        "Group size",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      // CustoTextFormField(
                      //   hintText: "Up to 10 (incl. you)",
                      //   sufixIcon: Padding(
                      //     padding: const EdgeInsets.all(12.0),
                      //     child: Image.asset(
                      //       "assets/icons/manicon.png",
                      //       height: 15,
                      //     ),
                      //   ),
                      // ),
                      Container(
                          height: Res.h_btn,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: clrGreyLight),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/manicon.png",
                                      height: 23,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Flexible(
                                        child: Text(
                                      "Up to 10 (incl. you)",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: clrGreyTextLight),
                                    ))
                                  ],
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    exploreListController.decGroupSize();
                                  },
                                  child: const Icon(Icons.remove)),
                              SizedBox(
                                width: w * .01,
                              ),
                              Obx(() {
                                return Text(
                                    "${exploreListController.groupSize}");
                              }),
                              SizedBox(
                                width: w * .01,
                              ),
                              InkWell(
                                  onTap: () {
                                    exploreListController.incGroupSize();
                                  },
                                  child: const Icon(Icons.add))
                            ],
                          )),
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      const Text(
                        "Date",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Obx(() {
                        return Wrap(
                          spacing: 8,
                          runSpacing: 10,
                          children: [
                            SizedBox(
                              height: Res.h_filter_btn,
                              child: CustoFilterBtn(
                                lable: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                        child: Image.asset(
                                      "assets/icons/calendericon.png",
                                      height: h * .02,
                                      color: exploreListController
                                                      .filterDateStart.value !=
                                                  '' &&
                                              exploreListController
                                                      .filterDateCalenderEnd
                                                      .value !=
                                                  ''
                                          ? clrWhite
                                          : clrBlacke,
                                    )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        exploreListController
                                                        .filterDateStart.value !=
                                                    '' &&
                                                exploreListController
                                                        .filterDateCalenderEnd
                                                        .value !=
                                                    ''
                                            ? "${exploreListController.filterDateStart.value}-${exploreListController.filterDateEnd.value}"
                                            : "Pick a date",
                                        style: TextStyle(
                                            color: exploreListController
                                                            .filterDateStart
                                                            .value !=
                                                        '' &&
                                                    exploreListController
                                                            .filterDateCalenderEnd
                                                            .value !=
                                                        ''
                                                ? clrWhite
                                                : clrBlacke,
                                            fontSize: 13))
                                  ],
                                ),
                                ontap: () async {
                                  DateTimeRange? dateRange =
                                      await showDateRangePicker(
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime.now(),
                                    context: context,
                                    // initialDateRange: exploreListController.filterDateStart.value != '' &&
                                    //     exploreListController.filterDateCalenderEnd.value !=''?DateTime.parse("") : null
                                  );
                                  if (dateRange != null) {
                                    print("gk=====$dateRange");
                                    exploreListController
                                        .changeFilterDate(dateRange);
                                  }
                                },
                                borderClr: clrBlacke,
                                backgroundClr: exploreListController
                                                .filterDateStart.value !=
                                            '' &&
                                        exploreListController
                                                .filterDateCalenderEnd.value !=
                                            ''
                                    ? clrBlacke
                                    : clrWhite,
                              ),
                            ),
                            SizedBox(
                              height: Res.h_filter_btn,
                              child: CustoFilterBtn(
                                lable: Text("today",
                                    style: TextStyle(
                                        color: exploreListController
                                                .dateFilter['today']
                                            ? clrWhite
                                            : clrBlacke,
                                        fontSize: 13)),
                                ontap: () {
                                  exploreListController
                                      .changeDateFilter("today");
                                },
                                borderClr: clrBlacke,
                                backgroundClr: exploreListController
                                        .dateFilter.value['today']
                                    ? clrBlacke
                                    : clrWhite,
                              ),
                            ),
                            SizedBox(
                              height: Res.h_filter_btn,
                              child: CustoFilterBtn(
                                lable: Text("tomorrow",
                                    style: TextStyle(
                                        color: exploreListController
                                                .dateFilter.value['tomorrow']
                                            ? clrWhite
                                            : clrBlacke,
                                        fontSize: 13)),
                                ontap: () {
                                  exploreListController
                                      .changeDateFilter("tomorrow");
                                },
                                borderClr: clrBlacke,
                                backgroundClr: exploreListController
                                        .dateFilter.value['tomorrow']
                                    ? clrBlacke
                                    : clrWhite,
                              ),
                            ),
                            SizedBox(
                              height: Res.h_filter_btn,
                              child: CustoFilterBtn(
                                lable: Text("This week",
                                    style: TextStyle(
                                        color: exploreListController
                                                .dateFilter.value['week']
                                            ? clrWhite
                                            : clrBlacke,
                                        fontSize: 13)),
                                ontap: () {
                                  exploreListController
                                      .changeDateFilter("week");
                                },
                                borderClr: clrBlacke,
                                backgroundClr: exploreListController
                                        .dateFilter.value['week']
                                    ? clrBlacke
                                    : clrWhite,
                              ),
                            ),
                            SizedBox(
                              height: Res.h_filter_btn,
                              child: CustoFilterBtn(
                                lable: Text("This weekend",
                                    style: TextStyle(
                                        color: exploreListController
                                                .dateFilter.value['weekend']
                                            ? clrWhite
                                            : clrBlacke,
                                        fontSize: 13)),
                                ontap: () {
                                  exploreListController
                                      .changeDateFilter("weekend");
                                },
                                borderClr: clrBlacke,
                                backgroundClr: exploreListController
                                        .dateFilter.value['weekend']
                                    ? clrBlacke
                                    : clrWhite,
                              ),
                            ),
                          ],
                        );
                      }),
                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      const Text(
                        "Time",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      SizedBox(
                        height: Res.h_btn,
                        child: Obx(() {
                          // int val=exploreListController.timeFilter.value;
                          return CustoDropDownBtn(
                              val: exploreListController.timeFilter.value == 0
                                  ? null
                                  : exploreListController.timeFilter.value,
                              onchange: (val) {
                                exploreListController.changeTimeFilter(val);
                              },
                              prefixIcon: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: const Image(
                                    image: AssetImage(
                                        "assets/icons/timericon.png"),
                                    height: 3,
                                    width: 3,
                                  )),
                              itemList: const [
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text("Morning (Before 12:00)"),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text("Afternoon (12:00 - 18:00)"),
                                ),
                                DropdownMenuItem(
                                  value: 3,
                                  child: Text("Evening (After 18:00)"),
                                )
                              ],
                              hindtext: "Select Time");
                        }),
                      ),

                      SizedBox(
                        height: Get.height * 0.025,
                      ),
                      const Text(
                        "Gender",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      SizedBox(
                        height: Res.h_btn,
                        child: Obx(() {
                          return CustoDropDownBtn(
                              val: exploreListController.genderFilter.value == 0
                                  ? null
                                  : exploreListController.genderFilter.value,
                              onchange: (val) {
                                exploreListController.changeGenderFilter(val);
                              },
                              prefixIcon: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: const Image(
                                    image: AssetImage(
                                        "assets/icons/gendericon.png"),
                                    height: 3,
                                    width: 3,
                                  )),
                              itemList: const [
                                const DropdownMenuItem(
                                  value: 1,
                                  child: Text("Same gender as me"),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text("All"),
                                )
                              ],
                              hindtext: "Select");
                        }),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Text("Hide waitlist-only activities",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15)),
                          ),
                          SizedBox(
                              height: h * .05,
                              child: FittedBox(child: Obx(() {
                                return Switch(
                                  activeTrackColor: clrYellow,
                                  value: exploreListController
                                      .hideWaitListAct.value,
                                  onChanged: (val) {
                                    exploreListController
                                        .changeHideWaitListAct();
                                  },
                                  activeColor: clrWhite,
                                  focusColor: clrWhite,
                                  inactiveThumbColor: clrWhite,
                                  trackOutlineColor:
                                      WidgetStateProperty.all(clrTransparent),
                                  inactiveTrackColor: clrTrack,
                                );
                              })))
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.005,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: Res.h_btn,
                      child: CustoFilterBtn(
                        lable: Text(
                          "Reset",
                          style: TextStyle(
                              color: clrBlacke,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        ontap: () {
                          exploreListController.resetForm();
                        },
                        backgroundClr: clrWhite,
                        borderClr: clrBlacke,
                      ),
                    )),
                    SizedBox(
                      width: w * .03,
                    ),
                    Expanded(
                        child: SizedBox(
                      height: Res.h_btn,
                      child: CustoElevatedBtn(
                          onTap: () {},
                          backgroundClr: clrBlacke,
                          child: Text("Apply filter",
                              style: TextStyle(
                                  color: clrWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700))),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
