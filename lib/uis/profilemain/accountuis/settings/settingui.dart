import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/custom_switch.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/size.dart';
import '../../../components/custoelevatedbtn.dart';
import '../../../components/custofilterbtn.dart';
import 'controller/setting_controller.dart';

class SettingUi extends GetWidget<SettingController>{
  const SettingUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SafeArea(
          child: Padding(
            padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
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
                      "Settings",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                    ),
                      SizedBox(
                      width:h*.025,
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Text(
                          "Notifications ",
                          style: TextStyle(fontSize: 14, color: clrGreyTextLight),
                        ),
                        Divider(
                          color: clrGreyLight,
                          height: 21,
                        ),
                        InkWell(
                            onTap: () {
                              Get.toNamed(Routes.pushNotiSettingUi);
                            },
                            child: Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: const Text(
                                "Push notifications",
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                              ),
                            )),
                        Divider(
                          color: clrGreyLight,
                          height: h*.025,
                        ),
                        const Text(
                          "Email",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          color: clrGreyLight,
                          height:h*.04,
                        ),
                          SizedBox(
                          height:h*.012,
                        ),
                        Text(
                          "Add other login options",
                          style: TextStyle(fontSize: 14, color: clrGreyTextLight),
                        ),
                        SizedBox(
                          height: h*.007,
                        ),
                        Divider(
                          color: clrGreyLight,
                          height:h*.016,
                        ),
                        InkWell(
                          onTap: () {
                            googlePermissionAlert();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Google",
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                ),
                                Obx(() => CustomSwitch(value: controller.googleVal.value, onChanged: (val) {
                                  controller.changeGoogleVal();
                                },))
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: clrGreyLight,
                          height: h*.016,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Apple",
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                            ),
                            Obx((){
                              return CustomSwitch(value: controller.appleVal.value, onChanged: (val) {
                                controller.changeAppleVal();
                              },);
                            })
                          ],
                        ),
                        Divider(
                          color: clrGreyLight,
                          height: h*.03,
                        ),
                          SizedBox(
                          height:h*.012,
                        ),
                        Text(
                          "Legal",
                          style: TextStyle(fontSize: 14, color: clrGreyTextLight),
                        ),
                        Divider(
                          color: clrGreyLight,
                          height: h*.037,
                        ),
                        const Text(
                          "Terms & conditions ",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          color: clrGreyLight,
                          height: h*.037,
                        ),
                        const Text(
                          "Privacy policy ",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          color: clrGreyLight,
                          height: h*.037,
                        ),
                        const Text(
                          "Community Guidelines ",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          color: clrGreyLight,
                          height:h*.037,
                        ),
                          SizedBox(
                          height:h*.012,
                        ),
                        Text(
                          "Privacy",
                          style: TextStyle(fontSize: 14, color: clrGreyTextLight),
                        ),
                        Divider(
                          color: clrGreyLight,
                          height: h*.021,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.activityVisibilitySettingUi);
                          },
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              "Activity visibility on profile",
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Divider(
                          color: clrGreyLight,
                          height: h*.021,
                        ),
                          SizedBox(
                          height:h*.012,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
  googlePermissionAlert() {
    return Get.dialog(AlertDialog(
      backgroundColor: clrWhite,
      contentPadding: const EdgeInsets.symmetric(horizontal: 25,vertical: 25),
      insetPadding: const EdgeInsets.symmetric(horizontal: 13),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: Text(
              """"PlusOnes" wants to use 
"google.com" to log in""",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          const Center(
              child: Text(
                "This allows the app to share information about you.",
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: CustoFilterBtn(
                    ontap: () {
                      Get.back();
                    },
                    borderClr: clrBlacke,
                    backgroundClr: clrWhite,
                    lable: Text(
                      "Cancel",
                      style: TextStyle(color: clrBlacke),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: CustomElevatedButton(
                    onTap: () {
                      Get.back();
                    },
                    backgroundClr: clrBlacke,
                    child: Text(
                      "Continue",
                      style: TextStyle(color: clrWhite),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
