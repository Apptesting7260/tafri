import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/navbar/navbar.dart';
import 'package:plusone/utils/size.dart';
import '../../../utils/colors.dart';

class PlansUi extends GetWidget{
  const PlansUi({super.key});

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: clrGreyLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(child: Icon(Icons.arrow_back_ios)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                const Text(
                  "Become a PlusOnes member",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                          "Join our members-only platform to find like-minded activity partners in a high-quality and safe community.",
                          style:
                          TextStyle(color: clrGrey5D5C5E)),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
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
                                          const Text("Annual",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                          RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text: "3 months free",
                                                  style: TextStyle(color: clrYellowText),
                                                ),
                                                TextSpan(
                                                    text: " then €23.99/year",
                                                    style: TextStyle(color: clrGrey5D5C5E))
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
                                        "Best value",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    )
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
                                  const Text("Monthly",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                                  RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: "3 months free",
                                          style: TextStyle(color: clrYellowText),
                                        ),
                                        TextSpan(
                                            text: " then €3.99/month",
                                            style: TextStyle(color: clrGrey5D5C5E))
                                      ])),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "By starting your membership, you agree to our ",

                              style:
                              TextStyle(color:clrGrey5D5C5E,height: 1.5, ),
                            ),
                            TextSpan(
                                text: " Terms of Service",

                                style: TextStyle(color: clrYellow,decoration: TextDecoration.underline,height: 1.5)),
                            TextSpan(
                              text: " and",
                              style:
                              TextStyle(color: clrGrey5D5C5E,height: 1.5),
                            ),
                            TextSpan(
                                text: " Privacy Policy.",
                                style: TextStyle(color: clrYellow,decoration: TextDecoration.underline,height: 1.5)),
                            TextSpan(
                              text:
                              " After the free trial, your membership will auto-renew annually at €23.99 unless cancelled. You authorise charges for late cancellations and no-shows. These policies ensure a committed and genuine community.",
                              style:
                              TextStyle(color:clrGrey5D5C5E,height: 1.5),
                            )
                          ])),

                    ],
                  ),
                ),
                SizedBox(
                    height: Res.h_btn,
                    width: double.maxFinite,
                    child: CustomElevatedButton(
                        onTap: () {
                          if(isIOS){
                            alertPurchaseSuccessIos();
                          }else{
                            planSuccessPopUp();
                          }
                        },
                        backgroundClr: clrBlacke,
                        child: Text(
                          "Start 3 months free",
                          style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),
                        ))),
                SizedBox(
                  height: Get.height * 0.01,
                ),
              ],
            ),
          )),
    );
  }
  planSuccessPopUp() async {
    Future.delayed(Duration.zero, () {
      return Get.dialog(AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 0),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          content: SizedBox(
            width: Get.width * 0.87,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    "assets/icons/congratesicon.png",
                    height: Get.height*.075,
                  ),
                ),
                  SizedBox(
                  height: Get.height*.013,
                ),
                const Center(
                    child: Text(
                      "Congratulations",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                    )),
                  SizedBox(
                  height:  Get.height*.013,
                ),
                const Center(
                  child: Text(
                    "You are now a PlusOnes member! Start connecting and find your perfect activity partners!",textAlign: TextAlign.center,style: TextStyle(fontSize: 14),),
                ),
                  SizedBox(
                  height: Get.height*.012,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width*0.6,
                    height: Res.h_btn,
                    child: CustomElevatedButton(onTap: (){
                      Get.offAll((){
                        return Navbar();
                      });
                    }, backgroundClr: clrBlacke, child: Text("Let’s explore",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),)),
                  ),
                )
              ],
            ),
          )));
    });
  }
  alertPurchaseSuccessIos() async {
    Future.delayed(Duration.zero, () {
      return Get.dialog(CupertinoAlertDialog(
        // insetPadding: const EdgeInsets.symmetric(horizontal: 0),
        // contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        title: Text("You’re all Set"),
        content: SizedBox(
          width: Get.width * 0.87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Your purchase was successful..",textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: clrGreyTextLight,),
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Get.back();
          }, child: Text('ok')),

        ],
      ));
    });
  }
}
