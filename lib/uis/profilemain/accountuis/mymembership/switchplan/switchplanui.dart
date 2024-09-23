import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/controller/mymembership_controller.dart';
import 'package:plusone/utils/custom_radio.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/common.dart';

class SwitchPlanUi extends GetWidget<MymembershipController>{
  const SwitchPlanUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonUi.appBar(),
                  // InkWell(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Container(
                  //     width: h*.05,
                  //     height: h*.05,
                  //     padding:
                  //     const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //     decoration: BoxDecoration(
                  //         color: clrGreyLight,
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: const Center(child: Icon(Icons.arrow_back_ios)),
                  //   ),
                  // ),
                  const Text(
                    "Switch plan",
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),
                  ),
                    SizedBox(
                    width: h*.025,
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Expanded(
                  child:Column(
                    children: [
                      Obx(() => GestureDetector(
                        onTap: () {
                          controller.updateSelectedValue(1);
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                          decoration: BoxDecoration(
                              color: controller.selectedval.value == 1 ?  clrGreyLight : clrTransparent,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: clrGrey.withOpacity(0.2))
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: CustomRadioButton(
                                  splashRadius: 20,
                                  value: 1,
                                  width: 2,
                                  // visualDensity: VisualDensity.compact,
                                  activeColor: clrYellow,
                                  text: '',
                                  groupValue: controller.selectedval.value,
                                  onChanged: (val) {
                                    controller.updateSelectedValue(val);
                                  },
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Flexible(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Annual",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: "3 months free",
                                                    style: TextStyle(
                                                        color: clrYellow,
                                                        fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text: " then €23.99/year",
                                                      style: TextStyle(
                                                          color: clrBlacke,
                                                          fontWeight: FontWeight.w700
                                                      )
                                                  )
                                                ]
                                                )
                                            ),
                                            const SizedBox(height: 5,)
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                     Obx(() =>  GestureDetector(
                       onTap: () {
                         controller.updateSelectedValue(2);
                       },
                       child: Container(
                         padding:
                         const EdgeInsets.symmetric(horizontal: 10, vertical:18),
                         decoration: BoxDecoration(
                             color:  controller.selectedval.value == 2 ?  clrGreyLight : clrTransparent,
                             borderRadius: BorderRadius.circular(15),
                             border: Border.all(color: clrGrey.withOpacity(0.2))
                         ),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top: 4),
                               child: CustomRadioButton(
                                 splashRadius: 20,
                                 value: 2,
                                 width: 2,
                                 // visualDensity: VisualDensity.compact,
                                 activeColor: clrYellow,
                                 text: '',
                                 groupValue: controller.selectedval.value,
                                 onChanged: (val) {
                                   controller.updateSelectedValue(val);
                                 },
                               ),
                             ),
                             const SizedBox(width: 5,),
                             Flexible(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const Text(
                                       "Monthly",
                                       style: TextStyle(
                                           fontWeight: FontWeight.w600,
                                           fontSize: 18
                                       )
                                   ),
                                   const SizedBox(height: 5,),
                                   RichText(
                                       text: TextSpan(children: [
                                         TextSpan(
                                           text: "1 week free",
                                           style: TextStyle(
                                               color: clrYellow,
                                               fontWeight: FontWeight.w700
                                           ),
                                         ),
                                         TextSpan(
                                             text: " then €3.99/month",
                                             style: TextStyle(
                                                 color: clrBlacke,fontWeight: FontWeight.w700
                                             )
                                         )
                                       ]
                                       )
                                   ),
                                   const SizedBox(height: 5,)
                                 ],
                               ),
                             ),
                             Container(
                               padding: const EdgeInsets.symmetric(
                                   horizontal: 8,
                                   vertical: 3
                               ),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                   color: clrYellow),
                               child: const Text(
                                 "Current plan",
                                 style: TextStyle(fontSize: 10),
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                     ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Obx(() => Opacity(
                        opacity: controller.buttonLoadingMonthly.value || controller.buttonLoadingYearly.value || controller.apiLoading.value ? 0.5 : 1,
                        child: SizedBox(
                          height:Res.h_btn,
                          width: double.maxFinite,
                          child: CustomElevatedButton(
                            onTap: () async{
                              if(!controller.buttonLoadingMonthly.value && !controller.buttonLoadingYearly.value && !controller.apiLoading.value) {
                                print('button tap');
                                await controller.buySubscription();
                              }
                              // changePlanAlert();
                            },
                            backgroundClr: clrBlacke,
                            child: controller.buttonLoadingMonthly.value || controller.buttonLoadingYearly.value || controller.apiLoading.value ? CommonUi.buttonLoading() : Text(
                              "Confirm change",
                              style: TextStyle(
                                  color: clrWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                        ),
                      ),)
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  changePlanAlert() async {
    Get.dialog(AlertDialog(
        backgroundColor: clrWhite,
        insetPadding: const EdgeInsets.symmetric(horizontal: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        content: SizedBox(
          width: Get.width * 0.87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
                SizedBox(
                height: Get.height*.012
              ),
              Center(
                  child: Image.asset(
                    "assets/icons/congratesicon.png",
                    height:Get.height*.095,
                    width:Get.height*.095,
                  )
              ),
                SizedBox(
                height: Get.height*.012
              ),
              const Center(
                  child: Text(
                    "All set!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 19
                    ),
                  )
              ),
                SizedBox(
                height: Get.height*.012
              ),
              Center(
                  child: Text(
                    "Your plan is successfully changed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: clrGreyTextLight,
                        fontSize: 16
                    ),
                  )
              ),
              SizedBox(
                height: Get.height*0.03,
              ),
              SizedBox(
                height: Res.h_btn,
                width: double.maxFinite,
                child: CustomElevatedButton(onTap: () {
                  Get.back();
                },
                  backgroundClr: clrBlacke,
                  child: Text(
                    "Let’s explore",
                    style: TextStyle(
                        color: clrWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    )
    );
  }

// cancelPlanAlert() async {
//   Get.dialog(AlertDialog(
//     backgroundColor: clrWhite,
//       insetPadding: const EdgeInsets.symmetric(horizontal: 13),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//       content: SizedBox(
//         width: Get.width * 0.87,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Center(child: Text("Are you sure to cancel?",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),)),
//             const SizedBox(
//               height: 10,
//             ),
//             Center(child: Text("You will remain a member till 31 May and won’t be charged from 1 June.",textAlign: TextAlign.center,style: TextStyle(color: clrGreyTextLight),)),
//              SizedBox(
//               height: Get.height*0.03,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     height: 45,
//                     child: CustoElevatedBtn(onTap: () {
//                       Get.back();
//                     },
//                       backgroundClr: clrBlacke,
//                       child: Text("No, stay",style: TextStyle(color: clrWhite),),),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     height: 45,
//                     child: CustoFilterBtn(ontap: () {
//                       Get.back();
//                     },borderClr: clrBlacke,
//                       backgroundClr: clrWhite,
//                       lable: Text("Yes, cancel",style: TextStyle(color: clrBlacke),),),
//                   ),
//                 ),
//               ],
//             ),
//
//
//           ],
//         ),
//       )));
// }
}
