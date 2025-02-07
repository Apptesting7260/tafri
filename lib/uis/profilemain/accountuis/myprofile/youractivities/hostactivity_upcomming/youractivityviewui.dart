import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/error_widget.dart';
import '../../../../../components/custoelevatedbtn.dart';
import '../../../../../components/custofilterbtn.dart';
import 'controller/host_upcomiacti_controller.dart';

class HostUpcomActivityViewUi extends GetWidget<HostUpcomiActiController> {
  HostUpcomActivityViewUi({super.key});

  final SocketController chatController = Get.find<SocketController>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          child: Column(
            children: [
              SizedBox(
                height: h * .012,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Container(
                  //     clipBehavior: Clip.hardEdge,
                  //     width:h*.05,
                  //     height:h*.05,
                  //     padding:
                  //     const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //     decoration: BoxDecoration(
                  //         color: clrGreyLight,
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: const Center(child: Icon(Icons.arrow_back_ios)),
                  //   ),
                  // ),
                  CommonUi.appBar(),
                  const Text(
                    "Your Activity",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Share.share(
                              '${controller.actData.value.activitySettings?.shareText} https://nbttech.xyz/activity?activityid=${controller.actData.value.activity?.id}&hostId=${controller.actData.value.activity?.hostId}');
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: h * .05,
                          height: h * .05,
                          decoration: BoxDecoration(
                            color: clrBlacke,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: 
                            // Image(
                            //   image: Svg('assets/images/share-2 1.svg'),
                            //   filterQuality: FilterQuality.high,
                            //   // color: clrWhite,
                            //   // height: h * .06,
                            //   // width: w * .06,
                            // ), //
                            Image.asset('assets/images/share-2 1.png')
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                child: SmartRefresher(
                  controller: controller.refreshController,
                  header: CommonUi.refreshHeader(),
                  onRefresh: () {
                    controller.refresh();
                  },
                  child: Obx(
                    () => controller.activityLoading.value &&
                            controller.actData.value.activity == null
                        ? Center(
                            child: CommonUi.scaffoldLoading(color: clrYellow),
                          )
                        : controller.actError.value.isNotEmpty
                            ? const ErrorScreen()
                            : SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: h * .25,
                                      child: Stack(
                                        // clipBehavior: Clip.none,
                                        children: [
                                          // CarouselSlider(
                                          //   options: CarouselOptions(
                                          //       height:h*.25, viewportFraction: 1),
                                          //   items: [1, 2, 3].map((i) {
                                          //     return Builder(
                                          //       builder: (BuildContext context) {
                                          //         return Container(
                                          //             clipBehavior: Clip.hardEdge,
                                          //             width: MediaQuery.of(context)
                                          //                 .size
                                          //                 .width,
                                          //             height: double.maxFinite,
                                          //             margin: const EdgeInsets.symmetric(
                                          //                 horizontal: 0),
                                          //             decoration: BoxDecoration(
                                          //                 borderRadius:
                                          //                 BorderRadius.circular(18)),
                                          //             child: Image.asset(
                                          //               "assets/images/cofee.png",
                                          //               fit: BoxFit.cover,
                                          //               height: h*.25,
                                          //               width: double.maxFinite,
                                          //             ));
                                          //       },
                                          //     );
                                          //   }).toList(),
                                          // ),
                                          CarouselSlider(
                                            options: CarouselOptions(
                                                height: h * .26,
                                                enableInfiniteScroll: false,
                                                viewportFraction: 1,
                                                onPageChanged: (currIndex,
                                                    CarouselPageChangedReason
                                                        reason) {
                                                  controller.changeIndicator(
                                                      currIndex);
                                                  debugPrint(
                                                      " currIndex $currIndex reason=$reason");
                                                }),
                                            items: controller
                                                .actData.value.activity!.banners
                                                ?.map<Widget>((i) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: double.maxFinite,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18)),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        height: h * .26,
                                                        width: double.maxFinite,
                                                        memCacheWidth: 500,
                                                        imageUrl: "$i",
                                                        placeholder: (context,
                                                                url) =>
                                                            Shimmer.fromColors(
                                                          baseColor: grey300,
                                                          highlightColor:
                                                              grey100,
                                                          child: Container(
                                                            width: double
                                                                .maxFinite,
                                                            height: h * .26,
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
                                                      ));
                                                },
                                              );
                                            }).toList(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: clrWhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Text(
                                                    controller
                                                        .actData
                                                        .value
                                                        .activity!
                                                        .subcategoryTitle
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                const SizedBox(),
                                              ],
                                            ),
                                          ),
                                          // Align(
                                          //   alignment: Alignment.bottomCenter,
                                          //   child: Container(
                                          //     margin: EdgeInsets.only(bottom: 7),
                                          //     height: 16,
                                          //     child: ListView.builder(
                                          //         itemCount: 3,
                                          //         shrinkWrap: true,
                                          //         scrollDirection: Axis.horizontal,
                                          //         itemBuilder: (context, index) {
                                          //           return Padding(
                                          //             padding: const EdgeInsets.symmetric(
                                          //                 horizontal: 1.5),
                                          //             child: Icon(
                                          //               Icons.circle,
                                          //               color: clrWhite,
                                          //               size: 8,
                                          //             ),
                                          //           );
                                          //         }),
                                          //   ),
                                          // )
                                          controller
                                              .actData
                                              .value
                                              .activity!
                                              .banners
                                              ?.length != 1 ? Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 7),
                                              height: 16,
                                              child: ListView.builder(
                                                  itemCount: controller
                                                      .actData
                                                      .value
                                                      .activity!
                                                      .banners
                                                      ?.length,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (context,
                                                      indicatorIndex) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 1.5),
                                                      child: Obx(
                                                        () => Icon(
                                                          Icons.circle,
                                                          color: controller
                                                                      .actData
                                                                      .value
                                                                      .activity!
                                                                      .circleIndex
                                                                      ?.value ==
                                                                  indicatorIndex
                                                              ? clrYellow
                                                              : clrWhite,
                                                          size: 8,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ) : SizedBox()
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.actData.value
                                                    .activity!.name
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: h * .005,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (controller.actData.value
                                                          .activity!.latitude ==
                                                      null || !controller
                                                      .actData
                                                      .value
                                                      .activity
                                                  !.longitude!.contains('.') || !controller
                                                      .actData
                                                      .value
                                                      .activity
                                                  !.latitude!.contains('.')) {
                                                    showTostMsg(
                                                        'No location found');
                                                  } else {
                                                    Get.toNamed(
                                                        Routes.mapexploreui,
                                                        arguments: {
                                                          'latitude': controller
                                                              .actData
                                                              .value
                                                              .activity!
                                                              .latitude,
                                                          'longitude':
                                                              controller
                                                                  .actData
                                                                  .value
                                                                  .activity!
                                                                  .longitude,
                                                          'title': controller
                                                              .actData
                                                              .value
                                                              .activity!
                                                              .name
                                                              .toString(),
                                                          'image': controller
                                                              .actData
                                                              .value
                                                              .activity!
                                                              .banners?[0]
                                                              .toString(),
                                                        });
                                                  }
                                                },
                                                child: Text(
                                                  controller.actData.value
                                                      .activity!.location
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: clrGreyDark),
                                                ),
                                              ),
                                              SizedBox(
                                                height: h * .005,
                                              ),
                                              Text(
                                                '${controller.actData.value.activity!.formattedDate} | ${controller.actData.value.activity!.startAt} - ${controller.actData.value.activity!.endAt}',
                                                style: TextStyle(
                                                    color: clrGreyTextLight),
                                              ),
                                              SizedBox(
                                                height: h * .008,
                                              ),
                                              Text(
                                                "Up to ${controller.actData.value.activity!.maxPeople} people | ${controller.actData.value.activity!.spotLeft} ${controller.actData.value.activity!.spotLeft! == 1 ? 'spot left' : 'spots left'}",
                                                style: TextStyle(
                                                    color: clrYellowText,
                                                    fontSize: 13),
                                              ),

                                              // Text(
                                              //   "Up to ${controller.actData.value.activity!.maxPeople} people | ${controller.actData.value.activity!.spotLeft} spot left",
                                              //   style: TextStyle(
                                              //       color: clrYellowText,
                                              //       fontSize: 13),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.hostProfileUi,
                                                arguments: controller.actData
                                                    .value.activity!.hostId
                                                    .toString());
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: CachedNetworkImage(
                                                  height: 40,
                                                  width: 40,
                                                  fit: BoxFit.cover,
                                                  memCacheWidth: 500,
                                                  imageUrl:
                                                      '${controller.actData.value.activity!.profilePhoto}',
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                    height: 40,
                                                    width: 40,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        color: clrGreyLight,
                                                        shape: BoxShape.circle),
                                                    child: Image.asset(
                                                      "assets/icons/manicon.png",
                                                      color: clrGrey,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor: grey300,
                                                    highlightColor: grey100,
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        color: grey300,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                controller.actData.value
                                                    .activity!.hostName
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Text(
                                      controller
                                          .actData.value.activity!.description
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: clrGreyTextLight),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    const Text(
                                      "You created this activity",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),

                                    controller.actData.value.requests!
                                        .isNotEmpty ||
                                        controller
                                            .actData.value.going!.isNotEmpty
                                        ? SizedBox(
                                      height: Get.height * 0.02,
                                    )
                                        : const SizedBox(),
                                    Obx(() {
                                      return controller.actData.value.requests!
                                          .isNotEmpty ||
                                          controller.actData.value.going!
                                              .isNotEmpty
                                          ? Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller
                                                  .changeSlectedTab(1);
                                            },
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Requests",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: controller
                                                          .selectedTab
                                                          .value ==
                                                          1
                                                          ? FontWeight
                                                          .w700
                                                          : FontWeight
                                                          .w400),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                controller.selectedTab
                                                    .value ==
                                                    1
                                                    ? Container(
                                                  height: 3,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      color:
                                                      clrYellow,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          10)),
                                                )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.1,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller
                                                  .changeSlectedTab(2);
                                            },
                                            child: Column(
                                              children: [
                                                Text("Going",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: controller
                                                            .selectedTab
                                                            .value ==
                                                            2
                                                            ? FontWeight
                                                            .w700
                                                            : FontWeight
                                                            .w400)),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                controller.selectedTab
                                                    .value ==
                                                    2
                                                    ? Container(
                                                  height: 3,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      color:
                                                      clrYellow,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          10)),
                                                )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                          : const SizedBox();
                                    }),
                                    controller.actData.value.requests!
                                        .isNotEmpty ||
                                        controller
                                            .actData.value.going!.isNotEmpty
                                        ? SizedBox(
                                      height: Get.height * 0.02,
                                    )
                                        : SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Obx(() {
                                      return controller.selectedTab.value == 1
                                          ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.actData
                                              .value.requests?.length,
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child:
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                Routes
                                                                    .userProfileui,
                                                                arguments: controller
                                                                    .actData
                                                                    .value
                                                                    .requests?[
                                                                index]
                                                                    .userId
                                                                    .toString());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100),
                                                                child:
                                                                CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height:
                                                                  40,
                                                                  width: 40,
                                                                  memCacheWidth: 500,
                                                                  imageUrl:
                                                                  "${controller.actData.value.requests?[index].profilePhoto}",
                                                                  placeholder: (context,
                                                                      url) =>
                                                                      Shimmer
                                                                          .fromColors(
                                                                        baseColor:
                                                                        grey300,
                                                                        highlightColor:
                                                                        grey100,
                                                                        child:
                                                                        Container(
                                                                          width:
                                                                          double.maxFinite,
                                                                          height:
                                                                          h * .26,
                                                                          decoration:
                                                                          BoxDecoration(
                                                                            color:
                                                                            grey300,
                                                                            borderRadius:
                                                                            BorderRadius.circular(18),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                        BorderRadius.circular(100),
                                                                        child:
                                                                        Container(
                                                                          height:
                                                                          55,
                                                                          width:
                                                                          55,
                                                                          color:
                                                                          clrGreyLight,
                                                                          child:
                                                                          Image.asset(
                                                                            'assets/icons/manicon.png',
                                                                            color:
                                                                            clrGrey,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                Get.width *
                                                                    0.02,
                                                              ),
                                                              Flexible(
                                                                  child: Text(
                                                                      ' ${controller.actData.value.requests?[index].firstName}',
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 16)))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Obx(() => controller
                                                          .actData
                                                          .value
                                                          .requests?[
                                                      index].loading.value == true ? CommonUi.fallingDot(color: clrBlacke) : Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Get.toNamed(Routes.attendReviewUi);
                                                              controller.rejectuserapi(controller
                                                                  .actData
                                                                  .value
                                                                  .requests?[
                                                              index]
                                                                  .userId
                                                                  .toString(),controller
                                                                  .actData
                                                                  .value
                                                                  .requests?[
                                                              index].loading);
                                                            },
                                                            child:
                                                            Container(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  7),
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100),
                                                                color:
                                                                clrBlacke,
                                                              ),
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                clrWhite,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                            Get.width *
                                                                0.04,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Get.toNamed(Routes.attendReviewUi);

                                                              controller.acceptuserapi(controller
                                                                  .actData
                                                                  .value
                                                                  .requests?[
                                                              index]
                                                                  .userId
                                                                  .toString(),controller
                                                                  .actData
                                                                  .value
                                                                  .requests?[
                                                              index].loading);
                                                            },
                                                            child:
                                                            Container(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(
                                                                  7),
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100),
                                                                color:
                                                                clrYellow,
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                color:
                                                                clrWhite,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    Get.height * 0.007,
                                                  ),
                                                  Divider(
                                                    color: clrGreyLight,
                                                    height: 8,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    Get.height * 0.007,
                                                  ),
                                                ],
                                              ),
                                            );
                                          })
                                          : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .actData.value.going?.length,
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets
                                                  .symmetric(vertical: 0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      // Flexible(
                                                      //   child: Row(
                                                      //     children: [
                                                      //       Container(
                                                      //           height:
                                                      //               h * .05,
                                                      //           width:
                                                      //               h * .05,
                                                      //           decoration: BoxDecoration(
                                                      //               borderRadius:
                                                      //                   BorderRadius.circular(
                                                      //                       100)),
                                                      //           child: Image
                                                      //               .asset(
                                                      //             "assets/images/girldp.png",
                                                      //             fit: BoxFit
                                                      //                 .cover,
                                                      //           )),
                                                      //       SizedBox(
                                                      //         width:
                                                      //             Get.width *
                                                      //                 0.02,
                                                      //       ),
                                                      //       const Flexible(
                                                      //           child: Text(
                                                      //         "Isabelle Wilson",
                                                      //         style: TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight
                                                      //                     .w600,
                                                      //             fontSize:
                                                      //                 16),
                                                      //       ))
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      Flexible(
                                                        child:
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                Routes
                                                                    .userProfileui,
                                                                arguments: controller
                                                                    .actData
                                                                    .value
                                                                    .going?[
                                                                index]
                                                                    .userId
                                                                    .toString());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    100),
                                                                child:
                                                                CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  memCacheWidth: 500,
                                                                  height:
                                                                  40,
                                                                  width: 40,
                                                                  imageUrl:
                                                                  "${controller.actData.value.going?[index].profilePhoto}",
                                                                  placeholder: (context,
                                                                      url) =>
                                                                      Shimmer
                                                                          .fromColors(
                                                                        baseColor:
                                                                        grey300,
                                                                        highlightColor:
                                                                        grey100,
                                                                        child:
                                                                        Container(
                                                                          width:
                                                                          double.maxFinite,
                                                                          height:
                                                                          h * .26,
                                                                          decoration:
                                                                          BoxDecoration(
                                                                            color:
                                                                            grey300,
                                                                            borderRadius:
                                                                            BorderRadius.circular(18),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                        BorderRadius.circular(100),
                                                                        child:
                                                                        Container(
                                                                          height:
                                                                          55,
                                                                          width:
                                                                          55,
                                                                          color:
                                                                          clrGreyLight,
                                                                          child:
                                                                          Image.asset(
                                                                            'assets/icons/manicon.png',
                                                                            color:
                                                                            clrGrey,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                Get.width *
                                                                    0.02,
                                                              ),
                                                              Flexible(
                                                                  child: Text(
                                                                      ' ${controller.actData.value.going?[index].firstName}',
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 16)))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          alertRemove(() {
                                                            Get.back();
                                                            controller.removeuserapi(
                                                                controller
                                                                    .actData
                                                                    .value
                                                                    .going?[
                                                                index]
                                                                    .userId
                                                                    .toString());
                                                          });
                                                          // controller.removeuserapi(controller.actData.value.going?[index].userId.toString());
                                                        },
                                                        child: Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              15,
                                                              vertical:
                                                              5),
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20),
                                                            color:
                                                            clrBlacke,
                                                          ),
                                                          child: Text(
                                                            "Remove",
                                                            style: TextStyle(
                                                                color:
                                                                clrWhite,
                                                                fontSize:
                                                                12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    Get.height * 0.007,
                                                  ),
                                                  Divider(
                                                    color: clrGreyLight,
                                                    height: 8,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                    Get.height * 0.007,
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    }),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),

                                    controller.actData.value.activity
                                        ?.latitude !=
                                        null &&
                                        controller.actData.value.activity
                                            ?.longitude !=
                                            null && controller
                                        .actData
                                        .value
                                        .activity
                                    !.longitude!.contains('.') && controller
                                        .actData
                                        .value
                                        .activity
                                    !.latitude!.contains('.')
                                        ? SizedBox(
                                      height: Get.height * 0.02,
                                    ) : SizedBox(),
                                    controller.actData.value.activity
                                                    ?.latitude !=
                                                null &&
                                            controller.actData.value.activity
                                                    ?.longitude !=
                                                null && controller
                                        .actData
                                        .value
                                        .activity
                                    !.longitude!.contains('.') && controller
                                        .actData
                                        .value
                                        .activity
                                    !.latitude!.contains('.')
                                        ? Container(
                                            height: 200,
                                            child: GoogleMap(
                                              onMapCreated: (GoogleMapController
                                                  googleMapController) {
                                                controller.mapController =
                                                    googleMapController;
                                                controller.addMarkerWithImage();
                                              },
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target: LatLng(
                                                    double.parse(controller
                                                        .actData
                                                        .value
                                                        .activity!
                                                        .latitude!),
                                                    double.parse(controller
                                                        .actData
                                                        .value
                                                        .activity!
                                                        .longitude!)),
                                                zoom: 14.0,
                                              ),
                                              myLocationEnabled: true,
                                              myLocationButtonEnabled: true,
                                              markers: Set<Marker>.from(
                                                  controller.markers),
                                            ))
                                        : const SizedBox(),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    // controller.actData.value.requests!
                                    //             .isNotEmpty ||
                                    //         controller
                                    //             .actData.value.going!.isNotEmpty
                                    //     ? SizedBox(
                                    //         height: Get.height * 0.04,
                                    //       )
                                    //     : const SizedBox(),
                                    // Obx(() {
                                    //   return controller.actData.value.requests!
                                    //               .isNotEmpty ||
                                    //           controller.actData.value.going!
                                    //               .isNotEmpty
                                    //       ? Row(
                                    //           children: [
                                    //             InkWell(
                                    //               onTap: () {
                                    //                 controller
                                    //                     .changeSlectedTab(1);
                                    //               },
                                    //               child: Column(
                                    //                 children: [
                                    //                   Text(
                                    //                     "Requests",
                                    //                     style: TextStyle(
                                    //                         fontSize: 16,
                                    //                         fontWeight: controller
                                    //                                     .selectedTab
                                    //                                     .value ==
                                    //                                 1
                                    //                             ? FontWeight
                                    //                                 .w700
                                    //                             : FontWeight
                                    //                                 .w400),
                                    //                   ),
                                    //                   const SizedBox(
                                    //                     height: 5,
                                    //                   ),
                                    //                   controller.selectedTab
                                    //                               .value ==
                                    //                           1
                                    //                       ? Container(
                                    //                           height: 3,
                                    //                           width: 70,
                                    //                           decoration: BoxDecoration(
                                    //                               color:
                                    //                                   clrYellow,
                                    //                               borderRadius:
                                    //                                   BorderRadius
                                    //                                       .circular(
                                    //                                           10)),
                                    //                         )
                                    //                       : const SizedBox()
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //             SizedBox(
                                    //               width: Get.width * 0.1,
                                    //             ),
                                    //             InkWell(
                                    //               onTap: () {
                                    //                 controller
                                    //                     .changeSlectedTab(2);
                                    //               },
                                    //               child: Column(
                                    //                 children: [
                                    //                   Text("Going",
                                    //                       style: TextStyle(
                                    //                           fontSize: 16,
                                    //                           fontWeight: controller
                                    //                                       .selectedTab
                                    //                                       .value ==
                                    //                                   2
                                    //                               ? FontWeight
                                    //                                   .w700
                                    //                               : FontWeight
                                    //                                   .w400)),
                                    //                   const SizedBox(
                                    //                     height: 5,
                                    //                   ),
                                    //                   controller.selectedTab
                                    //                               .value ==
                                    //                           2
                                    //                       ? Container(
                                    //                           height: 3,
                                    //                           width: 70,
                                    //                           decoration: BoxDecoration(
                                    //                               color:
                                    //                                   clrYellow,
                                    //                               borderRadius:
                                    //                                   BorderRadius
                                    //                                       .circular(
                                    //                                           10)),
                                    //                         )
                                    //                       : const SizedBox()
                                    //                 ],
                                    //               ),
                                    //             )
                                    //           ],
                                    //         )
                                    //       : const SizedBox();
                                    // }),
                                    // controller.actData.value.requests!
                                    //             .isNotEmpty ||
                                    //         controller
                                    //             .actData.value.going!.isNotEmpty
                                    //     ? SizedBox(
                                    //         height: Get.height * 0.02,
                                    //       )
                                    //     : SizedBox(
                                    //         height: Get.height * 0.01,
                                    //       ),
                                    // Obx(() {
                                    //   return controller.selectedTab.value == 1
                                    //       ? ListView.builder(
                                    //           shrinkWrap: true,
                                    //           itemCount: controller.actData
                                    //               .value.requests?.length,
                                    //           physics:
                                    //               const NeverScrollableScrollPhysics(),
                                    //           itemBuilder: (context, index) {
                                    //             return Container(
                                    //               margin: const EdgeInsets
                                    //                   .symmetric(vertical: 0),
                                    //               child: Column(
                                    //                 mainAxisAlignment:
                                    //                     MainAxisAlignment
                                    //                         .center,
                                    //                 children: [
                                    //                   Row(
                                    //                     mainAxisAlignment:
                                    //                         MainAxisAlignment
                                    //                             .spaceBetween,
                                    //                     children: [
                                    //                       Flexible(
                                    //                         child:
                                    //                             GestureDetector(
                                    //                           onTap: () {
                                    //                             Get.toNamed(
                                    //                                 Routes
                                    //                                     .userProfileui,
                                    //                                 arguments: controller
                                    //                                     .actData
                                    //                                     .value
                                    //                                     .going?[
                                    //                                         index]
                                    //                                     .userId
                                    //                                     .toString());
                                    //                           },
                                    //                           child: Row(
                                    //                             children: [
                                    //                               ClipRRect(
                                    //                                 borderRadius:
                                    //                                     BorderRadius.circular(
                                    //                                         100),
                                    //                                 child:
                                    //                                     CachedNetworkImage(
                                    //                                   fit: BoxFit
                                    //                                       .cover,
                                    //                                   height:
                                    //                                       40,
                                    //                                   width: 40,
                                    //                                   imageUrl:
                                    //                                       "${controller.actData.value.requests?[index].profilePhoto}",
                                    //                                   placeholder: (context,
                                    //                                           url) =>
                                    //                                       Shimmer
                                    //                                           .fromColors(
                                    //                                     baseColor:
                                    //                                         grey300,
                                    //                                     highlightColor:
                                    //                                         grey100,
                                    //                                     child:
                                    //                                         Container(
                                    //                                       width:
                                    //                                           double.maxFinite,
                                    //                                       height:
                                    //                                           h * .26,
                                    //                                       decoration:
                                    //                                           BoxDecoration(
                                    //                                         color:
                                    //                                             grey300,
                                    //                                         borderRadius:
                                    //                                             BorderRadius.circular(18),
                                    //                                       ),
                                    //                                     ),
                                    //                                   ),
                                    //                                   errorWidget: (context,
                                    //                                           url,
                                    //                                           error) =>
                                    //                                       ClipRRect(
                                    //                                     borderRadius:
                                    //                                         BorderRadius.circular(100),
                                    //                                     child:
                                    //                                         Container(
                                    //                                       height:
                                    //                                           55,
                                    //                                       width:
                                    //                                           55,
                                    //                                       color:
                                    //                                           clrGreyLight,
                                    //                                       child:
                                    //                                           Image.asset(
                                    //                                         'assets/icons/manicon.png',
                                    //                                         color:
                                    //                                             clrGrey,
                                    //                                       ),
                                    //                                     ),
                                    //                                   ),
                                    //                                 ),
                                    //                               ),
                                    //                               SizedBox(
                                    //                                 width:
                                    //                                     Get.width *
                                    //                                         0.02,
                                    //                               ),
                                    //                               Flexible(
                                    //                                   child: Text(
                                    //                                       ' ${controller.actData.value.requests?[index].firstName}',
                                    //                                       style: const TextStyle(
                                    //                                           fontWeight: FontWeight.w600,
                                    //                                           fontSize: 16)))
                                    //                             ],
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                       Obx(() => controller
                                    //                           .actData
                                    //                           .value
                                    //                           .requests?[
                                    //                       index].loading.value == true ? CommonUi.fallingDot(color: clrBlacke) : Row(
                                    //                         children: [
                                    //                           GestureDetector(
                                    //                             onTap: () {
                                    //                               // Get.toNamed(Routes.attendReviewUi);
                                    //                               controller.rejectuserapi(controller
                                    //                                   .actData
                                    //                                   .value
                                    //                                   .requests?[
                                    //                               index]
                                    //                                   .userId
                                    //                                   .toString(),controller
                                    //                                   .actData
                                    //                                   .value
                                    //                                   .requests?[
                                    //                               index].loading);
                                    //                             },
                                    //                             child:
                                    //                             Container(
                                    //                               padding:
                                    //                               const EdgeInsets
                                    //                                   .all(
                                    //                                   7),
                                    //                               decoration:
                                    //                               BoxDecoration(
                                    //                                 borderRadius:
                                    //                                 BorderRadius.circular(
                                    //                                     100),
                                    //                                 color:
                                    //                                 clrBlacke,
                                    //                               ),
                                    //                               child: Icon(
                                    //                                 Icons.close,
                                    //                                 color:
                                    //                                 clrWhite,
                                    //                                 size: 20,
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                           SizedBox(
                                    //                             width:
                                    //                             Get.width *
                                    //                                 0.02,
                                    //                           ),
                                    //                           GestureDetector(
                                    //                             onTap: () {
                                    //                               // Get.toNamed(Routes.attendReviewUi);
                                    //
                                    //                               controller.acceptuserapi(controller
                                    //                                   .actData
                                    //                                   .value
                                    //                                   .requests?[
                                    //                               index]
                                    //                                   .userId
                                    //                                   .toString(),controller
                                    //                                   .actData
                                    //                                   .value
                                    //                                   .requests?[
                                    //                               index].loading);
                                    //                             },
                                    //                             child:
                                    //                             Container(
                                    //                               padding:
                                    //                               const EdgeInsets
                                    //                                   .all(
                                    //                                   7),
                                    //                               decoration:
                                    //                               BoxDecoration(
                                    //                                 borderRadius:
                                    //                                 BorderRadius.circular(
                                    //                                     100),
                                    //                                 color:
                                    //                                 clrYellow,
                                    //                               ),
                                    //                               child: Icon(
                                    //                                 Icons.check,
                                    //                                 color:
                                    //                                 clrWhite,
                                    //                                 size: 20,
                                    //                               ),
                                    //                             ),
                                    //                           )
                                    //                         ],
                                    //                       ),)
                                    //                     ],
                                    //                   ),
                                    //                   SizedBox(
                                    //                     height:
                                    //                         Get.height * 0.007,
                                    //                   ),
                                    //                   Divider(
                                    //                     color: clrGreyLight,
                                    //                     height: 8,
                                    //                   ),
                                    //                   SizedBox(
                                    //                     height:
                                    //                         Get.height * 0.007,
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             );
                                    //           })
                                    //       : ListView.builder(
                                    //           shrinkWrap: true,
                                    //           itemCount: controller
                                    //               .actData.value.going?.length,
                                    //           physics:
                                    //               const NeverScrollableScrollPhysics(),
                                    //           itemBuilder: (context, index) {
                                    //             return Container(
                                    //               margin: const EdgeInsets
                                    //                   .symmetric(vertical: 0),
                                    //               child: Column(
                                    //                 children: [
                                    //                   Row(
                                    //                     mainAxisAlignment:
                                    //                         MainAxisAlignment
                                    //                             .spaceBetween,
                                    //                     children: [
                                    //                       // Flexible(
                                    //                       //   child: Row(
                                    //                       //     children: [
                                    //                       //       Container(
                                    //                       //           height:
                                    //                       //               h * .05,
                                    //                       //           width:
                                    //                       //               h * .05,
                                    //                       //           decoration: BoxDecoration(
                                    //                       //               borderRadius:
                                    //                       //                   BorderRadius.circular(
                                    //                       //                       100)),
                                    //                       //           child: Image
                                    //                       //               .asset(
                                    //                       //             "assets/images/girldp.png",
                                    //                       //             fit: BoxFit
                                    //                       //                 .cover,
                                    //                       //           )),
                                    //                       //       SizedBox(
                                    //                       //         width:
                                    //                       //             Get.width *
                                    //                       //                 0.02,
                                    //                       //       ),
                                    //                       //       const Flexible(
                                    //                       //           child: Text(
                                    //                       //         "Isabelle Wilson",
                                    //                       //         style: TextStyle(
                                    //                       //             fontWeight:
                                    //                       //                 FontWeight
                                    //                       //                     .w600,
                                    //                       //             fontSize:
                                    //                       //                 16),
                                    //                       //       ))
                                    //                       //     ],
                                    //                       //   ),
                                    //                       // ),
                                    //                       Flexible(
                                    //                         child:
                                    //                             GestureDetector(
                                    //                           onTap: () {
                                    //                             Get.toNamed(
                                    //                                 Routes
                                    //                                     .userProfileui,
                                    //                                 arguments: controller
                                    //                                     .actData
                                    //                                     .value
                                    //                                     .going?[
                                    //                                         index]
                                    //                                     .userId
                                    //                                     .toString());
                                    //                           },
                                    //                           child: Row(
                                    //                             children: [
                                    //                               ClipRRect(
                                    //                                 borderRadius:
                                    //                                     BorderRadius.circular(
                                    //                                         100),
                                    //                                 child:
                                    //                                     CachedNetworkImage(
                                    //                                   fit: BoxFit
                                    //                                       .cover,
                                    //                                   height:
                                    //                                       40,
                                    //                                   width: 40,
                                    //                                   imageUrl:
                                    //                                       "${controller.actData.value.going?[index].profilePhoto}",
                                    //                                   placeholder: (context,
                                    //                                           url) =>
                                    //                                       Shimmer
                                    //                                           .fromColors(
                                    //                                     baseColor:
                                    //                                         grey300,
                                    //                                     highlightColor:
                                    //                                         grey100,
                                    //                                     child:
                                    //                                         Container(
                                    //                                       width:
                                    //                                           double.maxFinite,
                                    //                                       height:
                                    //                                           h * .26,
                                    //                                       decoration:
                                    //                                           BoxDecoration(
                                    //                                         color:
                                    //                                             grey300,
                                    //                                         borderRadius:
                                    //                                             BorderRadius.circular(18),
                                    //                                       ),
                                    //                                     ),
                                    //                                   ),
                                    //                                   errorWidget: (context,
                                    //                                           url,
                                    //                                           error) =>
                                    //                                       ClipRRect(
                                    //                                     borderRadius:
                                    //                                         BorderRadius.circular(100),
                                    //                                     child:
                                    //                                         Container(
                                    //                                       height:
                                    //                                           55,
                                    //                                       width:
                                    //                                           55,
                                    //                                       color:
                                    //                                           clrGreyLight,
                                    //                                       child:
                                    //                                           Image.asset(
                                    //                                         'assets/icons/manicon.png',
                                    //                                         color:
                                    //                                             clrGrey,
                                    //                                       ),
                                    //                                     ),
                                    //                                   ),
                                    //                                 ),
                                    //                               ),
                                    //                               SizedBox(
                                    //                                 width:
                                    //                                     Get.width *
                                    //                                         0.02,
                                    //                               ),
                                    //                               Flexible(
                                    //                                   child: Text(
                                    //                                       ' ${controller.actData.value.going?[index].firstName}',
                                    //                                       style: const TextStyle(
                                    //                                           fontWeight: FontWeight.w600,
                                    //                                           fontSize: 16)))
                                    //                             ],
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                       InkWell(
                                    //                         onTap: () {
                                    //                           alertRemove(() {
                                    //                             Get.back();
                                    //                             controller.removeuserapi(
                                    //                                 controller
                                    //                                     .actData
                                    //                                     .value
                                    //                                     .going?[
                                    //                                         index]
                                    //                                     .userId
                                    //                                     .toString());
                                    //                           });
                                    //                           // controller.removeuserapi(controller.actData.value.going?[index].userId.toString());
                                    //                         },
                                    //                         child: Container(
                                    //                           padding:
                                    //                               const EdgeInsets
                                    //                                   .symmetric(
                                    //                                   horizontal:
                                    //                                       15,
                                    //                                   vertical:
                                    //                                       5),
                                    //                           decoration:
                                    //                               BoxDecoration(
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(
                                    //                                         20),
                                    //                             color:
                                    //                                 clrBlacke,
                                    //                           ),
                                    //                           child: Text(
                                    //                             "Remove",
                                    //                             style: TextStyle(
                                    //                                 color:
                                    //                                     clrWhite,
                                    //                                 fontSize:
                                    //                                     12,
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .w700),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                   SizedBox(
                                    //                     height:
                                    //                         Get.height * 0.007,
                                    //                   ),
                                    //                   Divider(
                                    //                     color: clrGreyLight,
                                    //                     height: 8,
                                    //                   ),
                                    //                   SizedBox(
                                    //                     height:
                                    //                         Get.height * 0.007,
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             );
                                    //           });
                                    // }),
                                    // SizedBox(
                                    //   height: Get.height * 0.02,
                                    // ),
                                  ],
                                ),
                              ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Obx(() => controller.activityLoading.value &&
                  controller.actData.value.activity == null
                  ? const SizedBox() : controller.actData.value.activity?.status == 'pending' ? SizedBox(
                  width: double.maxFinite,
                  height: Res.h_btn,
                  child: CustomElevatedButton(
                      onTap: () {

                      },
                      backgroundClr: clrBlacke,
                      child: Text(
                        "In review",
                        style: TextStyle(
                            color: clrWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ))) : SizedBox(
                  width: double.maxFinite,
                  height: Res.h_btn,
                  child: CustomElevatedButton(
                      onTap: () {
                        print(
                            'gp == ${controller.actData.value.activity?.groupId}');
                        if (controller.actData.value
                            .activity?.groupId !=
                            null) {
                          Get.offNamed(Routes.chatUi,
                              arguments: {
                                'gpID': controller
                                    .actData
                                    .value
                                    .activity
                                    ?.groupId,
                                'activityId': controller
                                  .actData
                                  .value
                                  .activity
                                  ?.id.toString(),
                                'hostId': controller.actData.value.activity?.hostId.toString()
                                // 'members': data.allMember
                              });
                        } else {
                          showTostMsg(
                              'No group exist for this activity');
                        }
                      },
                      backgroundClr: clrBlacke,
                      child: Text(
                        "Message group",
                        style: TextStyle(
                            color: clrWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ))),),
              const SizedBox(height: 10,),
              Obx(() => controller.activityLoading.value &&
                  controller.actData.value.activity == null
                  ? const SizedBox() : Center(
                  child: InkWell(
                      onTap: () {
                        if (controller.checkHour(context,
                            startDate: controller.actData
                                .value.activity!.date
                                .toString(),
                            startTime: controller.actData
                                .value.activity!.startAt
                                .toString(),
                            hours: controller
                                .actData
                                .value
                                .paymentSettings!
                                .hostCancellationHour
                                .toString())) {
                          alertConfirmCancelActivityFees(
                              controller.actData.value
                                  .activity!.id
                                  .toString(),
                              controller
                                  .actData
                                  .value
                                  .paymentSettings!
                                  .hostCancellationHour
                                  .toString(),
                              controller
                                  .actData
                                  .value
                                  .paymentSettings!
                                  .hostCancellationFee
                                  .toString());
                        } else {
                          alertConfirmCancelActivity();
                        }
                      },
                      child: const Text(
                        "Delete activity",
                        style: TextStyle(
                            decoration:
                            TextDecoration.underline),
                      ))),),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }

  alertRemove(dynamic Function() onTap) {
    Future.delayed(Duration.zero, () {
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Are you sure?",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Get.height * .012,
              ),
              Center(
                  child: Text(
                "Are you sure you want to remove this user?",
                style: TextStyle(color: clrGreyTextLight, fontSize: 15),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: Get.height * .024,
              ),
              Row(children: [
                Expanded(
                    child: SizedBox(
                  height: Res.h_btn,
                  child: CustoFilterBtn(
                      borderClr: clrBlacke,
                      lable: Text(
                        "Go back",
                        style: TextStyle(
                            color: clrBlacke,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      ontap: () {
                        Get.back();
                      },
                      backgroundClr: Get.theme.scaffoldBackgroundColor),
                )),
                SizedBox(
                  width: Get.width * 0.05,
                ),
                Expanded(
                  child: SizedBox(
                      width: double.maxFinite,
                      height: Res.h_btn,
                      child: CustomElevatedButton(
                          onTap: onTap,
                          backgroundClr: clrBlacke,
                          child: Text(
                            "Remove",
                            style: TextStyle(
                                color: clrWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ))),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ));
    });
  }

  // alertDeleteActivity() {
  //   Future.delayed(Duration.zero, () {
  //     Get.dialog(AlertDialog(
  //       scrollable: true,
  //       insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
  //       contentPadding:
  //           const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
  //       content: SizedBox(
  //         width: double.maxFinite,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Center(
  //               child: Text(
  //                 "Are you sure?",
  //                 style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //             SizedBox(
  //               height: Get.height * .012,
  //             ),
  //             Center(
  //                 child: Text(
  //               "Are you sure you want to delete this activity?",
  //               style: TextStyle(color: clrGreyTextLight, fontSize: 15),
  //               textAlign: TextAlign.center,
  //             )),
  //             SizedBox(
  //               height: Get.height * .024,
  //             ),
  //             Row(children: [
  //               Expanded(
  //                   child: SizedBox(
  //                 height: Res.h_btn,
  //                 child: CustoFilterBtn(
  //                     borderClr: clrBlacke,
  //                     lable: Text(
  //                       "Go back",
  //                       style: TextStyle(
  //                           color: clrBlacke,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w700),
  //                     ),
  //                     ontap: () {
  //                       Get.back();
  //                       // alertCancelRequestConfirmation();
  //                     },
  //                     backgroundClr: Get.theme.scaffoldBackgroundColor),
  //               )),
  //               SizedBox(
  //                 width: Get.width * 0.05,
  //               ),
  //               Expanded(
  //                 child: SizedBox(
  //                     width: double.maxFinite,
  //                     height: Res.h_btn,
  //                     child: CustomElevatedButton(
  //                         onTap: () {
  //                           Get.back();
  //                           alertConfirmCancelActivityFees();
  //                         },
  //                         backgroundClr: clrBlacke,
  //                         child: Text(
  //                           "Delete",
  //                           style: TextStyle(
  //                               color: clrWhite,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w700),
  //                         ))),
  //               ),
  //             ]),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ));
  //   });
  // }

  alertConfirmCancelActivityFees(String id, String hours, String fees) {
    Future.delayed(Duration.zero, () {
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Confirm cancellation",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Get.height * .013,
              ),
              Center(
                  child: Text(
                "Canceling within ${hours} hours of the activity will incur a €${fees} fee. Are you sure you want to proceed?",
                style: TextStyle(color: clrGreyTextLight, fontSize: 15),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: Get.height * .025,
              ),
              Row(children: [
                Expanded(
                    child: SizedBox(
                  height: Res.h_btn,
                  child: CustoFilterBtn(
                      borderClr: clrBlacke,
                      lable: Text(
                        "Yes, cancel",
                        style: TextStyle(
                            color: clrBlacke,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      ontap: () {
                        Get.back();
                        if (controller.actData.value.going!.isNotEmpty) {
                          alertConfCancelActiAttendies();
                        } else {
                          alertConfirmCancelActivity();
                        }
                      },
                      backgroundClr: Get.theme.scaffoldBackgroundColor),
                )),
                SizedBox(
                  width: Get.width * 0.05,
                ),
                Expanded(
                  child: SizedBox(
                      width: double.maxFinite,
                      height: Res.h_btn,
                      child: CustomElevatedButton(
                          onTap: () {
                            Get.back();
                          },
                          backgroundClr: clrBlacke,
                          child: Text(
                            "Go back",
                            style: TextStyle(
                                color: clrWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ))),
                ),
              ]),
              SizedBox(
                height: Get.width * 0.015,
              ),
            ],
          ),
        ),
      ));
    });
  }

  alertConfCancelActiAttendies() {
    Future.delayed(Duration.zero, () {
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Confirm cancellation",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Get.width * 0.013,
              ),
              Center(
                  child: Text(
                "There are already attendees joining your activity. Are you sure you want to cancel?",
                style: TextStyle(color: clrGreyTextLight, fontSize: 15),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: Get.width * 0.025,
              ),
              Row(children: [
                Expanded(
                    child: SizedBox(
                  height: Res.h_btn,
                  child: CustoFilterBtn(
                      borderClr: clrBlacke,
                      lable: Text(
                        "Yes, cancel",
                        style: TextStyle(
                            color: clrBlacke,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      ontap: () {
                        Get.back();
                        alertConfirmCancelActivity();
                      },
                      backgroundClr: Get.theme.scaffoldBackgroundColor),
                )),
                SizedBox(
                  width: Get.width * 0.05,
                ),
                Expanded(
                  child: SizedBox(
                      width: double.maxFinite,
                      height: Res.h_btn,
                      child: CustomElevatedButton(
                          onTap: () {
                            Get.back();
                          },
                          backgroundClr: clrBlacke,
                          child: Text(
                            "Go back",
                            style: TextStyle(
                                color: clrWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ))),
                ),
              ]),
              SizedBox(
                height: Get.width * 0.014,
              ),
            ],
          ),
        ),
      ));
    });
  }

  alertConfirmCancelActivity() {
    Future.delayed(Duration.zero, () {
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Confirm cancellation",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                "Are you sure you want to cancel?",
                style: TextStyle(color: clrGreyTextLight, fontSize: 15),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: Get.height * 0.025,
              ),
              Row(children: [
                Expanded(
                    child: SizedBox(
                  height: Res.h_btn,
                  child: CustoFilterBtn(
                      borderClr: clrBlacke,
                      lable: Text(
                        "Yes, cancel",
                        style: TextStyle(
                            color: clrBlacke,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      ontap: () {
                        Get.back();
                        controller.deleteactapi(
                            controller.actData.value.activity?.id.toString());
                        // alertCancelRequestConfirmation();
                      },
                      backgroundClr: Get.theme.scaffoldBackgroundColor),
                )),
                SizedBox(
                  width: Get.width * 0.05,
                ),
                Expanded(
                  child: SizedBox(
                      width: double.maxFinite,
                      height: Res.h_btn,
                      child: CustomElevatedButton(
                          onTap: () {
                            Get.back();
                          },
                          backgroundClr: clrBlacke,
                          child: Text(
                            "Go back",
                            style: TextStyle(
                                color: clrWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ))),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ));
    });
  }
}
