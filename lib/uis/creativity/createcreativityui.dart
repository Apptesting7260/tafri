import 'dart:ffi';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custodropdownbtn.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/components/location_form_field.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/custom_switch.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/colors.dart';
import '../../utils/size.dart';
import '../components/custotextfield.dart';

class CreateActivityUi extends GetWidget<Creativitycontroller> {
  CreateActivityUi({super.key});

  final ProfilemainController profileController =
      Get.find<ProfilemainController>();
  final PaymentController payment = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: Obx(
        () => controller.catLoading.value
            ? Center(
                child: CommonUi.scaffoldLoading(color: clrYellow),
              )
            : controller.catError.value.isNotEmpty
                ? const Center(child: ErrorScreen())
                : SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Res.Defalt_side_margin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonUi.appBar(),
                              const Text(
                                "Create activity",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              SizedBox(
                                width: h * .024,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        TabBar(
                          indicatorColor: tabBarColor,
                          dividerHeight: 0,
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor: clrBlacke,
                          labelColor: tabBarColor,
                          indicatorPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                          onTap: (value) {
                            controller.titleFocus.unfocus();
                            controller.desFocus.unfocus();
                            controller.locationFocus.unfocus();
                            controller.uptoFocus.unfocus();
                          },
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                          unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Edit",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Preview"),
                            )
                          ],
                          controller: controller.tabController,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Expanded(
                          child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Res.Defalt_side_margin),
                                  child: Column(children: [
                                    Expanded(
                                      child: ListView(
                                          // keyboardDismissBehavior: controller.isScrolling.value ? ScrollViewKeyboardDismissBehavior.onDrag : ScrollViewKeyboardDismissBehavior.manual,
                                          controller: controller.sc,
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            SizedBox(
                                              height: 120,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Obx(
                                                  () => Opacity(
                                                    opacity: controller
                                                            .choosePhotoCheck
                                                            .value
                                                        ? 0.3
                                                        : 1,
                                                    child: Row(
                                                      children: [
                                                        Obx(
                                                          () => ListView
                                                              .separated(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (index >=
                                                                            controller.galleryImages.length) {
                                                                          if (!controller
                                                                              .choosePhotoCheck
                                                                              .value) {
                                                                            controller.pickImage();
                                                                          }
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                1),
                                                                        child:
                                                                            Obx(
                                                                          () =>
                                                                              Stack(
                                                                            alignment:
                                                                                Alignment.topRight,
                                                                            children: [
                                                                              DottedBorder(
                                                                                  color: clrGrey,
                                                                                  dashPattern: const [6, 3],
                                                                                  borderType: BorderType.RRect,
                                                                                  strokeWidth: 2,
                                                                                  radius: const Radius.circular(12),
                                                                                  child: Container(
                                                                                    clipBehavior: Clip.hardEdge,
                                                                                    width: Get.width * 0.4,
                                                                                    height: 120,
                                                                                    decoration: BoxDecoration(color: clrGreyLight, borderRadius: BorderRadius.circular(15)),
                                                                                    child: Obx(() => index < controller.galleryImages.length
                                                                                        ? Image.file(
                                                                                            controller.galleryImages[index],
                                                                                            fit: BoxFit.cover,
                                                                                          )
                                                                                        : Center(
                                                                                            child: Image.asset(
                                                                                              "assets/icons/imgicon.png",
                                                                                              height: 30,
                                                                                              color: clrGreyDark.withOpacity(0.8),
                                                                                            ),
                                                                                          )),
                                                                                  )),
                                                                              controller.galleryImages.length > 0 && index < controller.galleryImages.length
                                                                                  ? GestureDetector(
                                                                                      onTap: () {
                                                                                        controller.removeContainer();
                                                                                        controller.galleryImages.removeAt(index);
                                                                                      },
                                                                                      child: CircleAvatar(
                                                                                          radius: 10,
                                                                                          backgroundColor: clrRedErr,
                                                                                          child: Center(
                                                                                              child: Icon(
                                                                                            Icons.close,
                                                                                            size: 15,
                                                                                            color: clrWhite,
                                                                                          ))),
                                                                                    )
                                                                                  : const SizedBox()
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  separatorBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return const SizedBox(
                                                                      width: 10,
                                                                    );
                                                                  },
                                                                  itemCount: controller
                                                                          .containerList
                                                                          .length +
                                                                      1),
                                                        ),
                                                        SizedBox(
                                                          width: w * .04,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 1),
                                                          child: InkWell(
                                                            onTap: () {
                                                              if (!controller
                                                                  .choosePhotoCheck
                                                                  .value) {
                                                                controller
                                                                    .addContainer();
                                                              }
                                                            },
                                                            child: DottedBorder(
                                                                color: clrGrey,
                                                                dashPattern: const [
                                                                  6
                                                                ],
                                                                borderType:
                                                                    BorderType
                                                                        .RRect,
                                                                strokeWidth: 2,
                                                                radius:
                                                                    const Radius
                                                                        .circular(
                                                                        12),
                                                                child:
                                                                    Container(
                                                                  clipBehavior:
                                                                      Clip.hardEdge,
                                                                  width:
                                                                      Get.width *
                                                                          0.4,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        30,
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          clrGreyLight,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15)),
                                                                  child: Center(
                                                                      child:
                                                                          Column(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .add,
                                                                        size:
                                                                            30,
                                                                        color: clrGreyDark
                                                                            .withOpacity(0.8),
                                                                      ),
                                                                      Text(
                                                                        "Add more",
                                                                        style: TextStyle(
                                                                            color:
                                                                                clrGreyDark.withOpacity(0.8)),
                                                                      )
                                                                    ],
                                                                  )),
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            Row(
                                              children: [
                                                Obx(() {
                                                  return Checkbox(
                                                    value: controller.choosePhotoCheck.value,
                                                    onChanged: (val) {
                                                      controller.changeChoosePhotoVal();
                                                    },
                                                    activeColor: clrYellow,
                                                  );
                                                }),
                                                const SizedBox(
                                                  width: 0,
                                                ),
                                                const Text("Choose a photo for me")
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            Obx(() => controller.catLoading.value
                                                ? Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade300,
                                                    highlightColor: Colors.grey.shade100,
                                                    child: const CustoDropDownBtn(
                                                      itemList: [],
                                                      hindtext: 'Select',
                                                    ))
                                                // : CustoDropDownBtn(
                                                //     onchange: (val) {
                                                //       controller.catID.value =
                                                //           val.toString();
                                                //       controller
                                                //           .getSubCat(val);
                                                //     },
                                                //     itemList: controller
                                                //         .categoryList,
                                                //     val: controller.catID
                                                //                 .value ==
                                                //             ''
                                                //         ? null
                                                //         : int.parse(controller
                                                //             .catID.value),
                                                //     hintColor: clrBlacke,
                                                //     hindtext:
                                                //         "Select Category",
                                                //     suffix: Image.asset(
                                                //       'assets/images/arrow down.png',
                                                //       scale: 4,
                                                //     ),
                                                //   ),
                                                : CustomDropdown(
                                                    items: controller.newList.map((e) => e['value'],).toList(),
                                                    hintText: 'Select category',
                                                    initialItem: controller
                                                            .catName
                                                            .value
                                                            .isNotEmpty
                                                        ? controller
                                                            .catName.value
                                                        : null,
                                                    decoration:
                                                        CustomDropdownDecoration(
                                                      hintStyle: TextStyle(
                                                          color: clrBlacke
                                                              .withOpacity(0.6),
                                                          fontSize: 15),
                                                      closedFillColor:
                                                          clrGreyLight,
                                                      closedBorderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      expandedSuffixIcon:
                                                          Image.asset(
                                                        'assets/images/arrow down.png',
                                                        scale: 4,
                                                      ),
                                                      closedSuffixIcon:
                                                          Image.asset(
                                                        'assets/images/arrow down.png',
                                                        scale: 4,
                                                      ),
                                                    ),
                                                    onChanged: (val) {
                                                      print('va == $val');
                                                      controller.catName.value =
                                                          val.toString();
                                                      controller.getSubCat(
                                                          val.toString());
                                                      controller.getCatID(
                                                          val.toString());
                                                    },
                                                  )),
                                            Obx(
                                              () => controller.catID.isEmpty
                                                  ? const SizedBox()
                                                  : SizedBox(
                                                      height: Get.height * 0.02,
                                                    ),
                                            ),
                                            Obx(
                                              () => controller.catID.isEmpty
                                                  ? const SizedBox()
                                                  : FutureBuilder(
                                                      future: Future.delayed(
                                                          const Duration(
                                                              seconds: 1)),
                                                      // Simulate delay
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return Shimmer
                                                              .fromColors(
                                                                  baseColor: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  highlightColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade100,
                                                                  child:
                                                                      Container(
                                                                    height: 50,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            clrGrey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(100)),
                                                                  )); // Show loading indicator
                                                        } else {
                                                          return CustomDropdown(
                                                            items: controller
                                                                .newSubList
                                                                .map(
                                                                  (e) => e[
                                                                      'value'],
                                                                )
                                                                .toList(),
                                                            hintText:
                                                                'Select sub category',
                                                            initialItem: controller
                                                                    .subCatName
                                                                    .value
                                                                    .isNotEmpty
                                                                ? controller
                                                                    .subCatName
                                                                    .value
                                                                : null,
                                                            decoration:
                                                                CustomDropdownDecoration(
                                                              hintStyle: TextStyle(
                                                                  color: clrBlacke
                                                                      .withOpacity(
                                                                          0.6),
                                                                  fontSize: 15),
                                                              closedFillColor:
                                                                  clrGreyLight,
                                                              closedBorderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              expandedSuffixIcon:
                                                                  Image.asset(
                                                                'assets/images/arrow down.png',
                                                                scale: 4,
                                                              ),
                                                              closedSuffixIcon:
                                                                  Image.asset(
                                                                'assets/images/arrow down.png',
                                                                scale: 4,
                                                              ),
                                                            ),
                                                            onChanged: (val) {
                                                              print(
                                                                  'va == $val');
                                                              controller
                                                                      .subCatName
                                                                      .value =
                                                                  val.toString();
                                                              controller
                                                                  .getSubCatID(
                                                                      val);
                                                            },
                                                          );
                                                          //   CustoDropDownBtn(
                                                          //   onchange: (val) {
                                                          //     controller
                                                          //             .subCatID
                                                          //             .value =
                                                          //         val.toString();
                                                          //     print(controller
                                                          //         .subCatID
                                                          //         .value);
                                                          //     controller
                                                          //         .getSubCatName(
                                                          //             val);
                                                          //   },
                                                          //   val: controller
                                                          //               .subCatID
                                                          //               .value ==
                                                          //           ''
                                                          //       ? null
                                                          //       : int.parse(
                                                          //           controller
                                                          //               .subCatID
                                                          //               .value),
                                                          //   itemList: controller
                                                          //       .subcategoryList,
                                                          //   hintColor:
                                                          //       clrBlacke,
                                                          //   hindtext:
                                                          //   controller
                                                          //       .subcategoryList.isEmpty ? 'Subcategory not found' : "Select Subcategory",
                                                          //   suffix: Image.asset(
                                                          //     'assets/images/arrow down.png',
                                                          //     scale: 4,
                                                          //   ),
                                                          // );
                                                        }
                                                      },
                                                    ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            Obx(() => Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                CustoTextFormField(
                                                  hintText: "Activity name (title)",
                                                  controll: controller
                                                      .titleController.value,
                                                  focusNode: controller.titleFocus,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(controller.titleMaxLen.value)
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 15,bottom: 5),
                                                  child: Text(
                                                    '${controller.titleLength.value}/${controller.titleMaxLen.value}',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),),
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            // TextFormField(
                                            //   maxLines: 4,
                                            //   maxLength: 500,
                                            //   decoration: InputDecoration(
                                            //       hintText:
                                            //           "Write a description (min. 30 characters)",
                                            //       hintStyle: TextStyle(
                                            //           fontWeight: FontWeight.w400,
                                            //           fontSize: 15,
                                            //           color: clrGreyTextLight),
                                            //       contentPadding: EdgeInsets.symmetric(
                                            //           horizontal: 15,
                                            //           vertical: Get.height * .02),
                                            //       fillColor: clrGreyLight,
                                            //       filled: true,
                                            //       border: OutlineInputBorder(
                                            //           borderSide: BorderSide.none,
                                            //           borderRadius: BorderRadius.circular(15))),
                                            // ),
                                            Obx(() {
                                              return Stack(
                                                children: [
                                                  TextFormField(
                                                    controller: controller
                                                        .desController.value,
                                                    maxLines: null,
                                                    minLines: 4,
                                                    focusNode: controller.desFocus,
                                                    maxLength:
                                                        controller.maxLength,
                                                    onChanged: (value) {
                                                      print('changfe == ${value}');
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Write a description (min. 30 characters)",
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15,
                                                        color: Colors.grey[600],
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: 15,
                                                        vertical: 15,
                                                      ),
                                                      fillColor:
                                                          Colors.grey[200],
                                                      filled: true,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      counterText:
                                                          "", // Remove the default counter
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 20,
                                                    bottom: 10,
                                                    child: Text(
                                                      '${controller.currentLength.value}/${controller.maxLength}',
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                            // const CustoTextFormField(
                                            //   hintText:
                                            //   "Write a description (min. 30 characters)",
                                            //   maxLines: 4,
                                            //   maxLength: 500,
                                            // ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            // Row(
                                            //     mainAxisAlignment:
                                            //     MainAxisAlignment.end,
                                            //     children: [
                                            //       InkWell(
                                            //         onTap: () {
                                            //           Get.toNamed(Routes.mapui);
                                            //         },
                                            //         child: Text('Choose on Map',
                                            //             style: TextStyle(
                                            //                 color:
                                            //                 clrYellowText,
                                            //                 fontWeight:
                                            //                 FontWeight
                                            //                     .bold)),
                                            //       )
                                            //     ]),
                                            // SizedBox(
                                            //   height: Get.height * 0.01,
                                            // ),
                                            CustomLocationField(
                                              itemBuilder:
                                                  (context, suggestion) {
                                                return ListTile(
                                                  title: Text(suggestion['des']
                                                      .toString()),
                                                );
                                              },
                                              suggestionsCallback:
                                                  (value) async {
                                                return controller
                                                    .searchPlaces(value);
                                              },
                                              hintText: "Location",
                                              controller: controller
                                                  .locController.value,
                                              validation: (val) {
                                                if (val == null ||
                                                    val.isEmpty ||
                                                    val == '') {
                                                  return "Location is required";
                                                }
                                                return null;
                                              },
                                              onSelected: (value) async {
                                                print(
                                                    'bjkjl=>>>>${value['id']}');
                                                controller.locController.value
                                                        .text =
                                                    value['des'].toString();
                                                await controller
                                                    .getLatLang(value['id']);
                                                // FocusScope.of(context).unfocus();
                                              },
                                              sufixIcon: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 13),
                                                  child: const Image(
                                                    image: AssetImage(
                                                        "assets/icons/locationicon.png"),
                                                    height: 1,
                                                    width: 1,
                                                  )),
                                              focusNode: controller.locationFocus,
                                            ),
                                            // CustoTextFormField(
                                            //   hintText: "Location",
                                            //   sufixIcon: SizedBox(
                                            //       height: h * .012,
                                            //       width: h * .012,
                                            //       child: Padding(
                                            //         padding: const EdgeInsets.all(13.0),
                                            //         child: Image.asset(
                                            //             "assets/icons/locationicon.png",
                                            //             height: 8,
                                            //             width: 8),
                                            //       )),
                                            // ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                DateTime? date =
                                                    await showDatePicker(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context,
                                                            Widget? child) {
                                                          return Theme(
                                                            data: ThemeData
                                                                    .light()
                                                                .copyWith(
                                                              colorScheme:
                                                                  ColorScheme
                                                                      .light(
                                                                primary:
                                                                    clrYellow,
                                                                // Change the color to yellow
                                                                onPrimary:
                                                                    Colors
                                                                        .black,
                                                                // Text color on selected date
                                                                onSurface: Colors
                                                                    .black, // Text color on unselected dates
                                                              ),
                                                              dialogBackgroundColor:
                                                                  Colors
                                                                      .white, // Background color of the date picker
                                                            ),
                                                            child: child!,
                                                          );
                                                        },
                                                        firstDate:
                                                            DateTime.now().add(
                                                                const Duration(
                                                                    days: 1)),
                                                        lastDate:
                                                            DateTime.now().add(Duration(days: 365)),
                                                        currentDate: controller
                                                                .dateForPicker
                                                                .value
                                                                .isNotEmpty
                                                            ? DateTime.parse(
                                                                controller
                                                                    .dateForPicker
                                                                    .value)
                                                            : DateTime.now());
                                                if (date != null) {
                                                  controller.changeDate(date);
                                                }
                                                controller.locationFocus.unfocus();
                                                controller.titleFocus.unfocus();
                                                controller.desFocus.unfocus();
                                                controller.uptoFocus.unfocus();
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          Get.height * .022,
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: clrGreyLight),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/calendericon.png",
                                                        height: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Obx(
                                                        () => Text(
                                                          controller.date.value
                                                                  .isNotEmpty
                                                              ? controller
                                                                  .formatDate(
                                                                      controller
                                                                          .date
                                                                          .value)
                                                              : "DD/MM/YYYY",
                                                          style: TextStyle(
                                                              color: controller
                                                                      .date
                                                                      .value
                                                                      .isNotEmpty
                                                                  ? clrBlacke
                                                                  : clrGreyTextLight),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            Obx(() {
                                              return InkWell(
                                                onTap: () async {
                                                  TimeOfDay? stime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialEntryMode:
                                                        TimePickerEntryMode
                                                            .inputOnly,
                                                    initialTime: controller
                                                            .sTime
                                                            .value
                                                            .isNotEmpty
                                                        ? TimeOfDay(
                                                            hour: int.parse(
                                                                controller
                                                                    .sTime.value
                                                                    .split(
                                                                        ":")[0]),
                                                            minute: int.parse(
                                                                controller
                                                                    .sTime.value
                                                                    .split(
                                                                        ":")[1]),
                                                          )
                                                        : TimeOfDay.now(),
                                                    builder:
                                                        (BuildContext context,
                                                            Widget? child) {
                                                      return MediaQuery(
                                                        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                                        child: Theme(
                                                          data: ThemeData.light()
                                                              .copyWith(
                                                            colorScheme:
                                                                ColorScheme.light(
                                                              primary: clrYellow,
                                                              // Change the color to yellow
                                                              onPrimary:
                                                                  Colors.black,
                                                              // Text color on selected time
                                                              onSurface: Colors
                                                                  .black, // Text color on unselected items
                                                            ),
                                                            timePickerTheme:
                                                                TimePickerThemeData(
                                                              dayPeriodColor: MaterialStateColor.resolveWith((states) =>
                                                                  states.contains(
                                                                          MaterialState
                                                                              .selected)
                                                                      ? clrYellow
                                                                      : clrWhite),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              // Background color of the time picker
                                                              hourMinuteTextColor:
                                                                  Colors
                                                                      .black, // Text color of the hour and minute
                                                            ),
                                                          ),
                                                          child: child!,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  if (stime != null) {
                                                    controller
                                                        .changeStime(stime);
                                                  }
                                                },
                                                child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical:
                                                                Get.height *
                                                                    .02),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: clrGreyLight,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/icons/timericon.png",
                                                              height: h * .032,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              controller.sTimeForApi
                                                                          .value ==
                                                                      ''
                                                                  ? "Start at"
                                                                  : "${controller.sTimeForApi}",
                                                              style: TextStyle(
                                                                  color: controller
                                                                              .sTimeForApi
                                                                              .value ==
                                                                          ''
                                                                      ? clrGreyDark
                                                                      : clrBlacke),
                                                            ),
                                                          ],
                                                        ),
                                                        Image.asset(
                                                          'assets/images/arrow down.png',
                                                          scale: 4,
                                                        )
                                                      ],
                                                    )),
                                              );
                                            }),

                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Obx(() {
                                              return InkWell(
                                                onTap: () async {
                                                  TimeOfDay? etime =
                                                      await showTimePicker(
                                                    context: context,
                                                    initialEntryMode:
                                                        TimePickerEntryMode
                                                            .inputOnly,
                                                    initialTime: controller
                                                            .eTime
                                                            .value
                                                            .isNotEmpty
                                                        ? TimeOfDay(
                                                            hour: int.parse(
                                                                controller
                                                                    .eTime.value
                                                                    .split(
                                                                        ":")[0]),
                                                            minute: int.parse(
                                                                controller
                                                                    .eTime.value
                                                                    .split(
                                                                        ":")[1]),
                                                          )
                                                        : TimeOfDay.now(),
                                                    builder:
                                                        (BuildContext context,
                                                            Widget? child) {
                                                      return MediaQuery(
                                                        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                                        child: Theme(
                                                          data: ThemeData.light()
                                                              .copyWith(
                                                            colorScheme:
                                                                ColorScheme.light(
                                                              primary: clrYellow,
                                                              // Change the color to yellow
                                                              onPrimary:
                                                                  Colors.black,
                                                              // Text color on selected time
                                                              onSurface: Colors
                                                                  .black, // Text color on unselected items
                                                            ),
                                                            timePickerTheme:
                                                                TimePickerThemeData(
                                                              dayPeriodColor: MaterialStateColor.resolveWith((states) =>
                                                                  states.contains(
                                                                          MaterialState
                                                                              .selected)
                                                                      ? clrYellow
                                                                      : clrWhite),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              // Background color of the time picker
                                                              hourMinuteTextColor:
                                                                  Colors
                                                                      .black, // Text color of the hour and minute
                                                            ),
                                                          ),
                                                          child: child!,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  if (etime != null) {
                                                    controller
                                                        .changeEtime(etime);
                                                  }
                                                },
                                                child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical:
                                                                Get.height *
                                                                    .02),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: clrGreyLight,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/icons/timericon.png",
                                                              height: h * .032,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              controller.eTimeForAPi
                                                                          .value ==
                                                                      ''
                                                                  ? "Ends at"
                                                                  : controller
                                                                      .eTimeForAPi
                                                                      .value,
                                                              style: TextStyle(
                                                                  color: controller
                                                                              .eTimeForAPi
                                                                              .value ==
                                                                          ''
                                                                      ? clrGreyDark
                                                                      : clrBlacke),
                                                            )
                                                          ],
                                                        ),
                                                        Image.asset(
                                                          'assets/images/arrow down.png',
                                                          scale: 4,
                                                        )
                                                      ],
                                                    )),
                                              );
                                            }),

                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            // Container(
                                            //     padding: EdgeInsets.symmetric(
                                            //         vertical: Get.height * .02,
                                            //         horizontal: 15),
                                            //     decoration: BoxDecoration(
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 100),
                                            //         color: clrGreyLight),
                                            //     child: Row(
                                            //       mainAxisAlignment:
                                            //           MainAxisAlignment
                                            //               .spaceBetween,
                                            //       children: [
                                            //         Flexible(
                                            //           child: Row(
                                            //             children: [
                                            //               Image.asset(
                                            //                 "assets/icons/manicon.png",
                                            //                 height: 20,
                                            //               ),
                                            //               const SizedBox(
                                            //                 width: 12,
                                            //               ),
                                            //               Flexible(
                                            //                   child: Text(
                                            //                 "Max 10 people (incl. you)",
                                            //                 maxLines: 1,
                                            //                 overflow:
                                            //                     TextOverflow
                                            //                         .ellipsis,
                                            //                 style: TextStyle(
                                            //                     color:
                                            //                         clrGreyTextLight),
                                            //               ))
                                            //             ],
                                            //           ),
                                            //         ),
                                            //         InkWell(
                                            //             onTap: () {
                                            //               controller
                                            //                   .decGroupSize();
                                            //             },
                                            //             child: const Icon(
                                            //                 Icons.remove)),
                                            //         const SizedBox(
                                            //           width: 5,
                                            //         ),
                                            //         Obx(() {
                                            //           return Text(
                                            //               "${controller.groupSize}");
                                            //         }),
                                            //         const SizedBox(
                                            //           width: 5,
                                            //         ),
                                            //         InkWell(
                                            //             onTap: () {
                                            //               controller
                                            //                   .incGroupSize();
                                            //             },
                                            //             child: const Icon(
                                            //                 Icons.add))
                                            //       ],
                                            //     )),
                                            CustoTextFormField(
                                              controll: controller.groupSizeController.value,
                                              hintText: "Up to 10 (incl. you)",
                                              focusNode: controller.uptoFocus,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(2),
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
                                              // maxLength: 1,
                                              sufixIcon: Padding(
                                                padding: const EdgeInsets.all(13.0),
                                                child: Image.asset(
                                                  "assets/icons/manicon.png",
                                                  height: 20,
                                                ),
                                              ),
                                              textKType: TextInputType.number,
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                          //                                         Obx(() {
                                          //                                           return CustomDropdown.search(
                                          //                                             hintText:
                                          //                                             "Select country",
                                          //                                             initialItem: controller.selectedCountry.value.isNotEmpty
                                          //                                                 ? controller.selectedCountry.value
                                          //                                                 : null,
                                          //                                             decoration:
                                          //                                             CustomDropdownDecoration(
                                          //                                                 hintStyle: TextStyle(
                                          //                                                     color: clrBlacke
                                          //                                                         .withOpacity(
                                          //                                                         0.6),
                                          //                                                     fontSize: 15),
                                          //                                                 closedSuffixIcon:
                                          //                                                 Image.asset(
                                          //                                                   'assets/images/arrow down.png',
                                          //                                                   scale: 4,
                                          //                                                 ),
                                          //                                                 expandedSuffixIcon:
                                          //                                                 Image.asset(
                                          //                                                   'assets/images/arrow down.png',
                                          //                                                   scale: 4,
                                          //                                                 ),
                                          //                                                 prefixIcon: Icon(Icons.public_rounded),
                                          //                                                 closedFillColor:
                                          //                                                 clrGreyLight,
                                          //                                                 closedBorderRadius:
                                          //                                                 BorderRadius
                                          //                                                     .circular(100)),
                                          //                                             items: controller.countryList
                                          //                                                 .map(
                                          //                                                   (e) => e['value'],).toList(),
                                          //                                             onChanged: (val) {
                                          //                                               print('$val');
                                          //                                               controller.selectedCountry.value = val;
                                          //                                               controller.getTimeZone(val);
                                          //                                             },
                                          //                                           );
                                          //                                         }),
                                          //                                         SizedBox(
                                          //                                           height: Get.height * 0.02,
                                          //                                         ),
                                          //
                                          //                                         Obx(() => controller.selectedCountry.value.isEmpty ? SizedBox() : FutureBuilder(
                                          //                                           future: Future.delayed(
                                          //                                           const Duration(
                                          //                                           seconds: 1)),
                                          //                                           builder:
                                          //                                           (context, snapshot) {
                                          //                                           if (snapshot
                                          //                                               .connectionState ==
                                          //                                           ConnectionState
                                          //                                               .waiting) {
                                          //                                           return Shimmer
                                          //                                               .fromColors(
                                          //                                           baseColor: Colors
                                          //                                               .grey
                                          //                                               .shade300,
                                          //                                           highlightColor:
                                          //                                           Colors
                                          //                                               .grey
                                          //                                               .shade100,
                                          //                                           child:
                                          //                                           Container(
                                          //                                           height: 50,
                                          //                                           decoration: BoxDecoration(
                                          //                                           color:
                                          //                                           clrGrey,
                                          //                                           borderRadius:
                                          //                                           BorderRadius.circular(100)),
                                          //                                           )); // Show loading indicator
                                          //                                           }else{
                                          //                                             return  CustomDropdown(
                                          //                                             hintText:
                                          //                                             "Select timezone",
                                          //                                             initialItem: controller.timeZoneName.value.isNotEmpty
                                          //                                             ? controller.timeZoneName.value
                                          //                                                 : null,
                                          //                                             decoration:
                                          //                                             CustomDropdownDecoration(
                                          //                                             hintStyle: TextStyle(
                                          //                                             color: clrBlacke
                                          //                                                 .withOpacity(
                                          //                                             0.6),
                                          //                                             fontSize: 15),
                                          //                                             closedSuffixIcon:
                                          //                                             Image.asset(
                                          //                                             'assets/images/arrow down.png',
                                          //                                             scale: 4,
                                          //                                             ),
                                          //                                             expandedSuffixIcon:
                                          //                                             Image.asset(
                                          //                                             'assets/images/arrow down.png',
                                          //                                             scale: 4,
                                          //                                             ),
                                          //                                             prefixIcon: Icon(Icons.access_time),
                                          //                                             closedFillColor:
                                          //                                             clrGreyLight,
                                          //                                             closedBorderRadius:
                                          //                                             BorderRadius
                                          //                                                 .circular(100)),
                                          //                                           items: controller.timeZoneList
                                          //                                               .map(
                                          //                                           (e) => e['value'],).toList(),
                                          //                                           onChanged: (val) {
                                          //                                           print('$val');
                                          //                                           controller.timeZoneName.value =
                                          //                                           val.toString();
                                          //                                           controller.getTimeId(val);
                                          //                                           },
                                          //                                           );
                                          //                                           }
                                          // }
                                          //                                           )),
                                          //                                         Obx(() => controller.selectedCountry.value.isEmpty ? SizedBox() : SizedBox(
                                          //                                           height: Get.height * 0.02,
                                          //                                         ),),

                                            Obx(() {
                                              return CustomDropdown(
                                                hintText:
                                                    "Gender preference (optional)",
                                                initialItem: controller
                                                        .genderName
                                                        .value
                                                        .isNotEmpty
                                                    ? controller
                                                        .genderName.value
                                                    : null,
                                                decoration:
                                                    CustomDropdownDecoration(
                                                        hintStyle: TextStyle(
                                                            color: clrBlacke
                                                                .withOpacity(
                                                                    0.6),
                                                            fontSize: 15),
                                                        closedSuffixIcon:
                                                            Image.asset(
                                                          'assets/images/arrow down.png',
                                                          scale: 4,
                                                        ),
                                                        expandedSuffixIcon:
                                                            Image.asset(
                                                          'assets/images/arrow down.png',
                                                          scale: 4,
                                                        ),
                                                        prefixIcon: Image.asset(
                                                          "assets/icons/gendericon.png",
                                                          scale: 2,
                                                        ),
                                                        closedFillColor:
                                                            clrGreyLight,
                                                        closedBorderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                items: controller.genderList
                                                    .map(
                                                      (e) => e['title'],
                                                    )
                                                    .toList(),
                                                onChanged: (val) {
                                                  controller.genderName.value =
                                                      val.toString();
                                                  if (val ==
                                                      'Same gender as me') {
                                                    controller.gender.value = 1;
                                                  } else if (val == 'All') {
                                                    controller.gender.value = 2;
                                                  }
                                                },
                                              );
                                              //   CustoDropDownBtn(
                                              //   val: controller.gender.value ==
                                              //           0
                                              //       ? null
                                              //       : controller.gender.value,
                                              //   onchange: (val) {
                                              //     controller
                                              //         .changeGenderFilter(val);
                                              //   },
                                              //   itemList: const [
                                              //     DropdownMenuItem(
                                              //       value: 1,
                                              //       child: Text(
                                              //           "Same gender as me"),
                                              //     ),
                                              //     DropdownMenuItem(
                                              //       value: 2,
                                              //       child: Text("All"),
                                              //     )
                                              //   ],
                                              //   hindtext:
                                              //       "Gender preference (optional)",
                                              //   hintColor: clrBlacke,
                                              //   suffix: Image.asset(
                                              //     'assets/images/arrow down.png',
                                              //     scale: 4,
                                              //   ),
                                              //   prefixIcon: Image.asset(
                                              //     "assets/icons/gendericon.png",
                                              //     scale: 2,
                                              //   ),
                                              // );
                                            }),
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            // CustoDropDownBtn(
                                            //   val: controller.repeat.value == 0 ? null : controller.repeat.value,
                                            //   onchange: (val) {
                                            //     controller.changeRepeatVal(val);
                                            //     if (val == 2) {
                                            //       alertRepeatSchedule(context);
                                            //     } else if (val == 1) {
                                            //       controller.repeatRefresh();
                                            //     }
                                            //   },
                                            //   backClr: clrWhite,
                                            //   borderClr:
                                            //       clrGrey.withOpacity(0.6),
                                            //   itemList: const [
                                            //     DropdownMenuItem(
                                            //       value: 1,
                                            //       child: Text("Doesn’t repeat"),
                                            //     ),
                                            //     DropdownMenuItem(
                                            //       value: 2,
                                            //       child: Text(
                                            //           "Should have repeat schedule "),
                                            //     ),
                                            //   ],
                                            //   hindtext: "Doesn’t repeat ",
                                            //   suffix: Image.asset(
                                            //     'assets/images/arrow down.png',
                                            //     scale: 4,
                                            //   ),
                                            // ),
                                            CustomDropdown(
                                              hintText: "Doesn’t repeat",
                                              initialItem: controller.repeatName
                                                      .value.isNotEmpty
                                                  ? controller.repeatName.value
                                                  : null,
                                              excludeSelected: false,
                                              decoration:
                                                  CustomDropdownDecoration(
                                                      hintStyle: TextStyle(
                                                          color: clrBlacke
                                                              .withOpacity(0.6),
                                                          fontSize: 15),
                                                      closedSuffixIcon:
                                                          Image.asset(
                                                        'assets/images/arrow down.png',
                                                        scale: 4,
                                                      ),
                                                      expandedSuffixIcon:
                                                          Image.asset(
                                                        'assets/images/arrow down.png',
                                                        scale: 4,
                                                      ),
                                                      prefixIcon:  Image.asset(
                                                        'assets/images/repeat.png',
                                                        scale: 4,
                                                      ),
                                                      closedBorder: Border.all(
                                                          color: clrGrey),
                                                      closedBorderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                              items: controller.repeatList
                                                  .map(
                                                    (e) => e['title'],
                                                  )
                                                  .toList(),
                                              onChanged: (val) {
                                                print(val);
                                                controller.repeatName.value =
                                                    val.toString();
                                                if (val == 'Doesn’t repeat') {
                                                  controller.changeRepeatVal(1);
                                                  controller.repeatRefresh();
                                                } else if (val ==
                                                    'Should have repeat schedule') {
                                                  controller.changeRepeatVal(2);
                                                  alertRepeatSchedule(context);
                                                }
                                              },
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.02,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "Join instantly without approval",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                Obx(() {
                                                  return CustomSwitch(
                                                    value: controller
                                                        .joinInstant.value,
                                                    onChanged: (p0) => controller
                                                        .changejoinInstant(),
                                                  );
                                                })
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.03,
                                            ),
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Obx(
                                        () => Opacity(
                                          opacity: controller.loading.value || payment.loading.value
                                              ? 0.5
                                              : 1,
                                          child: SizedBox(
                                              width: double.maxFinite,
                                              height: Res.h_btn,
                                              child: CustomElevatedButton(
                                                  onTap: () async{
                                                    // if(profileController.profileData.value.result?.cardSave == false){
                                                     // payment.alertRequestSent(() async{
                                                       // Get.back();
                                                       // await payment.createCustomer('${profileController.profileData.value.result?.firstName} ${profileController.profileData.value.result?.lastName}', "${profileController.profileData.value.result?.email}");
                                                       // await profileController.viewProfile();
                                                     // },);
                                                    // }else {
                                                      controller
                                                          .createActivity();
                                                    // }
                                                  },
                                                  backgroundClr: clrBlacke,
                                                  child: controller
                                                          .loading.value || payment.loading.value
                                                      ? CommonUi.buttonLoading()
                                                      : Text(
                                                          "Post Activity",
                                                          style: TextStyle(
                                                              color: clrWhite,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ))),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                ////////////////////////////////////////////////////preview ui
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Res.Defalt_side_margin),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.005,
                                              ),
                                              SizedBox(
                                                height: h * .25,
                                                child: Stack(
                                                  // clipBehavior: Clip.none,
                                                  children: [
                                                    Obx(
                                                      () => (controller.choosePhotoCheck.value == true && controller.subCatID.value.isNotEmpty)
                                                          ?  CarouselSlider(
                                                        options:
                                                        CarouselOptions(
                                                            height:
                                                            h * .25,
                                                            enableInfiniteScroll: false,
                                                            viewportFraction:
                                                            1),
                                                        items: [1]
                                                            .map((i) {
                                                          return Builder(
                                                            builder:
                                                                (BuildContext
                                                            context) {
                                                              return Container(
                                                                  clipBehavior:
                                                                  Clip
                                                                      .hardEdge,
                                                                  width: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .width,
                                                                  height: double
                                                                      .maxFinite,
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(
                                                                          18)),
                                                                  child:
                                                                  // Image.network(
                                                                  //   controller.subImage.value,
                                                                  //   fit: BoxFit
                                                                  //       .cover,
                                                                  //   height: h *
                                                                  //       .25,
                                                                  //   width: double
                                                                  //       .maxFinite,
                                                                  // )
                                                                  CachedNetworkImage(
                                                                    imageUrl: controller.subImage.value,
                                                                    fit: BoxFit.cover,
                                                                    height: h * 0.25,
                                                                    memCacheWidth: 500,
                                                                    width: double.maxFinite,
                                                                    placeholder: (context, url) =>  Shimmer
                                                                        .fromColors(
                                                                      baseColor:
                                                                      grey300,
                                                                      highlightColor:
                                                                      grey100,
                                                                      child:
                                                                      Container(
                                                                        width: double
                                                                            .maxFinite,
                                                                        height:
                                                                        h * .26,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          color:
                                                                          grey300,
                                                                          borderRadius:
                                                                          BorderRadius.circular(
                                                                              18),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    errorWidget: (context, url, error) => Icon(
                                                                      Icons.error,
                                                                      color: Colors.red,
                                                                    ),
                                                                  )

                                                              );
                                                            },
                                                          );
                                                        }).toList(),
                                                      )
                                                          : controller.galleryImages.isEmpty
                                                          ? Container(
                                                        decoration: BoxDecoration(
                                                          color: clrGreyLight,
                                                          borderRadius: BorderRadius.circular(18),
                                                        ),
                                                        child: Center(
                                                          child: Text('Add photos',style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600
                                                          ),),
                                                        ),
                                                      )
                                                      // CarouselSlider(
                                                      //         options:
                                                      //             CarouselOptions(
                                                      //                 height:
                                                      //                     h * .25,
                                                      //                 enableInfiniteScroll: false,
                                                      //                 viewportFraction:
                                                      //                     1),
                                                      //         items: [1, 2, 3]
                                                      //             .map((i) {
                                                      //           return Builder(
                                                      //             builder:
                                                      //                 (BuildContext
                                                      //                     context) {
                                                      //               return Container(
                                                      //                   clipBehavior:
                                                      //                       Clip
                                                      //                           .hardEdge,
                                                      //                   width: MediaQuery.of(
                                                      //                           context)
                                                      //                       .size
                                                      //                       .width,
                                                      //                   height: double
                                                      //                       .maxFinite,
                                                      //                   margin: const EdgeInsets
                                                      //                       .symmetric(
                                                      //                       horizontal:
                                                      //                           0),
                                                      //                   decoration: BoxDecoration(
                                                      //                       borderRadius: BorderRadius.circular(
                                                      //                           18)),
                                                      //                   child: Image
                                                      //                       .asset(
                                                      //                     "assets/images/cofee.png",
                                                      //                     fit: BoxFit
                                                      //                         .cover,
                                                      //                     height: h *
                                                      //                         .25,
                                                      //                     width: double
                                                      //                         .maxFinite,
                                                      //                   ));
                                                      //             },
                                                      //           );
                                                      //         }).toList(),
                                                      //       )
                                                          : CarouselSlider(
                                                              items: controller
                                                                  .galleryImages
                                                                  .map<Widget>(
                                                                (i) {
                                                                  return Builder(
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Container(
                                                                          clipBehavior: Clip
                                                                              .hardEdge,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          height: double
                                                                              .maxFinite,
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal:
                                                                                  0),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  18)),
                                                                          child: Image
                                                                              .file(
                                                                            i,
                                                                            fit: BoxFit
                                                                                .cover,
                                                                            height:
                                                                                h * .26,
                                                                            width:
                                                                                double.maxFinite,
                                                                          ));
                                                                    },
                                                                  );
                                                                },
                                                              ).toList(),
                                                              options:
                                                                  CarouselOptions(
                                                                      height:
                                                                          h * .26,
                                                                      enableInfiniteScroll: false,
                                                                      viewportFraction:
                                                                          1,
                                                                      onPageChanged:
                                                                          (currIndex,
                                                                              CarouselPageChangedReason
                                                                                  reason) {
                                                                        controller
                                                                            .changeIndicator(
                                                                                currIndex);
                                                                        debugPrint(
                                                                            " currIndex $currIndex reason=$reason");
                                                                      })),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical: 5),
                                                            decoration: BoxDecoration(
                                                                color: clrWhite,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Obx(
                                                              () => Text(
                                                                controller.catName.value.isEmpty && controller
                                                                        .subCatName
                                                                        .value
                                                                        .isEmpty
                                                                    ? "Select category"
                                                                    : controller
                                                                    .subCatName
                                                                    .value
                                                                    .isEmpty ? "Select subcategory" : '${controller.subCatName.value}',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox()
                                                        ],
                                                      ),
                                                    ),
                                                    controller.galleryImages.isEmpty ? SizedBox() : Align(
                                                      alignment:
                                                          Alignment.bottomCenter,
                                                      child: Container(
                                                          margin: const EdgeInsets
                                                              .only(bottom: 7),
                                                          height: 16,
                                                          child: Obx(
                                                            () => controller
                                                                    .galleryImages
                                                                    .isEmpty
                                                                ? ListView
                                                                    .builder(
                                                                        itemCount:
                                                                            1,
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return Padding(
                                                                            padding: const EdgeInsets
                                                                                .symmetric(
                                                                                horizontal: 1.5),
                                                                            child:
                                                                                Icon(
                                                                              Icons.circle,
                                                                              color: index == 0
                                                                                  ? clrYellow
                                                                                  : clrWhite,
                                                                              size:
                                                                                  8,
                                                                            ),
                                                                          );
                                                                        })
                                                                : ListView
                                                                    .builder(
                                                                        itemCount: controller
                                                                            .galleryImages
                                                                            .length,
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        itemBuilder:
                                                                            (context,
                                                                                indicatorIndex) {
                                                                          return Padding(
                                                                            padding: const EdgeInsets
                                                                                .symmetric(
                                                                                horizontal: 1.5),
                                                                            child:
                                                                                Obx(
                                                                              () =>
                                                                                  Icon(
                                                                                Icons.circle,
                                                                                color: controller.circleIndex.value == indicatorIndex ? clrYellow : clrWhite,
                                                                                size: 8,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Obx(
                                                          () => Text(
                                                            controller
                                                                    .titleController
                                                                    .value
                                                                    .value
                                                                    .text
                                                                    .isEmpty
                                                                ? "Add an activity title"
                                                                : '${controller.titleController.value.value.text}',
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.005,
                                                        ),
                                                        Obx(() => controller
                                                            .locController
                                                            .value
                                                            .value
                                                            .text
                                                            .isEmpty ? Row(
                                                          children: [
                                                            Icon(Icons.location_on_outlined,size: 18,),
                                                            Text(' Add location',style: TextStyle(
                                                                color:
                                                                clrGreyDark),)
                                                          ],
                                                        ) : Text('${controller.locController.value.value.text}',
                                                          style: TextStyle(
                                                              color:
                                                              clrGreyDark),
                                                        ),),
                                                        // Obx(
                                                        //   () => Text(
                                                        //     controller
                                                        //             .locController
                                                        //             .value
                                                        //             .value
                                                        //             .text
                                                        //             .isEmpty
                                                        //         ? "Add location"
                                                        //         : '${controller.locController.value.value.text}',
                                                        //     style: TextStyle(
                                                        //         color:
                                                        //             clrGreyDark),
                                                        //   ),
                                                        // ),
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.005,
                                                        ),
                                                        Obx(
                                                          () => controller.date.value.isEmpty || controller.sTimeForApi.value.isEmpty || controller.eTimeForAPi.value.isEmpty ? Text('Set date and time',style: TextStyle(
                                                              color:
                                                              clrGreyDark)) : Text(
                                                              '${controller.dateForView.value} ${" | ${controller.sTimeForApi.value}"} ${'- ${controller.eTimeForAPi.value}'}',
                                                              style: TextStyle(
                                                                  color:
                                                                      clrGreyDark)),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.005,
                                                        ),
                                                        Obx(
                                                          () => Text(
                                                            "${controller.groupSizeController.value.value.text.isNotEmpty ? 'Up to ${controller.groupSizeController.value.value.text} ${int.parse(controller.groupSizeController.value.value.text) == 1 ? 'people' : 'peoples'}' : 'Set group size'}",
                                                            style: TextStyle(
                                                                color:
                                                                    clrYellowText,
                                                                fontSize: 13),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                100),
                                                        child: CachedNetworkImage(
                                                          height: 40,
                                                          width: 40,
                                                          fit: BoxFit.cover,
                                                          memCacheWidth: 500,
                                                          imageUrl:
                                                              '${profileController.profileData.value.result?.profile?.profilePhoto}',
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(
                                                            height: 40,
                                                            width: 40,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    clrGreyLight,
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: Image.asset(
                                                              "assets/icons/manicon.png",
                                                              color: clrGrey,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              Shimmer.fromColors(
                                                            baseColor: grey300,
                                                            highlightColor:
                                                                grey100,
                                                            child: Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: grey300,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        '${profileController.profileData.value.result?.firstName}',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700),
                                                      )
                                                    ],
                                                  ),
                                                  // Column(
                                                  //   children: [
                                                  //     Container(
                                                  //         height: h * .05,
                                                  //         width: h * .05,
                                                  //         decoration: BoxDecoration(
                                                  //             borderRadius:
                                                  //             BorderRadius.circular(100)),
                                                  //         child: Image.asset(
                                                  //           "assets/images/girldp.png",
                                                  //           fit: BoxFit.cover,
                                                  //         )),
                                                  //     const Text(
                                                  //       "Jenny",
                                                  //       style: TextStyle(
                                                  //           fontWeight: FontWeight.w700),
                                                  //     )
                                                  //   ],
                                                  // )
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Obx(
                                                () => Text(
                                                  controller.desController.value
                                                          .value.text.isEmpty
                                                      ? "Write a description(minimum 30 characters)"
                                                      : "${controller.desController.value.value.text}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: clrGreyTextLight),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              controller.latitude.value.isNotEmpty && controller.longitude.value.isNotEmpty ? SizedBox(
                                                  height: 200,
                                                  child:  GoogleMap(
                                                    onMapCreated:
                                                        (GoogleMapController
                                                    googleMapController) {
                                                      controller.mapController1 =
                                                          googleMapController;
                                                    },
                                                    initialCameraPosition: controller.markers.isEmpty ? CameraPosition(
                                                      target: controller.currentLocation.value != null
                                                          ? LatLng(controller.currentLocation.value!.latitude!, controller.currentLocation.value!.longitude!)
                                                          : controller.initialPosition,
                                                      zoom: 14.0,
                                                    ) : CameraPosition(target: LatLng(double.parse(controller.latitude.value), double.parse(controller.longitude.value)),zoom: 14),
                                                    myLocationEnabled: true,
                                                    myLocationButtonEnabled: true,
                                                    markers: controller.markers,
                                                  ),
                                              ) : Container(
                                                height: 200,
                                                color: clrGreyLight,
                                                child: Center(
                                                  child: Text('Map will appear here',style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16
                                                  ),),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  alertRepeatSchedule(BuildContext context) {
    Get.dialog(AlertDialog(
      backgroundColor: clrWhite,
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 18),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.close)),
                  const Text(
                    "Set repeat schedule",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 1,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: clrGreyLight,
            ),
            const SizedBox(
              height: 10,
            ),
             Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Repeat every",
                      style: TextStyle(color: clrGreyTextLight, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      // padding: const EdgeInsets.symmetric(
                      //     horizontal: 25, vertical: 10),
                      height: 40,
                      width: Get.width * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: clrGreyLight),
                      child: CustoTextFormField(
                        controll: controller.countController.value,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(2)],
                        textKType: TextInputType.number,
                      ),
                    ),
                    // Container(
                    //   height: 35,
                    //   // color: Colors.red,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           controller.increment();
                    //         },
                    //         child: Container(
                    //           height: 16,
                    //           child: Image.asset(
                    //             'assets/images/arrow up.png',
                    //             scale: 3.5,
                    //           ),
                    //         ),
                    //       ),
                    //       // const SizedBox(
                    //       //   height: 8,
                    //       // ),
                    //       InkWell(
                    //         onTap: () {
                    //           controller.decrement();
                    //         },
                    //         child: Container(
                    //           height: 16,
                    //           child: Image.asset(
                    //             'assets/images/arrow down new.png',
                    //             scale: 3.5,
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 40,
                      width: Get.width * 0.27,
                      child: PopupMenuButton<int>(
                        onSelected: (value) {
                          controller.wmValue.value = value;
                          controller.monthIndex.value = (-1);
                          controller.dayIndex.value = (-1);
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 1,
                            child: Text(
                              "Week",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            child: Text(
                              "Day",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: clrGreyLight,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() {
                                return Text(
                                  controller.wmValue.value == 1
                                      ? "Week"
                                      : controller.wmValue.value == 2
                                          ? "Day"
                                          : "Week", // Default value
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: clrBlacke,
                                  ),
                                );
                              }),
                              const SizedBox(
                                width: 7,
                              ),
                              Image.asset(
                                'assets/images/arrow down.png',
                                scale: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    // SizedBox(
                    //     height: 40,
                    //     width: Get.width * 0.25,
                    //     child: DropdownButtonFormField(
                    //       value: controller.wmValue.value == 0
                    //           ? null
                    //           : controller.wmValue.value,
                    //       items: const [
                    //         DropdownMenuItem(
                    //           value: 1,
                    //           child: Text(
                    //             "Week",
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //         ),
                    //         DropdownMenuItem(
                    //           value: 2,
                    //           child: Text(
                    //             "Day",
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //         ),
                    //       ],
                    //       onChanged: (value) {
                    //         controller.monthIndex.value = (-1);
                    //         controller.dayIndex.value = (-1);
                    //         controller.wmValue.value = value!;
                    //         print('vmvalue ==> ${controller.wmValue.value}');
                    //       },
                    //       isExpanded: true,
                    //       hint: Padding(
                    //         padding: const EdgeInsets.only(left: 10),
                    //         child: Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text('Week',
                    //               style: TextStyle(
                    //                   color: clrBlacke, fontSize: 12)),
                    //         ),
                    //       ),
                    //       icon: const SizedBox.shrink(),
                    //       decoration: InputDecoration(
                    //         alignLabelWithHint: true,
                    //         suffixIcon: Image.asset(
                    //           'assets/images/arrow down.png',
                    //           scale: 6,
                    //         ),
                    //         hintStyle: TextStyle(
                    //             fontWeight: FontWeight.w400,
                    //             color: clrGreyTextLight),
                    //         // contentPadding: EdgeInsets.only(
                    //         //     left: controller.wmValue.value == 0 ? 0 : 6),
                    //         contentPadding: EdgeInsets.only(left: 16),
                    //         fillColor: clrGreyLight,
                    //         filled: true,
                    //         border: OutlineInputBorder(
                    //             borderSide: BorderSide.none,
                    //             borderRadius: BorderRadius.circular(30)),
                    //       ),
                    //     )
                    // )
                    // Container(
                    //   padding:
                    //       const EdgeInsets.only(left: 20,right: 10, top: 8,bottom: 8),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(50),
                    //       color: clrGreyLight),
                    //   child: const Row(
                    //     children: [
                    //       Text("week"),
                    //       SizedBox(width: 5,),
                    //       Icon(Icons.arrow_drop_down_sharp)
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            Obx(
              () => controller.wmValue.value == 2
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Repeat on",
                            style: TextStyle(
                                color: clrGreyTextLight, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: 40,
                              child: Obx(
                                () => controller.wmValue.value == 2
                                    // ? ListView.separated(
                                    //     itemCount: controller.monthList.length,
                                    //     shrinkWrap: true,
                                    //     scrollDirection: Axis.horizontal,
                                    //     itemBuilder: (context, index) {
                                    //       return GestureDetector(
                                    //         onTap: () {
                                    //           controller.monthIndex.value = index;
                                    //           controller.changemonth(index);
                                    //         },
                                    //         child: Obx(
                                    //           () => Container(
                                    //             padding: const EdgeInsets.all(5),
                                    //             height: 30,
                                    //             width: 30,
                                    //             decoration: BoxDecoration(
                                    //                 shape: BoxShape.circle,
                                    //                 color:
                                    //                     controller.monthIndex.value == index
                                    //                         ? clrYellow
                                    //                         : clrGreyLight),
                                    //             child: Center(
                                    //               child: FittedBox(
                                    //                 child: Text(
                                    //                   controller.monthList[index],
                                    //                   style: TextStyle(
                                    //                       color:
                                    //                           controller.monthIndex.value ==
                                    //                                   index
                                    //                               ? clrWhite
                                    //                               : clrBlacke),
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     },
                                    //     separatorBuilder:
                                    //         (BuildContext context, int index) {
                                    //       return const SizedBox(
                                    //         width: 10,
                                    //       );
                                    //     },
                                    //   )
                                    ? const SizedBox()
                                    : ListView.separated(
                                        itemCount: controller.dayList.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.dayIndex.value = index;
                                              print(
                                                  'day==> ${controller.dayIndex.value}');
                                              controller.changeday(index);
                                            },
                                            child: Obx(
                                              () => Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: controller.dayIndex
                                                                .value ==
                                                            index
                                                        ? clrYellow
                                                        : clrGreyLight),
                                                child: Center(
                                                  child: Text(
                                                    controller.dayList[index],
                                                    style: TextStyle(
                                                        color: controller
                                                                    .dayIndex
                                                                    .value ==
                                                                index
                                                            ? clrWhite
                                                            : clrBlacke),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            width: 10,
                                          );
                                        },
                                      ),
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Text(
                "Ends",
                style: TextStyle(color: clrGreyTextLight, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  controller.groupValue.value = 1;
                },
                child: Row(
                  children: [
                    Obx(
                      () => customRadioButton(1, controller.groupValue.value),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Never",
                      style: TextStyle(color: clrGreyTextLight),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.groupValue.value = 2;
                    },
                    child: Row(
                      children: [
                        Obx(
                          () =>
                              customRadioButton(2, controller.groupValue.value),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "On",
                          style: TextStyle(color: clrGreyTextLight),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Obx(
                    () => Opacity(
                      opacity: controller.groupValue.value == 1 ||
                              controller.groupValue.value == 3
                          ? 0.5
                          : 1,
                      // child: Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 15, vertical: 8),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(70),
                      //       color: clrGreyLight),
                      //   child: Text(
                      //     "18 Sep 2024",
                      //     style: TextStyle(color: clrGreyTextLight),
                      //   ),
                      // ),
                      child: controller.groupValue.value == 1 ||
                              controller.groupValue.value == 3
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(70),
                                  color: clrGreyLight),
                              child: Text(
                                "DD/MM/YYYY",
                                style: TextStyle(color: clrGreyTextLight),
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now().add(Duration(days: 1)),
                                    lastDate: DateTime.now().add(Duration(days: 365)),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: clrYellow,
                                            // Change the color to yellow
                                            onPrimary: Colors.black,
                                            // Text color on selected date
                                            onSurface: Colors
                                                .black, // Text color on unselected dates
                                          ),
                                          dialogBackgroundColor: Colors
                                              .white, // Background color of the date picker
                                        ),
                                        child: child!,
                                      );
                                    },
                                    currentDate: controller
                                            .RdateForPicker.value.isNotEmpty
                                        ? DateTime.parse(
                                            controller.RdateForPicker.value)
                                        : DateTime.now());
                                if (date != null) {
                                  controller.RchangeDate(date);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70),
                                    color: clrGreyLight),
                                child: Text(
                                  controller.Rdate.value.isNotEmpty
                                      ? controller.Rdate.value
                                      : "DD/MM/YYYY",
                                  style: TextStyle(
                                      color: controller.Rdate.value.isNotEmpty
                                          ? clrBlacke
                                          : clrGreyTextLight),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.groupValue.value = 3;
                    },
                    child: Row(
                      children: [
                        Obx(
                          () =>
                              customRadioButton(3, controller.groupValue.value),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "After",
                          style: TextStyle(color: clrGreyTextLight),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),

                  SizedBox(
                    height: 35,
                    width: Get.width*0.35,
                    child: CustoTextFormField(
                      hintText: 'Max ${controller.maxOcc.value} ${controller.maxOcc.value == 1 ? 'occurrence' : 'occurrences'}',
                      hintSize: 13,
                      maxLines: 1,
                      controll: controller.occurController.value,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textKType: TextInputType.number,
                    ),
                  ),

                  // Flexible(
                  //   child: Obx(
                  //     () => Opacity(
                  //       opacity: controller.groupValue.value == 1 ||
                  //               controller.groupValue.value == 2
                  //           ? 0.5
                  //           : 1,
                  //       child: Container(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 25, vertical: 8),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(70),
                  //             color: clrGreyLight),
                  //         child: Text(
                  //           "${controller.occs.value} occurrences",
                  //           style: TextStyle(color: clrGreyTextLight),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  // Obx(
                  //   () => Opacity(
                  //     opacity: controller.groupValue.value == 1 ||
                  //             controller.groupValue.value == 2
                  //         ? 0.5
                  //         : 1,
                  //     child: Container(
                  //       height: 35,
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           InkWell(
                  //             onTap: () {
                  //               controller.groupValue.value == 1 ||
                  //                       controller.groupValue.value == 2
                  //                   ? null
                  //                   : controller.occsincrement();
                  //             },
                  //             child: Container(
                  //               height: 17,
                  //               child: Image.asset(
                  //                 'assets/images/arrow up.png',
                  //                 scale: 1.5,
                  //               ),
                  //             ),
                  //           ),
                  //           // const SizedBox(
                  //           //   height: 8,
                  //           // ),
                  //           InkWell(
                  //             onTap: () {
                  //               controller.groupValue.value == 1 ||
                  //                       controller.groupValue.value == 2
                  //                   ? null
                  //                   : controller.occsdecrement();
                  //             },
                  //             child: Container(
                  //               height: 17,
                  //               child: Image.asset(
                  //                 'assets/images/arrow down new.png',
                  //                 scale: 1.5,
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CustoFilterBtn(
                        lable: Text(
                          "Cancel",
                          style: TextStyle(color: clrBlacke),
                        ),
                        borderClr: clrBlacke,
                        ontap: () {
                          Get.back();
                          controller.repeatRefresh();
                        },
                        backgroundClr: Get.theme.scaffoldBackgroundColor),
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  Expanded(
                      child: CustomElevatedButton(
                          child: Text(
                            "Done",
                            style: TextStyle(color: clrWhite),
                          ),
                          onTap: () {
                            if (controller.wmValue.value == 0) {
                              showTostMsg('Please select an option', gravity: ToastGravity.CENTER);
                            } else if (controller.wmValue.value == 1) {
                              if (controller.repeatday.value.isEmpty) {
                                showTostMsg('Please select the weekday', gravity: ToastGravity.CENTER);
                              } else if (controller.groupValue.value == 0) {
                                showTostMsg('Please select the ends.', gravity: ToastGravity.CENTER);
                              } else if (controller.groupValue.value == 2 && controller.Rdate.value.isEmpty) {
                                showTostMsg('Please select the date', gravity: ToastGravity.CENTER);
                              } else if(controller.groupValue.value == 3 && controller.occurController.value.value.text.trim().isEmpty){
                                showTostMsg('Please fill occurrences', gravity: ToastGravity.CENTER);
                              } else if(controller.groupValue.value == 3 && controller.occurController.value.value.text.trim().isNotEmpty && (int.parse(controller.occurController.value.value.text.trim().toString()) > controller.maxOcc.value)){
                                showTostMsg('Occurrences value exceeds max value', gravity: ToastGravity.CENTER);
                              } else {
                                print('All conditions met for wmValue == 1');
                                Get.back(); // Proceed only when all conditions are satisfied
                              }
                            } else if (controller.wmValue.value == 2) {
                              if (controller.groupValue.value == 0) {
                                showTostMsg('Please select the ends.', gravity: ToastGravity.CENTER);
                              } else if (controller.groupValue.value == 2 && controller.Rdate.value.isEmpty) {
                                showTostMsg('Please select the date', gravity: ToastGravity.CENTER);
                              } else if(controller.groupValue.value == 3 && controller.occurController.value.value.text.trim().isEmpty){
                                showTostMsg('Please fill occurrences', gravity: ToastGravity.CENTER);
                              } else if(controller.groupValue.value == 3 && controller.occurController.value.value.text.trim().isNotEmpty && (int.parse(controller.occurController.value.value.text.trim().toString()) > controller.maxOcc.value)){
                                showTostMsg('Occurrences value exceeds max value', gravity: ToastGravity.CENTER);
                              } else {
                                print('All conditions met for wmValue == 2');
                                Get.back(); // Proceed only when all conditions are satisfied
                              }
                            } else {
                              print('Unexpected wmValue');
                              Get.back(); // Fallback for unexpected wmValue
                            }
                          },

                          backgroundClr: clrBlacke)),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }

  Widget customRadioButton(int value, int groupValue) {
    bool isSelected = value == groupValue;
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: isSelected ? clrYellow : clrBlacke, width: 1.5)),
      child: isSelected
          ? Container(
              margin: const EdgeInsets.all(2.2),
              decoration:
                  BoxDecoration(color: clrYellow, shape: BoxShape.circle),
              child: const SizedBox(),
            )
          : null,
    );
  }
}
