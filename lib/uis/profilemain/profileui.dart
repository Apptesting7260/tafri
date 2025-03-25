import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:signin_with_linkedin/signin_with_linkedin.dart';

class ProfileUi extends GetWidget<ProfilemainController> {
  ProfileUi({super.key});

  final ExploreListController homeController = Get.find<ExploreListController>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;

    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.03,
                ),
                const Text(
                  "Account",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Obx(() {
                  if (controller.profileLoading.value) {
                    return Shimmer.fromColors(
                      baseColor: grey300,
                      highlightColor: grey100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            maxRadius: 50,
                            minRadius: 40,
                            backgroundColor: clrGrey,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            width: 100,
                            height: 20,
                            color: clrGrey,
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          Container(
                            width: 150,
                            height: 15,
                            color: clrGrey,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: '${controller.profileData.value.result?.profile?.profilePhoto}',
                            fit: BoxFit.cover,
                            height: h * .13,
                            width: h * .13,
                            memCacheWidth: 500,
                            placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: grey300,
                                highlightColor: grey100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    height: h * .13,
                                    width: h * .13,
                                    color: clrGrey,
                                  ),
                                )
                            ),
                            errorWidget: (context, url, error) {
                              print('error == $error');
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  height: h * .13,
                                  width: w * .28,
                                  color: clrGreyLight,
                                  child: Image.asset('assets/icons/manicon.png',color: clrGrey),
                                ),
                              );
                              },
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        if(controller.profileData.value.result?.firstName != null && controller.profileData.value.result?.lastName != null)
                          Text(
                            "${controller.profileData.value.result?.firstName} ${controller.profileData.value.result?.lastName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20
                            ),
                          ),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        if(controller.profileData.value.result?.email != null)
                          Text(
                            "${controller.profileData.value.result?.email}",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15
                            ),
                          ),
                      ],
                    );
                  }
                }),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    header: CommonUi.refreshHeader(),
                    onRefresh: () async{
                      await controller.viewProfile();
                      await homeController.homePageApi();
                      controller.refreshController.refreshCompleted();
                    },
                    child: ListView(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.myprofileInnUi)?.then((value) {
                              homeController.homePageApi();
                            },);
                          },
                          child: Container(
                            height: Res.h_btn,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                color: clrGreyLight,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/manicon.png",
                                  height: 19,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "My profile",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/icons/arrow right.png',
                                        height: 14,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.017,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.myfavProui);
                          },
                          child: Container(
                            height: Res.h_btn,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                color: clrGreyLight,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/fav.png",
                                  height: 19,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                          "My favorites",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600
                                          )
                                      ),
                                      Image.asset(
                                        'assets/icons/arrow right.png',
                                        height: 14,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.017,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.referFrndProUi);
                          },
                          child: Container(
                            height: Res.h_btn,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                color: clrGreyLight,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/manicon.png",
                                  height: 19,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                          "Refer friends",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600
                                          )
                                      ),
                                      Image.asset(
                                        'assets/icons/arrow right.png',
                                        height: 14,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.017,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.mymembershipProUi)?.then((value) {
                              controller.viewProfile();
                              homeController.homePageApi();
                            },);
                          },
                          child: Container(
                            height: Res.h_btn,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                color: clrGreyLight,
                                borderRadius: BorderRadius.circular(100)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/tajicon.png",
                                  height: 19,
                                  color: clrBlacke,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("My membership",
                                          style: TextStyle(

                                              fontSize: 15, fontWeight: FontWeight.w600)),
                                      Image.asset(
                                        'assets/icons/arrow right.png',
                                        height: 14,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.017,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.settingProUi);
                          },
                          child: Container(
                            height: Res.h_btn,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                color: clrGreyLight,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/setting.png",
                                  height: 19,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                          "Settings",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600
                                          )
                                      ),
                                      Image.asset(
                                        'assets/icons/arrow right.png',
                                        height: 14,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.017,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.helpcenterProUi);
                          },
                          child: Container(
                            height: Res.h_btn,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                color: clrGreyLight,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/custocare.png",
                                  height: 19,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                          "Help Center",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600
                                          )
                                      ),
                                      Image.asset(
                                        'assets/icons/arrow right.png',
                                        height: 14,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.017,
                        ),
                        Obx(() => GestureDetector(
                          onTap: () {
                            controller.logout();
                          },
                          child: Container(
                            height: Res.h_btn,
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                                color: clrGreyLight,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: controller.logoutloading.value ? Center(child: CommonUi.buttonLoading(color: clrBlacke)) : Row(
                              children: [
                                Image.asset(
                                  "assets/images/logout_new.png",
                                  height: 19,
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                          "Logout",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600
                                          )
                                      ),
                                      Image.asset(
                                        'assets/icons/arrow right.png',
                                        height: 14,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),),
                        SizedBox(
                          height: Get.height * 0.025,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
