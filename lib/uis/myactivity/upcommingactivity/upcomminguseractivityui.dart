import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/explore/hostprofile/hostprofileui.dart';
import 'package:plusone/uis/myactivity/upcommingactivity/controller/upcommingactiuser_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

import '../../../routes/routes.dart';
import '../../components/custotextfield.dart';

class UpcommingUserActivityUi extends GetWidget<UpCommingActiUserController>{
  const UpcommingUserActivityUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          child: Column(
            children: [
               const SizedBox(
                height:15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonUi.appBar(),
                  const Text("Activity",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: w*.1,
                          height:w*.1,
                          decoration: BoxDecoration(
                            color: clrBlacke,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/icons/uploadicon.png",color: clrWhite,height: w*.06,width: w*.06,), //
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      SizedBox(
                        width: w*0.07,
                        child: Center(
                          child: PopupMenuButton(
                            splashRadius: 0.1,
                            elevation: 5,
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 1,
                                child: Text("Report"),
                              )
                            ],
                            onSelected: (val) {
                              if (val == 1) {
                                alertActivityReport();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: h*.25,
                        child: Stack(
                          // clipBehavior: Clip.none,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  height:h*.25, viewportFraction: 1),
                              items: [1, 2, 3].map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        clipBehavior: Clip.hardEdge,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        height: double.maxFinite,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(18)),
                                        child: Image.asset(
                                          "assets/images/cofee.png",
                                          fit: BoxFit.cover,
                                          height: h*.25,
                                          width: double.maxFinite,
                                        ));
                                  },
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: clrWhite,
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: const Text("Coffee",style: TextStyle(fontWeight: FontWeight.w700),),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: clrWhite,
                                        borderRadius:
                                        BorderRadius.circular(100)),
                                    child: const Icon(
                                      Icons.favorite_border,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 7),
                                height: 16,
                                child: ListView.builder(
                                    itemCount: 3,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1.5),
                                        child: Icon(
                                          Icons.circle,
                                          color: clrWhite,
                                          size: 8,
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Picnic in the park",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                SizedBox(height: 5,),
                                Text("Vondelpark",style: TextStyle(fontSize: 14,color:clrGreyDark,fontWeight: FontWeight.w500),),
                                SizedBox(height: 5,),
                                Text("13 March 2024 | 2:30 PM - 6:00PM",style: TextStyle(fontSize: 14,color:clrGreyTextLight,fontWeight: FontWeight.w500),),
                                SizedBox(height: 5,),
                                Text("Up to 3 people | 1 spot left",style: TextStyle(color: clrYellowText,fontSize: 14,fontWeight: FontWeight.w500),),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Get.toNamed(Routes.hostProfileUi);
                            },
                            child: Column(
                              children: [
                                Container(
                                    height: h*.055,
                                    width: h*.055,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(100)),
                                    child: Image.asset(
                                      "assets/images/girldp.png",
                                      fit: BoxFit.cover,
                                    )),
                                const Text("Jenny",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text("Hey guys! Looking to brighten up your morning? How about joining me for a coffee break at the local café around 10 AM? I'm extending an invite to three fellow coffee lovers to join the chat and caffeine boost. Let's turn strangers into friends over a cup of joe! Hope to see you there for a delightful break. ☕️👋",style: TextStyle(fontSize: 14,color:clrGrey5D5C5E),),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      const Text("Going",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                      SizedBox(
                        height: Get.height*0.015,
                      ),
                      SizedBox(
                        height: h*.065,
                        child: ListView.builder(itemCount: 2,scrollDirection: Axis.horizontal,shrinkWrap: true,itemBuilder: (context,index){
                          return Container(
                            margin: const EdgeInsets.only(right: 15),
                            clipBehavior: Clip.hardEdge,
                            height: h*.065,
                            width: h*.065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset("assets/images/cofee.png",fit: BoxFit.cover,),
                          ) ;
                        }),
                      ),
                      SizedBox(
                        height: Get.height*0.035,
                      ),
                      SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){}, backgroundClr: clrGrey, child: Text("Pending Host Confirmation",style: TextStyle(color: clrWhite,fontWeight: FontWeight.w700,fontSize: 16),))),
                      const SizedBox(
                        height: 12,
                      ),
                      Center(child: InkWell(
                          onTap: (){
                            alertCancelRequest();
                          }
                          ,child: const Text("Cancel Request",style: TextStyle(decoration: TextDecoration.underline),))),

                      SizedBox(
                        height: Get.height*0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  alertActivityReport() {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 25,
                    )),
                const Flexible(
                  child: Text(
                    "Report activity",
                    style: TextStyle(fontSize: 19
                        , fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(
                  width: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Why are you reporting this activity?",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(height: 30,child: Radio(splashRadius: 0,value: 1, groupValue: 2, onChanged: (val) {})),
                const Text("Scam or fraud")
              ],
            ),
            Divider(
              color: clrGreyLight,
            ),
            Row(
              children: [
                SizedBox(height: 30,child: Radio(value: 2, groupValue: 2, onChanged: (val) {})),
                const Text("Inappropriate or misleading content")
              ],
            ),
            Divider(
              color: clrGreyLight,
            ),
            Row(
              children: [
                SizedBox(height: 30,child: Radio(value: 3, groupValue: 2, onChanged: (val) {})),
                const Text("Harrassment or abuse")
              ],
            ),
            Divider(
              color: clrGreyLight,
            ),
            Row(
              children: [
                SizedBox(height: 30,child: Radio(value: 4, groupValue: 2, onChanged: (val) {})),
                const Text("Other")
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const CustoTextFormField(hintText: "Please provide more details about what happened. We will review your report and take appropriate action.",maxLines: 5,),
            const SizedBox(
              height: 20,
            ),
            SizedBox(width: double.maxFinite,height: 45,child: CustomElevatedButton(onTap: (){
              Get.back();
            }, backgroundClr: clrBlacke, child: Text("Submit",style: TextStyle(color: clrWhite),))),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
  alertCancelRequest() {
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
                  "Cancel request",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),

                SizedBox(
                height:Get.height*.012,
              ),
              Center(child: Text("Are you sure you want to cancel your request to join this activity?",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),


                SizedBox(
                height:Get.height*.024,
              ),
              Row(
                  children: [
                    Expanded(child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                      Get.back();
                    }, backgroundClr: clrBlacke, child: Text("No",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),),
                    SizedBox(
                      width: Get.width*0.05,
                    ),
                    Expanded(child: SizedBox(
                      height: Res.h_btn,
                      child: CustoFilterBtn(borderClr: clrBlacke,lable: Text("Yes",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),), ontap: (){
                        Get.back();
                        alertCancelRequestConfirmation();
                      }, backgroundClr: Get.theme.scaffoldBackgroundColor),
                    ))
                  ]
              ),
                SizedBox(
                height:Get.height*.013,
              ),
            ],
          ),
        ),
      ));
    });
  }


  alertCancelRequestConfirmation() {
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
                  "Confirm cancellation",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),

                SizedBox(
                height: Get.height*.014,
              ),
              Center(child: Text("Canceling within 24 hours of the activity will incur a €3 fee. Are you sure you want to proceed?",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),
                SizedBox(
                height:Get.height*.024,
              ),
              Row(
                  children: [
                    Expanded(child: SizedBox(
                      height: Res.h_btn,
                      child: CustoFilterBtn(borderClr: clrBlacke,lable: Text("Yes",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),), ontap: (){
                        Get.back();
                      }, backgroundClr:Get.theme.scaffoldBackgroundColor),
                    )),
                    SizedBox(
                      width: Get.width*0.05,
                    ),
                    Expanded(child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                      Get.back();
                    }, backgroundClr: clrBlacke, child: Text("No",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),),


                  ]
              ),
                SizedBox(
                height: Get.height*.012,
              ),
            ],
          ),
        ),
      ));
    });
  }
}
