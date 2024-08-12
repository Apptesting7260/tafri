import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/controller/myprofileinn_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:shimmer/shimmer.dart';
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
                child: CommonUi.scaffoldLoading(color: clrYellow),
              )
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
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
                      height: Get.height * 0.025,
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
                                    .activityListData.value.result?.where((category) => category.status == '1',).length ??
                                0;
                            return ListView.builder(
                                itemCount: len,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  List<Result>? categoryDeta = controller
                                      .activityListData.value.result?.where((category) => category.status == '1',).toList();
                                  int subCategoryListLength =
                                      categoryDeta?[index].subcategories?.where((subCategory) => subCategory.status == '1',).length ?? 0;
                                  List<Widget> wrapSubCatList = [];
                                  for (int i = 0;
                                      i < subCategoryListLength;
                                      i++) {
                                    List<Subcategories>? singleSubCatData =
                                        categoryDeta?[index].subcategories?.where((subCategory) => subCategory.status == '1',).toList();
                                    wrapSubCatList.add(SizedBox(
                                        height: 36,
                                        child: CustoFilterBtn(
                                          lable: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: CachedNetworkImage(
                                                  height: 18,
                                                  width: 18,
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      '${singleSubCatData?[i].icon}',
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor: grey300,
                                                    highlightColor: grey100,
                                                    child: Container(
                                                      height: 18,
                                                      width: 18,
                                                      decoration: BoxDecoration(
                                                        color: grey300,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                18),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "${singleSubCatData?[i].title}",
                                                style: TextStyle(
                                                    color: singleSubCatData
                                                                ?[i].isSelected ==
                                                            true
                                                        ? clrWhite
                                                        : clrBlacke),
                                              )
                                            ],
                                          ),
                                          ontap: () {
                                            singleSubCatData?[i].isSelected = !(singleSubCatData[i].isSelected ?? false);
                                            controller.updateSelectedSubcategories(singleSubCatData?[i].categoryId.toString(), singleSubCatData?[i].id.toString(), singleSubCatData?[i].isSelected);
                                          },
                                          backgroundClr:
                                              singleSubCatData?[i].isSelected ==
                                                      true
                                                  ? clrBlacke
                                                  : clrWhite,
                                          borderClr: clrBlacke.withOpacity(0.2),
                                        )));
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${categoryDeta?[index].title}",
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
                        child: CustomElevatedButton(
                            onTap: () {
                              if(controller.hasAtLeastThreeTotalValues(controller.selectedActivity)){
                                Get.back();
                              }else{
                                showTostMsg('Select atleast three activity.',gravity: ToastGravity.CENTER);
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
              );
      })),
    );
  }
}
