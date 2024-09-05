import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/size.dart';
import 'controller/attendlist_controller.dart';

class AttendListUi extends GetView<AttendlistController>{
  const AttendListUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      // appBar: AppBar(
      //   scrolledUnderElevation: 0,
      //   leadingWidth: 55,
      //   leading: InkWell(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: Container(
      //       margin: const EdgeInsets.only(left: 13, bottom: 7, top: 7),
      //       clipBehavior: Clip.hardEdge,
      //       width: h*.04,
      //       height: h*.04,
      //       padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
      //       decoration: BoxDecoration(
      //           color: clrGreyLight, borderRadius: BorderRadius.circular(10)),
      //       child: const Center(child: Icon(Icons.arrow_back_ios)),
      //     ),
      //   ),
      //   centerTitle: true,
      //   title: const Text(
      //     "Attendance list",
      //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      //   ),
      // ),
      body: Obx(() => controller.activityLoading.value ? Center(child: CommonUi.scaffoldLoading(color: clrYellow)) : controller.attError.value.isNotEmpty? const Center(child: ErrorScreen()) :  Padding(
        padding:  EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonUi.appBar(),
                const Text(
                  "Attendance list",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                padding: EdgeInsets.symmetric(vertical:  h*.02,),
                shrinkWrap: true,
                itemCount: controller.attData.value.result?.attendanceList?.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  // Container(
                                  //     height: h*.055,
                                  //     width:  h*.055,
                                  //     decoration: BoxDecoration(
                                  //         borderRadius:
                                  //         BorderRadius.circular(100)),
                                  //     child: Image.asset(
                                  //       "assets/images/girldp.png",
                                  //       fit: BoxFit.cover,
                                  //     )),
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      height: 52,
                                      width: 52,
                                      fit: BoxFit.cover,
                                      imageUrl: '${controller.attData.value.result?.attendanceList?[index].profilePhoto}',
                                      errorWidget:
                                          (context, url, error) =>
                                          Container(
                                            height: 52,
                                            width: 52,
                                            padding:
                                            const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: clrGreyLight,
                                                shape: BoxShape.circle),
                                            child: Image.asset(
                                              "assets/icons/manicon.png",
                                              color: clrGrey,
                                              fit: BoxFit.cover,
                                              scale: 1.2,
                                            ),
                                          ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                            baseColor: grey300,
                                            highlightColor: grey100,
                                            child: Container(
                                              height: 52,
                                              width: 52,
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
                                  SizedBox(
                                    width: Get.width*0.02,
                                  ),
                                  Flexible(child: Text(
                                    '${controller.attData.value.result?.attendanceList?[index].firstName} ${controller.attData.value.result?.attendanceList?[index].lastName}',
                                    style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),))
                                ],
                              ),
                            ),
                            controller.attData.value.result?.attendanceList?[index].userAttendance == 'Joined'
                                ? Image.asset('assets/icons/joined.png',scale: 4,)
                                : Image.asset('assets/icons/notjoined.png',scale: 4)
                            // index >=0? Container(
                            //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            //     color:index ==0?clrGreyLight: clrYellow,
                            //   ),
                            //   child: Row(
                            //     children: [
                            //       Image.asset(index ==0?"assets/icons/closecircle.png":"assets/icons/congratesicon.png",height: 13,color: clrBlacke,),
                            //       const SizedBox(
                            //         width: 5,
                            //       ),
                            //       Text(index ==0?"Not joined":"Joined",style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w500,fontSize: 12),),
                            //     ],
                            //   ),
                            // ):const SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: Get.height*0.008,
                        ),
                        Divider(
                          color: clrGreyLight,
                          height: 8,
                        ),
                        SizedBox(
                          height: Get.height*0.003,
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),),
    );
  }
}
