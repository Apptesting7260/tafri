import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/onbording/introone/intoone.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';

class ProfileUi extends GetWidget<ProfilemainController>{
  const ProfileUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;

    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding:EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  const Text(
                    "Account",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: h*.12,
                    width:h*.12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/proimg.png"),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  const Text(
                    "Kayla Wood",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Text(
                    "kaylawood@gmail.com",
                    style: TextStyle(color: clrGreyTextLight,fontSize: 13),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.myprofileInnUi);
                    },
                    child: Container(
                      height: Res.h_btn,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: clrGreyLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/manicon.png",
                            height: 19,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("My profile",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.myfavProui);

                    },
                    child: Container(
                      height: Res.h_btn,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: clrGreyLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/fav.png",
                            height: 19,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("My favorites",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.to(() {
                  //       return const YourActivityListUi();
                  //     });
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  //     decoration: BoxDecoration(
                  //         color: clrGreyLight,
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: Row(
                  //       children: [
                  //         Image.asset(
                  //           "assets/icons/manicon.png",
                  //           height: 19,
                  //         ),
                  //         SizedBox(
                  //           width: Get.width * 0.03,
                  //         ),
                  //         const Expanded(
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text("Your Activity"),
                  //               Icon(Icons.arrow_right)
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: Get.height * 0.015,
                  // ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.referFrndProUi);

                    },
                    child: Container(
                      height: Res.h_btn,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: clrGreyLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/manicon.png",
                            height: 19,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Refer friends",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.mymembershipProUi);

                    },
                    child: Container(
                      height: Res.h_btn,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: clrGreyLight,
                          borderRadius: BorderRadius.circular(20)),
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
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("My membership",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.settingProUi);
                    },
                    child: Container(
                      height: Res.h_btn,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: clrGreyLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/setting.png",
                            height: 19,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Settings",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)), Icon(Icons.arrow_right)],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.helpcenterProUi);
                    },
                    child: Container(
                      height: Res.h_btn,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: clrGreyLight,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/custocare.png",
                            height: 19,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Help Center",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: Res.h_btn,
                    child: CustoElevatedBtn(
                        onTap: () {
                          LocalStorage.removeToken();
                          debugPrint("gk==getUid=${LocalStorage.getUid()}=token=${LocalStorage.getToken()}=");

                          if(LocalStorage.getToken()==null || LocalStorage.getUid()==null){
                                Get.offAllNamed(Routes.initialPage);
                          }
                        },
                        backgroundClr: clrBlacke,
                        child: Text(
                          "Logout",
                          style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),
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
