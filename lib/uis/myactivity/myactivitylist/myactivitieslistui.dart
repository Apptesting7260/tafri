import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/uis/myactivity/myactivitylist/controller/myacti_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/no_activity.dart';
import 'package:plusone/utils/no_activity_yet.dart';
import 'package:plusone/utils/no_hosted_activity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/colors.dart';
import '../../../utils/size.dart';

class MyActivitiesListUi extends GetWidget<MyactiController> {
  MyActivitiesListUi({super.key});

  final ExploreListController homeController = Get.put(ExploreListController());

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: Res.Defalt_side_margin),
            child: const Text(
              "My Activities",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: Get.height * 0.004,
          ),
          TabBar(
            tabAlignment: TabAlignment.start,
            indicatorColor: darkYellow,
            dividerHeight: 0,
            isScrollable: true,
            unselectedLabelColor: clrBlacke,
            labelColor: darkYellow,
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            labelStyle:
                const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9),
                child: Text(
                  "Attending",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9),
                child: Text("Hosting"),
              )
            ],
            controller: controller.tabController,
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Expanded(
                    child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          Obx(
                            () =>
                                controller.attendingLoading.value &&
                                        controller.attendingData.value.result ==
                                            null
                                    ? Center(
                                        child: CommonUi.scaffoldLoading(
                                            color: clrYellow),
                                      )
                                    : SmartRefresher(
                                        onRefresh: () async {
                                          await controller.attendingActivity();
                                          await controller.hostingActivity();
                                          controller.attendingRefreshController
                                              .refreshCompleted();
                                        },
                                        controller: controller
                                            .attendingRefreshController,
                                        header: CommonUi.refreshHeader(),
                                        // WaterDropMaterialHeader(
                                        //   color: clrWhite,
                                        //   backgroundColor: clrYellow,
                                        //   distance: 50,
                                        // ),
                                        child:
                                            controller.attendingError.value
                                                    .isEmpty
                                                ? controller
                                                            .attendingData
                                                            .value
                                                            .result!
                                                            .upcomingActivities!
                                                            .isEmpty &&
                                                        controller
                                                            .attendingData
                                                            .value
                                                            .result!
                                                            .previousActivities!
                                                            .isEmpty
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          NoActivityYetScreen(
                                                            height: Get.height *
                                                                0.16,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.offAllNamed(
                                                                  Routes
                                                                      .navbarUi);
                                                            },
                                                            child: Container(
                                                                // height: 50,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 10,
                                                                ),
                                                                margin: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        Get.width *
                                                                            0.2,vertical: 15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  color:
                                                                      clrYellow,
                                                                ),
                                                                child: Center(
                                                                    child:
                                                                        FittedBox(
                                                                  child: Text(
                                                                    'Start exploring',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            clrWhite),
                                                                  ),
                                                                ))),
                                                          )
                                                        ],
                                                      )
                                                    : ListView(
                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          controller
                                                              .attendingData
                                                              .value
                                                              .result!
                                                              .upcomingActivities!
                                                              .isNotEmpty ? const Text(
                                                            "Upcoming activities",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16),
                                                          ) : const SizedBox(),
                                                          controller
                                                              .attendingData
                                                              .value
                                                              .result!
                                                              .upcomingActivities!
                                                              .isNotEmpty ? SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ) : const SizedBox(),
                                                          controller
                                                                  .attendingData
                                                                  .value
                                                                  .result!
                                                                  .upcomingActivities!
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                      itemCount: controller
                                                                          .attendingData
                                                                          .value
                                                                          .result
                                                                          ?.upcomingActivities
                                                                          ?.length,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        var data = controller
                                                                            .attendingData
                                                                            .value
                                                                            .result
                                                                            ?.upcomingActivities?[index];
                                                                        return Container(
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 6),
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              top: 10,
                                                                              bottom: 15,
                                                                              left: 15,
                                                                              right: 15),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              color: clrGreyLight),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "${data?.formattedDate}",
                                                                                style: TextStyle(color: clrGreyDark),
                                                                              ),
                                                                              ListView.separated(
                                                                                physics: const NeverScrollableScrollPhysics(),
                                                                                itemCount: data!.activities!.length,
                                                                                shrinkWrap: true,
                                                                                itemBuilder: (context, ind) {
                                                                                  return Padding(
                                                                                    padding: const EdgeInsets.only(top: 5),
                                                                                    child: InkWell(
                                                                                      onTap: () {
                                                                                        Get.toNamed(Routes.exploreView, arguments: data.activities?[ind].id.toString());
                                                                                      },
                                                                                      child: Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            clipBehavior: Clip.hardEdge,
                                                                                            height: h * .075,
                                                                                            width: h * .075,
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(5),
                                                                                            ),
                                                                                            child: data.activities![ind].banners!.isNotEmpty
                                                                                                ? CachedNetworkImage(
                                                                                                    imageUrl: '${data.activities?[ind].banners?[0]}',
                                                                                                    errorWidget: (context, url, error) => Image.asset(
                                                                                                      "assets/images/parkimage.png",
                                                                                                      fit: BoxFit.cover,
                                                                                                    ),
                                                                                                    fit: BoxFit.cover,
                                                                                                    placeholder: (context, url) => Shimmer.fromColors(
                                                                                                        baseColor: grey300,
                                                                                                        highlightColor: grey100,
                                                                                                        child: Container(
                                                                                                          height: h * .075,
                                                                                                          width: h * .075,
                                                                                                          decoration: BoxDecoration(color: clrGrey, borderRadius: BorderRadius.circular(5)),
                                                                                                        )),
                                                                                                  )
                                                                                                : Image.asset(
                                                                                                    "assets/images/parkimage.png",
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: Get.width * 0.02,
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                                              decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(7)),
                                                                                              child: Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Flexible(
                                                                                                        child: Text(
                                                                                                          "${data.activities?[ind].name}",
                                                                                                          maxLines: 2,
                                                                                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                                                                                        ),
                                                                                                      ),
                                                                                                      const SizedBox(width: 5,),
                                                                                                      Container(
                                                                                                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 7),
                                                                                                        decoration: BoxDecoration(
                                                                                                            color: darkYellow.withOpacity(.15),
                                                                                                            borderRadius: BorderRadius.circular(50)
                                                                                                        ),
                                                                                                        child: Center(
                                                                                                            child: data.activities?[ind].requestType?.toString() == 'waitlist' ? Text('Waitlist',style: TextStyle(
                                                                                                              fontSize: 10,
                                                                                                              color: darkYellow,
                                                                                                            ),) : Text(
                                                                                                              data.activities?[ind].requestStatus?.toString() == 'pending' ? '${data.activities?[ind].requestStatus?.substring(0, 1).toUpperCase()}${data.activities?[ind].requestStatus?.substring(1) ?? ''}' : data.activities?[ind].requestStatus?.toString() == 'leave' ? '${data.activities?[ind].requestStatus?.substring(0, 1).toUpperCase()}${data.activities?[ind].requestStatus?.substring(1) ?? ''}d' : '${data.activities?[ind].requestStatus?.substring(0, 1).toUpperCase()}${data.activities?[ind].requestStatus?.substring(1) ?? ''}ed',
                                                                                                              style: TextStyle(
                                                                                                                fontSize: 10,
                                                                                                                color: darkYellow,
                                                                                                              ),
                                                                                                            )
                                                                                                        ),
                                                                                                      )
                                                                                                    ],
                                                                                                  ),
                                                                                                  Text("${data.activities?[ind].location}", style: TextStyle(color: clrGreyDark, fontSize: 12)),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                separatorBuilder: (BuildContext context, int index) {
                                                                                  return const SizedBox(
                                                                                    height: 5,
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      })
                                                              : const SizedBox(),
                                                          // Center(
                                                          //         child:
                                                          //             NoActivityYetScreen(
                                                          //           height:
                                                          //               Get.height *
                                                          //                   0.16,
                                                          //         ),
                                                          //       ),
                                                          controller
                                                              .attendingData
                                                              .value
                                                              .result!
                                                              .upcomingActivities!
                                                              .isNotEmpty ? const SizedBox(
                                                            height: 15,
                                                          ) : const SizedBox(),
                                                          controller
                                                              .attendingData
                                                              .value
                                                              .result!
                                                              .previousActivities!
                                                              .isNotEmpty ? const Text(
                                                            "Previous activities",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16),
                                                          ) : const SizedBox(),
                                                          controller
                                                              .attendingData
                                                              .value
                                                              .result!
                                                              .previousActivities!
                                                              .isNotEmpty ? SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ) : const SizedBox(),
                                                          controller
                                                                  .attendingData
                                                                  .value
                                                                  .result!
                                                                  .previousActivities!
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                      itemCount: controller
                                                                          .attendingData
                                                                          .value
                                                                          .result
                                                                          ?.previousActivities
                                                                          ?.length,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        var data = controller
                                                                            .attendingData
                                                                            .value
                                                                            .result
                                                                            ?.previousActivities?[index];
                                                                        return Container(
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 6),
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              top: 10,
                                                                              bottom: 15,
                                                                              left: 15,
                                                                              right: 15),
                                                                          // const EdgeInsets
                                                                          //     .symmetric(
                                                                          //     vertical: 18,
                                                                          //     horizontal:
                                                                          //         15),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              color: clrGreyLight),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                "${data?.formattedDate}",
                                                                                style: TextStyle(color: clrGreyDark),
                                                                              ),
                                                                              Column(
                                                                                children: [
                                                                                  ListView.separated(
                                                                                    physics: const NeverScrollableScrollPhysics(),
                                                                                    itemCount: data!.activities!.length,
                                                                                    shrinkWrap: true,
                                                                                    itemBuilder: (context, ind) {
                                                                                      return Padding(
                                                                                        padding: const EdgeInsets.only(top: 5),
                                                                                        child: InkWell(
                                                                                          onTap: () {
                                                                                            Get.toNamed(Routes.previousActivityUi, arguments: {
                                                                                              "isHost": false,
                                                                                              "id": data.activities?[ind].id.toString()
                                                                                            });
                                                                                          },
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                clipBehavior: Clip.hardEdge,
                                                                                                height: h * .075,
                                                                                                width: h * .075,
                                                                                                decoration: BoxDecoration(
                                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                                ),
                                                                                                child: data.activities![ind].banners!.isNotEmpty
                                                                                                    ? CachedNetworkImage(
                                                                                                        imageUrl: '${data.activities?[ind].banners?[0]}',
                                                                                                        fit: BoxFit.cover,
                                                                                                        errorWidget: (context, url, error) => Image.asset(
                                                                                                          "assets/images/parkimage.png",
                                                                                                          fit: BoxFit.cover,
                                                                                                        ),
                                                                                                        placeholder: (context, url) => Shimmer.fromColors(
                                                                                                            baseColor: grey300,
                                                                                                            highlightColor: grey100,
                                                                                                            child: Container(
                                                                                                              height: h * .075,
                                                                                                              width: h * .075,
                                                                                                              decoration: BoxDecoration(
                                                                                                                borderRadius: BorderRadius.circular(5),
                                                                                                                color: clrGrey,
                                                                                                              ),
                                                                                                            )),
                                                                                                      )
                                                                                                    : Image.asset(
                                                                                                        "assets/images/parkimage.png",
                                                                                                        fit: BoxFit.cover,
                                                                                                      ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: Get.width * 0.02,
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: Container(
                                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                                                  decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(7)),
                                                                                                  child: Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Flexible(
                                                                                                            child: Text(
                                                                                                              "${data.activities?[ind].name.toString()}",
                                                                                                              maxLines: 2,
                                                                                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Container(
                                                                                                            padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 7),
                                                                                                            decoration: BoxDecoration(
                                                                                                                color: darkYellow.withOpacity(.15),
                                                                                                                borderRadius: BorderRadius.circular(50)
                                                                                                            ),
                                                                                                            child:
                                                                                                            Center(
                                                                                                                // child: data.activities?[ind].requestType?.toString() == 'waitlist' ? Text('Waitlist',style: TextStyle(
                                                                                                                //   fontSize: 10,
                                                                                                                //   color: darkYellow,
                                                                                                                // ),) :
                                                                                                                child: Text(
                                                                                                                  data.activities?[ind].requestStatus?.toString() == 'pending' ? '${data.activities?[ind].requestStatus?.substring(0, 1).toUpperCase()}${data.activities?[ind].requestStatus?.substring(1) ?? ''}' : data.activities?[ind].requestStatus?.toString() == 'leave' ? '${data.activities?[ind].requestStatus?.substring(0, 1).toUpperCase()}${data.activities?[ind].requestStatus?.substring(1) ?? ''}d' : '${data.activities?[ind].requestStatus?.substring(0, 1).toUpperCase()}${data.activities?[ind].requestStatus?.substring(1) ?? ''}ed',
                                                                                                                  style: TextStyle(
                                                                                                                    fontSize: 10,
                                                                                                                    color: darkYellow,
                                                                                                                  ),
                                                                                                                )
                                                                                                            ),
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                      Text("${data.activities?[ind].status.toString()}", style: TextStyle(color: clrGreyDark, fontSize: 12)),
                                                                                                      data.activities?[ind].status.toString() == 'completed' && data.activities?[ind].activityReview == false
                                                                                                          ? Padding(
                                                                                                              padding: const EdgeInsets.symmetric(vertical: 3),
                                                                                                              child: Row(
                                                                                                                children: [
                                                                                                                  Flexible(child: Text("Rate and review your activity", style: TextStyle(color: clrYellowText, fontSize: 12, fontWeight: FontWeight.w600))),
                                                                                                                  SizedBox(
                                                                                                                    width: w * .00
                                                                                                                  ),
                                                                                                                  Icon(
                                                                                                                    Icons.arrow_right,
                                                                                                                    size: 18,
                                                                                                                    color: clrYellowText,
                                                                                                                  )
                                                                                                                ],
                                                                                                              ),
                                                                                                            )
                                                                                                          : const SizedBox(),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    separatorBuilder: (BuildContext context, int index) {
                                                                                      return const SizedBox(
                                                                                        height: 5,
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: h * .015,
                                                                                  ),
                                                                                  // Row(
                                                                                  //   children: [
                                                                                  //     Container(
                                                                                  //       clipBehavior:
                                                                                  //           Clip.hardEdge,
                                                                                  //       height:
                                                                                  //           57,
                                                                                  //       width:
                                                                                  //           57,
                                                                                  //       decoration:
                                                                                  //           BoxDecoration(
                                                                                  //         borderRadius:
                                                                                  //             BorderRadius.circular(5),
                                                                                  //       ),
                                                                                  //       child: Image
                                                                                  //           .asset(
                                                                                  //         "assets/images/parkimage.png",
                                                                                  //         fit: BoxFit
                                                                                  //             .cover,
                                                                                  //       ),
                                                                                  //     ),
                                                                                  //     SizedBox(
                                                                                  //       width: Get.width *
                                                                                  //           0.02,
                                                                                  //     ),
                                                                                  //     Expanded(
                                                                                  //       child:
                                                                                  //           Container(
                                                                                  //         padding: const EdgeInsets
                                                                                  //             .symmetric(
                                                                                  //             horizontal: 10,
                                                                                  //             vertical: 10),
                                                                                  //         decoration: BoxDecoration(
                                                                                  //             color: clrWhite,
                                                                                  //             borderRadius: BorderRadius.circular(7)),
                                                                                  //         child:
                                                                                  //             Column(
                                                                                  //           crossAxisAlignment:
                                                                                  //               CrossAxisAlignment.start,
                                                                                  //           children: [
                                                                                  //             const Text(
                                                                                  //               "Padel with Joris",
                                                                                  //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                                                                  //             ),
                                                                                  //             Text("Cancelled", style: TextStyle(color: clrGreyDark, fontSize: 12)),
                                                                                  //           ],
                                                                                  //         ),
                                                                                  //       ),
                                                                                  //     )
                                                                                  //   ],
                                                                                  // ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      })
                                                              : const SizedBox()
                                                          // Center(
                                                          //         child: NoActivityYetScreen(
                                                          //             height: Get
                                                          //                     .height *
                                                          //                 0.16),
                                                          //       )
                                                        ],
                                                      )
                                                : const Center(
                                                    child: ErrorScreen()),
                                      ),
                          ),

                          /// -------Upcoming activities(for host)------- ///
                          Obx(
                            () =>
                                controller.hostingLoading.value &&
                                        controller.hostingData.value.result ==
                                            null
                                    ? Center(
                                        child: CommonUi.scaffoldLoading(
                                            color: clrYellow),
                                      )
                                    : SmartRefresher(
                                        onRefresh: () async {
                                          await controller.hostingActivity();
                                          await controller.attendingActivity();
                                          controller.hostingRefreshController
                                              .refreshCompleted();
                                        },
                                        controller:
                                            controller.hostingRefreshController,
                                        header: CommonUi.refreshHeader(),
                                        // WaterDropMaterialHeader(
                                        //   color: clrWhite,
                                        //   backgroundColor: clrYellow,
                                        //   distance: 50,
                                        // ),
                                        child: controller.hostingError.isEmpty
                                            ? controller
                                                        .hostingData
                                                        .value
                                                        .result!
                                                        .upcomingActivities!
                                                        .isEmpty &&
                                                    controller
                                                        .hostingData
                                                        .value
                                                        .result!
                                                        .previousActivities!
                                                        .isEmpty
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      NoHostedScreen(
                                                        height:
                                                            Get.height * 0.16,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (homeController
                                                              .homeData.value
                                                              .result
                                                              ?.profileComplete ==
                                                              true &&
                                                              homeController
                                                                  .homeData
                                                                  .value.result
                                                                  ?.membershipStatus ==
                                                                  true) {
                                                            Get.toNamed(
                                                                Routes
                                                                    .createActivityUi);
                                                          }else{
                                                            homeController.showHomePop();
                                                          }
                                                        },
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 10,
                                                            ),
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        Get.width *
                                                                            0.2,vertical: 15),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              color: clrYellow,
                                                            ),
                                                            child: Center(
                                                                child:
                                                                    FittedBox(
                                                              child: Text(
                                                                'Create now',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        14,
                                                                    color:
                                                                        clrWhite),
                                                              ),
                                                            ))),
                                                      )
                                                    ],
                                                  )
                                                : ListView(
                                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      controller
                                                          .hostingData
                                                          .value
                                                          .result!
                                                          .upcomingActivities!
                                                          .isNotEmpty ? const Text(
                                                        "Upcoming activities",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16),
                                                      ) : const SizedBox(),
                                                      controller
                                                          .hostingData
                                                          .value
                                                          .result!
                                                          .upcomingActivities!
                                                          .isNotEmpty ? SizedBox(
                                                        height:
                                                            Get.height * 0.01,
                                                      ) : const SizedBox(),
                                                      controller
                                                              .hostingData
                                                              .value
                                                              .result!
                                                              .upcomingActivities!
                                                              .isNotEmpty
                                                          ? ListView.builder(
                                                              itemCount: controller
                                                                  .hostingData
                                                                  .value
                                                                  .result
                                                                  ?.upcomingActivities
                                                                  ?.length,
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                var data = controller
                                                                    .hostingData
                                                                    .value
                                                                    .result
                                                                    ?.upcomingActivities?[index];
                                                                return Container(
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          6),
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      top: 10,
                                                                      bottom:
                                                                          15,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color:
                                                                          clrGreyLight),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "${data?.formattedDate}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                clrGreyDark),
                                                                      ),
                                                                      ListView
                                                                          .separated(
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        itemCount: data!
                                                                            .activities!
                                                                            .length,
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemBuilder:
                                                                            (context,
                                                                                ind) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 5),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                Get.toNamed(Routes.hostUpcommingActiview, arguments: data.activities?[ind].id.toString());
                                                                              },
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    clipBehavior: Clip.hardEdge,
                                                                                    height: h * .075,
                                                                                    width: h * .075,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                    ),
                                                                                    child: data.activities![ind].banners!.isNotEmpty
                                                                                        ? CachedNetworkImage(
                                                                                            imageUrl: '${data.activities?[ind].banners?[0]}',
                                                                                            fit: BoxFit.cover,
                                                                                            errorWidget: (context, url, error) => Image.asset(
                                                                                              "assets/images/parkimage.png",
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                            placeholder: (context, url) => Shimmer.fromColors(baseColor: grey300, highlightColor: grey100, child: Container(height: h * .075, width: h * .075, decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: clrGrey))),
                                                                                          )
                                                                                        : Image.asset(
                                                                                            "assets/images/parkimage.png",
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: Get.width * 0.02,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                                      decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(7)),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  "${data.activities?[ind].name.toString().trim()}",
                                                                                                  maxLines: 2,
                                                                                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(width: 5,),
                                                                                              Container(
                                                                                                padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 7),
                                                                                                decoration: BoxDecoration(
                                                                                                  color: darkYellow.withOpacity(.15),
                                                                                                  borderRadius: BorderRadius.circular(50)
                                                                                                ),
                                                                                                child: Center(
                                                                                                  child: Text(
                                                                                                    '${data.activities?[ind].status?.substring(0, 1).toUpperCase()}${data.activities?[ind].status?.substring(1) ?? ''}',
                                                                                                    style: TextStyle(
                                                                                                      fontSize: 10,
                                                                                                      color: darkYellow,
                                                                                                    ),
                                                                                                  )
                                                                                                ),
                                                                                              )
                                                                                              // Text(data.activities![ind].status.toString(),
                                                                                              //   style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                                                                                              // ),
                                                                                            ],
                                                                                          ),
                                                                                          Text("${data.activities?[ind].location.toString()}", style: TextStyle(color: clrGreyDark, fontSize: 12)),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                        separatorBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          return const SizedBox(
                                                                            height:
                                                                                5,
                                                                          );
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              })
                                                          : const SizedBox(),
                                                      // Center(
                                                      //         child: NoHostedScreen(
                                                      //             height:
                                                      //                 Get.height *
                                                      //                     0.16)),
                                                      controller
                                                          .hostingData
                                                          .value
                                                          .result!
                                                          .upcomingActivities!
                                                          .isNotEmpty ? const SizedBox(
                                                        height: 15,
                                                      ) : const SizedBox(),
                                                      controller
                                                          .hostingData
                                                          .value
                                                          .result!
                                                          .previousActivities!
                                                          .isNotEmpty ? const Text(
                                                        "Previous activities",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16),
                                                      ) : const SizedBox(),
                                                      controller
                                                          .hostingData
                                                          .value
                                                          .result!
                                                          .previousActivities!
                                                          .isNotEmpty ? SizedBox(
                                                        height:
                                                            Get.height * 0.01,
                                                      ) : const SizedBox(),
                                                      controller
                                                              .hostingData
                                                              .value
                                                              .result!
                                                              .previousActivities!
                                                              .isNotEmpty
                                                          ? ListView.builder(
                                                              itemCount: controller
                                                                  .hostingData
                                                                  .value
                                                                  .result
                                                                  ?.previousActivities
                                                                  ?.length,
                                                              reverse: true,
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                var data = controller
                                                                    .hostingData
                                                                    .value
                                                                    .result
                                                                    ?.previousActivities?[index];
                                                                return InkWell(
                                                                  onTap: () {
                                                                    // Get.toNamed(
                                                                    //     Routes
                                                                    //         .previousActivityUi,
                                                                    //     arguments: {
                                                                    //       "isHost": true,
                                                                    //     });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            6),
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            15,
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                15),
                                                                        color:
                                                                            clrGreyLight),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "${data?.formattedDate}",
                                                                          style:
                                                                              TextStyle(color: clrGreyDark),
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            ListView.separated(
                                                                              physics: const NeverScrollableScrollPhysics(),
                                                                              itemCount: data!.activities!.length,
                                                                              shrinkWrap: true,
                                                                              reverse: true,
                                                                              itemBuilder: (context, ind) {
                                                                                var actdatas = data.activities?[ind];
                                                                                return Padding(
                                                                                  padding: const EdgeInsets.only(top: 5),
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      Get.toNamed(Routes.previousActivityUi, arguments: {
                                                                                        "isHost": true,
                                                                                        'id': data.activities?[ind].id
                                                                                      });
                                                                                    },
                                                                                    child: Row(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          clipBehavior: Clip.hardEdge,
                                                                                          height: h * .075,
                                                                                          width: h * .075,
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                          ),
                                                                                          child: data.activities![ind].banners!.isNotEmpty
                                                                                              ? CachedNetworkImage(
                                                                                                  imageUrl: '${data.activities?[ind].banners?[0]}',
                                                                                                  fit: BoxFit.cover,
                                                                                                  errorWidget: (context, url, error) => Image.asset(
                                                                                                    "assets/images/parkimage.png",
                                                                                                    fit: BoxFit.cover,
                                                                                                  ),
                                                                                                  placeholder: (context, url) => Shimmer.fromColors(
                                                                                                      baseColor: grey300,
                                                                                                      highlightColor: grey100,
                                                                                                      child: Container(
                                                                                                        height: h * .075,
                                                                                                        width: h * .075,
                                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: clrGrey),
                                                                                                      )),
                                                                                                )
                                                                                              : Image.asset(
                                                                                                  "assets/images/parkimage.png",
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: Get.width * 0.02,
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Container(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                                            decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(7)),
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Row(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                      child: Column(
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            "${data.activities?[ind].name.toString()}",
                                                                                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                                                                                          ),
                                                                                                          Text("${data.activities?[ind].status.toString()}", style: TextStyle(color: clrGreyDark, fontSize: 12)),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                    data.activities?[ind].status.toString() == 'completed' && data.activities?[ind].repeatStatus.toString() == 'not_repeat'
                                                                                                        ? SizedBox(
                                                                                                            height: 23,
                                                                                                            child: CustomElevatedButton(
                                                                                                                onTap: () {
                                                                                                                  Get.toNamed(Routes.repeatActUi, arguments: controller.hostingData.value.result?.previousActivities?[index].activities?[ind]);
                                                                                                                },
                                                                                                                backgroundClr: clrGreyLight,
                                                                                                                paddingHz: 10,
                                                                                                                child: Row(
                                                                                                                  children: [
                                                                                                                    Image.asset(
                                                                                                                      "assets/icons/repeaticon.png",
                                                                                                                      height: 10,
                                                                                                                    ),
                                                                                                                    const SizedBox(
                                                                                                                      width: 2,
                                                                                                                    ),
                                                                                                                    Text("Repeat", style: TextStyle(color: clrBlacke, fontSize: 10))
                                                                                                                  ],
                                                                                                                )),
                                                                                                          )
                                                                                                        : const SizedBox()
                                                                                                  ],
                                                                                                ),
                                                                                                data.activities?[ind].status.toString() == 'completed' && data.activities?[ind].markAttendance == false
                                                                                                    ? Padding(
                                                                                                        padding: const EdgeInsets.symmetric(vertical: 3),
                                                                                                        child: Row(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Flexible(child: Text("Confirm attendance", style: TextStyle(color: clrYellowText, fontSize: 12, fontWeight: FontWeight.w600))),
                                                                                                            Icon(
                                                                                                              Icons.arrow_right,
                                                                                                              size: 18,
                                                                                                              color: clrYellowText,
                                                                                                            )
                                                                                                          ],
                                                                                                        ),
                                                                                                      )
                                                                                                    : const SizedBox(),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              separatorBuilder: (BuildContext context, int index) {
                                                                                return const SizedBox(
                                                                                  height: 5,
                                                                                );
                                                                              },
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 8,
                                                                            ),
                                                                            // Row(
                                                                            //   children: [
                                                                            //     Container(
                                                                            //       clipBehavior:
                                                                            //           Clip.hardEdge,
                                                                            //       height: h *
                                                                            //           .075,
                                                                            //       width: h *
                                                                            //           .075,
                                                                            //       decoration:
                                                                            //           BoxDecoration(
                                                                            //         borderRadius:
                                                                            //             BorderRadius.circular(5),
                                                                            //       ),
                                                                            //       child: Image
                                                                            //           .asset(
                                                                            //         "assets/images/parkimage.png",
                                                                            //         fit: BoxFit
                                                                            //             .cover,
                                                                            //       ),
                                                                            //     ),
                                                                            //     SizedBox(
                                                                            //       width: Get.width *
                                                                            //           0.02,
                                                                            //     ),
                                                                            //     Expanded(
                                                                            //       child:
                                                                            //           Container(
                                                                            //         padding: const EdgeInsets
                                                                            //             .symmetric(
                                                                            //             horizontal: 10,
                                                                            //             vertical: 10),
                                                                            //         decoration: BoxDecoration(
                                                                            //             color: clrWhite,
                                                                            //             borderRadius: BorderRadius.circular(7)),
                                                                            //         child:
                                                                            //             Column(
                                                                            //           crossAxisAlignment:
                                                                            //               CrossAxisAlignment.start,
                                                                            //           children: [
                                                                            //             const Text(
                                                                            //               "Padel with Joris",
                                                                            //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                            //             ),
                                                                            //             Text("Cancelled", style: TextStyle(color: clrGreyDark, fontSize: 12)),
                                                                            //           ],
                                                                            //         ),
                                                                            //       ),
                                                                            //     )
                                                                            //   ],
                                                                            // ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              })
                                                          : const SizedBox()
                                                      // Center(
                                                      //         child: NoHostedScreen(
                                                      //             height:
                                                      //                 Get.height *
                                                      //                     0.16))
                                                    ],
                                                  )
                                            : const Center(
                                                child: ErrorScreen()),
                                      ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
