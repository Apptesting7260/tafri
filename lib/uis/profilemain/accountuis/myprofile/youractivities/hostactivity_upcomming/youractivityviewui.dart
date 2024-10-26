import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/error_widget.dart';
import '../../../../../components/custoelevatedbtn.dart';
import '../../../../../components/custofilterbtn.dart';
import 'controller/host_upcomiacti_controller.dart';

class HostUpcomActivityViewUi extends GetWidget<HostUpcomiActiController> {
  const HostUpcomActivityViewUi({super.key});

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
                          Share.share('Check out my activity https://urlsdemo.online/activity?activityid=${controller.actData.value.activity?.id}&hostId=${controller.actData.value.activity?.hostId}');
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: h * .045,
                          height: h * .045,
                          decoration: BoxDecoration(
                            color: clrBlacke,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/icons/actshare.png",
                              color: clrWhite,
                              height: 20,
                              width: 20,
                            ), //
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
                child: Obx(
                  () => controller.activityLoading.value
                      ? Center(
                          child: CommonUi.scaffoldLoading(color: clrYellow),
                        )
                      : controller.actError.value.isNotEmpty
                          ? ErrorScreen()
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
                                              viewportFraction: 1,
                                              onPageChanged: (currIndex,
                                                  CarouselPageChangedReason
                                                      reason) {
                                                controller.changeIndicator(currIndex);
                                                debugPrint(" currIndex $currIndex reason=$reason");
                                              }),
                                          items: controller.actData.value.activity!.banners
                                              ?.map<Widget>((i) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return Container(
                                                    clipBehavior: Clip.hardEdge,
                                                    width: MediaQuery.of(context).size.width,
                                                    height: double.maxFinite,
                                                    margin: const EdgeInsets.symmetric(horizontal: 0),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(18)
                                                    ),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      height: h * .26,
                                                      width: double.maxFinite,
                                                      imageUrl: "$i",
                                                      placeholder: (context, url) => Shimmer.fromColors(
                                                        baseColor: grey300,
                                                        highlightColor: grey100,
                                                        child: Container(
                                                          width: double.maxFinite,
                                                          height: h * .26,
                                                          decoration: BoxDecoration(
                                                            color: grey300,
                                                            borderRadius: BorderRadius.circular(18),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                );
                                              },
                                            );
                                          }).toList(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: clrWhite,
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Text(
                                                  controller.actData.value.activity!.subcategoryTitle.toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700
                                                  ),
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
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            margin: const EdgeInsets.only(bottom: 7),
                                            height: 16,
                                            child: ListView.builder(
                                                itemCount: controller
                                                    .actData
                                                    .value
                                                    .activity!
                                                    .banners
                                                    ?.length,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, indicatorIndex) {
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
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
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Flexible(
                                      //   child: Column(
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: [
                                      //       const Text("Picnic in the park",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                      //       Text("Vondelpark",style: TextStyle(fontSize: 14,color:clrGreyDark,fontWeight: FontWeight.w500),),
                                      //       Text("13 March 2024 | 2:30 PM - 6:00PM",style: TextStyle(fontSize: 14,color:clrGreyTextLight,fontWeight: FontWeight.w500),),
                                      //       Text("Up to 3 people | 1 spot left",style: TextStyle(color: clrYellowText,fontSize: 14,fontWeight: FontWeight.w500),),
                                      //     ],
                                      //   ),
                                      // ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.actData.value.activity!.name.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * .005,
                                            ),
                                            Text(
                                              controller.actData.value.activity!
                                                  .location
                                                  .toString(),
                                              style:
                                                  TextStyle(color: clrGreyDark),
                                            ),
                                            SizedBox(
                                              height: h * .005,
                                            ),
                                            Text(
                                              '${controller.actData.value.activity!.formattedDate} | ${controller.actData.value.activity!.startAt} - ${controller.actData.value.activity!.endAt}',
                                              style: TextStyle(
                                                  color: clrGreyTextLight
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * .008,
                                            ),
                                            Text(
                                              "Up to ${controller.actData.value.activity!.maxPeople} people | ${controller.actData.value.activity!.spotLeft} ${controller.actData.value.activity!.spotLeft! == 1 ? 'spot left' : 'spots left'}",
                                              style: TextStyle(
                                                  color: clrYellowText,
                                                  fontSize: 13
                                              ),
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
                                      SizedBox(
                                        width: 5,
                                      ),
                                      // InkWell(
                                      //   onTap: (){
                                      //     Get.toNamed(Routes.hostProfileUi);
                                      //   },
                                      //   child: Column(
                                      //     children: [
                                      //       Container(
                                      //           height: h*.055,
                                      //           width: h*.055,
                                      //           decoration: BoxDecoration(
                                      //               borderRadius:
                                      //               BorderRadius.circular(100)),
                                      //           child: Image.asset(
                                      //             "assets/images/girldp.png",
                                      //             fit: BoxFit.cover,
                                      //           )),
                                      //       const Text("Jenny",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)
                                      //     ],
                                      //   ),
                                      // )
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.hostProfileUi,
                                              arguments: controller.actData.value.activity!.hostId.toString());
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // Container(
                                            //     height: h*.055,
                                            //     width: h*.055,
                                            //     decoration: BoxDecoration(
                                            //         borderRadius:
                                            //         BorderRadius.circular(100)),
                                            //     child: Image.asset(
                                            //       "assets/images/girldp.png",
                                            //       fit: BoxFit.cover,
                                            //     )),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.cover,
                                                imageUrl: '${controller.actData.value.activity!.profilePhoto}',
                                                errorWidget: (context, url, error) => Container(
                                                  height: 40,
                                                  width: 40,
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: clrGreyLight,
                                                      shape: BoxShape.circle
                                                  ),
                                                  child: Image.asset(
                                                    "assets/icons/manicon.png",
                                                    color: clrGrey,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                placeholder: (context, url) => Shimmer.fromColors(
                                                  baseColor: grey300,
                                                  highlightColor: grey100,
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      color: grey300,
                                                      borderRadius: BorderRadius.circular(18),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              controller.actData.value.activity!.hostName.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700
                                              ),
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
                                    controller.actData.value.activity!.description.toString(),
                                    style: TextStyle(
                                        fontSize: 14, color: clrGreyTextLight
                                    ),
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
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  SizedBox(
                                      width: double.maxFinite,
                                      height: Res.h_btn,
                                      child: CustomElevatedButton(
                                          onTap: () {},
                                          backgroundClr: clrBlacke,
                                          child: Text(
                                            "Message Group",
                                            style: TextStyle(
                                                color: clrWhite,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700
                                            ),
                                          )
                                      )
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.04,
                                  ),
                                  Obx(() {
                                    return controller.actData.value.requests!.isNotEmpty || controller.actData.value.going!.isNotEmpty ? Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.changeSlectedTab(1);
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                "Requests",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: controller.selectedTab.value == 1
                                                        ? FontWeight.w700
                                                        : FontWeight.w400
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              controller.selectedTab.value == 1
                                                  ? Container(
                                                      height: 3,
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                          color: clrYellow,
                                                          borderRadius: BorderRadius.circular(10)),
                                                    ) : const SizedBox()
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.1,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.changeSlectedTab(2);
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                  "Going",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: controller.selectedTab.value == 2
                                                          ? FontWeight.w700
                                                          : FontWeight.w400
                                                  )
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              controller.selectedTab.value == 2
                                                  ? Container(
                                                      height: 3,
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                          color: clrYellow,
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                    )
                                                  : const SizedBox()
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                    :SizedBox();
                                  }),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Obx(() {
                                    return controller.selectedTab.value == 1
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: controller.actData.value.requests?.length,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: const EdgeInsets.symmetric(vertical: 0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Row(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                BorderRadius.circular(100),
                                                                child: CachedNetworkImage(
                                                                  fit: BoxFit.cover,
                                                                  height: 40,
                                                                  width: 40,
                                                                  imageUrl: "${controller.actData.value.requests?[index].profilePhoto}",
                                                                  placeholder: (context,
                                                                      url) =>
                                                                      Shimmer.fromColors(
                                                                        baseColor: grey300,
                                                                        highlightColor: grey100,
                                                                        child: Container(
                                                                          width: double.maxFinite,
                                                                          height: h * .26,
                                                                          decoration: BoxDecoration(
                                                                            color: grey300,
                                                                            borderRadius: BorderRadius.circular(18),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  errorWidget: (context, url, error) => ClipRRect(
                                                                    borderRadius: BorderRadius.circular(100),
                                                                    child: Container(
                                                                      height: 55,
                                                                      width: 55,
                                                                      color: clrGreyLight,
                                                                      child: Image.asset(
                                                                        'assets/icons/manicon.png',
                                                                        color: clrGrey,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: Get.width * 0.02,
                                                              ),
                                                              Flexible(
                                                                  child: Text(
                                                                      '${controller.actData.value.requests?[index].firstName} ${controller.actData.value.requests?[index].lastName}',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 16
                                                                      )
                                                                  )
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                // Get.toNamed(Routes.attendReviewUi);
                                                                controller.rejectuserapi(controller.actData.value.requests?[index].userId.toString());
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets.all(4),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  color: clrBlacke,
                                                                ),
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: clrWhite,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.02,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                // Get.toNamed(Routes.attendReviewUi);

                                                                controller.acceptuserapi(controller.actData.value.requests?[index].userId.toString());

                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets.all(4),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  color: clrYellow,
                                                                ),
                                                                child: Icon(
                                                                  Icons.check,
                                                                  color: clrWhite,
                                                                  size: 20,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Get.height * 0.005,
                                                    ),
                                                    Divider(
                                                      color: clrGreyLight,
                                                      height: 8,
                                                    )
                                                  ],
                                                ),
                                              );
                                            })
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: controller.actData.value.going?.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: const EdgeInsets.symmetric(vertical: 0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                          child: Row(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                BorderRadius.circular(100),
                                                                child: CachedNetworkImage(
                                                                  fit: BoxFit.cover,
                                                                  height: 40,
                                                                  width: 40,
                                                                  imageUrl: "${controller.actData.value.going?[index].profilePhoto}",
                                                                  placeholder: (context,
                                                                      url) =>
                                                                      Shimmer.fromColors(
                                                                        baseColor: grey300,
                                                                        highlightColor: grey100,
                                                                        child: Container(
                                                                          width:
                                                                          double.maxFinite,
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
                                                                  errorWidget: (context, url, error) => ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        100),
                                                                    child: Container(
                                                                      height: 55,
                                                                      width: 55,
                                                                      color: clrGreyLight,
                                                                      child: Image.asset(
                                                                        'assets/icons/manicon.png',
                                                                        color: clrGrey,
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
                                                                      '${controller.actData.value.going?[index].firstName} ${controller.actData.value.going?[index].lastName}',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                          16)))
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            controller.removeuserapi(controller.actData.value.going?[index].userId.toString());
                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(20),
                                                              color: clrBlacke,
                                                            ),
                                                            child: Text(
                                                              "Remove",
                                                              style: TextStyle(
                                                                  color: clrWhite,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w700
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Get.height * 0.005,
                                                    ),
                                                    Divider(
                                                      color: clrGreyLight,
                                                      height: 8,
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                  }),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Center(
                                      child: InkWell(
                                          onTap: () {
                                            alertDeleteActivity();
                                          },
                                          child: const Text(
                                            "Delete activity",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline),
                                          ))),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                ],
                              ),
                            ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  alertDeleteActivity() {
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
                "Are you sure you want to delete this activity?",
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
                            alertConfirmCancelActivityFees();
                          },
                          backgroundClr: clrBlacke,
                          child: Text(
                            "Delete",
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

  alertConfirmCancelActivityFees() {
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
                "Canceling within 24 hours of the activity will incur a €3 fee. Are you sure you want to proceed?",
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
                        alertConfCancelActiAttendies();
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
                        controller.deleteactapi(controller.actData.value.activity?.id.toString());
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
