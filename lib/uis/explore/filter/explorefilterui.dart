import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:plusone/uis/components/custodropdownbtn.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/creativity/model/category_model.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
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
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
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
                                      CustoTextFormField(
                                        controll: controller.locController,
                                        hintText: "Search Location",
                                        sufixIcon: Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: Image.asset(
                                            "assets/icons/locationicon.png",
                                            height: 15,
                                          ),
                                        ),
                                      ),
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
                                      Container(
                                          height: Res.h_btn,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 13),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: clrGreyLight),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/manicon.png",
                                                      height: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Flexible(
                                                        child: Text(
                                                      "Up to 10 (incl. you)",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              clrGreyTextLight),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    controller
                                                        .decGroupSize();
                                                  },
                                                  child:
                                                      const Icon(Icons.remove)),
                                              SizedBox(
                                                width: w * .01,
                                              ),
                                              Obx(() {
                                                return Text(
                                                    "${controller.groupSize}");
                                              }),
                                              SizedBox(
                                                width: w * .01,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    controller
                                                        .incGroupSize();
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
                                                ontap: () {
                                                  // _showCustomDateRangePicker(context);
                                                  _showCustomDatePicker(
                                                      context,
                                                      DateTime.parse(controller
                                                                  .filterDateStart
                                                                  .value !=
                                                              ''
                                                          ? controller
                                                              .filterDateStart
                                                              .value
                                                          : DateTime.now()
                                                              .toString())
                                                  );
                                                  controller
                                                      .changeDateFilter(
                                                      "Pick a date");
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
                                                              ? "${controller.filterDateStart.value}"
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
                                                // ontap: () async {
                                                //   DateTimeRange? dateRange =
                                                //       await showDateRangePicker(
                                                //     firstDate: DateTime(1950),
                                                //     lastDate: DateTime.now(),
                                                //     context: context,
                                                //     builder: (context, child) {
                                                //       return Theme(
                                                //         data: ThemeData.light().copyWith(
                                                //           colorScheme: ColorScheme.light(
                                                //             primary: clrYellow, // Circle color
                                                //             onPrimary: clrBlacke, // Text color when selected
                                                //             surface: clrBlacke, // Circle background color
                                                //           ),
                                                //           datePickerTheme: DatePickerThemeData(
                                                //             rangeSelectionBackgroundColor: clrGrey
                                                //           ),
                                                //           dialogBackgroundColor: Colors.white, // Background color
                                                //           inputDecorationTheme: InputDecorationTheme(
                                                //             focusedBorder: OutlineInputBorder(
                                                //               borderSide: BorderSide(color: clrYellow),
                                                //               borderRadius: BorderRadius.circular(8.0),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //         child: child!,
                                                //       );
                                                //     },
                                                //     // initialDateRange: controller.filterDateStart.value != '' &&
                                                //     //     controller.filterDateCalenderEnd.value !=''?DateTime.parse("") : null
                                                //   );
                                                //   if (dateRange != null) {
                                                //     print("gk=====$dateRange");
                                                //     controller
                                                //         .changeFilterDate(dateRange);
                                                //   }
                                                // },

                                                // ontap: () async{
                                                //   showDialog(
                                                //       context: context,
                                                //       builder:  (BuildContext context){
                                                //         return Dialog(
                                                //           backgroundColor: clrWhite,
                                                //           insetPadding: EdgeInsets.all(0),
                                                //           child: Container(
                                                //             height: h * .6,
                                                //             width: w * .8,
                                                //             child: Column(
                                                //               children: [
                                                //                 Padding(
                                                //                   padding: const EdgeInsets.only(top: 24.0,left: 12),
                                                //                   child: Row(
                                                //                     children: [
                                                //                       Image.asset('assets/icons/close.png',scale: 4,),
                                                //                     ],
                                                //                   ),
                                                //                 )
                                                //               ],
                                                //             ),
                                                //           ),
                                                //         );
                                                //       }
                                                //   );
                                                // },

                                                // ontap: () async{
                                                //   Get.dialog(
                                                //     AlertDialog(
                                                //       insetPadding: EdgeInsets.all(0),
                                                //       content: Container(
                                                //         height: 300,
                                                //         child: Column(
                                                //           children: [
                                                //             Row(
                                                //               children: [
                                                //                 Expanded(child: Image.asset('assets/icons/close.png',scale: 4,)),
                                                //                 Expanded(child: Text("August 2024")),
                                                //               ],
                                                //             )
                                                //           ],
                                                //         ),
                                                //       ),
                                                //     )
                                                //   );
                                                // },

                                                // ontap: () async {
                                                //   Get.dialog(
                                                //     AlertDialog(
                                                //       insetPadding: EdgeInsets.all(0),
                                                //       content: Center(
                                                //         child: Container(
                                                //           height: 300, // Adjust the height to ensure everything fits
                                                //           child: Column(
                                                //             children: [
                                                //               Row(
                                                //                 children: [
                                                //                   Expanded(
                                                //                     child: GestureDetector(
                                                //                       onTap: () => Get.back(),
                                                //                       child: Image.asset('assets/icons/close.png', scale: 4),
                                                //                     ),
                                                //                   ),
                                                //                   Expanded(
                                                //                     child: Center(
                                                //                       child: Text("Select Month", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                                //                     ),
                                                //                   ),
                                                //                   Expanded(child: Container()), // Empty Expanded to balance the row
                                                //                 ],
                                                //               ),
                                                //               SizedBox(height: 20),
                                                //               Expanded(
                                                //                 child: PageView.builder(
                                                //                   controller: pageController,
                                                //                   onPageChanged: (index) {
                                                //                     controller.updatePage(index); // Using the controller method to update state
                                                //                   },
                                                //                   itemBuilder: (context, index) {
                                                //                     final year = (index ~/ 12);
                                                //                     final month = (index % 12) + 1;
                                                //                     final date = DateTime(year, month);
                                                //                     return Center(
                                                //                       child: Obx(() => Text(
                                                //                         DateFormat.yMMMM().format(date),
                                                //                         style: TextStyle(
                                                //                           fontSize: 18.09,
                                                //                           fontWeight: FontWeight.w500,
                                                //                           color: Color(0xff696565),
                                                //                         ),
                                                //                       )),
                                                //                     );
                                                //                   },
                                                //                 ),
                                                //               ),
                                                //             ],
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   );
                                                // },

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
                                                lable: Text("today",
                                                    style: TextStyle(
                                                        color: controller.dateFilter[
                                                                'today']
                                                            ? clrWhite
                                                            : clrBlacke,
                                                        fontSize: 13)),
                                                ontap: () {
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
                                                lable: Text("tomorrow",
                                                    style: TextStyle(
                                                        color: controller
                                                                    .dateFilter
                                                                    .value[
                                                                'tomorrow']
                                                            ? clrWhite
                                                            : clrBlacke,
                                                        fontSize: 13)),
                                                ontap: () {
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
                                        height: Get.height * 0.01,
                                      ),
                                      Obx(() {
                                        // int val=controller.timeFilter.value;
                                        return CustoDropDownBtn(
                                            val: controller
                                                        .timeFilter.value ==
                                                    0
                                                ? null
                                                : controller
                                                    .timeFilter.value,
                                            onchange: (val) {
                                              controller
                                                  .changeTimeFilter(val);
                                            },
                                            prefixIcon: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 10),
                                                child: const Image(
                                                  image: AssetImage(
                                                      "assets/icons/timericon.png"),
                                                  height: 3,
                                                  width: 3,
                                                )),
                                            suffix: Image.asset(
                                              'assets/images/arrow down.png',
                                              scale: 4,
                                            ),
                                            itemList: const [
                                              DropdownMenuItem(
                                                value: 1,
                                                child: Text(
                                                    "Morning (Before 12:00)"),
                                              ),
                                              DropdownMenuItem(
                                                value: 2,
                                                child: Text(
                                                    "Afternoon (12:00 - 18:00)"),
                                              ),
                                              DropdownMenuItem(
                                                value: 3,
                                                child: Text(
                                                    "Evening (After 18:00)"),
                                              )
                                            ],
                                            hindtext: "Select Time");
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
                                        height: Get.height * 0.01,
                                      ),
                                      Obx(() {
                                        return CustoDropDownBtn(
                                            val: controller
                                                        .genderFilter.value ==
                                                    0
                                                ? null
                                                : controller
                                                    .genderFilter.value,
                                            onchange: (val) {
                                              controller
                                                  .changeGenderFilter(val);
                                            },
                                            suffix: Image.asset(
                                              'assets/images/arrow down.png',
                                              scale: 4,
                                            ),
                                            prefixIcon: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 10),
                                                child: const Image(
                                                  image: AssetImage(
                                                      "assets/icons/gendericon.png"),
                                                  height: 3,
                                                  width: 3,
                                                )),
                                            itemList: const [
                                              const DropdownMenuItem(
                                                value: 1,
                                                child:
                                                    Text("Same gender as me"),
                                              ),
                                              DropdownMenuItem(
                                                value: 2,
                                                child: Text("All"),
                                              )
                                            ],
                                            hindtext: "Select");
                                      }),
                                      SizedBox(
                                        height: Get.height * 0.02,
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
                                            );
                                          })
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                          controller.resetForm();
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
                                      child: CustomElevatedButton(
                                          onTap: () {
                                            controller.filterActivity(
                                            );
                                          },
                                          backgroundClr: clrBlacke,
                                          child: Text("Apply filter",
                                              style: TextStyle(
                                                  color: clrWhite,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.w700))),
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
