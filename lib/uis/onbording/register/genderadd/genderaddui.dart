import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../components/custoelevatedbtn.dart';
import '../../../components/custotextfield.dart';
import '../../introone/intoone.dart';
import 'controller/genderadd_controller.dart';

class GenderAddUi extends GetWidget<GenderaddController> {
  GenderAddUi({super.key});

  final _formKey = GlobalKey<FormState>();
  final _fromKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: h * .01,
                      ),
                      CommonUi.appBar(),
                      SizedBox(
                        height: h * .04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: h * .008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrYellow),
                          ),
                          Container(
                            height: h * .008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrYellow),
                          ),
                          Container(
                            height: h * .008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                          ),
                          Container(
                            height: h * .008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * .04,
                      ),
                      const Text(
                        "What gender describes you best?",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: h * .02,
                      ),
                      const Text(
                        "Your gender helps us create a more personalised and inclusive experience for you and other members.",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: h * .04,
                      ),
                      Column(
                        children: [
                          Obx(() {
                            return SizedBox(
                                // height: Res.h_btn,
                                child: Form(
                              key: _formKey,
                              child: DropdownButtonFormField(
                                validator: (val) {
                                  log("gk---$val");
                                  if (val == null ||
                                      controller.genderValue.value == '') {
                                    return "Gender is required";
                                  } else {
                                    return null;
                                  }
                                },
                                value: controller.genderValue.value!.isEmpty
                                    ? null
                                    : controller.genderValue.value,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'male',
                                    child: Text("Male"),
                                  ),
                                  DropdownMenuItem(
                                    value: 'female',
                                    child: Text("Female"),
                                  ),
                                  DropdownMenuItem(
                                    value: 'none-binary',
                                    child: Text("None-binary"),
                                  ),
                                  DropdownMenuItem(
                                    value: 'other',
                                    child: Text("Other"),
                                  )
                                ],
                                hint: const Text("Gender",style:TextStyle(
                                  fontWeight: FontWeight.w500
                                ) ,),
                                onChanged: (val) {
                                  controller.changeGenderVal(val);
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: h * .02),
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/icons/gendericon.png"),
                                          height: 3,
                                          width: 3,
                                        )),
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: clrGreyTextLight),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    fillColor: clrGreyLight,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(100))),
                              ),
                            ));
                          }),
                          Obx(() {
                            return controller.genderValue.value == 'other'
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: h * .025,
                                      ),
                                      SizedBox(
                                        // height: Res.h_btn,
                                        child: Form(
                                          key: _fromKey1,
                                          child: CustoTextFormField(
                                            validation: (val) {
                                              if (val == null || val.isEmpty) {
                                                return "Gender is required";
                                              } else {
                                                return null;
                                              }
                                            },
                                            hintText: "Enter your Gender",
                                            sufixIcon: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 10),
                                                child: const Image(
                                                  image: AssetImage(
                                                      "assets/icons/gendericon.png"),
                                                  height: 3,
                                                  width: 3,
                                                )),
                                            controll:
                                                controller.genderController,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox();
                          }),
                        ],
                      ),
                      SizedBox(
                        height: h * .03,
                      ),
                      Obx(
                        () => Opacity(
                          opacity: controller.loading.value ? 0.50 : 1,
                          child: SizedBox(
                              width: double.maxFinite,
                              height: Res.h_btn,
                              child: CustoElevatedBtn(
                                  onTap: () {
                                    if (!controller.loading.value) {
                                      if (controller.genderValue.value ==
                                          'other') {
                                        final validate = _fromKey1.currentState!
                                                .validate() &&
                                            _formKey.currentState!.validate();
                                        if (validate) {
                                          controller.registerGender();
                                        }
                                      } else if (_formKey.currentState!
                                          .validate()) {
                                        controller.registerGender();
                                      }
                                    }
                                  },
                                  backgroundClr: clrBlacke,
                                  child: Obx(
                                    () => controller.loading.value
                                        ? CommonUi.fourDotLoading()
                                        : Text(
                                            "Continue",
                                            style: TextStyle(
                                                color: clrWhite,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16),
                                          ),
                                  ))),
                        ),
                      ),
                      SizedBox(
                        height: h * .025,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.visibility_outlined,
                            color: clrYellow,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  width: Get.width * 0.8,
                                  child: Text(
                                      "Your gender will be visible to other members",
                                      style: TextStyle(color: clrBlacke))),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",
                          style: TextStyle(
                              color: clrGreyDark,
                              fontWeight: FontWeight.w400,
                              fontSize: 12)),
                      InkWell(
                          onTap: () {
                            Get.offAllNamed(Routes.initialPage);
                          },
                          child: Text("Log In",
                              style: TextStyle(
                                  color: clrYellowText,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)))
                    ],
                  ),
                  SizedBox(
                    height: h * .02,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
