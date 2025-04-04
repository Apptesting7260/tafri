import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/utils/custom_radio.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/common.dart';

class SwitchPlanUi extends StatefulWidget {
  const SwitchPlanUi({super.key});

  @override
  State<SwitchPlanUi> createState() => _SwitchPlanUiState();
}

class _SwitchPlanUiState extends State<SwitchPlanUi> {

  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  void dispose() {
    super.dispose();
    paymentController.purchasedPlan.value = '';
    paymentController.newAmount.value = '';
    paymentController.newId.value = '';
    paymentController.profileController.profileData.value.result?.planType == 'monthly' ? paymentController.updateSelectedValue(0) : paymentController.updateSelectedValue(1);
    paymentController.purchasedPlan.value = paymentController.profileController.profileData.value.result?.planType ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
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
                    "Switch plan",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(
                    width: h * .025,
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = paymentController.plans.value.result?[index];
                    print('data == ${data?.id}');
                    return Obx(
                          () => GestureDetector(
                        onTap: () {
                          if(paymentController.profileController.profileData.value.result?.planType != data.billingPeriod){
                            paymentController.updateSelectedValue(index);
                            paymentController.purchasedPlan.value = data.billingPeriod!;
                            paymentController.newAmount.value = data.price!;
                            paymentController.newId.value = data.id.toString();
                          }
                          // controller.updateSelectedValue(1);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 18),
                          decoration: BoxDecoration(
                              color:
                              paymentController.selectedval.value == index
                                  ? clrGreyLight
                                  : clrTransparent,
                              borderRadius: BorderRadius.circular(15),
                              border:
                              Border.all(color: clrGrey.withOpacity(0.2))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: CustomRadioButton(
                                  splashRadius: 20,
                                  value: data!.id! - 1,
                                  width: 2,
                                  // visualDensity: VisualDensity.compact,
                                  activeColor: clrYellow,
                                  text: '',
                                  groupValue:
                                  paymentController.selectedval.value,
                                  onChanged: (val) {
                                    if(paymentController.profileController.profileData.value.result?.planType != data.billingPeriod){
                                      paymentController.updateSelectedValue(index);
                                      paymentController.purchasedPlan.value = data.billingPeriod!;
                                      paymentController.newAmount.value = data.price!;
                                      paymentController.newId.value = data.id.toString();
                                    }
                                    // controller.updateSelectedValue(val);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data.name}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            paymentController.profileController.profileData.value.result?.myReferDays != null ? Text("Your referral code has been added. You've received ${paymentController.profileController.profileData.value.result?.myReferDays} days on top of your free trial.",style: TextStyle(
                                                color: clrBlacke.withOpacity(0.5)
                                            ),) : SizedBox(),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                                  // TextSpan(
                                                  //   text:
                                                  //       "${paymentController.getWeek(int.parse(data.trailDays.toString()))} free",
                                                  //   style: TextStyle(
                                                  //       color: clrYellowText,
                                                  //       fontWeight: FontWeight.w700),
                                                  // ),
                                                  TextSpan(
                                                      text:
                                                      "€${data.price}/${data.billingPeriod == 'monthly' ? 'month' : data.billingPeriod == 'yearly' ? 'year' : ''}",
                                                      style: TextStyle(
                                                          color: clrBlacke,
                                                          fontWeight: FontWeight.w700))
                                                ])),
                                            // const SizedBox(
                                            //   height: 5,
                                            // ),
                                            // paymentController.profileController.profileData.value.result?.myReferDays != null ? Text('Your referral code has been added',style: TextStyle(
                                            //     color: clrBlacke.withOpacity(0.5)
                                            // ),) : SizedBox()
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              paymentController.profileController.profileData.value.result?.planType == data.billingPeriod ? Container(
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
                              ) : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                  itemCount: paymentController.plans.value.result?.length ?? 0),
              SizedBox(
                height: Get.height * 0.03,
              ),
              // Obx(() =>
              Obx(() => Opacity(
                opacity: paymentController.switchLoading.value ? 0.5 : 1,
                child: SizedBox(
                  height: Res.h_btn,
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                    onTap: paymentController.switchLoading.value ? (){} : () async {
                      if(paymentController.profileController.profileData.value.result?.planType == paymentController.purchasedPlan.value){
                        showTostMsg('Please select different plan');
                      }else{
                        paymentController.switchPlanPopUp(onTap: () {
                          Get.back();
                          paymentController.switchPlan(planID: paymentController.newId.value, amount: paymentController.newAmount.value);
                          // paymentController.updateSub(
                          //     amount: paymentController.newAmount.value,
                          //     des: paymentController.purchasedPlan.value == 'monthly' ? 'Monthly membership' : 'Yearly membership',
                          //     duration: paymentController.purchasedPlan.value == 'monthly' ? '1 month' : '12 months',
                          //   date: DateTime.parse(paymentController.profileController.profileData.value.result!.trailDate.toString())
                          // );
                        },);
                      }

                    },
                    backgroundClr: clrBlacke,
                    child: paymentController.switchLoading.value ? CommonUi.buttonLoading() : Text(
                      "Confirm change",
                      style: TextStyle(
                          color: clrWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),)
              // SizedBox(height: 15,),
              // Obx(() => SizedBox(
              //   height: Res.h_btn,
              //   width: double.maxFinite,
              //   child: CustomElevatedButton(
              //     onTap: paymentController.billingLoading.value ? (){} : () async {
              //       paymentController.updateBilling();
              //     },
              //     backgroundClr: clrWhite,
              //     borderClr: clrBlacke,
              //     child: paymentController.billingLoading.value ? CommonUi.buttonLoading(color: clrBlacke) : Text(
              //       "Update billing",
              //       style: TextStyle(
              //           color: clrBlacke,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w700),
              //     ),
              //   ),
              // ),)
              // )

              //           Expanded(
              //               child:Column(
              //                 children: [
              //                   Obx(() => GestureDetector(
              //                     onTap: () {
              //                       controller.updateSelectedValue(1);
              //                     },
              //                     child: Container(
              //                       padding:
              //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
              //                       decoration: BoxDecoration(
              //                           color: controller.selectedval.value == 1 ?  clrGreyLight : clrTransparent,
              //                           borderRadius: BorderRadius.circular(15),
              //                           border: Border.all(color: clrGrey.withOpacity(0.2))
              //                       ),
              //                       child: Row(
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           Padding(
              //                             padding: const EdgeInsets.only(top: 4),
              //                             child: CustomRadioButton(
              //                               splashRadius: 20,
              //                               value: 1,
              //                               width: 2,
              //                               // visualDensity: VisualDensity.compact,
              //                               activeColor: clrYellow,
              //                               text: '',
              //                               groupValue: controller.selectedval.value,
              //                               onChanged: (val) {
              //                                 controller.updateSelectedValue(val);
              //                               },
              //                             ),
              //                           ),
              //                           const SizedBox(width: 5,),
              //                           Flexible(
              //                               child: Row(
              //                                 crossAxisAlignment: CrossAxisAlignment.start,
              //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                                 children: [
              //                                   Flexible(
              //                                     child: Column(
              //                                       crossAxisAlignment: CrossAxisAlignment.start,
              //                                       children: [
              //                                         const Text(
              //                                           "Annual",
              //                                           style: TextStyle(
              //                                               fontWeight: FontWeight.w600,
              //                                               fontSize: 18
              //                                           ),
              //                                         ),
              //                                         const SizedBox(height: 5,),
              //                                         RichText(
              //                                             text: TextSpan(children: [
              //                                               TextSpan(
              //                                                 text: "3 months free",
              //                                                 style: TextStyle(
              //                                                     color: clrYellow,
              //                                                     fontWeight: FontWeight.w700
              //                                                 ),
              //                                               ),
              //                                               TextSpan(
              //                                                   text: " then €23.99/year",
              //                                                   style: TextStyle(
              //                                                       color: clrBlacke,
              //                                                       fontWeight: FontWeight.w700
              //                                                   )
              //                                               )
              //                                             ]
              //                                             )
              //                                         ),
              //                                         const SizedBox(height: 5,)
              //                                       ],
              //                                     ),
              //                                   ),
              //                                 ],
              //                               )
              //                           ),
              //                           controller.homeController.homeData.value.result!.planType == 'yearly' ? Container(
              //                             padding: const EdgeInsets.symmetric(
              //                                 horizontal: 8,
              //                                 vertical: 3
              //                             ),
              //                             decoration: BoxDecoration(
              //                                 borderRadius: BorderRadius.circular(20),
              //                                 color: clrYellow),
              //                             child: const Text(
              //                               "Current plan",
              //                               style: TextStyle(fontSize: 10),
              //                             ),
              //                           ) : SizedBox()
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                   ),
              //                   SizedBox(
              //                     height: Get.height * 0.02,
              //                   ),
              //                  Obx(() =>  GestureDetector(
              //                    onTap: () {
              //                      controller.updateSelectedValue(2);
              //                    },
              //                    child: Container(
              //                      padding:
              //                      const EdgeInsets.symmetric(horizontal: 10, vertical:18),
              //                      decoration: BoxDecoration(
              //                          color:  controller.selectedval.value == 2 ?  clrGreyLight : clrTransparent,
              //                          borderRadius: BorderRadius.circular(15),
              //                          border: Border.all(color: clrGrey.withOpacity(0.2))
              //                      ),
              //                      child: Row(
              //                        crossAxisAlignment: CrossAxisAlignment.start,
              //                        children: [
              //                          Padding(
              //                            padding: const EdgeInsets.only(top: 4),
              //                            child: CustomRadioButton(
              //                              splashRadius: 20,
              //                              value: 2,
              //                              width: 2,
              //                              // visualDensity: VisualDensity.compact,
              //                              activeColor: clrYellow,
              //                              text: '',
              //                              groupValue: controller.selectedval.value,
              //                              onChanged: (val) {
              //                                controller.updateSelectedValue(val);
              //                              },
              //                            ),
              //                          ),
              //                          const SizedBox(width: 5,),
              //                          Flexible(
              //                            child: Column(
              //                              crossAxisAlignment: CrossAxisAlignment.start,
              //                              children: [
              //                                const Text(
              //                                    "Monthly",
              //                                    style: TextStyle(
              //                                        fontWeight: FontWeight.w600,
              //                                        fontSize: 18
              //                                    )
              //                                ),
              //                                const SizedBox(height: 5,),
              //                                RichText(
              //                                    text: TextSpan(children: [
              //                                      TextSpan(
              //                                        text: "1 week free",
              //                                        style: TextStyle(
              //                                            color: clrYellow,
              //                                            fontWeight: FontWeight.w700
              //                                        ),
              //                                      ),
              //                                      TextSpan(
              //                                          text: " then €3.99/month",
              //                                          style: TextStyle(
              //                                              color: clrBlacke,fontWeight: FontWeight.w700
              //                                          )
              //                                      )
              //                                    ]
              //                                    )
              //                                ),
              //                                const SizedBox(height: 5,)
              //                              ],
              //                            ),
              //                          ),
              //                          controller.homeController.homeData.value.result!.planType == 'monthly' ? Container(
              //                            padding: const EdgeInsets.symmetric(
              //                                horizontal: 8,
              //                                vertical: 3
              //                            ),
              //                            decoration: BoxDecoration(
              //                                borderRadius: BorderRadius.circular(20),
              //                                color: clrYellow),
              //                            child: const Text(
              //                              "Current plan",
              //                              style: TextStyle(fontSize: 10),
              //                            ),
              //                          ) : SizedBox()
              //                        ],
              //                      ),
              //                    ),
              //                  ),
              //                  ),
              //                   SizedBox(
              //                     height: Get.height * 0.03,
              //                   ),
              //                   // Obx(() =>
              //                       Opacity(
              //                     opacity: 1,
              //                     // opacity: controller.buttonLoadingMonthly.value || controller.buttonLoadingYearly.value || controller.apiLoading.value ? 0.5 : 1,
              //                     child: SizedBox(
              //                       height:Res.h_btn,
              //                       width: double.maxFinite,
              //                       child: CustomElevatedButton(
              //                         onTap: () async{
              //                           // if(!controller.buttonLoadingMonthly.value && !controller.buttonLoadingYearly.value && !controller.apiLoading.value) {
              //                           //   print('button tap');
              //                           //   await controller.buySubscription();
              //                           // }
              //                           // // changePlanAlert();
              //                         },
              //                         backgroundClr: clrBlacke,
              //                         child: Text(
              //                           "Confirm change",
              //                           style: TextStyle(
              //                               color: clrWhite,
              //                               fontSize: 16,
              //                               fontWeight: FontWeight.w700
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              // // )
              //                 ],
              //               )
              //           )
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
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        content: SizedBox(
          width: Get.width * 0.87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: Get.height * .012),
              Center(
                  child: Image.asset(
                    "assets/icons/congratesicon.png",
                    height: Get.height * .095,
                    width: Get.height * .095,
                  )),
              SizedBox(height: Get.height * .012),
              const Center(
                  child: Text(
                    "All set!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                  )),
              SizedBox(height: Get.height * .012),
              Center(
                  child: Text(
                    "Your plan is successfully changed",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: clrGreyTextLight, fontSize: 16),
                  )),
              SizedBox(
                height: Get.height * 0.03,
              ),
              SizedBox(
                height: Res.h_btn,
                width: double.maxFinite,
                child: CustomElevatedButton(
                  onTap: () {
                    Get.back();
                  },
                  backgroundClr: clrBlacke,
                  child: Text(
                    "Let’s explore",
                    style: TextStyle(
                        color: clrWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        )));
  }

}


//
// class SwitchPlanUi extends GetWidget<MymembershipController> {
//   SwitchPlanUi({super.key});
//
//   final PaymentController paymentController = Get.find<PaymentController>();
//
//   @override
//   Widget build(BuildContext context) {
//     var h = Get.height;
//     var w = Get.width;
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CommonUi.appBar(),
//                   const Text(
//                     "Switch plan",
//                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//                   ),
//                   SizedBox(
//                     width: h * .025,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: Get.height * 0.05,
//               ),
//               ListView.separated(
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     final data = paymentController.plans.value.result?[index];
//                     print('data == ${data?.id}');
//                     return Obx(
//                       () => GestureDetector(
//                         onTap: () {
//                           if(paymentController.profileController.profileData.value.result?.planType != data.billingPeriod){
//                             paymentController.updateSelectedValue(index);
//                             paymentController.purchasedPlan.value = data.billingPeriod!;
//                             paymentController.newAmount.value = data.price!;
//                             paymentController.newId.value = data.id.toString();
//                           }
//                           // controller.updateSelectedValue(1);
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 18),
//                           decoration: BoxDecoration(
//                               color:
//                                   paymentController.selectedval.value == index
//                                       ? clrGreyLight
//                                       : clrTransparent,
//                               borderRadius: BorderRadius.circular(15),
//                               border:
//                                   Border.all(color: clrGrey.withOpacity(0.2))),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: CustomRadioButton(
//                                   splashRadius: 20,
//                                   value: data!.id! - 1,
//                                   width: 2,
//                                   // visualDensity: VisualDensity.compact,
//                                   activeColor: clrYellow,
//                                   text: '',
//                                   groupValue:
//                                       paymentController.selectedval.value,
//                                   onChanged: (val) {
//                                     if(paymentController.profileController.profileData.value.result?.planType != data.billingPeriod){
//                                       paymentController.updateSelectedValue(index);
//                                       paymentController.purchasedPlan.value = data.billingPeriod!;
//                                       paymentController.newAmount.value = data.price!;
//                                       paymentController.newId.value = data.id.toString();
//                                     }
//                                     // controller.updateSelectedValue(val);
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               Flexible(
//                                   child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Flexible(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "${data.name}",
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 18),
//                                         ),
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         RichText(
//                                             text: TextSpan(children: [
//                                           // TextSpan(
//                                           //   text:
//                                           //       "${paymentController.getWeek(int.parse(data.trailDays.toString()))} free",
//                                           //   style: TextStyle(
//                                           //       color: clrYellowText,
//                                           //       fontWeight: FontWeight.w700),
//                                           // ),
//                                           TextSpan(
//                                               text:
//                                                   " €${data.price}/${data.billingPeriod == 'monthly' ? 'month' : data.billingPeriod == 'yearly' ? 'year' : ''}",
//                                               style: TextStyle(
//                                                   color: clrBlacke,
//                                                   fontWeight: FontWeight.w700))
//                                         ])),
//                                         const SizedBox(
//                                           height: 5,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               )),
//                               paymentController.profileController.profileData.value.result?.planType == data.billingPeriod ? Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8,
//                                     vertical: 3
//                                 ),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     color: clrYellow),
//                                 child: const Text(
//                                   "Current plan",
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                               ) : SizedBox()
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) => const SizedBox(
//                         height: 20,
//                       ),
//                   itemCount: paymentController.plans.value.result?.length ?? 0),
//               SizedBox(
//                 height: Get.height * 0.03,
//               ),
//               // Obx(() =>
//               Obx(() => Opacity(
//                 opacity: paymentController.switchLoading.value ? 0.5 : 1,
//                 child: SizedBox(
//                   height: Res.h_btn,
//                   width: double.maxFinite,
//                   child: CustomElevatedButton(
//                     onTap: paymentController.switchLoading.value ? (){} : () async {
//                       if(paymentController.profileController.profileData.value.result?.planType == paymentController.purchasedPlan.value){
//                         showTostMsg('Please select different plan');
//                       }else{
//                           paymentController.switchPlanPopUp(onTap: () {
//                             Get.back();
//                             paymentController.switchPlan(planID: paymentController.newId.value, amount: paymentController.newAmount.value);
//                             // paymentController.updateSub(
//                             //     amount: paymentController.newAmount.value,
//                             //     des: paymentController.purchasedPlan.value == 'monthly' ? 'Monthly membership' : 'Yearly membership',
//                             //     duration: paymentController.purchasedPlan.value == 'monthly' ? '1 month' : '12 months',
//                             //   date: DateTime.parse(paymentController.profileController.profileData.value.result!.trailDate.toString())
//                             // );
//                           },);
//                       }
//
//                     },
//                     backgroundClr: clrBlacke,
//                     child: paymentController.switchLoading.value ? CommonUi.buttonLoading() : Text(
//                       "Confirm change",
//                       style: TextStyle(
//                           color: clrWhite,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ),
//               ),)
//               // SizedBox(height: 15,),
//               // Obx(() => SizedBox(
//               //   height: Res.h_btn,
//               //   width: double.maxFinite,
//               //   child: CustomElevatedButton(
//               //     onTap: paymentController.billingLoading.value ? (){} : () async {
//               //       paymentController.updateBilling();
//               //     },
//               //     backgroundClr: clrWhite,
//               //     borderClr: clrBlacke,
//               //     child: paymentController.billingLoading.value ? CommonUi.buttonLoading(color: clrBlacke) : Text(
//               //       "Update billing",
//               //       style: TextStyle(
//               //           color: clrBlacke,
//               //           fontSize: 16,
//               //           fontWeight: FontWeight.w700),
//               //     ),
//               //   ),
//               // ),)
//               // )
//
//               //           Expanded(
//               //               child:Column(
//               //                 children: [
//               //                   Obx(() => GestureDetector(
//               //                     onTap: () {
//               //                       controller.updateSelectedValue(1);
//               //                     },
//               //                     child: Container(
//               //                       padding:
//               //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
//               //                       decoration: BoxDecoration(
//               //                           color: controller.selectedval.value == 1 ?  clrGreyLight : clrTransparent,
//               //                           borderRadius: BorderRadius.circular(15),
//               //                           border: Border.all(color: clrGrey.withOpacity(0.2))
//               //                       ),
//               //                       child: Row(
//               //                         crossAxisAlignment: CrossAxisAlignment.start,
//               //                         children: [
//               //                           Padding(
//               //                             padding: const EdgeInsets.only(top: 4),
//               //                             child: CustomRadioButton(
//               //                               splashRadius: 20,
//               //                               value: 1,
//               //                               width: 2,
//               //                               // visualDensity: VisualDensity.compact,
//               //                               activeColor: clrYellow,
//               //                               text: '',
//               //                               groupValue: controller.selectedval.value,
//               //                               onChanged: (val) {
//               //                                 controller.updateSelectedValue(val);
//               //                               },
//               //                             ),
//               //                           ),
//               //                           const SizedBox(width: 5,),
//               //                           Flexible(
//               //                               child: Row(
//               //                                 crossAxisAlignment: CrossAxisAlignment.start,
//               //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //                                 children: [
//               //                                   Flexible(
//               //                                     child: Column(
//               //                                       crossAxisAlignment: CrossAxisAlignment.start,
//               //                                       children: [
//               //                                         const Text(
//               //                                           "Annual",
//               //                                           style: TextStyle(
//               //                                               fontWeight: FontWeight.w600,
//               //                                               fontSize: 18
//               //                                           ),
//               //                                         ),
//               //                                         const SizedBox(height: 5,),
//               //                                         RichText(
//               //                                             text: TextSpan(children: [
//               //                                               TextSpan(
//               //                                                 text: "3 months free",
//               //                                                 style: TextStyle(
//               //                                                     color: clrYellow,
//               //                                                     fontWeight: FontWeight.w700
//               //                                                 ),
//               //                                               ),
//               //                                               TextSpan(
//               //                                                   text: " then €23.99/year",
//               //                                                   style: TextStyle(
//               //                                                       color: clrBlacke,
//               //                                                       fontWeight: FontWeight.w700
//               //                                                   )
//               //                                               )
//               //                                             ]
//               //                                             )
//               //                                         ),
//               //                                         const SizedBox(height: 5,)
//               //                                       ],
//               //                                     ),
//               //                                   ),
//               //                                 ],
//               //                               )
//               //                           ),
//               //                           controller.homeController.homeData.value.result!.planType == 'yearly' ? Container(
//               //                             padding: const EdgeInsets.symmetric(
//               //                                 horizontal: 8,
//               //                                 vertical: 3
//               //                             ),
//               //                             decoration: BoxDecoration(
//               //                                 borderRadius: BorderRadius.circular(20),
//               //                                 color: clrYellow),
//               //                             child: const Text(
//               //                               "Current plan",
//               //                               style: TextStyle(fontSize: 10),
//               //                             ),
//               //                           ) : SizedBox()
//               //                         ],
//               //                       ),
//               //                     ),
//               //                   ),
//               //                   ),
//               //                   SizedBox(
//               //                     height: Get.height * 0.02,
//               //                   ),
//               //                  Obx(() =>  GestureDetector(
//               //                    onTap: () {
//               //                      controller.updateSelectedValue(2);
//               //                    },
//               //                    child: Container(
//               //                      padding:
//               //                      const EdgeInsets.symmetric(horizontal: 10, vertical:18),
//               //                      decoration: BoxDecoration(
//               //                          color:  controller.selectedval.value == 2 ?  clrGreyLight : clrTransparent,
//               //                          borderRadius: BorderRadius.circular(15),
//               //                          border: Border.all(color: clrGrey.withOpacity(0.2))
//               //                      ),
//               //                      child: Row(
//               //                        crossAxisAlignment: CrossAxisAlignment.start,
//               //                        children: [
//               //                          Padding(
//               //                            padding: const EdgeInsets.only(top: 4),
//               //                            child: CustomRadioButton(
//               //                              splashRadius: 20,
//               //                              value: 2,
//               //                              width: 2,
//               //                              // visualDensity: VisualDensity.compact,
//               //                              activeColor: clrYellow,
//               //                              text: '',
//               //                              groupValue: controller.selectedval.value,
//               //                              onChanged: (val) {
//               //                                controller.updateSelectedValue(val);
//               //                              },
//               //                            ),
//               //                          ),
//               //                          const SizedBox(width: 5,),
//               //                          Flexible(
//               //                            child: Column(
//               //                              crossAxisAlignment: CrossAxisAlignment.start,
//               //                              children: [
//               //                                const Text(
//               //                                    "Monthly",
//               //                                    style: TextStyle(
//               //                                        fontWeight: FontWeight.w600,
//               //                                        fontSize: 18
//               //                                    )
//               //                                ),
//               //                                const SizedBox(height: 5,),
//               //                                RichText(
//               //                                    text: TextSpan(children: [
//               //                                      TextSpan(
//               //                                        text: "1 week free",
//               //                                        style: TextStyle(
//               //                                            color: clrYellow,
//               //                                            fontWeight: FontWeight.w700
//               //                                        ),
//               //                                      ),
//               //                                      TextSpan(
//               //                                          text: " then €3.99/month",
//               //                                          style: TextStyle(
//               //                                              color: clrBlacke,fontWeight: FontWeight.w700
//               //                                          )
//               //                                      )
//               //                                    ]
//               //                                    )
//               //                                ),
//               //                                const SizedBox(height: 5,)
//               //                              ],
//               //                            ),
//               //                          ),
//               //                          controller.homeController.homeData.value.result!.planType == 'monthly' ? Container(
//               //                            padding: const EdgeInsets.symmetric(
//               //                                horizontal: 8,
//               //                                vertical: 3
//               //                            ),
//               //                            decoration: BoxDecoration(
//               //                                borderRadius: BorderRadius.circular(20),
//               //                                color: clrYellow),
//               //                            child: const Text(
//               //                              "Current plan",
//               //                              style: TextStyle(fontSize: 10),
//               //                            ),
//               //                          ) : SizedBox()
//               //                        ],
//               //                      ),
//               //                    ),
//               //                  ),
//               //                  ),
//               //                   SizedBox(
//               //                     height: Get.height * 0.03,
//               //                   ),
//               //                   // Obx(() =>
//               //                       Opacity(
//               //                     opacity: 1,
//               //                     // opacity: controller.buttonLoadingMonthly.value || controller.buttonLoadingYearly.value || controller.apiLoading.value ? 0.5 : 1,
//               //                     child: SizedBox(
//               //                       height:Res.h_btn,
//               //                       width: double.maxFinite,
//               //                       child: CustomElevatedButton(
//               //                         onTap: () async{
//               //                           // if(!controller.buttonLoadingMonthly.value && !controller.buttonLoadingYearly.value && !controller.apiLoading.value) {
//               //                           //   print('button tap');
//               //                           //   await controller.buySubscription();
//               //                           // }
//               //                           // // changePlanAlert();
//               //                         },
//               //                         backgroundClr: clrBlacke,
//               //                         child: Text(
//               //                           "Confirm change",
//               //                           style: TextStyle(
//               //                               color: clrWhite,
//               //                               fontSize: 16,
//               //                               fontWeight: FontWeight.w700
//               //                           ),
//               //                         ),
//               //                       ),
//               //                     ),
//               //                   ),
//               // // )
//               //                 ],
//               //               )
//               //           )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   changePlanAlert() async {
//     Get.dialog(AlertDialog(
//         backgroundColor: clrWhite,
//         insetPadding: const EdgeInsets.symmetric(horizontal: 13),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//         content: SizedBox(
//           width: Get.width * 0.87,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: Get.height * .012),
//               Center(
//                   child: Image.asset(
//                 "assets/icons/congratesicon.png",
//                 height: Get.height * .095,
//                 width: Get.height * .095,
//               )),
//               SizedBox(height: Get.height * .012),
//               const Center(
//                   child: Text(
//                 "All set!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
//               )),
//               SizedBox(height: Get.height * .012),
//               Center(
//                   child: Text(
//                 "Your plan is successfully changed",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: clrGreyTextLight, fontSize: 16),
//               )),
//               SizedBox(
//                 height: Get.height * 0.03,
//               ),
//               SizedBox(
//                 height: Res.h_btn,
//                 width: double.maxFinite,
//                 child: CustomElevatedButton(
//                   onTap: () {
//                     Get.back();
//                   },
//                   backgroundClr: clrBlacke,
//                   child: Text(
//                     "Let’s explore",
//                     style: TextStyle(
//                         color: clrWhite,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )));
//   }
//
// // cancelPlanAlert() async {
// //   Get.dialog(AlertDialog(
// //     backgroundColor: clrWhite,
// //       insetPadding: const EdgeInsets.symmetric(horizontal: 13),
// //       contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
// //       content: SizedBox(
// //         width: Get.width * 0.87,
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Center(child: Text("Are you sure to cancel?",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),)),
// //             const SizedBox(
// //               height: 10,
// //             ),
// //             Center(child: Text("You will remain a member till 31 May and won’t be charged from 1 June.",textAlign: TextAlign.center,style: TextStyle(color: clrGreyTextLight),)),
// //              SizedBox(
// //               height: Get.height*0.03,
// //             ),
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: SizedBox(
// //                     height: 45,
// //                     child: CustoElevatedBtn(onTap: () {
// //                       Get.back();
// //                     },
// //                       backgroundClr: clrBlacke,
// //                       child: Text("No, stay",style: TextStyle(color: clrWhite),),),
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: 10,
// //                 ),
// //                 Expanded(
// //                   child: SizedBox(
// //                     height: 45,
// //                     child: CustoFilterBtn(ontap: () {
// //                       Get.back();
// //                     },borderClr: clrBlacke,
// //                       backgroundClr: clrWhite,
// //                       lable: Text("Yes, cancel",style: TextStyle(color: clrBlacke),),),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //
// //
// //           ],
// //         ),
// //       )));
// // }
// }
