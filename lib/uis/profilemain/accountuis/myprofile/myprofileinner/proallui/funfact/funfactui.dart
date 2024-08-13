import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/controller/myprofileinn_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

import '../../../../../../../utils/colors.dart';
import '../../../../../../components/custodropdownbtn.dart';

class FunFactUi extends GetWidget<MyprofileInnController> {
  const FunFactUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus,
      child: Scaffold(body: SafeArea(
        child: Obx(() {
          if(controller.isLoadingFunFactQuest.value){
            return Center(
              child: CommonUi.scaffoldLoading(color: clrYellow),
            );
          }
          return Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonUi.appBar(),
                    const Text(
                      "Fun facts about me",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: w * .04,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Res.Defalt_side_margin),
                      child: const Text(
                          "Answer 1-3 fun fact questions to show your personality and help others get to know you"),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    ListView.builder(
                        itemCount: controller.funFactListDeta.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: Res.Defalt_side_margin),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight),
                                    child: Column(
                                      children: [
                                        CustoDropDownBtn(
                                            onchange: (val) {
                                              // controller.funFactListDeta[index]['question'] = val.toString();
                                            },
                                            itemList: controller.questionList,
                                            hindtext: "Select Question",
                                          suffix: Image.asset('assets/images/arrow down.png',scale: 4,),
                                        ),
                                        SizedBox(
                                          height: h * .012,
                                        ),
                                        Divider(
                                          color: clrGrey.withOpacity(0.3),
                                        ),
                                        CustoTextFormField(
                                          hintText: "Enter your answer",
                                          maxLines: 3,
                                          onChanged: (value) {
                                            // controller.funFactListDeta[index]['answer'] = value;
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 15,
                                    top: -5,
                                    child: InkWell(
                                      onTap: () {
                                        log("gk-==$index");
                                        // controller.removeFunFactDeta(index);
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: clrBlacke,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: Icon(
                                            Icons.close,
                                            color: clrWhite,
                                            size: 19,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Res.Defalt_side_margin),
                      child: InkWell(
                        onTap: () {
                          controller.addFunFactDeta('', '', '');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: clrYellow,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Icons.add,
                                  color: clrWhite,
                                  size: 18,
                                )),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text("Add new question")
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: SizedBox(
                    height: Res.h_btn,
                    width: double.maxFinite,
                    child: CustomElevatedButton(
                        onTap: () {

                        },
                        backgroundClr: clrBlacke,
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: clrWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ))),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }),
      )),
    );
  }
}
