import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/onbording/introone/intoone.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';
import 'package:shimmer/shimmer.dart';

class ProfileUi extends GetWidget<ProfilemainController> {
  const ProfileUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              const Text(
                "Account",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
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
                          width: w * .28,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: grey300,
                            highlightColor: grey100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                height: h * .13,
                                width: w * .28,
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
                                decoration: BoxDecoration(
                                    color: clrGrey,
                                    image: DecorationImage(image: AssetImage('assets/icons/dangericon.png'))
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(
                        "${controller.profileData.value.result?.firstName} ${controller.profileData.value.result?.lastName}",
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      SizedBox(
                        height: Get.height * 0.005,
                      ),
                      Text(
                        "${controller.profileData.value.result?.email}",
                        style: const TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  );
                }
              }),
              SizedBox(
                height: Get.height * 0.03,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.myprofileInnUi);
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
                                  fontSize: 15, fontWeight: FontWeight.w600),
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
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.myfavProui);
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
                            const Text("My favorites",
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
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.referFrndProUi);
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
                            const Text("Refer friends",
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
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.mymembershipProUi);
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
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.settingProUi);
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
                            const Text("Settings",
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
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.helpcenterProUi);
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
                            const Text("Help Center",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600)),
                            Image.asset('assets/icons/arrow right.png',height: 14,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
              SizedBox(
                width: double.maxFinite,
                height: Res.h_btn,
                child: CustomElevatedButton(
                    onTap: () {
                      GoogleSignIn().signOut();
                      LocalStorage.removeToken();
                      debugPrint(
                          "gk==getUid=${LocalStorage.getUid()}=token=${LocalStorage.getToken()}=");

                      if (LocalStorage.getToken() == null ||
                          LocalStorage.getUid() == null) {
                        Get.offAllNamed(Routes.initialPage);
                      }
                    },
                    backgroundClr: clrBlacke,
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: clrWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
