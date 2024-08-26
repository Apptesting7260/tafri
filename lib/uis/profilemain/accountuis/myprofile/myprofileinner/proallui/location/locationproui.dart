import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/components/location_form_field.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../../../utils/colors.dart';
import '../../controller/myprofileinn_controller.dart';

class LocationProUi extends GetWidget<MyprofileInnController> {
  LocationProUi({super.key});

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
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () => controller.locController.text =
                          profilemainController
                              .profileData.value.result!.location
                              .toString(),
                    );
                  },
                ),
                const Text(
                  "Location",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: w * .06,
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
                    "Share where you are based to join activities nearby.",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  Form(
                    key: _formState,
                    child: CustomLocationField(
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.name.toString()),
                        );
                      },
                      suggestionsCallback: (value) async {
                        return controller.searchPlaces(value);
                      },
                      hintText: "Amsterdam, Netherlands",
                      controller: controller.locController,
                      validation: (val) {
                        if (val == null || val.isEmpty || val == '') {
                          return "Location is required";
                        }
                        return null;
                      },
                      onSelected: (value) {
                        controller.locController.text = value.name;
                      },
                      sufixIcon: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 13),
                          child: const Image(
                            image: AssetImage("assets/icons/locationicon.png"),
                            height: 1,
                            width: 1,
                          )),
                    ),
                  )
                ],
              ),
            ),
            Obx(() => Opacity(
              opacity: controller.locationLoading.value ? .5 : 1,
              child: SizedBox(
                  height: Res.h_btn,
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                      onTap: () async{
                        if (_formState.currentState!.validate()) {
                          // profilemainController
                          //         .profileData.value.result?.location =
                          //     controller.locController.value.text.trim();
                          // profilemainController.profileData.refresh();
                          // print(profilemainController
                          //     .profileData.value.result?.location);
                          // print(profilemainController.hashCode);
                          //
                          // Get.back();

                          await controller.locationUpdate();

                        }
                      },
                      backgroundClr: clrBlacke,
                      child: controller.locationLoading.value ? CommonUi.buttonLoading() : Text(
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
