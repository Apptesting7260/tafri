import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../../../utils/colors.dart';
import '../../controller/myprofileinn_controller.dart';

class BioUi extends GetWidget<MyprofileInnController> {
  BioUi({super.key});

  final _formState = GlobalKey<FormState>();
  final ProfilemainController profilemainController =
      Get.find<ProfilemainController>();
  int maxLength = 350;

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    print(profilemainController
        .profileData.value.result?.profile?.bio);
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
                      () => controller.bioController.value.text =
                          profilemainController
                                  .profileData.value.result?.profile?.bio ??
                              '',
                    );
                  },
                ),
                const Text(
                  "Bio",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: w * .06,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Share a bit about yourself helps members understand you better and find like-minded activity partners.",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Form(
                      key: _formState,
                      child: Obx(() {
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            TextFormField(
                              controller: controller.bioController.value,
                              validator: (val) {
                                if (val == null || val.isEmpty || val == '') {
                                  return "Please tell about yourself";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.multiline,
                              minLines: 8,
                              maxLines: 20,
                              maxLength: maxLength,
                              decoration: InputDecoration(
                                hintText: "Introduce yourself...",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: clrGreyTextLight),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                fillColor: clrGreyLight,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10)),
                                counterText: '',
                                // Error border
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // Error border when focused
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) {
                                print(
                                    'object == ${controller.bioController.value.text.length}');
                              },
                            ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 15, right: 15),
                                child: Text(
                                  '${controller.currentLength.value}/$maxLength',
                                  style: TextStyle(
                                      fontSize: 13, color: clrGreyTextLight),
                                )
                            )
                          ],
                        );
                      },),
                    )
                  ],
                ),
              ),
            ),
           Obx(() =>  Opacity(
             opacity:  controller.bioLoading.value ? .5 : 1,
             child: SizedBox(
                 height: Res.h_btn,
                 width: double.maxFinite,
                 child: CustomElevatedButton(
                     onTap: () async{
                       // if(_formState.currentState!.validate()){
             
                       // profilemainController.profileData.value.result?.profile
                       //     ?.bio = controller.bioController.value.value.text.trim();
                       // print(controller.bioController.value.text.trim());
                       // profilemainController.profileData.refresh();
                       // print(profilemainController
                       //     .profileData.value.result?.profile?.bio);
                       // print(profilemainController.hashCode);

                       if(_formState.currentState!.validate()) {
                         await controller.bioProfile();
                       }
             
                       // }
                     },
                     backgroundClr: clrBlacke,
                     child: controller.bioLoading.value
                         ? CommonUi.buttonLoading()
                         : Text(
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
