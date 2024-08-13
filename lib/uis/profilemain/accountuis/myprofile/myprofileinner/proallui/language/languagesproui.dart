import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/controller/myprofileinn_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../../../utils/colors.dart';
import 'models/langauagemodel.dart';

class LanguagesProUi extends GetWidget<MyprofileInnController> {
  LanguagesProUi({super.key});

  SingleSelectController cutoDropController = SingleSelectController(null);
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      body: Obx(() {
        return controller.isLanLoading.value == true
            ? Center(
                child: CommonUi.scaffoldLoading(color: clrYellow),
              )
            : SafeArea(
                child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonUi.appBar(),
                        const Text(
                          "Languages",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
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
                      child: Column(
                        children: [
                          const Text(
                            "Share what languages you speak and find members who share common languages.",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          CustomDropdown.search(
                            initialItem: null,
                            controller: cutoDropController,
                            closedHeaderPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: h * .017),
                            closeDropDownOnClearFilterSearch: true,
                            hideSelectedFieldWhenExpanded: true,
                            decoration: CustomDropdownDecoration(
                                closedSuffixIcon:
                                    const Icon(Icons.arrow_drop_down_outlined),
                                expandedSuffixIcon:
                                    const Icon(Icons.arrow_drop_up),
                                closedFillColor: clrGreyLight,
                                closedBorderRadius: BorderRadius.circular(100)),
                            hintText: 'Select language',
                            items: controller.langListData.value.result
                                ?.where((language) => language.status == '1')
                                .map((e) {
                              return e.name;
                            }).toList(),
                            excludeSelected: false,
                            onChanged: (value) {
                              if (value != null) {
                                var selectedLanguage = controller
                                    .langListData.value.result
                                    ?.firstWhere(
                                        (language) => language.name == value);
                                if (selectedLanguage != null) {
                                  if (controller.selectedLanguageID
                                      .contains(selectedLanguage.id)) {
                                    // controller.selectedLanguageID
                                    //     .remove(selectedLanguage.id);
                                  } else {
                                    controller.selectedLanguageID
                                        .add(selectedLanguage.id.toString());
                                  }
                                }
                                print('lan == ${controller.selectedLanguageID}');
                              }

                              if (value != null) {
                                if (controller.selectedLanguageList
                                    .any((map) => map.containsValue(value))) {
                                } else {
                                  int len = controller.langListData.value
                                          .result?.length ??
                                      0;
                                  for (int i = 0; i < len; i++) {
                                    Result? singleDeta = controller
                                        .langListData.value.result?[i];
                                    if (value.toString().toLowerCase() ==
                                        singleDeta?.name?.toLowerCase()) {
                                      controller.selectedLanguageList.add({
                                        'id': singleDeta?.id,
                                        "lang": singleDeta?.name
                                      });
                                      log("gk===selectedLanguageList==${controller.selectedLanguageList}");
                                    }
                                  }
                                }
                              }
                              print('changing value to: ${controller.selectedLanguageList}');
                              cutoDropController.value = null;
                            },
                          ),
                          controller.isShowLangReqError.value
                              ? SizedBox(
                                  width: double.maxFinite,
                                  child: Text(
                                    "Please select atleast one language",
                                    style: TextStyle(
                                        color: clrRedErr, fontSize: 12),
                                  ))
                              : SizedBox(),
                          SizedBox(
                            height: h * .02,
                          ),
                          Obx(() {
                            List<Widget> lst = [];
                            for (int i = 0;
                                i < controller.selectedLanguageList.length;
                                i++) {
                              var singelDeta =
                                  controller.selectedLanguageList[i];
                              lst.add(Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                    color: clrBlacke,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: clrWhite,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: const Icon(
                                        Icons.check,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * .01,
                                    ),
                                    Text(
                                      "${singelDeta['lang']}",
                                      style: TextStyle(color: clrWhite),
                                    ),
                                    SizedBox(
                                      width: w * .01,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          controller.removeSelectLan(i);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: clrWhite,
                                          size: 20,
                                        )),
                                  ],
                                ),
                              ));
                            }
                            return SizedBox(
                                width: double.maxFinite,
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  runSpacing: h * .005,
                                  spacing: w * .013,
                                  children: lst,
                                ));
                          })
                        ],
                      ),
                    ),
                    SizedBox(
                        height: Res.h_btn,
                        width: double.maxFinite,
                        child: CustomElevatedButton(
                            onTap: () {
                              if (controller.selectedLanguageList.isEmpty) {
                                controller.changeIsShowLangError(true);
                              } else {
                                controller.changeIsShowLangError(false);
                                Get.back();
                              }
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
              ));
      }),
    );
  }
}
