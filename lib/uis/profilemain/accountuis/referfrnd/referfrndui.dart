import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/profilemain/accountuis/referfrnd/controller/referfrnd_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../utils/colors.dart';

class ReferFrndUi extends GetWidget<ReferFrndController> {
  const ReferFrndUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
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
                const Text(
                  "Invite friends",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                ),
                SizedBox(
                  width: w * .07,
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Obx(
              () => controller.profileController.profileLoading.value && controller.profileController.profileData.value.result == null
                  ? Expanded(
                      child: Center(
                          child: CommonUi.scaffoldLoading(color: clrYellow)))
                  : controller.profileController.profileError.value.isNotEmpty
                      ? Expanded(child: SmartRefresher(
                  controller: controller.refreshController,
                  header: CommonUi.refreshHeader(),
                  onRefresh: () {
                    controller.refresh();
                  },
                  child: Center(child: ErrorScreen())))
                      : Expanded(
                        child: SmartRefresher(
                          controller: controller.refreshController1,
                          header: CommonUi.refreshHeader(),
                          onRefresh: () {
                            controller.refresh();
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                              children: [
                                const Image(
                                  image: AssetImage("assets/images/refer.png"),
                                ),
                                Text(
                                  "Invite friends and enjoy a free ${controller.getWeek(controller.profileController.profileData.value.result!.referralSetting!.referralDays!)} membership",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 18),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Text(
                                  "Once your friend sign up and successfully joins an event, you both receive ${controller.getWeek(controller.profileController.profileData.value.result!.referralSetting!.referralDays!)} of free membership.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14, color: clrGreyTextLight),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                SizedBox(
                                    width: double.maxFinite,
                                    height: Res.h_btn,
                                    child: CustomElevatedButton(
                                        onTap: () {
                                          // if(controller.profileController.profileData.value.result?.referCode != null) {
                                          //   Share.share(
                                          //       'https://urlsdemo.online/refer?refercode=${controller
                                          //           .profileController
                                          //           .profileData.value.result
                                          //           ?.referCode}');
                                          // }else{
                                          //   showTostMsg('You are not eligible for referral.');
                                          // }
                                          Share.share(
                                              'https://nbttech.xyz/refer?refercode=${controller
                                                  .profileController
                                                  .profileData.value.result
                                                  ?.referCode}');
                                        },
                                        backgroundClr: clrBlacke,
                                        child: Text(
                                          "Invite friends",
                                          style: TextStyle(
                                              color: clrWhite,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        )))
                              ],
                            ),
                        ),
                      ),
            )
          ],
        ),
      )),
    );
  }
}
