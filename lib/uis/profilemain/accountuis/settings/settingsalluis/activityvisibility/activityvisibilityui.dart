import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/controller/setting_controller.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/activityvisibility/controller/activityvisibility_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/custom_switch.dart';
import 'package:plusone/utils/size.dart';

import '../../../../../../utils/colors.dart';

class ActivityVisibility extends GetWidget<ActivityvisibilityController> {
  const ActivityVisibility({super.key});

  @override
  Widget build(BuildContext context) {
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
                    "Activities visibility",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.035,
              ),
              Expanded(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                          child: Text(
                        "Show my upcoming activities to other members",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const SizedBox(
                        width: 40,
                      ),
                      Obx(() => CustomSwitch(
                        value: controller.upcomingVisibility.value,
                        onChanged: (val) {
                          controller.changeUpcomingVisibility();
                        }
                      ),)
                    ],
                  ),
                  Divider(
                    color: clrGreyLight,
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                          child: Text(
                        "Show my previous activities to other members",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const SizedBox(
                        width: 45,
                      ),
                      Obx(() => CustomSwitch(
                        value: controller.previousVisibility.value,
                        onChanged: (value) {
                          controller.changePreviousVisibility();
                          },
                      ),)
                    ],
                  ),
                  Divider(
                    color: clrGreyLight,
                    height: 25,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
