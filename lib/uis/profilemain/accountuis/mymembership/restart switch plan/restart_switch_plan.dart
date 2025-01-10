import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/controller/mymembership_controller.dart';
import 'package:plusone/utils/custom_radio.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/common.dart';


class RestartSwitchPlanUi extends StatefulWidget {
  const RestartSwitchPlanUi({super.key});

  @override
  State<RestartSwitchPlanUi> createState() => _RestartSwitchPlanUiState();
}

class _RestartSwitchPlanUiState extends State<RestartSwitchPlanUi> {

  final PaymentController paymentController = Get.find<PaymentController>();

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
                          if(paymentController.profileController.profileData.value.result?.restartPlan?.planType != data.billingPeriod){
                            paymentController.restartUpdateSelectedValue(index);
                            paymentController.restartPurchasedPlan.value = data.billingPeriod!;
                            paymentController.restartNewAmount.value = data.price!;
                            paymentController.restartNewId.value = data.id.toString();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 18),
                          decoration: BoxDecoration(
                              color:
                              paymentController.restartSelectedValue.value == index
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
                                  paymentController.restartSelectedValue.value,
                                  onChanged: (val) {
                                    if(paymentController.profileController.profileData.value.result?.restartPlan?.planType != data.billingPeriod){
                                      paymentController.restartUpdateSelectedValue(index);
                                      paymentController.restartPurchasedPlan.value = data.billingPeriod!;
                                      paymentController.restartNewAmount.value = data.price!;
                                      paymentController.restartNewId.value = data.id.toString();
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
                                            RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                      " €${data.price}/${data.billingPeriod == 'monthly' ? 'month' : data.billingPeriod == 'yearly' ? 'year' : ''}",
                                                      style: TextStyle(
                                                          color: clrBlacke,
                                                          fontWeight: FontWeight.w700))
                                                ])),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            paymentController.profileController.profileData.value.result?.myReferDays != null ? Text('Your referral code has been added',style: TextStyle(
                                                color: clrBlacke.withOpacity(0.5)
                                            ),) : SizedBox()
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              paymentController.profileController.profileData.value.result?.restartPlan?.planType == data.billingPeriod ? Container(
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
                opacity: paymentController.restartSwitchLoading.value ? 0.5 : 1,
                child: SizedBox(
                  height: Res.h_btn,
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                    onTap: paymentController.restartSwitchLoading.value ? (){} : () async {
                      if(paymentController.profileController.profileData.value.result?.restartPlan?.planType == paymentController.restartPurchasedPlan.value){
                        showTostMsg('Please select different plan');
                      }else{
                        paymentController.switchPlanPopUp(onTap: () {
                          Get.back();
                          paymentController.switchRestartPlan(planID: paymentController.restartNewId.value, amount: paymentController.restartNewAmount.value);
                        },);
                      }

                    },
                    backgroundClr: clrBlacke,
                    child: paymentController.restartSwitchLoading.value ? CommonUi.buttonLoading() : Text(
                      "Confirm change",
                      style: TextStyle(
                          color: clrWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),)
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

