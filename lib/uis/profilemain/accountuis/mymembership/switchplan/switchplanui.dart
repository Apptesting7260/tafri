import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../utils/colors.dart';

class SwitchPlanUi extends GetWidget{
  const SwitchPlanUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: h*.05,
                      height: h*.05,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: clrGreyLight,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(child: Icon(Icons.arrow_back_ios)),
                    ),
                  ),
                  const Text("Switch plan",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
                    SizedBox(
                    width: h*.025,
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Expanded(
                  child:Column(
                    children: [
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                        decoration: BoxDecoration(
                            color: clrGreyLight,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: clrGrey.withOpacity(0.3))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Radio(
                              value: 1,
                              groupValue: 1,
                              onChanged: (val) {},
                              visualDensity: VisualDensity.compact,
                              activeColor: clrYellow,
                            ),
                            Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Annual",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                                          RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: "3 months free",
                                                  style: TextStyle(color: clrYellowText,fontWeight: FontWeight.w700),
                                                ),
                                                TextSpan(
                                                    text: " then €23.99/year",
                                                    style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w700))
                                              ])),
                                        ],
                                      ),
                                    ),

                                  ],
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical:18),
                        decoration: BoxDecoration(
                            color: clrTransparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: clrGrey.withOpacity(0.3))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Radio(
                              value: 2,
                              groupValue: 1,
                              onChanged: (val) {},
                              visualDensity: VisualDensity.compact,
                              activeColor: clrYellow,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Monthly",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),
                                  RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: "3 months free",
                                          style: TextStyle(color: clrYellowText,fontWeight: FontWeight.w700),
                                        ),
                                        TextSpan(
                                            text: " then €3.99/month",
                                            style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w700))
                                      ])),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
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
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      SizedBox(
                        height:Res.h_btn,
                        width: double.maxFinite,
                        child: CustoElevatedBtn(child: Text("Confirm change",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),), onTap: (){
                          changePlanAlert();
                        }, backgroundClr: clrBlacke),
                      ),
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
              Center(child: Image.asset("assets/icons/congratesicon.png",height:Get.height*.095,width:Get.height*.095,)),
                SizedBox(
                height: Get.height*.012
              ),
              const Center(child: Text("All set!",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),)),
                SizedBox(
                height: Get.height*.012
              ),
              Center(child: Text("Your plan is successfully changed",textAlign: TextAlign.center,style: TextStyle(color: clrGreyTextLight,fontSize: 16),)),
              SizedBox(
                height: Get.height*0.03,
              ),
              SizedBox(
                height: Res.h_btn,
                width: double.maxFinite,
                child: CustoElevatedBtn(onTap: () {
                  Get.back();
                },
                  backgroundClr: clrBlacke,
                  child: Text("Let’s explore",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),),),
              ),


            ],
          ),
        )));
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
