import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/size.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../utils/colors.dart';
import '../../../../components/custofilterbtn.dart';
import 'controller/myprofileinn_controller.dart';

class MyProfileUi extends GetWidget<MyprofileInnController> {
  MyProfileUi({super.key});

  final ProfilemainController profileController =
      Get.find<ProfilemainController>();

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
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonUi.appBar(),
                const Text(
                  "My profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: w * .1,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            TabBar(
              indicatorColor: tabBarColor,
              dividerHeight: 0,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: clrBlacke,
              labelColor: tabBarColor,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              tabs: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 9),
                  child: Text(
                    "Edit",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 9),
                  child: Text("Preview"),
                )
              ],
              controller: controller.tabController,
            ),
            Expanded(
                child:
                    TabBarView(controller: controller.tabController, children: [
              Obx(
                () => profileController.profileLoading.value
                    ? Center(
                        child: CommonUi.scaffoldLoading(color: clrYellow),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: h * .035,
                                ),
                                SizedBox(
                                  child: Center(
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: h * .14,
                                              width: w * .29,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: clrGreyLight),
                                              child: profileController
                                                              .profileData
                                                              .value
                                                              .result
                                                              ?.profile ==
                                                          null ||
                                                      profileController
                                                              .profileData
                                                              .value
                                                              .result
                                                              ?.profile
                                                              ?.profilePhoto ==
                                                          null
                                                  ? Image.asset(
                                                      "assets/icons/manicon.png",
                                                      color: clrGrey,
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            '${profileController.profileData.value.result?.profile?.profilePhoto}',
                                                        memCacheWidth: 500,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Container(
                                                            height: h * .14,
                                                            width: w * .29,
                                                            color: clrGreyLight,
                                                            child: Image.asset(
                                                                'assets/icons/manicon.png',
                                                                color: clrGrey),
                                                          ),
                                                        ),
                                                        placeholder: (context, url) => Shimmer.fromColors(
                                                            baseColor: grey300,
                                                            highlightColor: grey100,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(100),
                                                              child: Container(
                                                                height: h * .14,
                                                                width: w * .29,
                                                                color: clrGrey,
                                                              ),
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              height: h * .02,
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            profileController
                                                .profileData
                                                .value
                                                .result
                                                ?.profile ==
                                                null ||
                                                profileController
                                                    .profileData
                                                    .value
                                                    .result
                                                    ?.profile
                                                    ?.profilePhoto ==
                                                    null ? SizedBox(
                                              width: w * .04,
                                            ) : SizedBox(),
                                            profileController
                                                .profileData
                                                .value
                                                .result
                                                ?.profile ==
                                                null ||
                                                profileController
                                                    .profileData
                                                    .value
                                                    .result
                                                    ?.profile
                                                    ?.profilePhoto ==
                                                    null
                                                ? SizedBox(
                                              width: w * .04,
                                            ) : SizedBox(),
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.addPhotoProUi);
                                              },
                                              child: Container(
                                                // height: 100,
                                                // width: 100,
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10,
                                                    vertical: 4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: clrYellow),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt,
                                                      color: clrWhite,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      profileController
                                                          .profileData
                                                          .value
                                                          .result
                                                          ?.profile
                                                          ?.profilePhoto ==
                                                          null ?"Add" : 'Update',
                                                      style: TextStyle(
                                                          color: clrWhite),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            profileController
                                                .profileData
                                                .value
                                                .result
                                                ?.profile ==
                                                null ||
                                                profileController
                                                    .profileData
                                                    .value
                                                    .result
                                                    ?.profile
                                                    ?.profilePhoto ==
                                                    null
                                                ? const SizedBox(
                                              width: 5,
                                            ) : SizedBox(),
                                            profileController
                                                .profileData
                                                .value
                                                .result
                                                ?.profile ==
                                                null ||
                                                profileController
                                                    .profileData
                                                    .value
                                                    .result
                                                    ?.profile
                                                    ?.profilePhoto ==
                                                    null
                                                ? Padding(
                                              padding: const EdgeInsets.only(left: 5),
                                              child: Image.asset(
                                                "assets/icons/danger_new.png",
                                                height: 17,
                                              ),
                                            )
                                                : CommonUi.emptySizeBox(),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .04,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.bioUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Bio",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Obx(
                                              () => Text(
                                                profileController
                                                            .profileData
                                                            .value
                                                            .result
                                                            ?.profile
                                                            ?.bio ==
                                                        null || profileController
                                                    .profileData
                                                    .value
                                                    .result
                                                    !.profile
                                                    !.bio!.isEmpty
                                                    ? "Add a short bio (Optional)"
                                                    : '${profileController.profileData.value.result?.profile?.bio}',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    // color: clrGreyTextLight
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                        SizedBox(
                                          width: w * .05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            profileController.profileData.value
                                                            .result?.profile ==
                                                        null ||
                                                    profileController
                                                            .profileData
                                                            .value
                                                            .result
                                                            ?.profile
                                                            ?.bio ==
                                                        null || profileController
                                                .profileData
                                                .value
                                                .result
                                                !.profile
                                                !.bio!.isEmpty
                                                ? Image.asset(
                                                    "assets/icons/danger_new.png",
                                                    height: 17,
                                                  )
                                                : CommonUi.emptySizeBox(),
                                            SizedBox(
                                              width: w * .02,
                                            ),
                                            Image.asset(
                                              'assets/icons/arrow right.png',
                                              height: 14,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .018,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.locationProUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Location",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Obx(
                                              () => Text(
                                                profileController
                                                        .profileData
                                                        .value
                                                        .result
                                                        ?.location ??
                                                    'Add your location',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                          width: w * .05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            profileController
                                                .profileData
                                                .value
                                                .result
                                                ?.location == null ? Image.asset("assets/icons/danger_new.png",height: 17,) : SizedBox(),
                                            SizedBox(
                                              width: w * .02,
                                            ),
                                            Image.asset(
                                              'assets/icons/arrow right.png',
                                              height: 14,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .018,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.occupationProUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Occupation",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(
                                              profileController
                                                          .profileData
                                                          .value
                                                          .result
                                                          ?.profile
                                                          ?.occupation ==
                                                      null || profileController
                                                  .profileData
                                                  .value
                                                  .result
                                                  !.profile
                                                  !.occupation!.isEmpty
                                                  ? "Add your occupation"
                                                  : '${profileController.profileData.value.result?.profile?.occupation}',
                                              style: TextStyle(
                                                  fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                          width: w * .05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            profileController.profileData.value
                                                            .result?.profile ==
                                                        null ||
                                                    profileController
                                                            .profileData
                                                            .value
                                                            .result
                                                            ?.profile
                                                            ?.occupation ==
                                                        null || profileController
                                                .profileData
                                                .value
                                                .result
                                                !.profile
                                                !.occupation!.isEmpty
                                                ? Image.asset(
                                                    "assets/icons/danger_new.png",
                                                    height: 17,
                                                  )
                                                : CommonUi.emptySizeBox(),
                                            SizedBox(
                                              width: w * .02,
                                            ),
                                            Image.asset(
                                              'assets/icons/arrow right.png',
                                              height: 14,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .018,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.languageProUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Languages",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            profileController
                                                        .profileData
                                                        .value
                                                        .result
                                                        ?.profile
                                                        ?.languageNames ==
                                                    null || profileController
                                                .profileData
                                                .value
                                                .result
                                                !.profile
                                                !.languageNames!.isEmpty
                                                ? Text(
                                                    "Select languages you speak",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                    ),
                                                  )
                                                : Container(
                                                    height: 20,
                                                    child: ListView.separated(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Text(
                                                              profileController
                                                                  .profileData
                                                                  .value
                                                                  .result!
                                                                  .profile!
                                                                  .languageNames![
                                                                      index]
                                                                  .toString());
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return const Text(
                                                              ', ');
                                                        },
                                                        itemCount:
                                                            profileController
                                                                    .profileData
                                                                    .value
                                                                    .result!
                                                                    .profile!
                                                                    .languageNames
                                                                    ?.length ??
                                                                0),
                                                  )
                                          ],
                                        )),
                                        SizedBox(
                                          width: w * .05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            profileController.profileData.value
                                                        .result?.profile ==
                                                    null || profileController.profileData.value
                                                .result!.profile!.languageNames!.isEmpty
                                                ? Image.asset(
                                                    "assets/icons/danger_new.png",
                                                    height: 17,
                                                  )
                                                : CommonUi.emptySizeBox(),
                                            SizedBox(
                                              width: w * .02,
                                            ),
                                            Image.asset(
                                              'assets/icons/arrow right.png',
                                              height: 14,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .018,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.activityInterestUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Activity interests",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(
                                              (profileController
                                                          .profileData
                                                          .value
                                                          .result
                                                          ?.profile
                                                          ?.activityTitles ==
                                                      null || profileController
                                                  .profileData
                                                  .value
                                                  .result
                                                  !.profile
                                                  !.activityTitles!.isEmpty) && controller.selectedActivity.isEmpty
                                                  ? "Add 3-10 activities"
                                                  : 'Click to adjust.',
                                              style: TextStyle(
                                                  fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                          width: w * .05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                           (profileController.profileData.value
                                                            .result?.profile ==
                                                        null ||
                                                    profileController
                                                            .profileData
                                                            .value
                                                            .result
                                                            ?.profile
                                                            ?.activityTitles ==
                                                        null || profileController
                                                .profileData
                                                .value
                                                .result
                                                !.profile
                                                !.activityTitles!.isEmpty) && controller.selectedActivity.isEmpty
                                                ? Image.asset(
                                                    "assets/icons/danger_new.png",
                                                    height: 17,
                                                  )
                                                : CommonUi.emptySizeBox(),
                                            SizedBox(
                                              width: w * .02,
                                            ),
                                            Image.asset(
                                              'assets/icons/arrow right.png',
                                              height: 14,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .018,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.funfactProUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("Fun facts about me ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(
                                              (profileController
                                                          .profileData
                                                          .value
                                                          .result
                                                          ?.profile
                                                          ?.funFactsAboutMe ==
                                                      null || profileController
                                                  .profileData
                                                  .value
                                                  .result
                                                  !.profile
                                                  !.funFactsAboutMe!.isEmpty) || controller.funFactListDeta.isEmpty
                                                  ? "Select 1-3 questions"
                                                  : '${profileController.profileData.value.result?.profile?.funFactsAboutMe?[0].question}',
                                              style: TextStyle(
                                                  fontSize: 13,),
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                          width: w * .05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            (profileController.profileData.value
                                                            .result?.profile ==
                                                        null ||
                                                    profileController
                                                            .profileData
                                                            .value
                                                            .result
                                                            ?.profile
                                                            ?.funFactsAboutMe ==
                                                        null || profileController
                                                .profileData
                                                .value
                                                .result
                                                !.profile
                                                !.funFactsAboutMe!.isEmpty) && controller.funFactListDeta.isEmpty
                                                ? Image.asset(
                                                    "assets/icons/danger_new.png",
                                                    height: 17,
                                                  )
                                                : CommonUi.emptySizeBox(),
                                            SizedBox(
                                              width: w * .02,
                                            ),
                                            Image.asset(
                                              'assets/icons/arrow right.png',
                                              height: 14,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .018,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.verifySocialMedProUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                                "Verify your social media",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(
                                              profileController
                                                              .profileData
                                                              .value
                                                              .result
                                                              ?.profile
                                                              ?.verifyInstagram ==
                                                          null ||
                                                      profileController
                                                              .profileData
                                                              .value
                                                              .result
                                                              ?.profile
                                                              ?.verifyLinkedin ==
                                                          null ||
                                                      profileController
                                                              .profileData
                                                              .value
                                                              .result
                                                              ?.profile
                                                              ?.verifyInstagram ==
                                                          "0" ||
                                                      profileController
                                                              .profileData
                                                              .value
                                                              .result
                                                              ?.profile
                                                              ?.verifyLinkedin ==
                                                          "0"
                                                  ? "Click to verify (Optional)"
                                                  : 'Verified.',
                                              style: TextStyle(
                                                  fontSize: 13,),
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                          width: w * .05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            profileController.profileData.value
                                                        .result?.profile ==
                                                    null || profileController
                                                .profileData
                                                .value
                                                .result
                                                ?.profile
                                                ?.verifyInstagram ==
                                                null ||
                                                profileController
                                                    .profileData
                                                    .value
                                                    .result
                                                    ?.profile
                                                    ?.verifyLinkedin ==
                                                    null ||
                                                profileController
                                                    .profileData
                                                    .value
                                                    .result
                                                    ?.profile
                                                    ?.verifyInstagram ==
                                                    "0" ||
                                                profileController
                                                    .profileData
                                                    .value
                                                    .result
                                                    ?.profile
                                                    ?.verifyLinkedin ==
                                                    "0"
                                                ? Image.asset(
                                                    "assets/icons/danger_new.png",
                                                    height: 17,
                                                  )
                                                : CommonUi.emptySizeBox(),
                                            SizedBox(
                                              width: w * .02,
                                            ),
                                            Image.asset(
                                              'assets/icons/arrow right.png',
                                              height: 14,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * .03,
                                ),
                                // Obx(() {
                                //   return Opacity(
                                //     opacity: controller.deleteloading.value ? 0.5 : 1,
                                //     child: SizedBox(
                                //       height: Res.h_btn,
                                //       child: CustomElevatedButton(
                                //           onTap: () {
                                //             alertDeleteAccount();
                                //           },
                                //           backgroundClr: clrBlacke,
                                //           child: controller.deleteloading.value ? CommonUi.buttonLoading() : Text(
                                //             "Delete Account",
                                //             style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),
                                //           )
                                //       ),
                                //     ),
                                //   );
                                // },),
                                // SizedBox(
                                //   height: Get.height * .03,
                                // ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 10),
                          //   child: SizedBox(
                          //     height: Res.h_btn,
                          //     width: double.maxFinite,
                          //     child: Obx(
                          //       () => Opacity(
                          //         opacity: controller.isLoadingProfile.value
                          //             ? 0.5
                          //             : 1,
                          //         child: CustomElevatedButton(
                          //             onTap: () {
                          //               if (!controller
                          //                   .isLoadingProfile.value) {
                          //                 controller.myProfileSubmit();
                          //               }
                          //             },
                          //             backgroundClr: clrBlacke,
                          //             child: controller.isLoadingProfile.value
                          //                 ? CommonUi.buttonLoading()
                          //                 : Text(
                          //                     "Save",
                          //                     style: TextStyle(
                          //                         color: clrWhite,
                          //                         fontSize: 16,
                          //                         fontWeight: FontWeight.w700),
                          //                   )),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),),
                      Obx(() => profileController.profileLoading.value ? Center(
                        child: CommonUi.scaffoldLoading(color: clrYellow),
                      ) : profileController.profileError.value.isNotEmpty ? ErrorScreen() : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.035,
                            ),
                            Center(
                              child: Obx(
                                  () => ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                        imageUrl: '${profileController.profileData.value.result?.profile?.profilePhoto}',
                                        memCacheWidth: 500,
                                        fit: BoxFit.cover,
                                        height: h * .14,
                                        width: w * .3,
                                        placeholder: (context, url) => Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade100,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Container(
                                            height: h * .14,
                                            width: w * .3,
                                            color: clrGrey,
                                          ),
                                        )
                                        ),
                                        errorWidget: (context, url, error) {
                                          print('error == $error');
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: Container(
                                              height: h * .14,
                                              width: w * .3,
                                              color: clrGreyLight,
                                              child: Image.asset(
                                                'assets/icons/manicon.png',
                                                color: clrGrey,
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                              ),
                            ),
                            profileController.profileData.value.result?.firstName != null
                                ? SizedBox(
                              height: Get.height * 0.015,
                            )
                                : CommonUi.emptySizeBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profileController.profileData.value.result?.firstName ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                profileController.profileData.value.result?.profile?.verifyInstagram == '1'
                                    && profileController.profileData.value.result?.profile?.verifyLinkedin == '1'
                                    ? InkWell(
                                    onTap: () {
                                      verificationAlert();
                                      },
                                    child: Icon(
                                      Icons.verified,
                                      color: clrYellow,
                                      size: 16,
                                    )
                                )
                                    : CommonUi.emptySizeBox()
                              ],
                            ),
                            profileController.profileData.value.result?.firstName != null
                                ? SizedBox(
                              height: Get.height * 0.008,
                            )
                                : CommonUi.emptySizeBox(),
                            Center(
                                child: profileController.profileData.value.result?.firstName != null && profileController.profileData.value.result!.age! > 0
                                    ? Text(
                                  "${profileController.profileData.value.result?.age ?? ''} years old | ${profileController.profileData.value.result?.gender == 'male' ? "He/Him" : profileController.profileData.value.result?.gender == 'female' ? "She/Her" : ''}",
                                  style: TextStyle(
                                      fontSize: 13
                                  ),
                                )
                                    : CommonUi.emptySizeBox()
                            ),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: clrGreyLight
                                    ),
                                    child: Column(
                                      children: [
                                        // TweenAnimationBuilder<int>(
                                        //   tween: IntTween(
                                        //       begin: 0,
                                        //       end: int.parse(profileController
                                        //           .profileData
                                        //           .value
                                        //           .result!
                                        //           .attendanceRate
                                        //           .toString()
                                        //           .split('%')[0])),
                                        //   duration: const Duration(seconds: 1),
                                        //   builder: (context, value, child) {
                                        //     return Text(
                                        //       '$value%',
                                        //       style: TextStyle(
                                        //           color: clrYellowText.withOpacity(0.8),
                                        //           fontSize: 22,
                                        //           fontWeight: FontWeight.w700),
                                        //     );
                                        //   },
                                        // ),
                                        Text(
                                          '${profileController.profileData.value.result?.attendanceRate ?? 0}',
                                          style: TextStyle(
                                              color: clrYellowText.withOpacity(0.8),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                const Text(
                                  "Attendance",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ), const Text(
                                  "Rate",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.028,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                            child: Column(
                              children: [
                                // TweenAnimationBuilder<int>(
                                //   tween: IntTween(
                                //       begin: 0,
                                //       end: int.parse(profileController
                                //           .profileData
                                //           .value
                                //           .result!
                                //           .activitiesJoined
                                //           .toString())),
                                //   duration: const Duration(seconds: 1),
                                //   builder: (context, value, child) {
                                //     return Text(
                                //       '$value',
                                //       style: TextStyle(
                                //           color: clrYellowText.withOpacity(0.8),
                                //           fontSize: 22,
                                //           fontWeight: FontWeight.w700),
                                //     );
                                //   },
                                // ),
                                Text(
                                  '${profileController.profileData.value.result?.activitiesJoined ?? 0}',
                                  style: TextStyle(
                                      color: clrYellowText.withOpacity(0.8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Text(
                                  "Activities",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),const Text(
                                  "Joined",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.028,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                            child: Column(
                              children: [
                                // TweenAnimationBuilder<int>(
                                //   tween: IntTween(
                                //       begin: 0,
                                //       end: int.parse(profileController
                                //           .profileData
                                //           .value
                                //           .result!
                                //           .activitiesHosted
                                //           .toString())),
                                //   duration: const Duration(seconds: 1),
                                //   builder: (context, value, child) {
                                //     return Text(
                                //       '$value',
                                //       style: TextStyle(
                                //           color: clrYellowText.withOpacity(0.8),
                                //           fontSize: 22,
                                //           fontWeight: FontWeight.w700),
                                //     );
                                //   },
                                // ),
                                Text(
                                  '${profileController.profileData.value.result?.activitiesHosted ?? 0}',
                                  style: TextStyle(
                                      color: clrYellowText.withOpacity(0.8),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Text("Activities",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12)),
                                const Text("Hosted",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: clrGreyLight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bio",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          profileController.profileData.value.result
                              ?.profile?.bio !=
                              null ? Text("${profileController.profileData.value.result?.profile?.bio}",
                              // style: TextStyle(color: clrGreyTextLight)
                          ) : CommonUi.emptySizeBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: clrGreyLight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Location",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                              "${profileController.profileData.value.result?.location ?? ''}",
                              // style: TextStyle(color: clrGreyTextLight)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: clrGreyLight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Occupation",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),

                          profileController.profileData.value.result
                              ?.profile?.occupation !=
                              null ? Text("${ profileController.profileData.value.result?.profile?.occupation}${ profileController.profileData.value.result
                              ?.profile?.organisationName !=
                              null &&  profileController.profileData.value.result
                          !.profile!.organisationName!.isNotEmpty ? ", ${ profileController.profileData.value.result?.profile?.organisationName}" : ''}",
                            // style: TextStyle(color: clrGreyTextLight)
                          ) : CommonUi.emptySizeBox()
                          
                          // Row(
                          //   children: [
                          //     profileController.profileData.value.result
                          //         ?.profile?.occupation !=
                          //         null ? Flexible(
                          //           child: Text("${profileController.profileData.value.result?.profile?.occupation}",
                          //           // style: TextStyle(color: clrGreyTextLight)
                          //                                         ),
                          //         ) : CommonUi.emptySizeBox(),
                          //     profileController.profileData.value.result
                          //         ?.profile?.organisationName !=
                          //         null && profileController.profileData.value.result
                          //         !.profile!.organisationName!.isNotEmpty ? Flexible(
                          //           child: Text(", ${profileController.profileData.value.result?.profile?.organisationName}",
                          //           // style: TextStyle(color: clrGreyTextLight)
                          //                                         ),
                          //         ) : CommonUi.emptySizeBox(),
                          //   ],
                          // )

                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: clrGreyLight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Languages",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          SizedBox(
                            height: h * .007,
                          ),
                          Wrap(
                            spacing: w * .02,
                            runSpacing: h * .01,
                            children: [
                              ...?profileController.profileData.value.result
                                  ?.profile?.languageNames
                                  ?.map((language) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: clrWhite,
                                  ),
                                  child: Text(language),
                                );
                              }).toList(),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: clrGreyLight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Interests",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          SizedBox(
                            height: h * .008,
                          ),
                          Wrap(
                              spacing: w * .02,
                              runSpacing: h * .01,
                              children: profileController.interestList.map(
                                    (e) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.network(
                                          e.icon.toString(),
                                          height: 20,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(e.title.toString()),
                                      ],
                                    ),
                                  );
                                },
                              ).toList())
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: clrGreyLight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fun facts about ${profileController.profileData.value.result?.firstName ?? ''}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${profileController.profileData.value.result?.profile?.funFactsAboutMe?[index].question}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                Text(
                                    "${profileController.profileData.value.result?.profile?.funFactsAboutMe?[index].answer}",
                                    ),
                              ],
                            ),
                            itemCount: profileController.profileData.value
                                .result?.profile?.funFactsAboutMe?.length ??
                                0,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    profileController.profileData.value.result!.upcomingActivities!.isEmpty
                        ? SizedBox()
                        :  Text(
                      "Upcoming activities",
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    profileController.profileData.value.result!.upcomingActivities!.isEmpty
                        ? SizedBox()
                        : ListView.builder(
                        itemCount: profileController.profileData.value
                            .result?.upcomingActivities?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.height * 0.01),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileController.profileData.value
                                      .result?.upcomingActivities?[index].formattedDate ?? '',
                                  style: TextStyle(color: clrGreyDark),
                                ),
                                SizedBox(
                                  height: Get.height * 0.003,
                                ),
                                // Row(
                                //   children: [
                                //     Container(
                                //       clipBehavior: Clip.hardEdge,
                                //       height: h * .075,
                                //       width: h * .075,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //       child: Image.asset(
                                //         "assets/images/parkimage.png",
                                //         fit: BoxFit.cover,
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: Get.width * 0.02,
                                //     ),
                                //     Expanded(
                                //       child: Container(
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 10, vertical: 10),
                                //         decoration: BoxDecoration(
                                //             color: clrWhite,
                                //             borderRadius:
                                //             BorderRadius.circular(5)),
                                //         child: Column(
                                //           crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //           children: [
                                //             Text(
                                //               "10KM Vondelpark run",
                                //               style: TextStyle(
                                //                   fontSize: 14,
                                //                   fontWeight: FontWeight.w600),
                                //             ),
                                //             Text(
                                //                 "Padel next, 1055 AH, Amsterdam ",
                                //                 style: TextStyle(
                                //                     color: clrGreyDark,
                                //                     fontSize: 12)),
                                //           ],
                                //         ),
                                //       ),
                                //     )
                                //   ],
                                // ),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: profileController.profileData.value
                                      .result?.upcomingActivities?[index].activities?.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,ind) {
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.previousActivityUi,
                                            arguments: {
                                              "isHost": false,
                                              "id": profileController.profileData.value.result?.upcomingActivities?[index].activities?[ind].id.toString()
                                            });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Container(
                                            //   clipBehavior: Clip.hardEdge,
                                            //   height: h * .075,
                                            //   width: h * .075,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius:
                                            //     BorderRadius.circular(10),
                                            //   ),
                                            //   child: Image.asset(
                                            //     "assets/images/parkimage.png",
                                            //     fit: BoxFit.cover,
                                            //   ),
                                            // ),
                                            Container(
                                              clipBehavior: Clip.hardEdge,
                                              height: h * .075,
                                              width: h * .075,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: profileController.profileData.value.result?.upcomingActivities?[index].activities?[ind].banners != null &&
                                                  profileController.profileData.value.result!.upcomingActivities![index].activities![ind].banners!.isNotEmpty
                                                  ? CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                memCacheWidth: 500,
                                                imageUrl: profileController.profileData.value.result!.upcomingActivities![index].activities![ind].banners![0],
                                                placeholder: (context, url) => Shimmer.fromColors(
                                                  baseColor: grey300,
                                                  highlightColor: grey100,
                                                  child: Container(
                                                    color: grey300,
                                                  ),
                                                ),
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
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: clrWhite,
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      profileController.profileData.value.result?.upcomingActivities?[index].activities?[ind].name.toString() ?? '',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),
                                                    Text(
                                                        profileController.profileData.value.result!.upcomingActivities![index].activities![ind].location.toString() ?? '',
                                                        style: TextStyle(
                                                            color: clrGreyTextLight,
                                                            fontSize: 12)
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    profileController.profileData.value.result!.previousActivities!.isEmpty
                        ? SizedBox() : Text(
                      "Previous activities",
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    profileController.profileData.value.result!.previousActivities!.isEmpty
                        ? SizedBox()
                        : ListView.builder(
                        itemCount: profileController.profileData.value
                            .result?.previousActivities?.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileController.profileData.value.result!.previousActivities![index].formattedDate ?? '',
                                  style: TextStyle(color: clrGreyDark),
                                ),
                                SizedBox(
                                  height: Get.height * 0.003,
                                ),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: profileController.profileData.value
                                      .result?.previousActivities?[index].activities?.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,ind) {
                                   return InkWell(
                                     onTap: () {
                                       Get.toNamed(Routes.previousActivityUi,
                                           arguments: {
                                             "isHost": false,
                                             "id": profileController.profileData.value.result?.previousActivities?[index].activities?[ind].id.toString()
                                           });
                                     },
                                     child: Padding(
                                       padding: const EdgeInsets.only(top: 12),
                                       child: Row(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Container(
                                            //   clipBehavior: Clip.hardEdge,
                                            //   height: h * .075,
                                            //   width: h * .075,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius:
                                            //     BorderRadius.circular(10),
                                            //   ),
                                            //   child: Image.asset(
                                            //     "assets/images/parkimage.png",
                                            //     fit: BoxFit.cover,
                                            //   ),
                                            // ),
                                            Container(
                                              clipBehavior: Clip.hardEdge,
                                              height: h * .075,
                                              width: h * .075,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: profileController.profileData.value.result?.previousActivities?[index].activities?[ind].banners != null &&
                                                  profileController.profileData.value.result!.previousActivities![index].activities![ind].banners!.isNotEmpty
                                                  ? CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                memCacheWidth: 500,
                                                imageUrl: profileController.profileData.value.result!.previousActivities![index].activities![ind].banners![0],
                                                placeholder: (context, url) => Shimmer.fromColors(
                                                  baseColor: grey300,
                                                  highlightColor: grey100,
                                                  child: Container(
                                                    color: grey300,
                                                  ),
                                                ),
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
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: clrWhite,
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      profileController.profileData.value.result?.previousActivities?[index].activities?[ind].name.toString() ?? '',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),
                                                    Text(
                                                        profileController.profileData.value.result!.previousActivities![index].activities![ind].status.toString() ?? '',
                                                        style: TextStyle(
                                                            color: clrGreyTextLight,
                                                            fontSize: 12)
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                     ),
                                   );
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          );
                        }),
                    profileController.profileData.value.result!.previousActivities!.isNotEmpty || profileController.profileData.value.result!.upcomingActivities!.isNotEmpty ? SizedBox(
                      height: Get.height * 0.02,
                    ) : SizedBox(),
                  ],
                ),
              ),),
            ]))
          ],
        ),
      )),
    );
  }

  alertDeleteAccount() {
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
                  "Delete Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                    "Are you sure you want to delete your account?",
                    style: TextStyle(
                        color: clrGreyTextLight,
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
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
                            ontap: () {
                              Get.back();
                              controller.deleteUser();
                            },
                            borderClr: clrBlacke,
                            lable: Text(
                              "Yes",
                              style: TextStyle(
                                  color: clrBlacke,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            backgroundClr: Get.theme.scaffoldBackgroundColor),
                      )
                  ),
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

  verificationAlert() {
    return Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 65),
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: InkWell(
                onTap: () {
                  return Get.back();
                },
                child: const Icon(
                  Icons.close,
                  size: 25,
                )),
          ),
          SizedBox(
            height: Get.height * .013,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              child: Icon(
                Icons.verified,
                color: clrYellow,
                size: 40,
              ),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Social media account verified",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
