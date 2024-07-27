import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/controller/myprofileinn_controller.dart';
import 'package:plusone/utils/common.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../../utils/size.dart';
import 'models/activitymodel.dart';

class ActivityInterestUi extends GetWidget<MyprofileInnController> {
  const ActivityInterestUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SafeArea(child: Obx(() {
        return controller.isLoadingActivity.value
            ? Center(
                child: Container(
                  color: clrBlacke,
                  child: CommonUi.fourDotLoading(),
                ),
              )
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                child: Column(
                  children: [
                    SizedBox(
                      height: h * .012,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: h * .05,
                            height: h * .05,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: clrGreyLight,
                                borderRadius: BorderRadius.circular(10)),
                            child:
                                const Center(child: Icon(Icons.arrow_back_ios)),
                          ),
                        ),
                        const Text(
                          "Activity interests",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: h * .024,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Expanded(
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Add 3 to 10 activities you are interested in partnering with others",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Obx(() {
                            int len = controller
                                    .activityListData.value.result?.length ??
                                0;
                            return ListView.builder(
                                itemCount: len,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Result? categoryDeta = controller
                                      .activityListData.value.result?[index];
                                  int subCategoryListLength =
                                      categoryDeta?.subcategories?.length ?? 0;
                                  List<Widget> wrapSubCatList = [];
                                  for (int i = 0;
                                      i < subCategoryListLength;
                                      i++) {
                                    Subcategories? singleSubCatData =
                                        categoryDeta?.subcategories?[i];
                                    wrapSubCatList.add(SizedBox(
                                        height: 36,
                                        child: CustoFilterBtn(
                                          lable: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.network(
                                                "${singleSubCatData?.icon}",
                                                height: 16,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "${singleSubCatData?.title}",
                                                style:
                                                    TextStyle(color:singleSubCatData?.isSelected==true?clrWhite : clrBlacke),
                                              )
                                            ],
                                          ),
                                          ontap: () {
                                            controller.changeActivitySelect(index, categoryDeta?.id, i, singleSubCatData?.id, singleSubCatData?.isSelected==false?true:false);
                                          },
                                          backgroundClr:singleSubCatData?.isSelected==true?clrBlacke : clrWhite,
                                          borderClr: clrBlacke.withOpacity(0.2),
                                        )));
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${categoryDeta?.title}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: wrapSubCatList,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.015,
                                      ),
                                    ],
                                  );
                                });
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: Res.h_btn,
                        width: double.maxFinite,
                        child: CustoElevatedBtn(
                            onTap: () {},
                            backgroundClr: clrBlacke,
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: clrWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ))),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                  ],
                ),
              );
      })),
    );
  }
}
