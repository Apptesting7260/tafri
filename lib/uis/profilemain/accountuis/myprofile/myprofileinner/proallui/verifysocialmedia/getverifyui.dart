import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/controller/myprofileinn_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../../../utils/colors.dart';

class GetVerifyUi extends GetWidget<MyprofileInnController> {
  const GetVerifyUi({super.key});

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
                            SizedBox(
                                height: h * .044,
                                child: FittedBox(child: Obx(() {
                                  return Switch(
                                    activeTrackColor: clrYellow,
                                    value: controller.isInstaVerified.value == 1
                                        ? true
                                        : false,
                                    onChanged: (val) {
                                      controller.changeVerifyInsta(
                                          controller.isInstaVerified.value == 1
                                              ? 0
                                              : 1);
                                    },
                                    activeColor: clrWhite,
                                    focusColor: clrWhite,
                                    inactiveThumbColor: clrWhite,
                                    trackOutlineColor:
                                        WidgetStateProperty.all(clrTransparent),
                                    inactiveTrackColor: clrTrack,
                                  );
                                })))
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
                            SizedBox(
                                height: h * .044,
                                child: FittedBox(child: Obx(() {
                                  return Switch(
                                    activeTrackColor: clrYellow,
                                    value:
                                        controller.isLinkdinVerified.value == 1
                                            ? true
                                            : false,
                                    onChanged: (val) {
                                      controller.changeVerifyLinkdin(
                                          controller.isLinkdinVerified.value ==
                                                  1
                                              ? 0
                                              : 1);
                                    },
                                    activeColor: clrWhite,
                                    trackOutlineColor:
                                        WidgetStateProperty.all(clrTransparent),
                                    focusColor: clrWhite,
                                    inactiveThumbColor: clrWhite,
                                    inactiveTrackColor: clrTrack,
                                  );
                                })))
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
            SizedBox(
                height: Res.h_btn,
                width: double.maxFinite,
                child: CustomElevatedButton(
                    onTap: () {
                      Get.back();
                    },
                    backgroundClr: clrBlacke,
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: clrWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ))),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}
