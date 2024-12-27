import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/restart%20membership/restart_membership_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:url_launcher/url_launcher.dart';

class ReStartMembershipScreen extends StatelessWidget {
  ReStartMembershipScreen({super.key});

  final PaymentController paymentController = Get.find<PaymentController>();
  final ReStartMembershipController restartController = Get.find<ReStartMembershipController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  CommonUi.appBar(),
                ],
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
              const Text(
                "Become a PlusOnes member",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                        "Join our members-only platform to find like-minded activity partners in a high-quality and safe community.",
                        style: TextStyle(
                            color: clrGrey5D5C5E)),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    ListView.separated(itemBuilder: (context, index) {
                      final data = paymentController.plans.value.result?[index];
                      return Obx(() => GestureDetector(
                        onTap: () {
                          restartController.updatePlan(index,data.price!,data.trailDays!,data.billingPeriod.toString(),data.id.toString());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 18),
                          decoration: BoxDecoration(
                              // color: paymentController.choosePlan.value == index ? clrGreyLight : clrWhite,
                              borderRadius:
                              BorderRadius.circular(10),
                              border: Border.all(
                                  color: clrGrey
                                      .withOpacity(0.3))),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Radio(
                                value: data!.id! - 1,
                                groupValue: restartController.choosePlan.value,
                                onChanged: (val) {
                                  restartController.updatePlan(index,data.price!,data.trailDays!,data.billingPeriod.toString(),data.id.toString());
                                },
                                visualDensity:
                                VisualDensity.compact,
                                activeColor: clrYellow,
                              ),
                              Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              "${data.name}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight
                                                      .w600),
                                            ),
                                            RichText(
                                                text: TextSpan(
                                                    children: [
                                                      paymentController.profileController.profileData.value.result?.cardDetail?.cardSave == false ? TextSpan(
                                                        text:
                                                        "${paymentController.getWeek(int.parse(data.trailDays.toString()))} free",
                                                        style: TextStyle(
                                                            color:
                                                            clrYellowText),
                                                      ) : const TextSpan(),
                                                      TextSpan(
                                                          text:
                                                          " ${paymentController.profileController.profileData.value.result?.cardDetail?.cardSave == false ? 'then' : ''} €${data.price}/${data.billingPeriod == 'monthly' ? 'month' : data.billingPeriod == 'yearly' ? 'year' : ''}",
                                                          style: TextStyle(
                                                              color:
                                                              clrGrey5D5C5E))
                                                    ])),
                                          ],
                                        ),
                                      ),
                                      data.billingPeriod == 'yearly' ? Container(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 8,
                                            vertical: 3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(20),
                                            color: clrYellow),
                                        child: const Text(
                                          "Best value",
                                          style: TextStyle(
                                              fontSize: 10),
                                        ),
                                      ) : const SizedBox()
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),);
                    },shrinkWrap: true, separatorBuilder: (context, index) => const SizedBox(height: 20,), itemCount: paymentController.plans.value.result!.length),

                    paymentController.profileController.profileData.value.result?.referalApplied == null ? SizedBox(
                      height: Get.height * 0.03,
                    ) : SizedBox(),
                    paymentController.profileController.profileData.value.result?.referalApplied == null ? Row(
                      children: [
                        Flexible(
                          child: Opacity(
                            opacity: paymentController.profileController.profileData.value.result?.referalApplied == null ? 1 : 0.5,
                            child: CustoTextFormField(
                              hintText: 'Enter referral code',
                              controll: paymentController.referalController,
                              readonly: paymentController.profileController.profileData.value.result?.referalApplied == null ? false : true,
                            ),
                          ),
                        ),
                        paymentController.profileController.profileData.value.result?.referalApplied == null ? SizedBox(width: Get.width*0.04,) :SizedBox(),
                        paymentController.profileController.profileData.value.result?.referalApplied == null ? Obx(() => Opacity(
                          opacity: paymentController.referalLoading.value ? 0.5 : 1,
                          child: SizedBox(
                            height: Get.height*.06,
                            child: CustomElevatedButton(onTap: () {
                              paymentController.applyCode();
                            }, backgroundClr: clrBlacke,paddingHz: 20,paddingVr: 10, child: paymentController.referalLoading.value ? CommonUi.buttonLoading() : Text('Apply',style: TextStyle(color: clrWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),)),
                          ),
                        ),) : SizedBox(),
                        paymentController.profileController.profileData.value.result?.referalApplied == null ? const SizedBox(width: 10,) : SizedBox(),
                      ],
                    ) : SizedBox(),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Obx(() => RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                            "By starting your membership, you agree to our ",
                            style: TextStyle(
                              color: clrGrey5D5C5E,
                              height: 1.5,
                            ),
                          ),
                          TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () async{
                                await launchUrl(Uri.parse('https://plusonesapp.com/terms-and-conditions'));
                              },
                              text: " Terms of Service",
                              style: TextStyle(
                                  color: clrYellowText,
                                  decoration: TextDecoration
                                      .underline,
                                  height: 1.5)),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(
                                color: clrGrey5D5C5E,
                                height: 1.5),
                          ),
                          TextSpan(
                              text: "Privacy Policy.",
                              recognizer: TapGestureRecognizer()..onTap = () async{
                                await launchUrl(Uri.parse('https://plusonesapp.com/privacy-policy'));
                              },
                              style: TextStyle(
                                  color: clrYellowText,
                                  decoration: TextDecoration
                                      .underline,
                                  height: 1.5)),
                          paymentController.profileController.profileData.value.result?.cardDetail?.cardSave == false ? TextSpan(
                            text:
                            " After the free trial, your membership will auto-renew ${restartController.selectedPlan.value.isNotEmpty ? restartController.selectedPlan.value == 'yearly' ? 'annually' : 'monthly' : ''} at ${restartController.choosePlan.value != (-1) ? '€${restartController.price.value}' : 'regular price'} unless cancelled. You authorise charges for late cancellations and no-shows. These policies ensure a committed and genuine community.",
                            style: TextStyle(
                                color: clrGrey5D5C5E,
                                height: 1.5),
                          ) : TextSpan(
                            text:
                            "Your membership will auto-renew ${restartController.selectedPlan.value.isNotEmpty ? restartController.selectedPlan.value == 'yearly' ? 'annually' : 'monthly' : ''} at ${restartController.choosePlan.value != (-1) ? '€${restartController.price.value}' : 'regular price'} unless cancelled. You authorise charges for late cancellations and no-shows. These policies ensure a committed and genuine community.",
                            style: TextStyle(
                                color: clrGrey5D5C5E,
                                height: 1.5),
                          )
                        ])),)
                  ],
                ),
              ),
              Obx(() => Opacity(
                opacity: restartController.loading.value ? 0.5 : 1,
                child: SizedBox(
                  height: Res.h_btn,
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                      onTap: restartController.loading.value ? (){} : () {
                        if(restartController.choosePlan.value == (-1)){
                          showTostMsg('Please select any plan.');
                        }else{
                          print('selected');
                          // restartController.restartPlan(customerID: paymentController.profileController.profileData.value.result!.cardDetail!.customerId.toString());
                        }
                      },
                      backgroundClr: clrBlacke,
                      child: Text('Start now',style: TextStyle(
                          color: clrWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700))),),
              ),),
              SizedBox(
                height: Get.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
