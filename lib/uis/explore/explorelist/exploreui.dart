import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/no_activity.dart';
import 'package:plusone/utils/size.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'controller/explorelist_controller.dart';

class ExploreUi extends GetWidget<ExploreListController> {
  const ExploreUi({super.key});

// var controller= Get.put(ExploreController());
  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: h * 0.070,
          padding: const EdgeInsets.only(bottom: 20),
          child: CustomElevatedButton(
              paddingHz: 10,
              onTap: () {
                Get.toNamed(Routes.mapActivityUi);
              },
              backgroundClr: clrWhite,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/mapbtnicon.png",
                    height: 15,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Map",
                    style: TextStyle(
                        color: clrBlacke, fontWeight: FontWeight.w600),
                  )
                ],
              )),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: SizedBox(
                      height: Res.h_btn,
                      width: Get.width * 0.76,
                      child: const CustoTextFormField(
                        hintText: "Anywhere • any week",
                        sufixIcon: Icon(Icons.search),
                      )),
                ),
                SizedBox(
                  width: w * .03,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.filterExploreUi);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    margin: EdgeInsets.only(bottom: h * .006),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: clrBlacke),
                    child: Image.asset(
                      "assets/icons/filtericon.png",
                      height: w * .07,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.022,
          ),
          Obx(
            () => controller.homePageLoading.value &&
                    controller.homeData.value.result == null
                ? Expanded(
                    child: Center(
                      child: CommonUi.scaffoldLoading(color: clrYellow),
                    ),
                  )
                : controller.homeError.value.isNotEmpty
                    ? Expanded(
                        child: SmartRefresher(
                        onRefresh: () async {
                          await controller.homePageApi();
                          controller.refreshController1.refreshCompleted();
                        },
                        controller: controller.refreshController1,
                        header: WaterDropMaterialHeader(
                          color: clrWhite,
                          backgroundColor: clrYellow,
                          distance: 50,
                        ),
                        child: const Center(
                          child: ErrorScreen(),
                        ),
                      ))
                    : Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: h * .048,
                              child: ListView.builder(
                                  padding: EdgeInsets.only(
                                      left: Res.Defalt_side_margin),
                                  itemCount: controller
                                          .homeData.value.result?.categories
                                          ?.where((category) =>
                                              category.status == '1')
                                          .length ??
                                      0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var categoryData = controller
                                        .homeData.value.result?.categories
                                        ?.where((category) =>
                                            category.status == '1')
                                        .toList();
                                    return GestureDetector(
                                      onTap: () async {
                                        if(controller.selectedIndex.value != index){
                                          controller.selectedIndex.value =
                                              index;
                                          controller.categoryID.value =
                                              categoryData?[index].id
                                                  .toString();
                                          controller
                                              .homeData
                                              .value
                                              .result
                                              ?.categories?[index]
                                              .loading
                                              ?.value = true;
                                          await controller.homePageApi();
                                          controller
                                              .homeData
                                              .value
                                              .result
                                              ?.categories?[index]
                                              .loading
                                              ?.value = false;
                                        }
                                      },
                                      child: Obx(
                                        () => Container(
                                          margin:
                                              const EdgeInsets.only(right: 7),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: controller.selectedIndex
                                                          .value ==
                                                      index
                                                  ? clrBlacke
                                                  : clrGreyLight),
                                          child: controller
                                                  .homeData
                                                  .value
                                                  .result!
                                                  .categories![index]
                                                  .loading!
                                                  .value
                                              ? CommonUi.fallingDot()
                                              : Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: CachedNetworkImage(
                                                        height: 24,
                                                        width: 24,
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            '${categoryData?[index].icon}',
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(
                                                          Icons.error,
                                                          color: clrBlacke,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${categoryData?[index].title}',
                                                      style: TextStyle(
                                                          color: controller
                                                                      .selectedIndex
                                                                      .value !=
                                                                  index
                                                              ? clrBlacke
                                                              : clrWhite,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: Get.height * 0.013,
                            ),
                            Expanded(
                              child: Obx(() {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Res.Defalt_side_margin),
                                  child: SmartRefresher(
                                      controller: controller.refreshController,
                                      onRefresh: () async {
                                        await controller.homePageApi();
                                        controller.refreshController
                                            .refreshCompleted();
                                      },
                                      header: WaterDropMaterialHeader(
                                        color: clrWhite,
                                        backgroundColor: clrYellow,
                                        distance: 50,
                                      ),
                                      child:
                                          controller.homeData.value.result!
                                                  .activities!.isEmpty
                                              ? Center(
                                                  child: NoActivityScreen(),
                                                )
                                              : controller.homeData.value
                                                      .result!.activities!
                                                      .where(
                                                        (element) =>
                                                            element.status ==
                                                            '1',
                                                      )
                                                      .isNotEmpty
                                                  ? ListView.builder(
                                                      itemCount: controller
                                                          .homeData
                                                          .value
                                                          .result
                                                          ?.activities
                                                          ?.where((activity) =>
                                                              activity.status ==
                                                              '1')
                                                          .length,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var activityData = controller
                                                            .homeData
                                                            .value
                                                            .result
                                                            ?.activities
                                                            ?.where((activity) =>
                                                                activity
                                                                    .status ==
                                                                '1')
                                                            .toList();
                                                        return InkWell(
                                                          onTap: () {
                                                            controller
                                                                .showHomePop();
                                                            // Get.toNamed(Routes.exploreView);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      h * .26,
                                                                  child: Stack(
                                                                    children: [
                                                                      CarouselSlider(
                                                                        options: CarouselOptions(
                                                                            height: h * .26,
                                                                            viewportFraction: 1,
                                                                            onPageChanged: (currIndex, CarouselPageChangedReason reason) {
                                                                              controller.changeIndicator(index, currIndex);
                                                                              debugPrint(" currIndex $currIndex reason=$reason");
                                                                            }),
                                                                        items: activityData?[index]
                                                                            .banners
                                                                            ?.map<Widget>((i) {
                                                                          return Builder(
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return Container(
                                                                                  clipBehavior: Clip.hardEdge,
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  height: double.maxFinite,
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 0),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
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
                                                                                  ));
                                                                            },
                                                                          );
                                                                        }).toList(),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                10),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                              decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(20)),
                                                                              child: Text(
                                                                                '${activityData?[index].subcategoryTitle}',
                                                                                style: const TextStyle(fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                // controller
                                                                                //     .changeFav(
                                                                                //         index);
                                                                              },
                                                                              child: Container(
                                                                                padding: const EdgeInsets.all(6),
                                                                                decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(100)),
                                                                                child: activityData?[index].isFav == true
                                                                                    ? Icon(
                                                                                        Icons.favorite,
                                                                                        size: 20,
                                                                                        color: clrYellow,
                                                                                      )
                                                                                    : const Icon(
                                                                                        Icons.favorite_border,
                                                                                        size: 20,
                                                                                      ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.bottomCenter,
                                                                        child:
                                                                            Container(
                                                                          margin: const EdgeInsets
                                                                              .only(
                                                                              bottom: 7),
                                                                          height:
                                                                              16,
                                                                          child: ListView.builder(
                                                                              itemCount: activityData?[index].banners?.length,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.horizontal,
                                                                              itemBuilder: (context, indicatorIndex) {
                                                                                return Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 1.5),
                                                                                  child: Obx(
                                                                                    () => Icon(
                                                                                      Icons.circle,
                                                                                      color: activityData?[index].circleIndex?.value == indicatorIndex ? clrYellow : clrWhite,
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
                                                                  height:
                                                                      Get.height *
                                                                          0.02,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "${activityData?[index].name}",
                                                                            style:
                                                                                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                h * .005,
                                                                          ),
                                                                          Text(
                                                                            '${activityData?[index].location}',
                                                                            style:
                                                                                TextStyle(color: clrGreyDark),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                h * .005,
                                                                          ),
                                                                          Text(
                                                                            '${activityData?[index].formattedDate} | ${activityData?[index].startAt} - ${activityData?[index].endAt}',
                                                                            style:
                                                                                TextStyle(color: clrGreyDark),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                h * .005,
                                                                          ),
                                                                          Text(
                                                                            "Up to ${activityData?[index].maxPeople} people | 2 spot left",
                                                                            style:
                                                                                TextStyle(color: clrYellowText, fontSize: 13),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(100),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            height:
                                                                                38,
                                                                            width:
                                                                                38,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            imageUrl:
                                                                                '${activityData?[index].profilePhoto}',
                                                                            errorWidget: (context, url, error) =>
                                                                                Container(
                                                                                  height: 38,
                                                                                  width: 38,
                                                                                  padding: const EdgeInsets.all(10),
                                                                                  decoration: BoxDecoration(
                                                                                    color: clrGreyLight,
                                                                                    shape: BoxShape.circle
                                                                                  ),
                                                                                  child: Image.asset("assets/icons/manicon.png",
                                                                                    color: clrGrey,fit: BoxFit.cover,),
                                                                                ),
                                                                            placeholder: (context, url) =>
                                                                                Shimmer.fromColors(
                                                                              baseColor: grey300,
                                                                              highlightColor: grey100,
                                                                              child: Container(
                                                                                width: double.maxFinite,
                                                                                height: h * .05,
                                                                                decoration: BoxDecoration(
                                                                                  color: grey300,
                                                                                  borderRadius: BorderRadius.circular(18),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${activityData?[index].hostName}',
                                                                          style:
                                                                              const TextStyle(fontWeight: FontWeight.w700),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      Get.height *
                                                                          0.015,
                                                                ),
                                                                ReadMoreText(
                                                                  '${activityData?[index].description}',
                                                                  style: TextStyle(
                                                                      color:
                                                                          clrGreyDark),
                                                                  trimMode:
                                                                      TrimMode
                                                                          .Line,
                                                                  trimLines: 2,
                                                                  colorClickableText:
                                                                      Colors
                                                                          .pink,
                                                                  trimCollapsedText:
                                                                      'Learn more',
                                                                  trimExpandedText:
                                                                      'Learn less',
                                                                  moreStyle: TextStyle(
                                                                      color:
                                                                          clrBlacke,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      })
                                                  : Center(
                                                      child: NoActivityScreen(),
                                                    )),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
          )
        ],
      )),
    );
  }
}
