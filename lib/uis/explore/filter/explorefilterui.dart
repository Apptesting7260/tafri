import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/components/location_form_field.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/custom_date_selector.dart';
import 'package:plusone/utils/custom_switch.dart';
import 'package:plusone/utils/size.dart';
import '../../../utils/error_widget.dart';
import 'controller/filterexp_controller.dart';

class ExploreFilterUi extends GetWidget<FilterExpController> {
  ExploreFilterUi({super.key});


  final PageController pageController = PageController();

  String _selectedRange = 'Select a date range';

  // Future<void> _showCustomDateRangePicker(BuildContext context) async {
  //   final List<DateTime?>? picked = await showDialog(
  //     context: context,
  //     builder: (context) => CustomDateRangePicker(),
  //   );
  //
  //   // if (picked != null && picked.length == 2) {
  //   //     _selectedRange =
  //   //     '${picked[0]?.toLocal().toShortDateString()} - ${picked[1]?.toLocal().toShortDateString()}';
  //   // }
  // }


  void _showCustomDatePicker(BuildContext context, DateTime? date) async {
    DateTime? selectedDate = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDateRangePicker(
          date: date,
        );
      },
    );

    if (selectedDate != null) {
      // Use the formatted date in the controller
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
      controller.filterDateStart.value = formattedDate;
      controller.filterDate.value = formattedDate; // Ensure both are updated
      print("Selected date: $formattedDate");
    }
  }


  // void _showCustomDatePicker(BuildContext context, DateTime? date) async {
  //   DateTime? selectedDate = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CustomDateRangePicker(
  //         date: date,
  //       );
  //     },
  //   );
  //
  //   if (selectedDate != null) {
  //     // Handle selected date
  //     controller.filterDateStart.value =
  //         DateFormat('yyyy-MM-dd').format(selectedDate).toString();
  //     print("Selected date: $selectedDate");
  //     controller.filterDate.value = selectedDate.toString();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: clrWhite,
          body: Obx(
            () => controller.catLoading.value
                ? Center(
                    child: CommonUi.scaffoldLoading(color: clrYellow),
                  )
                : controller.catError.value.isNotEmpty
                    ? const Center(child: ErrorScreen())
                    : SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Res.Defalt_side_margin),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CommonUi.appBar(),
                                          const Text(
                                            "Filter",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 24),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: Text(
                                                "Hide waitlist-only activities",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15)),
                                          ),
                                          Obx(() {
                                            return CustomSwitch(
                                              value: controller
                                                  .hideWaitListAct.value,
                                              onChanged: (p0) {
                                                controller
                                                    .changeHideWaitListAct();
                                              },
                                              height: 20,
                                              width: 35,
                                              iWidth: 16,
                                              iHeight: 16,
                                            );
                                          })
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      const Text(
                                        "Category",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.015,
                                      ),
                                      // Obx(() {
                                      //   return Wrap(
                                      //     spacing: 7,
                                      //     runSpacing: 9,
                                      //     children: controller
                                      //         .catData.value.result!
                                      //         .map((e) {
                                      //       return SizedBox(
                                      //         height: Res.h_filter_btn,
                                      //         child: CustoFilterBtn(
                                      //           borderClr: clrBlacke,
                                      //           lable: Row(
                                      //             mainAxisSize:
                                      //                 MainAxisSize.min,
                                      //             children: [
                                      //               SizedBox(
                                      //                   child: e.icon == null
                                      //                       ? null
                                      //                       : CachedNetworkImage(
                                      //                           imageUrl:
                                      //                               '${e.icon}',
                                      //                           scale: 1,
                                      //                           // color: e.isSelected
                                      //                           //     ? clrWhite
                                      //                           //     : clrBlacke,
                                      //                         )
                                      //               ),
                                      //               const SizedBox(
                                      //                 width: 5,
                                      //               ),
                                      //               Text(e.title.toString(),
                                      //                   style: TextStyle(
                                      //                       color: e.isSelected
                                      //                           ? clrWhite
                                      //                           : clrBlacke,
                                      //                       fontSize: 13,
                                      //                       fontWeight:
                                      //                           e.isSelected
                                      //                               ? FontWeight
                                      //                                   .w700
                                      //                               : FontWeight
                                      //                                   .w400))
                                      //             ],
                                      //           ),
                                      //           ontap: () {
                                      //             controller.selectCategory(e.id!);
                                      //           },
                                      //           backgroundClr: e.isSelected
                                      //               ? clrBlacke
                                      //               : clrWhite,
                                      //         ),
                                      //       );
                                      //     }).toList(),
                                      //   );
                                      // }),
                                      Obx(() {
                                        List<Widget> items = [
                                          ...controller.catData.value.result!.map((e) {
                                            return SizedBox(
                                              height: Res.h_filter_btn,
                                              child: catButton(
                                                borderClr: clrBlacke,
                                                lable: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 2,right: 2),
                                                      child: SizedBox(
                                                        child: e.icon == null
                                                            ? null
                                                            : CachedNetworkImage(
                                                          imageUrl: '${e.icon}',
                                                          memCacheWidth: 500,
                                                          scale: 1,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 8),
                                                      child: Text(
                                                        e.title.toString(),
                                                        style: TextStyle(
                                                          color: e.isSelected ? clrWhite : clrBlacke,
                                                          fontSize: 13,
                                                          fontWeight: e.isSelected ? FontWeight.w700 : FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  controller.selectCategory(e.id!);
                                                  controller.categoryid.value = false;
                                                },
                                                backgroundClr: e.isSelected ? clrBlacke : clrWhite,
                                              ),
                                            );
                                          }).toList(),
                                          SizedBox(
                                            height: Res.h_filter_btn,
                                            child: CustoFilterBtn(
                                              borderClr: clrBlacke,
                                              lable: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "All",
                                                    style: TextStyle(
                                                      color: controller.categoryid.value ? clrWhite : clrBlacke,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ontap: () {
                                                controller.categoryid.value = !controller.categoryid.value;
                                                for (var category in controller.catData.value.result!) {
                                                  category.isSelected = false;
                                                }
                                                controller.selected.clear();
                                              },
                                              backgroundClr: controller.categoryid.value ? clrBlacke : clrWhite,
                                            ),
                                          ),
                                        ];
                                        return Wrap(
                                          spacing: 7,
                                          runSpacing: 9,
                                          children: items,
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
                                        height: 40,
                                        child: CustomLocationField(
                                          itemBuilder: (context, suggestion) {
                                            return ListTile(
                                              title: Text(suggestion.toString()),
                                            );
                                          },
                                            cursorHeight: 25,
                                          suggestionsCallback: (value) async{
                                            return controller.searchPlaces(value);
                                          },
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
                                          hintText: "Search location",
                                          controller: controller.locController,
                                          onSelected: (value) {
                                            controller.locController.text = value.toString();
                                          },
                                          sufixIcon: Image.asset('assets/icons/locationicon.png',scale: 2.5,)
                                          // Container(
                                          //     padding: const EdgeInsets.symmetric(
                                          //         horizontal: 12, vertical: 13),
                                          //     child: const Image(
                                          //       image: AssetImage(
                                          //           "assets/icons/locationicon.png"),
                                          //       height: 1,
                                          //       width: 1,
                                          //     )),
                                        ),
                                      ),
                                      // CustoTextFormField(
                                      //   controll: controller.locController,
                                      //   hintText: "Search Location",
                                      //   sufixIcon: Padding(
                                      //     padding: const EdgeInsets.all(13.0),
                                      //     child: Image.asset(
                                      //       "assets/icons/locationicon.png",
                                      //       height: 15,
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      const Text(
                                        "Group size",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
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

                                      SizedBox(
                                        height: 40,
                                        child: CustoTextFormField(
                                          controll: controller.groupSizeController,
                                          hintText: "Up to 10 (incl. you)",
                                          sufixIcon: Image.asset(
                                            "assets/icons/manicon.png",
                                            scale: 2.5,
                                          ),
                                          hintSize: 14,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
                                          textKType: TextInputType.number,
                                        ),
                                      ),

                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      const Text(
                                        "Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Obx(() {
                                        return Wrap(
                                          spacing: 7,
                                          runSpacing: 9,
                                          children: [
                                            SizedBox(
                                              height: Res.h_filter_btn,
                                              child: CustoFilterBtn(
                                                ontap: () async {
                                                  // _showCustomDateRangePicker(context);
                                                  // _showCustomDatePicker(
                                                  //     context,
                                                  //     DateTime.parse(controller
                                                  //                 .filterDateStart
                                                  //                 .value !=
                                                  //             ''
                                                  //         ? controller
                                                  //             .filterDateStart
                                                  //              .value
                                                  //         : DateTime.now()
                                                  //             .toString())
                                                  // );
                                                  DateTimeRange? picked = await showDateRangePicker(
                                                    context: context,
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2031),
                                                    initialDateRange: controller.initialRange?.value,
                                                    builder: (BuildContext context, Widget? child) {
                                                      return Theme(
                                                        data: ThemeData.light().copyWith(
                                                          primaryColor: clrBlacke,
                                                          scaffoldBackgroundColor: Colors.white,
                                                          appBarTheme: AppBarTheme(
                                                            color: clrBlacke,
                                                          ),
                                                          colorScheme: ColorScheme.light(
                                                            primary: clrYellow,
                                                            onPrimary: Colors.white,
                                                            surface: clrBlacke,
                                                            onSurface: clrBlacke,
                                                            secondary: clrGreyLight
                                                          ),
                                                          dialogBackgroundColor: Colors.white,
                                                        ),
                                                        child: child!,
                                                      );
                                                    },
                                                  );

                                                  // controller
                                                  //     .changeDateFilter(
                                                  //     "Pick a date");
                                                  if (picked != null) {
                                                    controller.changeFilterDate(picked);
                                                    controller.initialRange?.value = picked;
                                                    // controller.filterDateStart.value =
                                                    // "${picked.start.day}/${picked.start.month}/${picked.start.year}";
                                                    // controller.filterDateEnd.value =
                                                    // controller.filterDateCalenderEnd.value =
                                                    // "${picked.end.day}/${picked.end.month}/${picked.end.year}";

                                                    // This will update the label with the selected date range
                                                    controller.changeDateFilter("Pick a date");
                                                  }
                                                },
                                                lable: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                        child: Image.asset(
                                                      "assets/icons/calendericon.png",
                                                      height: h * .02,
                                                      color: controller
                                                                      .filterDateStart
                                                                      .value !=
                                                                  '' ||
                                                              controller
                                                                      .filterDateCalenderEnd
                                                                      .value !=
                                                                  ''
                                                          ? clrWhite
                                                          : clrBlacke,
                                                    )),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Obx(
                                                      () => Text(
                                                          controller.filterDateStart
                                                                          .value !=
                                                                      '' ||
                                                                  controller
                                                                          .filterDateCalenderEnd
                                                                          .value !=
                                                                      ''
                                                              ? "${controller.filterDateCalenderStart.value} - ${controller.filterDateCalenderEnd.value}"
                                                              : "Pick a date",
                                                          style: TextStyle(
                                                              color: controller
                                                                              .filterDateStart
                                                                              .value !=
                                                                          '' ||
                                                                      controller
                                                                              .filterDateCalenderEnd
                                                                              .value !=
                                                                          ''
                                                                  ? clrWhite
                                                                  : clrBlacke,
                                                              fontSize: 13)),
                                                    )
                                                  ],
                                                ),
                                                borderClr: clrBlacke,
                                                backgroundClr: controller
                                                                .filterDateStart
                                                                .value !=
                                                            '' ||
                                                        controller
                                                                .filterDateCalenderEnd
                                                                .value !=
                                                            ''
                                                    ? clrBlacke
                                                    : clrWhite,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Res.h_filter_btn,
                                              child: CustoFilterBtn(
                                                lable: Text("Today",
                                                    style: TextStyle(
                                                        color: controller.dateFilter[
                                                                'today']
                                                            ? clrWhite
                                                            : clrBlacke,
                                                        fontSize: 13)),
                                                ontap: () {
                                                  controller.filterDateCalenderStart.value = '';
                                                  controller.filterDateCalenderEnd.value = '';
                                                  controller.filterDateStart.value = '';
                                                  controller.filterDateEnd.value = '';
                                                  controller
                                                      .changeDateFilter(
                                                          "today");
                                                },
                                                borderClr: clrBlacke,
                                                backgroundClr:
                                                    controller
                                                            .dateFilter
                                                            .value['today']
                                                        ? clrBlacke
                                                        : clrWhite,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Res.h_filter_btn,
                                              child: CustoFilterBtn(
                                                lable: Text("Tomorrow",
                                                    style: TextStyle(
                                                        color: controller
                                                                    .dateFilter
                                                                    .value[
                                                                'tomorrow']
                                                            ? clrWhite
                                                            : clrBlacke,
                                                        fontSize: 13)),
                                                ontap: () {
                                                  controller.filterDateCalenderStart.value = '';
                                                  controller.filterDateCalenderEnd.value = '';
                                                  controller.filterDateStart.value = '';
                                                  controller.filterDateEnd.value = '';
                                                  controller
                                                      .changeDateFilter(
                                                          "tomorrow");
                                                },
                                                borderClr: clrBlacke,
                                                backgroundClr:
                                                    controller
                                                            .dateFilter
                                                            .value['tomorrow']
                                                        ? clrBlacke
                                                        : clrWhite,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Res.h_filter_btn,
                                              child: CustoFilterBtn(
                                                lable: Text("This week",
                                                    style: TextStyle(
                                                        color:
                                                            controller
                                                                    .dateFilter
                                                                    .value['week']
                                                                ? clrWhite
                                                                : clrBlacke,
                                                        fontSize: 13)),
                                                ontap: () {
                                                  controller.filterDateCalenderStart.value = '';
                                                  controller.filterDateCalenderEnd.value = '';
                                                  controller.filterDateStart.value = '';
                                                  controller.filterDateEnd.value = '';
                                                  controller
                                                      .changeDateFilter("week");
                                                },
                                                borderClr: clrBlacke,
                                                backgroundClr:
                                                    controller
                                                            .dateFilter
                                                            .value['week']
                                                        ? clrBlacke
                                                        : clrWhite,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Res.h_filter_btn,
                                              child: CustoFilterBtn(
                                                lable: Text("This weekend",
                                                    style: TextStyle(
                                                        color: controller
                                                                    .dateFilter
                                                                    .value[
                                                                'weekend']
                                                            ? clrWhite
                                                            : clrBlacke,
                                                        fontSize: 13)),
                                                ontap: () {
                                                  controller.filterDateCalenderStart.value = '';
                                                  controller.filterDateCalenderEnd.value = '';
                                                  controller.filterDateStart.value = '';
                                                  controller.filterDateEnd.value = '';
                                                  controller
                                                      .changeDateFilter(
                                                          "weekend");
                                                },
                                                borderClr: clrBlacke,
                                                backgroundClr:
                                                    controller
                                                            .dateFilter
                                                            .value['weekend']
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
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.005,
                                      ),
                                      Obx(() {
                                        // int val=controller.timeFilter.value;
                                        return CustomDropdown(
                                          initialItem: controller.time(),
                                          closedHeaderPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 17),
                                          hintText: 'Select time',
                                            items: controller.timelist.map((e) {
                                              return e['value'];
                                            },).toList(),
                                            onChanged: (val) {
                                              switch (val) {
                                                case 'Morning (Before 12:00)':
                                                  controller.selectedTime.value = "morning";
                                                  break;
                                                case 'Afternoon (12:00 - 18:00)':
                                                  controller.selectedTime.value = "afternoon";
                                                  break;
                                                case 'Evening (After 18:00)':
                                                  controller.selectedTime.value = "evening";
                                                  break;
                                                default:
                                                  controller.selectedTime.value = "";
                                              }
                                            },
                                          decoration: CustomDropdownDecoration(
                                              hintStyle: TextStyle(
                                                  color: clrBlacke.withOpacity(0.6),
                                                  fontSize: 15

                                              ),
                                              closedSuffixIcon: Image.asset(
                                                'assets/images/arrow down.png',
                                                scale: 4,
                                              ),
                                              expandedSuffixIcon: Image.asset(
                                                'assets/images/arrow down.png',
                                                scale: 4,
                                              ),
                                              prefixIcon: Image.asset(
                                                'assets/icons/timericon.png',
                                                scale: 2.5,
                                              ),
                                              closedFillColor: clrGreyLight,
                                              closedBorderRadius: BorderRadius.circular(100)
                                          ),
                                        );
                                          // CustoDropDownBtn(
                                          //   val: controller.timeFilter.value == 0
                                          //       ? null
                                          //       : controller.timeFilter.value,
                                          //   onchange: (val) {
                                          //
                                          //     switch (val) {
                                          //       case 1:
                                          //         controller.selectedTime.value = "morning";
                                          //         break;
                                          //       case 2:
                                          //         controller.selectedTime.value = "afternoon";
                                          //         break;
                                          //       case 3:
                                          //         controller.selectedTime.value = "evening";
                                          //         break;
                                          //       default:
                                          //         controller.selectedTime.value = "";
                                          //     }
                                          //     controller.changeTimeFilter(val);
                                          //   },
                                          //   prefixIcon: Container(
                                          //       padding:
                                          //           const EdgeInsets.symmetric(
                                          //               horizontal: 12,
                                          //               vertical: 10),
                                          //       child: const Image(
                                          //         image: AssetImage(
                                          //             "assets/icons/timericon.png"),
                                          //         height: 3,
                                          //         width: 3,
                                          //       )),
                                          //   suffix: Image.asset(
                                          //     'assets/images/arrow down.png',
                                          //     scale: 4,
                                          //   ),
                                          //   itemList: const [
                                          //     DropdownMenuItem(
                                          //       value: 1,
                                          //       child: Text(
                                          //           "Morning (Before 12:00)"),
                                          //     ),
                                          //     DropdownMenuItem(
                                          //       value: 2,
                                          //       child: Text(
                                          //           "Afternoon (12:00 - 18:00)"),
                                          //     ),
                                          //     DropdownMenuItem(
                                          //       value: 3,
                                          //       child: Text(
                                          //           "Evening (After 18:00)"),
                                          //     )
                                          //   ],
                                          //   hindtext: "Select Time");
                                      }),

                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      const Text(
                                        "Gender",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.005,
                                      ),
                                      Obx(() {
                                        return CustomDropdown(
                                          initialItem: controller.gender(),
                                          closedHeaderPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 17),
                                          hintText: 'Select Gender',
                                          items: controller.genderlist.map((e) {
                                            return e['value'];
                                          },).toList(),
                                          onChanged: (val) {
                                            if(val == 'All'){
                                              controller.genderFilter.value = 2;
                                            }else if(val  == 'Same gender as me'){
                                              controller.genderFilter.value = 1;
                                            }
                                          },
                                          decoration: CustomDropdownDecoration(
                                              hintStyle: TextStyle(
                                                  color: clrBlacke.withOpacity(0.6),
                                                  fontSize: 15

                                              ),
                                              closedSuffixIcon: Image.asset(
                                                'assets/images/arrow down.png',
                                                scale: 4,
                                              ),
                                              expandedSuffixIcon: Image.asset(
                                                'assets/images/arrow down.png',
                                                scale: 4,
                                              ),
                                              prefixIcon: Image.asset(
                                                'assets/icons/gendericon.png',
                                                scale: 2.5,
                                              ),
                                              closedFillColor: clrGreyLight,
                                              closedBorderRadius: BorderRadius.circular(100)
                                          ),
                                        );
                                          // CustoDropDownBtn(
                                          //   val: controller
                                          //               .genderFilter.value ==
                                          //           0
                                          //       ? null
                                          //       : controller
                                          //           .genderFilter.value,
                                          //   onchange: (val) {
                                          //     controller
                                          //         .changeGenderFilter(val);
                                          //   },
                                          //   suffix: Image.asset(
                                          //     'assets/images/arrow down.png',
                                          //     scale: 4,
                                          //   ),
                                          //   prefixIcon: Container(
                                          //       padding:
                                          //           const EdgeInsets.symmetric(
                                          //               horizontal: 12,
                                          //               vertical: 10),
                                          //       child: const Image(
                                          //         image: AssetImage(
                                          //             "assets/icons/gendericon.png"),
                                          //         height: 3,
                                          //         width: 3,
                                          //       )),
                                          //   itemList: const [
                                          //     const DropdownMenuItem(
                                          //       value: 1,
                                          //       child:
                                          //           Text("Same gender as me"),
                                          //     ),
                                          //     DropdownMenuItem(
                                          //       value: 2,
                                          //       child: Text("All"),
                                          //     )
                                          //   ],
                                          //   hindtext: "Select");
                                      }),
                                      SizedBox(
                                        height: Get.height * 0.005,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: SizedBox(
                                          // height: h*0.05,
                                          child: CustomElevatedButton(
                                              onTap: () {
                                                controller.resetForm();
                                              },
                                              backgroundClr: clrWhite,
                                              borderClr: clrBlacke,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 5),
                                                child: Text("Reset",
                                                    style: TextStyle(
                                                        color: clrBlacke,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w700)),
                                              )),
                                    )),
                                    SizedBox(
                                      width: w * .03,
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      // height: h*0.05,
                                      child: CustomElevatedButton(
                                          onTap: () {
                                            controller.filterActivity();
                                          },
                                          backgroundClr: controller.filterLoading.value ? clrGrey : clrBlacke,
                                          child: controller.filterLoading.value
                                              ? CommonUi.buttonLoading()
                                              : Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 5),
                                                child: Text("Apply filter",
                                                style: TextStyle(
                                                    color: clrWhite,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700)),
                                              )),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          )),
    );
  }

  Widget catButton({Color? borderClr,required dynamic Function() onTap,required Color backgroundClr, required Widget lable}){
    return CustomElevatedButton(
        borderClr: borderClr,
        paddingHz: 2,
        paddingVr: 3,
        onTap: onTap,
        backgroundClr: backgroundClr,
        child: lable);
  }

}
