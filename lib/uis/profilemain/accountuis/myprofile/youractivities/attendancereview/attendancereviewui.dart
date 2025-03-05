import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/size.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/common.dart';
import '../../../../../components/custoelevatedbtn.dart';
import '../../../../../components/custofilterbtn.dart';
import '../../activity/previousactivity/controller/previousacti_controller.dart';
import 'controller/attend_review_controller.dart';

class AttendanceReviewUi extends GetWidget<AttendReviewController>{
   AttendanceReviewUi({super.key});

  final PreviousActiController pcontroller = Get.find<PreviousActiController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonUi.appBar(
                      onTap: () async{
                        Get.back();
                        await pcontroller.actapi(controller.actid);
                      },
                    ),
                    const Text(
                      "Attendance review",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Please tell us who attended your activity.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "We use this information to keep members accountable for attendance.",
                  style: TextStyle(color: clrGreyTextLight,fontSize: 14,fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
               Obx(() => controller.activityLoading.value ? Center(child: CommonUi.scaffoldLoading(color: clrYellow))
                   : ListView.separated(
                   shrinkWrap: true,
                   itemCount: controller.goinglist?.length ?? 0,
                   physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (context, index) {
                     return Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Flexible(
                           child: Row(
                             children: [
                               Center(
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(100),
                                   child: CachedNetworkImage(
                                       imageUrl:
                                       '${controller.goinglist![index].profilePhoto}',
                                       fit: BoxFit.cover,
                                       height: 46,
                                       width: 46,
                                       memCacheWidth: 500,
                                       placeholder: (context, url) => Shimmer.fromColors(
                                           baseColor: Colors.grey.shade300,
                                           highlightColor: Colors.grey.shade100,
                                           child: ClipRRect(
                                             borderRadius: BorderRadius.circular(100),
                                             child: Container(
                                               height: 46,
                                               width:46,
                                               color: clrGrey,
                                             ),
                                           )),
                                       errorWidget: (context, url, error) {
                                         print('error == $error');
                                         return ClipRRect(
                                           borderRadius: BorderRadius.circular(100),
                                           child: Container(
                                             height: 46,
                                             width:46,
                                             color: clrGreyLight,
                                             child: Image.asset(
                                               'assets/icons/manicon.png',
                                               color: clrGrey,
                                             ),
                                           ),
                                         );
                                       }),
                                 ),
                               ),
                               SizedBox(
                                 width: Get.width * 0.02,
                               ),
                               Flexible(
                                   child: Text(
                                     ' ${controller.goinglist![index].firstName.toString()}',
                                     style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                                   )
                               )
                             ],
                           ),
                         ),
                         controller.goinglist![index].userAttendance == false ? Row(
                           children: [
                             InkWell(
                               onTap: () {
                                 Future.delayed(Duration.zero,(){
                                   Get.dialog(AlertDialog(
                                     scrollable: true,
                                     insetPadding: const EdgeInsets.symmetric(horizontal: 13),
                                     contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
                                     content: SizedBox(
                                       width: double.maxFinite,
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         mainAxisSize: MainAxisSize.min,
                                         children: [
                                           const Center(
                                             child:  Text(
                                               "Are you sure?",
                                               style: TextStyle(fontSize: 19
                                                   , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                                             ),
                                           ),
                                           SizedBox(
                                             height: Get.height*.013,
                                           ),
                                           Center(child: Text("Are you sure ${controller.goinglist?[index].firstName.toString()} ${controller.goinglist?[index].lastName.toString()} couldn't make it? They'll be notified and charged with a no-show fee.",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),
                                           SizedBox(
                                             height: Get.height*.023,
                                           ),
                                           controller.goinglist?[index].userAttendance == false ?  Row(
                                               children: [
                                                 Expanded(child: SizedBox(
                                                   height: Res.h_btn,
                                                   child: CustoFilterBtn(borderClr: clrBlacke,lable: Text("Cancel",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),), ontap: (){
                                                     Get.back();
                                                     // alertCancelRequestConfirmation();
                                                   }, backgroundClr: Get.theme.scaffoldBackgroundColor),
                                                 )),
                                                 SizedBox(
                                                   width: Get.width*0.05,
                                                 ),
                                                 Expanded(
                                                   child: SizedBox(width: double.maxFinite,height: Res.h_btn,
                                                       child: CustomElevatedButton(
                                                           onTap: () async{
                                                             Get.back();
                                                             await controller.attapi(controller.actid, controller.goinglist?[index].userId.toString() , true,index);
                                                           },
                                                           backgroundClr: clrBlacke,
                                                           child: Text(
                                                             "Yes, no-show",
                                                             style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),
                                                           )
                                                       )
                                                   ),
                                                 ),
                                               ]
                                           ) : SizedBox(),
                                           SizedBox(
                                             height:Get.height*.013,
                                           ),
                                         ],
                                       ),
                                     ),
                                   ));
                                 });
                               },
                               child: Container(
                                 padding: EdgeInsets.all(4),
                                 decoration: BoxDecoration(
                                   borderRadius:
                                   BorderRadius.circular(100),
                                   color: clrBlacke,
                                 ),
                                 child: Icon(
                                   Icons.close,
                                   color: clrWhite,
                                   size: 20,
                                 ),
                               ),
                             ),
                             SizedBox(
                               width: Get.width * 0.02,
                             ),
                             InkWell(
                               onTap: () {
                                 // alertRemove();
                                 controller.attapi(controller.actid, controller.goinglist?[index].userId.toString() , false,index);
                               },
                               child: Container(
                                 padding: EdgeInsets.all(4),
                                 decoration: BoxDecoration(
                                   borderRadius:
                                   BorderRadius.circular(100),
                                   color: clrYellow,
                                 ),
                                 child: Icon(
                                   Icons.check,
                                   color: clrWhite,
                                   size: 20,
                                 ),
                               ),
                             )
                           ],
                         ) : SizedBox(),
                       ],
                     );
                   }, separatorBuilder: (BuildContext context, int index) {
                     return Padding(
                       padding: const EdgeInsets.symmetric(vertical: 12),
                       child: Divider(
                         color: clrGreyLight,
                         height: 8,
                       ),
                     );
               },),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
