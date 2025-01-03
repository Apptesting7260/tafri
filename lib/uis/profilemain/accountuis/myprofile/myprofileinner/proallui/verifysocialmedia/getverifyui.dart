import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/controller/myprofileinn_controller.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/custom_switch.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import '../../../../../../../utils/colors.dart';

class GetVerifyUi extends GetWidget<MyprofileInnController> {
  GetVerifyUi({super.key});

  final ProfilemainController profilemainController = Get.find<ProfilemainController>();

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
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonUi.appBar(),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                const Text(
                  "Get verified for a safer",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    const Text(
                      "community",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.verified,
                      color: clrYellow,
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.018,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      const Text(
                        "Help keep our community secure and authentic by optionally verifying your social media accounts. Your information will remain private, and you’ll receive a badge on your profile.",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/insta.png",
                            height: h * .033,
                          ),
                          SizedBox(
                            width: w * .04,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Instagram",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Obx(() {
                                  return CustomSwitch(
                                    value: controller.isInstaVerified.value == 1
                                        ? true
                                        : false,
                                    onChanged: (val) {
                                      controller.changeVerifyInsta(
                                          controller.isInstaVerified.value == 1
                                              ? 0
                                              : 1);
                                      },
                                  );
                                })
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: h * .04,
                        color: clrGreyLight,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/linkdin.png",
                            height: h * .033,
                          ),
                          SizedBox(
                            width: w * .04,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "LinkedIn",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Obx(() {
                                  return CustomSwitch(
                                    value: controller.isLinkdinVerified.value == 1
                                        ? true
                                        : false,
                                    onChanged: (val) {
                                      controller.changeVerifyLinkdin(context,
                                          controller.isLinkdinVerified.value == 1
                                              ? 0
                                              : 1);
                                      },
                                  );
                                })
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: h * .04,
                        color: clrGreyLight,
                      )
                    ],
                  ),
                ),
                Obx(() => Opacity(
                  opacity: controller.socialLoading.value ? .5 : 1,
                  child: SizedBox(
                      height: Res.h_btn,
                      width: double.maxFinite,
                      child: CustomElevatedButton(
                          onTap: () {
                              controller.socialUpdate();
                          },
                          backgroundClr: clrBlacke,
                          child: controller.socialLoading.value ? CommonUi.buttonLoading() : Text(
                            "Save",
                            style: TextStyle(
                                color: clrWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                            ),
                          )
                      )
                  ),
                ),),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
      ),
    );
  }
}
