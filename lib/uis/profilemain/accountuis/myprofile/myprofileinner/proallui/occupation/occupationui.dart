import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/controller/myprofileinn_controller.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

import '../../../../../../../utils/colors.dart';

class OccupationUi extends GetWidget<MyprofileInnController> {
  OccupationUi({super.key});

  final _formState = GlobalKey<FormState>();
  final ProfilemainController profilemainController =
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
                CommonUi.appBar(
                  onTap: () {
                    Get.back();
                    Future.delayed(const Duration(milliseconds: 100),(){
                      controller.organiController.text = profilemainController.profileData.value.result?.profile?.organisationName ?? '';
                      controller.ocupatController.text = profilemainController.profileData.value.result?.profile?.occupation ?? '';
                    } ,);
                  },
                ),
                const Text(
                  "Occupation",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.035,
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Share your current occupation. This can be your job, education, or other roles. ",
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  Form(
                    key: _formState,
                    child: CustoTextFormField(
                      controll: controller.ocupatController,
                      validation: (val) {
                        if (val == null || val.isEmpty || val == '') {
                          return "Please enter your occupation";
                        }
                        return null;
                      },
                      hintText: "Occupation",
                      sufixIcon: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 10,top: 13,bottom: 13),
                        child: Image.asset(
                          "assets/icons/bagicon.png",
                          height: h * .02,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustoTextFormField(
                    controll: controller.organiController,
                    hintText: "Organisation (optional)",
                    sufixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 10,top: 13,bottom: 13),
                      child: Image.asset("assets/icons/buildingicon.png",height: 10,),
                    ),
                  )
                ],
              ),
            ),
            Obx(() => Opacity(
              opacity: controller.occLoading.value ? .5 : 1,
              child: SizedBox(
                  height: Res.h_btn,
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                      onTap: () async{
                        if (_formState.currentState!.validate()) {
                          // profilemainController.profileData.value.result?.profile
                          //     ?.occupation = controller.ocupatController.value.text.trim();
                          // profilemainController.profileData.value.result?.profile?.organisationName = controller.organiController.value.text.trim();
                          // profilemainController.profileData.refresh();
                          // Get.back();

                          await controller.occUpdate();

                        }
                      },
                      backgroundClr: clrBlacke,
                      child: controller.occLoading.value ? CommonUi.buttonLoading() : Text(
                        "Save",
                        style: TextStyle(
                            color: clrWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ))),
            ),),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}
