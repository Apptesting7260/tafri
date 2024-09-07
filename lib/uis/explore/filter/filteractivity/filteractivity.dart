import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/explore/filter/controller/filterexp_controller.dart';
import 'package:plusone/uis/explore/filter/filteractivity/controller/filteractivity_controller.dart';
import 'package:plusone/utils/no_activity.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common.dart';
import '../../../../utils/error_widget.dart';
import '../../../../utils/size.dart';

class FilterActUi extends GetWidget<FilterActController> {
  FilterActUi({super.key});

  final FilterExpController fcontorller = Get.find<FilterExpController>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: Obx(
        () => fcontorller.filterLoading.value
            ? Center(
                child: CommonUi.scaffoldLoading(color: clrYellow),
              )
            : SafeArea(
                child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    CommonUi.appBar(),
                    SizedBox(
                      height: 15,
                    ),
                    fcontorller.filterError.value.isNotEmpty
                        ? Expanded(child: Center(child: ErrorScreen()))
                        : fcontorller
                                .filterActData.value.result!.activities!.isEmpty
                            ? Expanded(child: Center(child: NoActivityScreen()))
                            : SingleChildScrollView(
                              child: Container(
                                height: h * .88,
                                child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    // controller: controller.scrollController,
                                    itemCount: fcontorller
                                        .filterActData.value.result?.activities
                                        ?.where((activity) =>
                                            activity.status == 'approved')
                                        .length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var activityData = fcontorller
                                          .filterActData.value.result?.activities
                                          ?.where((activity) =>
                                              activity.status == 'approved')
                                          .toList();
                                      return InkWell(
                                        onTap: () {
                                          if(fcontorller.filterActData.value.result?.profileComplete == false
                                              &&  fcontorller.filterActData.value.result?.membershipStatus == false) {
                                            // fcontorller.showHomePop();
                                          } else {
                                            Get.toNamed(
                                                Routes
                                                    .exploreView,
                                                arguments:
                                                activityData?[
                                                index]
                                                    .id
                                                    .toString());
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: h * .26,
                                                child: Stack(
                                                  children: [
                                                    CarouselSlider(
                                                      options: CarouselOptions(
                                                          height: h * .26,
                                                          viewportFraction: 1,
                                                          onPageChanged: (currIndex,
                                                              CarouselPageChangedReason
                                                                  reason) {
                                                            fcontorller
                                                                .changeIndicator(
                                                                    index,
                                                                    currIndex);
                                                            debugPrint(
                                                                " currIndex $currIndex reason=$reason");
                                                          }),
                                                      items: activityData?[index]
                                                          .banners
                                                          ?.map<Widget>((i) {
                                                        return Builder(
                                                          builder: (BuildContext
                                                              context) {
                                                            return Container(
                                                                clipBehavior: Clip
                                                                    .hardEdge,
                                                                width: MediaQuery
                                                                        .of(context)
                                                                    .size
                                                                    .width,
                                                                height:
                                                                    double
                                                                        .maxFinite,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            0),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                18)),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  fit: BoxFit.cover,
                                                                  height: h * .26,
                                                                  width: double
                                                                      .maxFinite,
                                                                  imageUrl: "$i",
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
                                                                ));
                                                          },
                                                        );
                                                      }).toList(),
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
                                                                    horizontal: 10,
                                                                    vertical: 5),
                                                            decoration: BoxDecoration(
                                                                color: clrWhite,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Text(
                                                              '${activityData?[index].subcategoryTitle}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              if(fcontorller.filterActData.value.result?.profileComplete == false
                                                                  &&  fcontorller.filterActData.value.result?.membershipStatus == false) {
                                                                // fcontorller.showHomePop();
                                                              } else {
                                                                var id = activityData?[index].id.toString();
                                                                await fcontorller.changeFavApi(id).then(
                                                                      (value) {
                                                                    if (value == true) {
                                                                      activityData?[index].isFav = !activityData[index].isFav!;
                                                                    }
                                                                  },
                                                                );

                                                                fcontorller.filterActData.refresh();
                                                              }

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
                                                      child: Container(
                                                        margin:
                                                            const EdgeInsets.only(
                                                                bottom: 7),
                                                        height: 16,
                                                        child: ListView.builder(
                                                            itemCount:
                                                                activityData?[index]
                                                                    .banners
                                                                    ?.length,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemBuilder: (context,
                                                                indicatorIndex) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            1.5),
                                                                child: Obx(
                                                                  () => Icon(
                                                                    Icons.circle,
                                                                    color: activityData?[index]
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
                                                          "${activityData?[index].name}",
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                        ),
                                                        SizedBox(
                                                          height: h * .005,
                                                        ),
                                                        Text(
                                                          '${activityData?[index].location}',
                                                          style: TextStyle(
                                                              color: clrGreyDark),
                                                        ),
                                                        SizedBox(
                                                          height: h * .005,
                                                        ),
                                                        Text(
                                                          '${activityData?[index].formattedDate} | ${activityData?[index].startAt} - ${activityData?[index].endAt}',
                                                          style: TextStyle(
                                                              color: clrGreyDark),
                                                        ),
                                                        SizedBox(
                                                          height: h * .008,
                                                        ),
                                                        Text(
                                                          "Up to ${activityData?[index].maxPeople} people | ${activityData?[index].spotLeft} ${activityData![index].spotLeft! == 1 ? 'spot left' : 'spots left'}",
                                                          style: TextStyle(
                                                              color: clrYellowText,
                                                              fontSize: 13),
                                                        ),

                                                        // Text(
                                                        //   "Up to ${activityData?[index].maxPeople} people | "${activityData?[index].spotLeft} ${activityData?[index].spotLeft > 1 ? 'spots left' : 'spot left'}"
                                                        //     style:
                                                        //       TextStyle(color: clrYellowText, fontSize: 13),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          Routes.hostProfileUi,
                                                          arguments:
                                                              activityData?[index]
                                                                  .hostId
                                                                  .toString());
                                                    },
                                                    child: Column(
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
                                                            imageUrl:
                                                                '${activityData?[index].profilePhoto}',
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
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          '${activityData?[index].hostName}',
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
                                                height: Get.height * 0.015,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 13),
                                                child: ReadMoreText(
                                                  '${activityData?[index].description}',
                                                  style:
                                                      TextStyle(color: clrGreyDark),
                                                  trimMode: TrimMode.Line,
                                                  trimLines: 2,
                                                  colorClickableText: Colors.pink,
                                                  trimCollapsedText: 'Learn more',
                                                  trimExpandedText: 'Learn less',
                                                  moreStyle: TextStyle(
                                                      color: clrBlacke,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                  ],
                ),
              )),
      ),
    );
  }
}
