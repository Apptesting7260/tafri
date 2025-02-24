import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/explore/Userprofile/controller/userprofile_controller.dart';
import 'package:plusone/uis/explore/exploreview/controller/exploreview_controller.dart';
import 'package:plusone/uis/explore/hostprofile/controller/hostprofile_controller.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/custom_radio.dart';
import '../../../utils/error_widget.dart';
import '../../../utils/tostmsg.dart';
import '../../components/custotextfield.dart';
import '../explorelist/controller/explorelist_controller.dart';

class ExploreViewUi extends GetWidget<ExploreViewController> {
  ExploreViewUi({super.key});

 final ExploreListController exploreListController =
      Get.find<ExploreListController>();

 final PaymentController payment = Get.find<PaymentController>();
 final ProfilemainController profile = Get.find<ProfilemainController>();

 final SocketController chatController = Get.find<SocketController>();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    // var controller.actData.value.activity! = controller.controller.actData.value.activity!.value.activity!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonUi.appBar(),
                  const Text(
                    "Activity",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Share.share('${controller.actData.value.activitySettings?.shareText ?? ''} https://api.plusonesapp.com/activity?activityid=${controller.actData.value.activity?.id}&hostId=${controller.actData.value.activity?.hostId}');
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
                            // child: Image(
                            //   image: Svg('assets/images/share-2 1.svg'),
                            //   filterQuality: FilterQuality.high,
                            //   // color: clrWhite,
                            //   // height: h * .06,
                            //   // width: w * .06,
                            // )
                            child: Image.asset(
                              "assets/images/share-2 1.png",
                              // color: clrWhite,
                              // height: h * .06,
                              // width: w * .06,
                            ), //
                          ),
                        ),
                      ),
                      SizedBox(
                        width: w * .01,
                      ),
                      SizedBox(
                        width: w * 0.07,
                        child: Center(
                          child: PopupMenuButton(
                            splashRadius: 0.1,
                            icon: const Icon(
                              Icons.more_vert,
                              size: 30,
                            ),
                            elevation: 5,
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 1,
                                child: Text("Report"),
                              )
                            ],
                            onSelected: (val) {
                              if (val == 1) {
                                alertActivityReport();
                              }
                            },
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
                () => controller.activitypage.value
                    ? Center(
                        child: CommonUi.scaffoldLoading(color: clrYellow),
                      )
                    : controller.actError.value.isNotEmpty
                        ? SmartRefresher(
                            onRefresh: () async {
                              controller.refreshApi();
                            },
                            controller: controller.refreshController1,
                            header: CommonUi.refreshHeader(),
                            child: const Center(child: ErrorScreen()))
                        : SmartRefresher(
                            onRefresh: () async {
                              controller.refreshApi();
                            },
                            controller: controller.refreshController,
                            header: CommonUi.refreshHeader(),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: h * .25,
                                    child: Stack(
                                      children: [
                                        CarouselSlider(
                                          options: CarouselOptions(
                                              height: h * .26,
                                              enableInfiniteScroll: false,
                                              viewportFraction: 1,
                                              onPageChanged: (currIndex,
                                                  CarouselPageChangedReason reason) {
                                                controller.changeIndicator(currIndex);
                                                debugPrint(" currIndex $currIndex reason=$reason");
                                              }),
                                          items: controller
                                              .actData.value.activity!.banners
                                              ?.map<Widget>((i) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return Container(
                                                    clipBehavior: Clip.hardEdge,
                                                    width: MediaQuery.of(context).size.width,
                                                    height: double.maxFinite,
                                                    margin: const EdgeInsets.symmetric(horizontal: 0),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(18)),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      height: h * .26,
                                                      width: double.maxFinite,
                                                      memCacheWidth: 500,
                                                      imageUrl: "$i",
                                                      placeholder: (context, url) =>
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
                                                padding: const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5
                                                    ),
                                                decoration: BoxDecoration(
                                                    color: clrWhite,
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
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
                                              InkWell(
                                                onTap: () async {
                                                  var id = controller.actData
                                                      .value.activity!.id
                                                      .toString();
                                                  await controller
                                                      .changeFavApi(id)
                                                      .then(
                                                    (value) {
                                                      if (value == true) {
                                                        controller
                                                                .actData
                                                                .value
                                                                .activity!
                                                                .isFav =
                                                            !controller
                                                                .actData
                                                                .value
                                                                .activity!
                                                                .isFav!;
                                                        exploreListController
                                                            .homePageApi();
                                                      }
                                                    },
                                                  );
                                                  controller.actData.refresh();
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                      color: clrWhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: controller
                                                              .actData
                                                              .value
                                                              .activity!
                                                              .isFav ==
                                                          true
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
                                                itemBuilder:
                                                    (context, indicatorIndex) {
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
                                              controller
                                                  .actData.value.activity!.name
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: h * .005,
                                            ),
                                            InkWell(
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
                                                        'longitude': controller
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
                                              '${controller.actData.value.activity!.formattedDate}${controller.actData.value.activity!.endDate != controller.actData.value.activity!.formattedDate ? ' - ${controller.actData.value.activity!.endDate}' : ''} | ${controller.actData.value.activity!.startAt} - ${controller.actData.value.activity!.endAt}',
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
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if(Get.isRegistered<HostProfileController>()){
                                            Get.delete<HostProfileController>();
                                          }
                                          Get.toNamed(Routes.hostProfileUi,
                                              arguments: controller.actData
                                                  .value.activity!.hostId
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
                                                      const EdgeInsets.all(10),
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
                                                          BorderRadius.circular(
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
                                              controller.actData.value.activity!
                                                  .hostName
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700),
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
                                        fontSize: 14, color: clrGrey5D5C5E),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  controller.actData.value.going!.isEmpty
                                      ? const SizedBox()
                                      : const Text(
                                          "Going",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  controller.actData.value.going!.isEmpty
                                      ? const SizedBox()
                                      : SizedBox(
                                          height: 55,
                                          child: ListView.builder(
                                              itemCount: controller
                                                  .actData.value.going?.length,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    if(Get.isRegistered<UserProfileController>()){
                                                      Get.delete<UserProfileController>();
                                                    }
                                                    Get.toNamed(
                                                        Routes.userProfileui,
                                                        arguments: controller
                                                            .actData
                                                            .value
                                                            .going?[index]
                                                            .userId
                                                            .toString());
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: CachedNetworkImage(
                                                          height: 55,
                                                          width: 55,
                                                          fit: BoxFit.cover,
                                                          memCacheWidth: 500,
                                                          imageUrl:
                                                              '${controller.actData.value.going?[index].profilePhoto}',
                                                          placeholder: (context, url) => Shimmer
                                                              .fromColors(
                                                                  baseColor: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  highlightColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade100,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          55,
                                                                      width: 55,
                                                                      color:
                                                                          clrGrey,
                                                                    ),
                                                                  )),
                                                          errorWidget: (context,
                                                              url, error) {
                                                            print(
                                                                'error == $error');
                                                            return ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              child: Container(
                                                                height: 55,
                                                                width: 55,
                                                                color:
                                                                    clrGreyLight,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/icons/manicon.png',
                                                                  color:
                                                                      clrGrey,
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                              Obx(() => controller.mapLoading.value
                                      ? Expanded(
                                  child: Center(
                                      child:
                                      CommonUi.scaffoldLoading(
                                          color: clrYellow)))
                                  : controller.actData.value.activity
                                  ?.latitude !=
                                  null &&
                                  controller
                                      .actData
                                      .value
                                      .activity
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
                                    child:  GoogleMap(
                                                  onMapCreated:
                                                      (GoogleMapController
                                                          googleMapController) {
                                                    controller.mapController =
                                                        googleMapController;
                                                    controller
                                                        .addMarkerWithImage();
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
                                                )

                                    ) : const SizedBox()),
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                ],
                              ),
                            ),
                          ),
              )),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Obx(() => controller.activitypage.value ? const SizedBox() : controller.actError.value.isNotEmpty ? const SizedBox() : Obx(() {
                print('re');
                return controller.actData.value.activity!
                    .requestStatus ==
                    'pending'
                    ? SizedBox(
                    width: double.maxFinite,
                    height: Res.h_btn,
                    child: CustomElevatedButton(
                        onTap: () {},
                        backgroundClr: clrGrey,
                        child: Text(
                          "Pending host confirmation",
                          style: TextStyle(
                              color: clrWhite,
                              fontSize: 16,
                              fontWeight:
                              FontWeight.w700),
                        )))
                    : controller.actData.value.activity!
                    .requestStatus ==
                    'accept'
                    ? SizedBox(
                    width: double.maxFinite,
                    height: Res.h_btn,
                    child: CustomElevatedButton(
                        onTap: () {
                          print('gp == ${controller.actData.value.activity!.groupId}');
                          if(controller.actData.value.activity!
                              .groupId != null) {
                            chatController.addMember(
                                groupID: controller.actData.value.activity!
                                    .groupId.toString(),
                                members: [
                                  int.parse(LocalStorage.getUid().toString())
                                ],
                                hostID: controller.actData.value.activity!
                                    .hostId!,
                              actId: controller.actData.value.activity!.id.toString()
                            );
                          }else{
                            showTostMsg('No group exist for this activity');
                          }
                        },
                        backgroundClr: clrBlacke,
                        child: Text(
                          "Join group chat",
                          style: TextStyle(
                              color: clrWhite,
                              fontSize: 16,
                              fontWeight:
                              FontWeight.w700),
                        )))
                    : controller.actData.value.activity!
                    .requestStatus ==
                    'reject'
                    ? SizedBox(
                    width: double.maxFinite,
                    height: Res.h_btn,
                    child: CustomElevatedButton(
                        onTap: () {},
                        backgroundClr:
                        clrBlacke,
                        child: Text(
                          "Rejected",
                          style: TextStyle(
                              color: clrWhite,
                              fontSize: 16,
                              fontWeight:
                              FontWeight
                                  .w700),
                        )))
                    // : controller
                    // .actData
                    // .value
                    // .activity!
                    // .requestStatus ==
                    // 'leave'
                    // ? SizedBox(
                    // width: double.maxFinite,
                    // height: Res.h_btn,
                    // child:
                    // CustomElevatedButton(
                    //     onTap: () {},
                    //     backgroundClr:
                    //     clrBlacke,
                    //     child: Text(
                    //       "Leaved",
                    //       style: TextStyle(
                    //           color:
                    //           clrWhite,
                    //           fontSize:
                    //           16,
                    //           fontWeight:
                    //           FontWeight
                    //               .w700),
                    //     )))
                    : int.parse(LocalStorage
                    .getUid()!) !=
                    controller
                        .actData
                        .value
                        .activity
                        ?.hostId
                    ? Opacity(
                  opacity: controller
                      .isLoadingRequest
                      .value || payment.loading.value
                      ? 0.5
                      : 1,
                  child: SizedBox(
                      width: double
                          .maxFinite,
                      height:
                      Res.h_btn,
                      child: CustomElevatedButton(
                          onTap: () {
                            // if(profile
                            //     .profileData
                            //     .value.result?.cardSave == false){
                            // payment.alertRequestSent(() async{
                            // Get.back();
                            // await payment.createCustomer('${profile.profileData.value.result?.firstName} ${profile.profileData.value.result?.lastName}', '${profile.profileData.value.result?.email}');
                            // await profile.viewProfile();
                            // },);
                            // } else
                            // if (controller
                            //     .actData
                            //     .value
                            //     .activity
                            //     ?.spotLeft ==
                            //     0) {
                            //   controller.alertAddaMessage(controller
                            //       .actData
                            //       .value
                            //       .activity!
                            //       .id
                            //       .toString());
                            // } else {
                            //   controller.requestApi(controller
                            //       .actData
                            //       .value
                            //       .activity!
                            //       .id
                            //       .toString());
                            // }
                            controller.alertAddaMessage(controller
                                .actData
                                .value
                                .activity!
                                .id
                                .toString());
                          },
                          backgroundClr: clrBlacke,
                          child: controller.isLoadingRequest.value || payment.loading.value
                              ? CommonUi.buttonLoading()
                              : Text(
                            controller.actData.value.activity?.spotLeft == 0
                                ? 'Join waitlist'
                                : "Request to join",
                            style: TextStyle(
                                color: clrWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ))),
                )
                    : const Center(
                    child: Text(
                      'You created this activity.',
                      style: TextStyle(
                          fontWeight:
                          FontWeight
                              .w600,
                          fontSize: 16),
                    ));
              }),),
              Obx(() => controller.activitypage.value ? const SizedBox() : controller.actError.value.isNotEmpty ? const SizedBox() : Obx(() {
                return controller.actData.value.activity!
                    .requestStatus ==
                    'pending'
                    ? Column(
                  children: [
                    SizedBox(
                      height: h * 0.015,
                    ),
                    Center(
                        child: InkWell(
                            onTap: () {
                              alertCancelRequest(
                                  controller
                                      .actData
                                      .value
                                      .activity!
                                      .id
                                      .toString());
                            },
                            child: const Text(
                              "Cancel request",
                              style: TextStyle(
                                  decoration:
                                  TextDecoration
                                      .underline,
                                  fontWeight:
                                  FontWeight
                                      .w600),
                            )))
                  ],
                )
                    : controller.actData.value.activity!
                    .requestStatus ==
                    'accept'
                    ? Column(
                  children: [
                    SizedBox(
                      height: h * 0.015,
                    ),
                    Center(
                        child: InkWell(
                            onTap: () {
                              if(controller.checkHour(context, startDate: controller
                                  .actData
                                  .value
                                  .activity!.date.toString(), startTime: controller
                                  .actData
                                  .value
                                  .activity!.startAt.toString(), hours: controller.actData.value.paymentSettings!.attendeeCancellationHour.toString())){
                                alertCancelRequestConfirmation(
                                    controller
                                        .actData
                                        .value
                                        .activity!
                                        .id
                                        .toString(),
                                    true,controller.actData.value.paymentSettings!.attendeeCancellationHour.toString(),controller.actData.value.paymentSettings!.attendeeCancellationFee.toString());
                              }else{
                                alertLeave(controller.actData.value.activity!.id.toString(),() async{
                                      Get.back();
                                      await controller.leaveActivity(controller.actData.value.activity!.id.toString(),gpID: controller.actData.value.activity!.groupId.toString());
                                      await controller.actapi(controller.actData.value.activity!.id.toString());
                                    },);
                              }

                            },
                            child: const Text(
                              "Leave activity",
                              style: TextStyle(
                                  decoration:
                                  TextDecoration
                                      .underline,
                                  fontSize: 16),
                            )))
                  ],
                )
                    : const SizedBox();
              }),),
              SizedBox(
                height: Get.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }

  alertActivityReport() {
    Get.dialog(AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      content: SizedBox(
        width: double.maxFinite,
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         InkWell(
        //             onTap: () {
        //               Get.back();
        //             },
        //             child: const Icon(
        //               Icons.close,
        //               size: 25,
        //             )),
        //         const Flexible(
        //           child: Text(
        //             "Report activity",
        //             style: TextStyle(fontSize: 19
        //                 , fontWeight: FontWeight.w800),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 1,
        //         ),
        //       ],
        //     ),
        //       SizedBox(
        //       height:Get.height*.02,
        //     ),
        //     const Text(
        //       "Why are you reporting this activity?",
        //       style: TextStyle(fontWeight: FontWeight.w800),
        //     ),
        //       SizedBox(
        //       height: Get.height*.014,
        //     ),
        //     Row(
        //       children: [
        //         SizedBox(height: 30,child: Radio(splashRadius: 0,value: 1, groupValue: 2, onChanged: (val) {})),
        //         const Text("Scam or fraud",style: TextStyle(fontSize: 15),)
        //       ],
        //     ),
        //     Divider(
        //       color: clrGreyLight,
        //     ),
        //     Row(
        //       children: [
        //         SizedBox(height: 30,child: Radio(value: 2, groupValue: 2, onChanged: (val) {})),
        //         const Text("Inappropriate or misleading content",style: TextStyle(fontSize: 15))
        //       ],
        //     ),
        //     Divider(
        //       color: clrGreyLight,
        //     ),
        //     Row(
        //       children: [
        //         SizedBox(height: 30,child: Radio(value: 3, groupValue: 2, onChanged: (val) {})),
        //         const Text("Harrassment or abuse",style: TextStyle(fontSize: 15))
        //       ],
        //     ),
        //     Divider(
        //       color: clrGreyLight,
        //     ),
        //     Row(
        //       children: [
        //         SizedBox(height: 30,child: Radio(value: 4, groupValue: 2, onChanged: (val) {})),
        //         const Text("Other",style: TextStyle(fontSize: 15))
        //       ],
        //     ),
        //     const SizedBox(
        //       height: 10,
        //     ),
        //     const CustoTextFormField(hintText: "Please provide more details about what happened. We will review your report and take appropriate action.",maxLines: 5,),
        //       SizedBox(
        //       height: Get.height*.024,
        //     ),
        //     SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
        //       Get.back();
        //     }, backgroundClr: clrBlacke, child: Text("Submit",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
        //       SizedBox(
        //       height: Get.height*.014,
        //     ),
        //   ],
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 25,
                    )),
                const Text(
                  "Report activity",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Why are you reporting this activity?",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => SizedBox(
                  height: 30,
                  child: CustomRadioButton(
                      text: "Scam or fraud",
                      activeColor: clrYellow,
                      value: 1,
                      groupValue: controller.selectedValue.value,
                      onChanged: (val) {
                        controller.updateSelectedValue(val);
                      })),
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(
              color: clrBlacke.withOpacity(.15),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => SizedBox(
                  height: 30,
                  child: CustomRadioButton(
                      text: "Inappropriate or misleading content",
                      activeColor: clrYellow,
                      value: 2,
                      groupValue: controller.selectedValue.value,
                      onChanged: (val) {
                        controller.updateSelectedValue(val);
                      })),
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(
              color: clrBlacke.withOpacity(.15),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => SizedBox(
                  height: 30,
                  child: CustomRadioButton(
                      text: "Harrassment or abuse",
                      activeColor: clrYellow,
                      value: 3,
                      groupValue: controller.selectedValue.value,
                      onChanged: (val) {
                        controller.updateSelectedValue(val);
                      })),
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(
              color: clrBlacke.withOpacity(.15),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => SizedBox(
                  height: 30,
                  child: CustomRadioButton(
                      text: "Other",
                      activeColor: clrYellow,
                      value: 4,
                      groupValue: controller.selectedValue.value,
                      onChanged: (val) {
                        controller.updateSelectedValue(val);
                      })),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: formkey,
              child: CustoTextFormField(
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter something';
                  } else {
                    return null;
                  }
                },
                controll: controller.reportDescriptionController,
                hintText:
                    "Please provide more details about what happened. We will review your report and take appropriate action.",
                maxLines: 5,
                borderRadius: 15,
                hintSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Opacity(
                opacity: controller.reportactivityLoading.value ? 0.5 : 1,
                child: SizedBox(
                    width: double.maxFinite,
                    height: Get.height * .07,
                    child: CustomElevatedButton(
                        onTap: () {
                          if (controller.selectedValue.value == 4) {
                            if (formkey.currentState!.validate()) {
                              controller.reportActivity(controller
                                  .actData.value.activity?.id
                                  .toString());
                            }
                          } else if (controller.selectedValue.value != 0) {
                            controller.reportActivity(controller
                                .actData.value.activity?.id
                                .toString());
                          } else {
                            showTostMsg('Please select any reason');
                          }
                        },
                        backgroundClr: clrBlacke,
                        child: controller.reportactivityLoading.value
                            ? CommonUi.buttonLoading()
                            : Text(
                                "Submit",
                                style: TextStyle(
                                    color: clrWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ))),
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

  alertCancelRequest(String id) {
    Future.delayed(Duration.zero, () {
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Cancel request",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                "Are you sure you want to cancel your request to join this activity?",
                style: TextStyle(
                    color: clrGreyTextLight,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: Get.height * .024,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Expanded(
                      child: SizedBox(
                    height: Res.h_btn,
                    child: CustoFilterBtn(
                        borderClr: clrBlacke,
                        lable: Text(
                          "Yes",
                          style: TextStyle(
                              color: clrBlacke,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        ontap: () async{
                          Get.back();
                          await controller.cancelActivity(id);
                          await controller.actapi(id);
                          // alertCancelRequestConfirmation(id, false,controller.actData.value.paymentSettings!.attendeeCancellationHour.toString(),controller.actData.value.paymentSettings!.attendeeCancellationFee.toString());
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
                              "No",
                              style: TextStyle(
                                  color: clrWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ))),
                  ),
                ]),
              ),
              SizedBox(
                height: Get.height * .014,
              ),
            ],
          ),
        ),
      ));
    });
  }

  alertCancelRequestConfirmation(String id, bool isLeave,String hours,String fees) {
    Future.delayed(Duration.zero, () {
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
                height: Get.height * .014,
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Canceling within ${hours} hours of the activity will incur a €${fees} fee. Are you sure you want to proceed?",
                  style: TextStyle(
                      color: clrGreyTextLight,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              )),
              SizedBox(
                height: Get.height * .024,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Expanded(
                      child: SizedBox(
                    height: Res.h_btn,
                    child: CustoFilterBtn(
                        borderClr: clrBlacke,
                        lable: Text(
                          "Yes",
                          style: TextStyle(
                              color: clrBlacke,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        ontap: () async {
                          // controller.changeReqSent(1);
                          if (isLeave) {
                            Get.back();
                            await controller.leaveActivity(id,gpID: controller.actData.value.activity!.groupId.toString());
                            await controller.actapi(id);
                          } else {
                            Get.back();
                            await controller.cancelActivity(id);
                            await controller.actapi(id);
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
                              "No",
                              style: TextStyle(
                                  color: clrWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ))),
                  ),
                ]),
              ),
              SizedBox(
                height: Get.height * .014,
              ),
            ],
          ),
        ),
      ));
    });
  }

  alertLeave(String id, dynamic Function() ontap) {
    Future.delayed(Duration.zero, () {
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Leave activity",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                    "Are you sure you want to leave this activity?",
                    style: TextStyle(
                        color: clrGreyTextLight,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: Get.height * .024,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Expanded(
                      child: SizedBox(
                        height: Res.h_btn,
                        child: CustoFilterBtn(
                            borderClr: clrBlacke,
                            lable: Text(
                              "Yes",
                              style: TextStyle(
                                  color: clrBlacke,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            ontap: ontap,
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
                              "No",
                              style: TextStyle(
                                  color: clrWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ))),
                  ),
                ]),
              ),
              SizedBox(
                height: Get.height * .014,
              ),
            ],
          ),
        ),
      ));
    });
  }


}
