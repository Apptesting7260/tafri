import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/controller/mymembership_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/colors.dart';

class MyMemberShipUi extends GetWidget<MymembershipController> {
  MyMemberShipUi({super.key});

  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;

    var referCode = Get.arguments ?? '';
    paymentController.referalController.text = referCode ?? '';

    return GestureDetector(
      onTap: () {
        print('tap');
        FocusScope.of(context).unfocus();
        paymentController.handleExternalPurchase();
      },
      child: Scaffold(
        backgroundColor: clrWhite,
        body: SmartRefresher(
          controller: controller.refreshController,
          header: CommonUi.refreshHeader(),
          onRefresh: () async{
            paymentController.getPlan();
            paymentController.profileController.viewProfile();
            await controller.homeController.homePageApi();
            controller.refreshController.refreshCompleted();
          },
          child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                  child: Obx(
                    () => (controller.homeController.homePageLoading.value || paymentController.plansLoading.value) && (paymentController.plans.value.result == null || paymentController.plans.value.result!.isEmpty)
                        ? Center(child: CommonUi.scaffoldLoading(color: clrYellow))
                        : controller.homeController.homeError.value.isNotEmpty || paymentController.planError.value.isNotEmpty
                            ? const Center(child: ErrorScreen())
                            : paymentController.profileController.profileData.value.result?.membershipStatus == true
                                ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            CommonUi.appBar(),
                                            const Text(
                                              "My membership",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 19),
                                            ),
                                            SizedBox(
                                              width: w * .05,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.035,
                                        ),

                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              // color: clrGreyLight,
                                              border: Border.all(
                                                  color: clrGrey.withOpacity(0.4))),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text("${getSubscriptionStatus() == 'monthly' ? 'Monthly' : getSubscriptionStatus() == 'yearly' ? 'Annually' : getSubscriptionStatus()}", style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 18),),
                                              // Text(
                                              //   paymentController.profileController.profileData.value.result?.planType == 'monthly' ?  'Monthly' : "Annually",
                                              //   style: const TextStyle(
                                              //       fontWeight: FontWeight.w600,
                                              //       fontSize: 18),
                                              // ),
                                              const SizedBox(
                                                height: 5,
                                              ),

                                              /// for trail
                                              paymentController.profileController.profileData.value.result?.restartPlan?.planType == null && paymentController.profileController.profileData.value.result?.trailDate != null && paymentController.profileController.profileData.value.result?.cancelDate != null ? RichText(
                                                  text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: 'You have ',
                                                            style: TextStyle(
                                                                color: clrGreyTextLight,
                                                                fontSize: 14,
                                                                fontFamily: 'Nunito',
                                                                fontWeight: FontWeight.w600
                                                            )
                                                        ),
                                                        TextSpan(
                                                            text: 'cancelled',
                                                            style: TextStyle(
                                                                color: clrGreyTextLight,
                                                                fontSize: 14,
                                                                fontFamily: 'Nunito',
                                                                fontWeight: FontWeight.w600
                                                            )
                                                        ),
                                                        TextSpan(
                                                            text: ' your trial.',
                                                            style: TextStyle(
                                                                color: clrGreyTextLight,
                                                                fontSize: 14,
                                                                fontFamily: 'Nunito',
                                                                fontWeight: FontWeight.w600
                                                            )
                                                        ),
                                                      ]
                                                  )
                                              ) : paymentController.profileController.profileData.value.result?.restartPlan?.planType == null && paymentController.profileController.profileData.value.result?.trailDate != null ? RichText(
                                                text: TextSpan(
                                                   children: [
                                                     TextSpan(
                                                       text: 'You are currently on a ',
                                                       style: TextStyle(
                                                           color: clrGreyTextLight,
                                                           fontSize: 14,
                                                           fontFamily: 'Nunito',
                                                           fontWeight: FontWeight.w600
                                                       )
                                                     ),
                                                     TextSpan(
                                                       text: 'free trial',
                                                       style: TextStyle(
                                                         color: clrYellowText,
                                                           fontSize: 14,
                                                           fontFamily: 'Nunito',
                                                           fontWeight: FontWeight.w600
                                                       )
                                                     ),
                                                   ]
                                                )
                                              ) : SizedBox(),
                                              /// for trail

                                              paymentController.profileController.profileData.value.result?.trailDate != null ? SizedBox(height: 2,) : SizedBox(),

                                              paymentController.profileController.profileData.value.result?.restartPlan?.planType == null && paymentController.profileController.profileData.value.result?.trailDate != null && paymentController.profileController.profileData.value.result?.cancelDate != null ? RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Your current ',style: TextStyle(
                                                      color: clrGrey5D5C5E,
                                                      fontSize: 14,
                                                      fontFamily: 'Nunito',
                                                    )),
                                                    TextSpan(
                                                      text: '${paymentController.profileController.profileData.value.result?.planType == 'monthly' ?  'monthly' : "annually"}',
                                                      style: TextStyle(
                                                        color: clrYellowText,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )
                                                    ),
                                                    TextSpan(
                                                      text: ' plan will remain active until ',style: TextStyle(
                                                      color: clrGrey5D5C5E,
                                                      fontSize: 14,
                                                      fontFamily: 'Nunito',
                                                    )),
                                                    TextSpan(
                                                      text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',
                                                        style: TextStyle(
                                                          color: clrYellowText,
                                                          fontSize: 14,
                                                          fontFamily: 'Nunito',
                                                        )),
                                                    TextSpan(
                                                      text: ', after which it will not renew, and you will not be charged again.',style: TextStyle(
                                                      color: clrGrey5D5C5E,
                                                      fontSize: 14,
                                                      fontFamily: 'Nunito',
                                                    ))


                                                    // TextSpan(
                                                    //   text: 'Your plan will not renew, and there will be no further charges after ',
                                                    //     style: TextStyle(
                                                    //         color: clrGrey5D5C5E,
                                                    //         fontSize: 14,
                                                    //         fontFamily: 'Nunito',
                                                    //     )
                                                    // ),
                                                    // TextSpan(
                                                    //   text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',
                                                    //     style: TextStyle(
                                                    //         color: clrYellowText,
                                                    //         fontSize: 14,
                                                    //         fontFamily: 'Nunito',
                                                    //     )
                                                    // ),
                                                    // TextSpan(
                                                    //     text: '.',
                                                    //     style: TextStyle(
                                                    //       color: clrGrey5D5C5E,
                                                    //       fontSize: 14,
                                                    //       fontFamily: 'Nunito',
                                                    //     )
                                                    // ),
                                                  ]
                                                ),
                                              ) : paymentController.profileController.profileData.value.result?.restartPlan?.planType == null && paymentController.profileController.profileData.value.result?.trailDate != null ? RichText(
                                                  text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: 'Starting ',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: clrGrey5D5C5E,
                                                                fontFamily: 'Nunito',
                                                            )
                                                        ),
                                                        TextSpan(
                                                            text: '${DateFormat('d MMMM').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: clrYellowText,
                                                              fontFamily: 'Nunito',
                                                            )
                                                        ),
                                                        TextSpan(
                                                            text: ', your plan will renew for the regular price of €${paymentController.getAmount(paymentController.profileController.profileData.value.result?.planType == 'monthly' ? 'monthly' : 'yearly')}',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: clrGrey5D5C5E,
                                                              fontFamily: 'Nunito',
                                                            )
                                                        ),
                                                        TextSpan(
                                                            text: ' ${paymentController.profileController.profileData.value.result?.planType == 'monthly' ? 'monthly' : 'annually'}',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: clrYellowText,
                                                              fontFamily: 'Nunito',
                                                            )
                                                        ),
                                                        TextSpan(
                                                            text: '.',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: clrGrey5D5C5E,
                                                              fontFamily: 'Nunito',
                                                            )
                                                        ),
                                                      ]
                                                  )
                                              ) : paymentController.profileController.profileData.value.result?.cancelDate != null ? Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  paymentController.profileController.profileData.value.result?.restartPlan?.planType != null && paymentController.profileController.profileData.value.result?.restartPlan?.cancelDate == null ? SizedBox() :
                                                  paymentController.profileController.profileData.value.result?.switchPlan!.planId != null && paymentController.profileController.profileData.value.result?.switchPlan!.cancelDate != null ? RichText(text: TextSpan(
                                                    children: [
                                                      TextSpan(text: 'You have ', style: TextStyle(
                                                          color: clrGreyTextLight,
                                                          fontSize: 14,
                                                          fontFamily: 'Nunito',
                                                          fontWeight: FontWeight.w600
                                                      )),
                                                      TextSpan(text: 'cancelled', style: TextStyle(
                                                          color: clrGreyTextLight,
                                                          fontSize: 14,
                                                          fontFamily: 'Nunito',
                                                          fontWeight: FontWeight.w600,
                                                      )),
                                                      TextSpan(text: ' your membership.', style: TextStyle(
                                                          color: clrGreyTextLight,
                                                          fontSize: 14,
                                                          fontFamily: 'Nunito',
                                                          fontWeight: FontWeight.w600
                                                      )),
                                                    ]
                                                  )) : paymentController.profileController.profileData.value.result?.switchPlan!.cancelDate == null && paymentController.profileController.profileData.value.result?.switchPlan!.planId == null && paymentController.profileController.profileData.value.result?.cancelDate != null ? RichText(text: TextSpan(
                                                      children: [
                                                        TextSpan(text: 'You have ', style: TextStyle(
                                                            color: clrGreyTextLight,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                            fontWeight: FontWeight.w600
                                                        )),
                                                        TextSpan(text: 'cancelled', style: TextStyle(
                                                            color: clrGreyTextLight,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                            fontWeight: FontWeight.w600,

                                                        )),
                                                        TextSpan(text: ' your membership.', style: TextStyle(
                                                            color: clrGreyTextLight,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                            fontWeight: FontWeight.w600
                                                        )),
                                                      ]
                                                  )) : paymentController.profileController.profileData.value.result?.switchPlan!.cancelDate == null && paymentController.profileController.profileData.value.result?.cancelDate != null ? SizedBox() : RichText(text: TextSpan(
                                                      children: [
                                                        TextSpan(text: 'You have ', style: TextStyle(
                                                            color: clrGreyTextLight,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                            fontWeight: FontWeight.w600
                                                        )),
                                                        TextSpan(text: 'cancelled', style: TextStyle(
                                                            color: clrGreyTextLight,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                            fontWeight: FontWeight.w600,
                                                        )),
                                                        TextSpan(text: ' your membership.', style: TextStyle(
                                                            color: clrGreyTextLight,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                            fontWeight: FontWeight.w600
                                                        )),
                                                      ]
                                                  )),
                                                  const SizedBox(height: 2,),
                                                  paymentController.profileController.profileData.value.result?.restartPlan?.planType != null && paymentController.profileController.profileData.value.result?.restartPlan?.cancelDate == null ? RichText(text: TextSpan(
                                                    children: [

                                                      ///restart plan
                                                      TextSpan(
                                                          text: 'Your current ',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                          text: '${paymentController.profileController.profileData.value.result?.planType}',
                                                          style: TextStyle(
                                                            color: clrYellowText,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: ' plan is active. From ',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',style: TextStyle(
                                                        color: clrYellowText,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                          text: ', your plan will switch to the ',
                                                          style: TextStyle(
                                                            color: clrGrey5D5C5E,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: '${paymentController.profileController.profileData.value.result?.restartPlan!.planType == 'monthly' ? 'monthly' : 'annual'}',style: TextStyle(
                                                        color: clrYellowText,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                          text: ' plan automatically, and you will be charged ',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                          text: '€${paymentController.getAmount(paymentController.profileController.profileData.value.result?.restartPlan!.planType == 'monthly' ? 'monthly' : 'yearly')}',
                                                          style: TextStyle(
                                                            color: clrGrey5D5C5E,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: ' ${paymentController.profileController.profileData.value.result?.restartPlan!.planType == 'monthly' ? 'monthly' : 'annually'}',style: TextStyle(
                                                        color: clrYellowText,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                          text: '.',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),




                                                      // TextSpan(
                                                      //   text: 'Your current ${paymentController.profileController.profileData.value.result?.planType} plan remains active until ',style: TextStyle(
                                                      //   color: clrGrey5D5C5E,
                                                      //   fontSize: 14,
                                                      //   fontFamily: 'Nunito',
                                                      // )),
                                                      // TextSpan(text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',style: TextStyle(
                                                      //   color: clrYellowText,
                                                      //   fontSize: 14,
                                                      //   fontFamily: 'Nunito',
                                                      // )),
                                                      // TextSpan(
                                                      //     text: ', then your new ${paymentController.profileController.profileData.value.result?.restartPlan!.planType} plan will active.',style: TextStyle(
                                                      //   color: clrGrey5D5C5E,
                                                      //   fontSize: 14,
                                                      //   fontFamily: 'Nunito',
                                                      // ))
                                                    ]
                                                  )) :
                                                  paymentController.profileController.profileData.value.result?.switchPlan!.planId != null && paymentController.profileController.profileData.value.result?.switchPlan!.cancelDate == null && paymentController.profileController.profileData.value.result?.cancelDate != null ? RichText(text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Your current ',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                        text: '${paymentController.profileController.profileData.value.result?.planType}',
                                                        style: TextStyle(
                                                          color: clrYellowText,
                                                          fontSize: 14,
                                                          fontFamily: 'Nunito',
                                                        )
                                                      ),
                                                      TextSpan(
                                                          text: ' plan is active. From ',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',style: TextStyle(
                                                        color: clrYellowText,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                        text: ', your plan will switch to the ',
                                                        style: TextStyle(
                                                          color: clrGrey5D5C5E,
                                                          fontSize: 14,
                                                          fontFamily: 'Nunito',
                                                        )
                                                      ),
                                                      TextSpan(
                                                        text: '${paymentController.profileController.profileData.value.result?.switchPlan!.planId == 'monthly' ? 'monthly' : 'annual'}',style: TextStyle(
                                                        color: clrYellowText,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                        text: ' plan automatically, and you will be charged ',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                        text: '€${paymentController.getAmount(paymentController.profileController.profileData.value.result?.switchPlan!.planId == 'monthly' ? 'monthly' : 'yearly')}',
                                                          style: TextStyle(
                                                            color: clrGrey5D5C5E,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                          )
                                                      ),
                                                      TextSpan(
                                                        text: ' ${paymentController.profileController.profileData.value.result?.switchPlan!.planId == 'monthly' ? 'monthly' : 'annually'}',style: TextStyle(
                                                        color: clrYellowText,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                          text: '.',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                    ]
                                                  )) : RichText(text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Your current ',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                          text: '${paymentController.profileController.profileData.value.result?.planType == 'monthly' ?  'monthly' : "annually"}',
                                                          style: TextStyle(
                                                            color: clrYellowText,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: ' plan will remain active until ',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      )),
                                                      TextSpan(
                                                          text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',
                                                          style: TextStyle(
                                                            color: clrYellowText,
                                                            fontSize: 14,
                                                            fontFamily: 'Nunito',
                                                          )),
                                                      TextSpan(
                                                          text: ', after which it will not renew, and you will not be charged again.',style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                      ))



                                                      // TextSpan(text: 'Your plan will not renew, and there will be no further charges after ',style: TextStyle(
                                                      //   color: clrGrey5D5C5E,
                                                      //   fontSize: 14,
                                                      //   fontFamily: 'Nunito',
                                                      // )),
                                                      // TextSpan(text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',style: TextStyle(
                                                      //   color: clrYellowText,
                                                      //   fontSize: 14,
                                                      //   fontFamily: 'Nunito',
                                                      // )),
                                                      // TextSpan(text: '.',style: TextStyle(
                                                      //   color: clrGrey5D5C5E,
                                                      //   fontSize: 14,
                                                      //   fontFamily: 'Nunito',
                                                      // )),
                                                    ]
                                                  ))
                                                ],
                                              ) : RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: 'Your current ',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: clrGrey5D5C5E,
                                                            fontFamily: 'Nunito',
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: '${paymentController.profileController.profileData.value.result?.planType == 'monthly' ? 'monthly' : 'annually'}',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: clrYellowText,
                                                            fontFamily: 'Nunito',
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: ' plan is active and will renew automatically on ',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: clrGrey5D5C5E,
                                                            fontFamily: 'Nunito',
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: clrYellowText,
                                                            fontFamily: 'Nunito',
                                                          )
                                                      ),
                                                      TextSpan(
                                                          text: '.',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: clrGrey5D5C5E,
                                                            fontFamily: 'Nunito',
                                                          )
                                                      ),
                                                    ]
                                                  )
                                              )

                                            ],
                                          ),
                                        ),

                                        // /// switch plan
                                        // paymentController.profileController.profileData.value.result?.switchPlan?.planId != null && paymentController.profileController.profileData.value.result?.switchPlan?.cancelDate == null ? SizedBox(
                                        //   height: Get.height * 0.025,
                                        // ) : const SizedBox(),
                                        // paymentController.profileController.profileData.value.result?.switchPlan?.planId != null && paymentController.profileController.profileData.value.result?.switchPlan?.cancelDate == null ? Container(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       horizontal: 20, vertical: 20),
                                        //   decoration: BoxDecoration(
                                        //       borderRadius:
                                        //       BorderRadius.circular(10),
                                        //       // color: clrGreyLight,
                                        //       border: Border.all(
                                        //           color: clrGrey.withOpacity(0.4))),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        //     children: [
                                        //       Text(paymentController.profileController.profileData.value.result?.switchPlan?.planId == 'monthly' ? 'Monthly' : 'Annually',
                                        //         style: const TextStyle(
                                        //             fontWeight: FontWeight.w600,
                                        //             fontSize: 18),
                                        //       ),
                                        //       const SizedBox(height: 5,),
                                        //       // Text(
                                        //       //   paymentController.profileController.profileData.value.result?.switchPlan?.planId == 'monthly' ? "Your plan will be activate after the annual plan." : "Your plan will be activate after the monthly plan.",
                                        //       //   style: TextStyle(
                                        //       //       fontSize: 13,
                                        //       //       color: clrGrey5D5C5E),
                                        //       // ),
                                        //       RichText(text: TextSpan(
                                        //         children: [
                                        //           TextSpan(text: 'The changes to your membership have been made, and your new plan will renew at €${paymentController.getAmount(paymentController.profileController.profileData.value.result?.switchPlan?.planId == 'monthly' ? 'monthly' : 'yearly')} per',style: TextStyle(
                                        //             fontSize: 14,
                                        //             color: clrGrey5D5C5E,
                                        //             fontFamily: 'Nunito',
                                        //           )),
                                        //           TextSpan(text: ' ${paymentController.profileController.profileData.value.result?.switchPlan?.planId == 'monthly' ? 'month' : 'year'} ',style: TextStyle(
                                        //             fontSize: 14,
                                        //             color: clrYellowText,
                                        //             fontFamily: 'Nunito',
                                        //           )),
                                        //           TextSpan(text: 'starting ',style: TextStyle(
                                        //             fontSize: 14,
                                        //             color: clrGrey5D5C5E,
                                        //             fontFamily: 'Nunito',
                                        //           )),
                                        //           TextSpan(text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',style: TextStyle(
                                        //             fontSize: 14,
                                        //             color: clrYellowText,
                                        //             fontFamily: 'Nunito',
                                        //           )),
                                        //           TextSpan(text: '.',style: TextStyle(
                                        //             fontSize: 14,
                                        //             color: clrGrey5D5C5E,
                                        //             fontFamily: 'Nunito',
                                        //           )),
                                        //         ]
                                        //       ))
                                        //     ],
                                        //   ),
                                        // ) : const SizedBox(),
                                        // SizedBox(height: 20,),
                                        //
                                        // /// restart plan
                                        // paymentController.profileController.profileData.value.result?.restartPlan?.planType != null && paymentController.profileController.profileData.value.result?.restartPlan?.cancelDate == null ? Container(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       horizontal: 20, vertical: 20),
                                        //   decoration: BoxDecoration(
                                        //       borderRadius:
                                        //       BorderRadius.circular(10),
                                        //       // color: clrGreyLight,
                                        //       border: Border.all(
                                        //           color: clrGrey.withOpacity(0.4))),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        //     children: [
                                        //       Text(paymentController.profileController.profileData.value.result?.restartPlan?.planType == 'monthly' ? 'Monthly' : 'Annually',
                                        //         style: const TextStyle(
                                        //             fontWeight: FontWeight.w600,
                                        //             fontSize: 18),
                                        //       ),
                                        //       const SizedBox(height: 5,),
                                        //       // Text(
                                        //       //   paymentController.profileController.profileData.value.result?.switchPlan?.planId == 'monthly' ? "Your plan will be activate after the annual plan." : "Your plan will be activate after the monthly plan.",
                                        //       //   style: TextStyle(
                                        //       //       fontSize: 13,
                                        //       //       color: clrGrey5D5C5E),
                                        //       // ),
                                        //       RichText(text: TextSpan(
                                        //           children: [
                                        //             TextSpan(text: 'The changes to your membership have been made, and your new plan will renew at €${paymentController.getAmount(paymentController.profileController.profileData.value.result?.restartPlan?.planType == 'monthly' ? 'monthly' : 'yearly')} per',style: TextStyle(
                                        //               fontSize: 14,
                                        //               color: clrGrey5D5C5E,
                                        //               fontFamily: 'Nunito',
                                        //             )),
                                        //             TextSpan(text: ' ${paymentController.profileController.profileData.value.result?.restartPlan?.planType == 'monthly' ? 'month' : 'year'} ',style: TextStyle(
                                        //               fontSize: 14,
                                        //               color: clrYellowText,
                                        //               fontFamily: 'Nunito',
                                        //             )),
                                        //             TextSpan(text: 'starting ',style: TextStyle(
                                        //               fontSize: 14,
                                        //               color: clrGrey5D5C5E,
                                        //               fontFamily: 'Nunito',
                                        //             )),
                                        //             TextSpan(text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',style: TextStyle(
                                        //               fontSize: 14,
                                        //               color: clrYellowText,
                                        //               fontFamily: 'Nunito',
                                        //             )),
                                        //             TextSpan(text: '.',style: TextStyle(
                                        //               fontSize: 14,
                                        //               color: clrGrey5D5C5E,
                                        //               fontFamily: 'Nunito',
                                        //             )),
                                        //           ]
                                        //       ))
                                        //     ],
                                        //   ),
                                        // ) : const SizedBox(),
                                        //
                                        // paymentController.profileController.profileData.value.result?.cancelDate == null ? SizedBox(
                                        //   height: Get.height * 0.035,
                                        // ) : const SizedBox(),
                                        // ///


                                        ///
                                        // Container(
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 20, vertical: 20),
                                        //     decoration: BoxDecoration(
                                        //         borderRadius:
                                        //         BorderRadius.circular(10),
                                        //         // color: clrGreyLight,
                                        //         border: Border.all(
                                        //             color: clrGrey.withOpacity(0.4))),
                                        //     child: Column(
                                        //         crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //         children: [
                                        //           Text(
                                        //             paymentController.profileController.profileData.value.result?.planType == 'monthly' ?  'Monthly' : "Annually",
                                        //             style: const TextStyle(
                                        //                 fontWeight: FontWeight.w600,
                                        //                 fontSize: 18),
                                        //           ),
                                        //           const SizedBox(
                                        //             height: 5,
                                        //           ),
                                        //
                                        //
                                        //           /// for trail
                                        //           paymentController.profileController.profileData.value.result?.trailDate != null && paymentController.profileController.profileData.value.result?.cancelDate != null ? RichText(
                                        //               text: TextSpan(
                                        //                   children: [
                                        //                     TextSpan(
                                        //                         text: 'You have ',
                                        //                         style: TextStyle(
                                        //                             color: clrGreyTextLight,
                                        //                             fontSize: 14,
                                        //                             fontFamily: 'Nunito',
                                        //                             fontWeight: FontWeight.w600
                                        //                         )
                                        //                     ),
                                        //                     TextSpan(
                                        //                         text: 'canceled',
                                        //                         style: TextStyle(
                                        //                             color: clrGreyTextLight,
                                        //                             fontSize: 14,
                                        //                             decoration: TextDecoration.underline,
                                        //                             fontFamily: 'Nunito',
                                        //                             fontWeight: FontWeight.w600
                                        //                         )
                                        //                     ),
                                        //                     TextSpan(
                                        //                         text: ' your trial.',
                                        //                         style: TextStyle(
                                        //                             color: clrGreyTextLight,
                                        //                             fontSize: 14,
                                        //                             fontFamily: 'Nunito',
                                        //                             fontWeight: FontWeight.w600
                                        //                         )
                                        //                     ),
                                        //                   ]
                                        //               )
                                        //           ) : paymentController.profileController.profileData.value.result?.trailDate != null ? RichText(
                                        //               text: TextSpan(
                                        //                   children: [
                                        //                     TextSpan(
                                        //                         text: 'You are currently on a ',
                                        //                         style: TextStyle(
                                        //                             color: clrGreyTextLight,
                                        //                             fontSize: 14,
                                        //                             fontFamily: 'Nunito',
                                        //                             fontWeight: FontWeight.w600
                                        //                         )
                                        //                     ),
                                        //                     TextSpan(
                                        //                         text: 'free trial',
                                        //                         style: TextStyle(
                                        //                             color: clrYellowText,
                                        //                             fontSize: 14,
                                        //                             fontFamily: 'Nunito',
                                        //                             fontWeight: FontWeight.w600
                                        //                         )
                                        //                     ),
                                        //                   ]
                                        //               )
                                        //           ) : SizedBox(),
                                        //           /// for trail
                                        //
                                        //
                                        //           paymentController.profileController.profileData.value.result?.restartPlan?.planType == null && paymentController.profileController.profileData.value.result?.switchPlan?.planId == null && paymentController.profileController.profileData.value.result?.cancelDate == null ? RichText(
                                        //               text: TextSpan(
                                        //                   children: [
                                        //                     TextSpan(
                                        //                         text: 'Your plan will renew on ',
                                        //                         style: TextStyle(
                                        //                           fontSize: 14,
                                        //                           color: clrGrey5D5C5E,
                                        //                           fontFamily: 'Nunito',
                                        //                         )
                                        //                     ),
                                        //                     TextSpan(
                                        //                         text: '${DateFormat('MMMM d, yyyy').format(DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString()))}',
                                        //                         style: TextStyle(
                                        //                           fontSize: 14,
                                        //                           color: clrYellowText,
                                        //                           fontFamily: 'Nunito',
                                        //                         )
                                        //                     ),
                                        //                     TextSpan(
                                        //                         text: ' for the regular price of €${paymentController.getAmount(paymentController.profileController.profileData.value.result?.planType == 'monthly' ? 'monthly' : 'yearly')}',
                                        //                         style: TextStyle(
                                        //                           fontSize: 14,
                                        //                           color: clrGrey5D5C5E,
                                        //                           fontFamily: 'Nunito',
                                        //                         )
                                        //                     ),
                                        //                     TextSpan(
                                        //                         text: ' ${paymentController.profileController.profileData.value.result?.planType == 'monthly' ? 'monthly' : 'annually'}',
                                        //                         style: TextStyle(
                                        //                           fontSize: 14,
                                        //                           color: clrYellowText,
                                        //                           fontFamily: 'Nunito',
                                        //                         )
                                        //                     ),
                                        //                     TextSpan(
                                        //                         text: '.',
                                        //                         style: TextStyle(
                                        //                           fontSize: 14,
                                        //                           color: clrGrey5D5C5E,
                                        //                           fontFamily: 'Nunito',
                                        //                         )
                                        //                     ),
                                        //                   ]
                                        //               )) : paymentController.profileController.profileData.value.result?.restartPlan?.planType == null && paymentController.profileController.profileData.value.result?.switchPlan?.planId == null && paymentController.profileController.profileData.value.result?.cancelDate != null ? RichText(text: TextSpan(
                                        //               children: [
                                        //                 TextSpan(text: 'You have ', style: TextStyle(
                                        //                     color: clrGreyTextLight,
                                        //                     fontSize: 14,
                                        //                     fontFamily: 'Nunito',
                                        //                     fontWeight: FontWeight.w600
                                        //                 )),
                                        //                 TextSpan(text: 'canceled', style: TextStyle(
                                        //                     color: clrGreyTextLight,
                                        //                     fontSize: 14,
                                        //                     fontFamily: 'Nunito',
                                        //                     fontWeight: FontWeight.w600,
                                        //                     decoration: TextDecoration.underline
                                        //                 )),
                                        //                 TextSpan(text: ' your membership.', style: TextStyle(
                                        //                     color: clrGreyTextLight,
                                        //                     fontSize: 14,
                                        //                     fontFamily: 'Nunito',
                                        //                     fontWeight: FontWeight.w600
                                        //                 )),
                                        //               ]
                                        //           )) : SizedBox()
                                        //
                                        //
                                        //
                                        //         ])),
                                        ///


                                      ],
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          paymentController.profileController.profileData.value.result?.cancelDate == null ? SizedBox(
                                            width: double.maxFinite,
                                            height: Res.h_btn,
                                            child: CustomElevatedButton(
                                                onTap: () {
                                                  Get.toNamed(Routes.switchPlanProUi);
                                                },
                                                backgroundClr: clrBlacke,
                                                child: Text(
                                                  "Switch plan",
                                                  style: TextStyle(
                                                      color: clrWhite,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700),
                                                )),
                                          ) : const SizedBox(),
                                          paymentController.profileController.profileData.value.result?.restartPlan?.planType != null && paymentController.profileController.profileData.value.result?.restartPlan?.cancelDate == null ? SizedBox(
                                            width: double.maxFinite,
                                            height: Res.h_btn,
                                            child: CustomElevatedButton(
                                                onTap: () {
                                                  Get.toNamed(Routes.restartSwitchScreen);
                                                },
                                                backgroundClr: clrBlacke,
                                                child: Text(
                                                  "Switch plan",
                                                  style: TextStyle(
                                                      color: clrWhite,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700),
                                                )),
                                          ) : SizedBox(),
                                          const SizedBox(height: 15,),
                                          buildBillingButton(),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          paymentController.profileController.profileData.value.result?.switchPlan?.planId == null ?
                                          paymentController.profileController.profileData.value.result?.cancelDate != null && paymentController.profileController.profileData.value.result?.restartPlan?.planType == null ?  SizedBox(
                                            width: double.maxFinite,
                                            height: Res.h_btn,
                                            child: CustomElevatedButton(
                                                onTap: () {
                                                  Get.toNamed(Routes.restartScreen);
                                                },
                                                backgroundClr: clrBlacke,
                                                child: Text(
                                                  "Restart Membership",
                                                  style: TextStyle(
                                                      color: clrWhite,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700),
                                                )),
                                          ) : Obx(() =>  paymentController.cancelSubLoading.value ? CommonUi.buttonLoading(color: clrBlacke) : GestureDetector(
                                                onTap: () {
                                                  // DateTime date = DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString());
                                                  // String endDate = DateFormat('dd MMMM yyyy').format(date);
                                                  bool inTrail = paymentController.profileController.profileData.value.result?.trailDate != null && paymentController.profileController.profileData.value.result?.cancelDate == null ? true : false;
                                                  var id = paymentController.profileController.profileData.value.result!.cancelDate == null ? paymentController.profileController.profileData.value.result!.subscriptionId.toString() : paymentController.profileController.profileData.value.result?.restartPlan?.subId;
                                                  paymentController.cancelSubPopUp(inTrail: inTrail, onTap: () async{
                                                    Get.back();
                                                    await paymentController.cancelSub(id: id.toString());
                                                  },);
                                                },
                                                child: Text(
                                                  paymentController.profileController.profileData.value.result?.trailDate != null && paymentController.profileController.profileData.value.result?.cancelDate == null ? "Cancel trial" : 'Cancel membership',
                                                  style: TextStyle(
                                                      color: clrBlacke,
                                                      fontSize: 16,
                                                      decoration: TextDecoration.underline),
                                                ),
                                              ),) : paymentController.profileController.profileData.value.result?.switchPlan?.cancelDate != null && paymentController.profileController.profileData.value.result?.restartPlan?.planType == null ? SizedBox(
                                                width: double.maxFinite,
                                                height: Res.h_btn,
                                                child: CustomElevatedButton(
                                                    onTap: () {
                                                      Get.toNamed(Routes.restartScreen);
                                                    },
                                                    backgroundClr: clrBlacke,
                                                    child: Text(
                                                      "Restart Membership",
                                                      style: TextStyle(
                                                          color: clrWhite,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700),
                                                    )),
                                              ) : paymentController.profileController.profileData.value.result?.restartPlan?.cancelDate == null ? Obx(() => paymentController.cancelSubLoading.value ? CommonUi.buttonLoading(color: clrBlacke) : GestureDetector(
                                            onTap: () {
                                              // DateTime date = DateTime.parse(paymentController.profileController.profileData.value.result!.endDate.toString());
                                              // String endDate = DateFormat('dd MMMM yyyy').format(date);
                                              bool inTrail = paymentController.profileController.profileData.value.result?.trailDate != null && paymentController.profileController.profileData.value.result?.cancelDate == null ? true : false;
                                              var subId = paymentController.profileController.profileData.value.result?.restartPlan?.subId;
                                              if(subId == null) {
                                                paymentController.cancelSubPopUp(
                                                  inTrail: inTrail,
                                                  onTap: () async {
                                                    Get.back();
                                                    await paymentController
                                                        .cancelSub(
                                                        id: paymentController
                                                            .profileController
                                                            .profileData.value
                                                            .result?.switchPlan
                                                            ?.subscriptionId);
                                                  },);
                                              }else{
                                                paymentController.cancelSubPopUp(
                                                  inTrail: inTrail,
                                                  onTap: () async {
                                                    Get.back();
                                                    await paymentController
                                                        .cancelSub(
                                                        id: subId);
                                                  },);
                                              }
                                            },
                                            child: Text(
                                              paymentController.profileController.profileData.value.result?.trailDate != null ? "Cancel trial" : 'Cancel membership',
                                              style: TextStyle(
                                                  color: clrBlacke,
                                                  fontSize: 16,
                                                  decoration: TextDecoration.underline),
                                            ),
                                          ),) : SizedBox(),
                                          SizedBox(height: 10,)
                                        ],
                                      ),
                                    )
                                  ],
                                )
                                : Column(
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
                                                  paymentController.updatePlan(index,data.price!,data.trailDays!,data.billingPeriod.toString(),data.id.toString());
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10, vertical: 15),
                                                  decoration: BoxDecoration(
                                                      color: paymentController.choosePlan.value == index ? clrGreyLight : clrWhite,
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
                                                        groupValue: paymentController.choosePlan.value,
                                                        onChanged: (val) {
                                                          paymentController.updatePlan(index,data.price!,data.trailDays!,data.billingPeriod.toString(),data.id.toString());
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
                                                                                "${paymentController.getWeek(int.parse(data.trailDays.toString()))} free ",
                                                                                style: TextStyle(
                                                                                    color:
                                                                                    clrYellowText),
                                                                              ) : const TextSpan(),
                                                                              TextSpan(
                                                                                  text:
                                                                                  "${paymentController.profileController.profileData.value.result?.cardDetail?.cardSave == false ? 'then ' : ''}€${data.price}/${data.billingPeriod == 'monthly' ? 'month' : data.billingPeriod == 'yearly' ? 'year' : ''}",
                                                                                  style: TextStyle(
                                                                                      color:
                                                                                      clrGrey5D5C5E))
                                                                            ])),
                                                                    paymentController.profileController.profileData.value.result?.myReferDays != null ? SizedBox(height: 3,) : SizedBox(),
                                                                    paymentController.profileController.profileData.value.result?.myReferDays != null ? Text('Your referral code has been added',style: TextStyle(
                                                                      color: clrBlacke.withOpacity(0.5)
                                                                    ),) : SizedBox()
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

                                            // paymentController.profileController.profileData.value.result?.referalApplied == null && paymentController.profileController.profileData.value.result?.cardDetail?.cardSave == false ? SizedBox(
                                            //   height: Get.height * 0.03,
                                            // ) : SizedBox(),
                                            SizedBox(
                                              height: Get.height * 0.03,
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: CustoTextFormField(
                                                    hintText: 'Enter referral code',
                                                    controll: paymentController.referalController,
                                                  ),
                                                ),
                                                SizedBox(width: Get.width*0.04,),
                                                Obx(() => Opacity(
                                                  opacity: paymentController.referalLoading.value ? 0.5 : 1,
                                                  child: SizedBox(
                                                    height: Get.height*.06,
                                                    child: CustomElevatedButton(onTap: () {
                                                      paymentController.applyCode();
                                                    }, backgroundClr: clrBlacke,paddingHz: 20,paddingVr: 10, child: paymentController.referalLoading.value ? CommonUi.buttonLoading() : Text('Apply',style: TextStyle(color: clrWhite,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700),)),
                                                  ),
                                                ),),
                                                const SizedBox(width: 10,),
                                              ],
                                            ),
                                            // paymentController.profileController.profileData.value.result?.referalApplied == null && paymentController.profileController.profileData.value.result?.cardDetail?.cardSave == false ? Row(
                                            //   children: [
                                            //     Flexible(
                                            //       child: Opacity(
                                            //         opacity: paymentController.profileController.profileData.value.result?.referalApplied == null ? 1 : 0.5,
                                            //         child: CustoTextFormField(
                                            //           hintText: 'Enter referral code',
                                            //           controll: paymentController.referalController,
                                            //           readonly: paymentController.profileController.profileData.value.result?.referalApplied == null ? false : true,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     paymentController.profileController.profileData.value.result?.referalApplied == null ? SizedBox(width: Get.width*0.04,) :SizedBox(),
                                            //     paymentController.profileController.profileData.value.result?.referalApplied == null ? Obx(() => Opacity(
                                            //       opacity: paymentController.referalLoading.value ? 0.5 : 1,
                                            //       child: SizedBox(
                                            //         height: Get.height*.06,
                                            //         child: CustomElevatedButton(onTap: () {
                                            //           paymentController.applyCode();
                                            //         }, backgroundClr: clrBlacke,paddingHz: 20,paddingVr: 10, child: paymentController.referalLoading.value ? CommonUi.buttonLoading() : Text('Apply',style: TextStyle(color: clrWhite,
                                            //             fontSize: 16,
                                            //             fontWeight: FontWeight.w700),)),
                                            //       ),
                                            //     ),) : SizedBox(),
                                            //     paymentController.profileController.profileData.value.result?.referalApplied == null ? const SizedBox(width: 10,) : SizedBox(),
                                            //   ],
                                            // ) : SizedBox(),
                                            SizedBox(
                                              height: Get.height * 0.03,
                                            ),
                                            RichText(
                                                textAlign: TextAlign.left,
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
                                                      text: "Privacy Policy",
                                                      recognizer: TapGestureRecognizer()..onTap = () async{
                                                        await launchUrl(Uri.parse('https://plusonesapp.com/privacy-policy'));
                                                      },
                                                      style: TextStyle(
                                                          color: clrYellowText,
                                                          decoration: TextDecoration
                                                              .underline,
                                                          height: 1.5)),
                                                  TextSpan(
                                                    text: ". ",
                                                    style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        height: 1.5),
                                                  ),
                                                  paymentController.profileController.profileData.value.result?.cardDetail?.cardSave == false ? TextSpan(
                                                    text:
                                                        " After the free trial, your membership will auto-renew ${paymentController.selectedPlan.value.isNotEmpty ? paymentController.selectedPlan.value == 'yearly' ? 'annually' : 'monthly' : ''} at ${paymentController.choosePlan.value != (-1) ? '€${paymentController.price.value}' : 'regular price'} unless cancelled. You authorise charges for late cancellations and no-shows. These policies ensure a committed and genuine community.",
                                                    style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        height: 1.5),
                                                  ) : TextSpan(
                                                    text:
                                                    "Your membership will auto-renew ${paymentController.selectedPlan.value.isNotEmpty ? paymentController.selectedPlan.value == 'yearly' ? 'annually' : 'monthly' : ''} at ${paymentController.choosePlan.value != (-1) ? '€${paymentController.price.value}' : 'regular price'} unless cancelled. You authorise charges for late cancellations and no-shows. These policies ensure a committed and genuine community.",
                                                    style: TextStyle(
                                                        color: clrGrey5D5C5E,
                                                        height: 1.5),
                                                  )
                                                ])),
                                          ],
                                        ),
                                      ),
                                      Obx(() => Opacity(
                                        opacity: paymentController.loading.value ? 0.5 : 1,
                                        // opacity: controller.buttonLoadingMonthly.value || controller.buttonLoadingYearly.value || controller.apiLoading.value ? 0.5 : 1,
                                        child: SizedBox(
                                          height: Res.h_btn,
                                          width: double.maxFinite,
                                          child: CustomElevatedButton(
                                              onTap: paymentController.loading.value ? (){} : () async{
                                                if(paymentController.profileController.profileData.value.result?.cardDetail?.cardSave == false) {
                                                  if (paymentController.selectedPlan.value == 'yearly') {
                                                    await paymentController.createNewCustomer('${paymentController.profileController
                                                        .profileData.value
                                                        .result
                                                        ?.firstName} ${paymentController.profileController
                                                        .profileData.value
                                                        .result?.lastName}', '${paymentController.profileController
                                                        .profileData.value
                                                        .result?.email}', 'yearly', paymentController.price.value);
                                                    await controller.homeController.homePageApi();
                                                  } else if (paymentController.selectedPlan.value == 'monthly') {
                                                    await paymentController.createNewCustomer('${paymentController.profileController
                                                        .profileData.value
                                                        .result
                                                        ?.firstName} ${paymentController.profileController
                                                        .profileData.value
                                                        .result?.lastName}', '${paymentController.profileController
                                                        .profileData.value
                                                        .result?.email}', 'monthly', paymentController.price.value);
                                                    await controller.homeController
                                                        .homePageApi();
                                                  } else {
                                                    showTostMsg(
                                                        'Please select any plan.');
                                                  }
                                                }else{
                                                  if (paymentController.selectedPlan.value ==
                                                      'yearly') {
                                                    paymentController.planType.value = 'yearly';
                                                    await paymentController.createSub("${paymentController.profileController.profileData.value.result?.cardDetail?.customerId}", paymentController.price.value, '12 months', 'Yearly Membership');
                                                    await controller.homeController
                                                        .homePageApi();
                                                  } else
                                                  if (paymentController.selectedPlan.value ==
                                                      'monthly') {
                                                    paymentController.planType.value = 'monthly';
                                                   await paymentController.createSub('${paymentController.profileController.profileData.value.result?.cardDetail?.customerId}', paymentController.price.value, '1 month', 'Monthly Membership');
                                                    await controller.homeController
                                                        .homePageApi();
                                                  } else {
                                                    showTostMsg(
                                                        'Please select any plan.');
                                                  }
                                                }
                                              },
                                              backgroundClr: clrBlacke,
                                              child: paymentController.loading.value ? CommonUi.buttonLoading() : (paymentController.profileController.profileData.value.result?.cardDetail?.cardSave == false ? Text(
                                                paymentController.choosePlan.value != (-1) ? "Start ${paymentController.getWeek(int.parse(paymentController.freeDays.value))} free" : 'Start membership',
                                                style: TextStyle(
                                                    color: clrWhite,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700),
                                              ) : Text('Start membership',style: TextStyle(
                                                  color: clrWhite,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)))),),
                                      ),),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                    ],
                                  ),
                  ))),
        ),
      ),
    );
  }

  String getSubscriptionStatus() {
    final result = paymentController.profileController.profileData.value.result;

    // Check if the main plan is active
    if(result?.cancelDate == null && result?.switchPlan?.cancelDate == null && result?.switchPlan?.planId == null && result?.restartPlan?.planType == null && result?.restartPlan?.cancelDate == null){
      return result!.planType.toString();
    }

    // Check if the switch plan exists
    if (result?.switchPlan?.planId != null && result?.restartPlan?.planType == null) {
      var switchPlan = result?.switchPlan;
      if (switchPlan?.cancelDate == null) {
        return result!.planType.toString();
      } else {
        return "No active plan";
      }
    }

    // Check if the restart plan exists
    if (result?.restartPlan?.planType != null) {
      var restartPlan = result?.restartPlan;
      if (restartPlan?.cancelDate == null) {
        return result!.planType.toString();
      }
    }

    return "No active plan";
  }


  Widget buildBillingButton() {
    final result = paymentController.profileController.profileData.value.result;

    final isCurrentPlanActive = result?.cancelDate == null;
    final isSwitchPlanActive = result?.switchPlan?.cancelDate == null && result?.switchPlan?.planId != null;
    final isRestartPlanActive = result?.restartPlan?.cancelDate == null && result?.restartPlan?.planType != null;

    if (!isCurrentPlanActive && !isSwitchPlanActive && !isRestartPlanActive) {
      return SizedBox();
    }

    return Obx(() => SizedBox(
      height: Res.h_btn,
      width: double.infinity,
      child: CustomElevatedButton(
        onTap: paymentController.billingLoading.value
            ? () {}
            : () async {
          paymentController.updateBilling();
        },
        backgroundClr: clrWhite,
        borderClr: clrBlacke,
        child: paymentController.billingLoading.value
            ? CommonUi.buttonLoading(color: clrBlacke)
            : Text(
          "Change billing details",
          style: TextStyle(
            color: clrBlacke,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ));
  }



}

// class SubscriptionScreen extends StatefulWidget {
//   const SubscriptionScreen({super.key});
//
//   @override
//   State<SubscriptionScreen> createState() => _SubscriptionScreenState();
// }
//
// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//
//   final membershipPlanController = Get.put(MembershipPlanController());
//   var homeScreen_viewModel = Get.put(HomeViewModel());
//
//   final InAppPurchase _inAppPurchase = InAppPurchase.instance;
//   List<ProductDetails> _products = [];
//   bool _available = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeIAP();
//
//   }
//
//   void _initializeIAP() {
//     final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
//     purchaseUpdated.listen((purchaseDetailsList) {
//       _listenToPurchaseUpdated(purchaseDetailsList);
//     });
//
//     _getProducts();
//   }
//
//
//   Future<void> _getProducts() async {
//     available = await inAppPurchase.isAvailable();
//     if (!_available) {
//       print("store not being available.");
//       return;
//     }
//
//     const Set<String> _kIds = {"basic","premium","pro",}; // Replace with your actual product IDs
//     final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_kIds);
//
//     if (response.notFoundIDs.isNotEmpty) {
//       print("product IDs were not found.") ;
//     }
//
//     setState(() {
//       _products = response.productDetails;
//     });
//   }
//   String basicAmount = "14.99";
//   String premiumAmount = "19.99";
//   String proAmount = "24.99";
//
//   List<String> planeName =
//   [
//     "Basic",
//     "Premium",
//     "Pro",
//   ];
//   List<String> planeAmount =
//   [
//     "14.99",
//     "19.99",
//     "24.99",
//   ];
//   List<String> planeOffers =
//   [
//     "Max 5 Profiles (Individual and Consultant Owned)",
//     "Max 10 Profiles (Individual and Consultant Owned)",
//     "Unlimited # Profiles (Individual and Consultant Owned",
//   ];
//
//   void _buyProduct(ProductDetails productDetails) {
//     final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
//     _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
//   }
//
//
//   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
//     for (var purchaseDetails in purchaseDetailsList) {
//       if (purchaseDetails.status == PurchaseStatus.purchased) {
//         // Save purchase details
//         membershipPlanController.all_json_data.value = purchaseDetails.verificationData.localVerificationData.toString();
//         membershipPlanController.payment_id.value = purchaseDetails.purchaseID.toString();
//         membershipPlanController.pay_type.value = GetPlatform.isIOS ? "app_store" : "play_store";
//
//         // Set the amount based on the product ID
//         switch (purchaseDetails.productID) {
//           case "basic":
//             membershipPlanController.amount.value = basicAmount;
//             break;
//           case "premium":
//             membershipPlanController.amount.value = premiumAmount;
//             break;
//           case "pro":
//             membershipPlanController.amount.value = proAmount;
//             break;
//         }
//
//         // Complete the purchase
//         await InAppPurchase.instance.completePurchase(purchaseDetails);
//
//         // Verify the purchase and trigger the API call
//         if (await _verifyPurchase(purchaseDetails)) {
//           membershipPlanController.MembershipPlanApi();
//         }
//
//         print("Purchase successfully completed.");
//       } else if (purchaseDetails.status == PurchaseStatus.error) {
//         // Handle error
//         print(purchaseDetails.error);
//       }
//
//       // Check if the purchase is pending completion
//       if (purchaseDetails.pendingCompletePurchase) {
//         await InAppPurchase.instance.completePurchase(purchaseDetails);
//       }
//     }
//   }
//
// // Dummy implementation of purchase verification
//   Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
//     // Perform your verification logic here (e.g., validating receipt with server)
//     // For now, we assume all purchases are valid
//     return true;
//   }
//

//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         surfaceTintColor: Colors.transparent,
//         leading: BackButton(),
//         elevation: 0,
//         title: Text(
//           "Membership",
//           textAlign: TextAlign.start,
//           style: GoogleFonts.poppins(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // _products.isEmpty
//               //     ? Center(child: TextClass(size: 16, fontWeight: FontWeight.w600, title: "Data not found", fontColor: primaryDark))
//               //     :
//               ListView.builder(
//                 itemCount: planeName.length,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   var PurchaseAmount = int.tryParse(
//                       homeScreen_viewModel
//                           .UserDataList.value.plan_details!.amount
//                           .toString());
//                   var planPrice = int.tryParse(planeAmount[index]);
//                   bool?   activePlan(){
//                     if(PurchaseAmount! < planPrice!){
//                       return true;
//                     }else if(PurchaseAmount == planPrice || PurchaseAmount > planPrice){
//                       return false;
//                     }
//                   }
//                   print("plandkldfkd ====>>>>$PurchaseAmount");
//                   print("planPrice ====>>>>$planPrice");
//                   return Container(
//                     width: double.maxFinite,
//                     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Color(0xffecefed),
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           width: double.maxFinite,
//                           padding: EdgeInsets.all(15),
//                           margin: EdgeInsets.only(bottom: 25),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Color(0xffcad2cc),
//                           ),
//                           child: Row(
//                             children: [
//                               Image.asset("assets/images/crown_Icon.png", height: 50,),
//                               SizedBox(width: 15,),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   TextClass(
//                                     align: TextAlign.center,
//                                     size: 18,
//                                     fontWeight: FontWeight.w600,
//                                     title: planeName[index],
//                                     fontColor: Colors.black,
//                                   ),
//                                   SizedBox(height: 5,),
//                                   Row(
//                                     children: [
//                                       TextClass(
//                                         align: TextAlign.center,
//                                         size: 18,
//                                         fontWeight: FontWeight.w600,
//                                         title: "\$${planeAmount[index]}/ Month",
//                                         fontColor: primaryDark,
//                                       ),
//
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: Row(
//                             children: [
//                               Image.asset("assets/images/check_Icon.png", height: 20,),
//                               SizedBox(width: 15,),
//                               Flexible(
//                                 child: Text(
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 16,
//                                     fontFamily: 'Poppins',
//                                     color: Colors.black,
//                                   ),
//                                   softWrap: true,
//                                   planeOffers[index],
//                                   overflow: TextOverflow.clip,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             if(PurchaseAmount != null && PurchaseAmount < planPrice!){
//                               if (products.isNotEmpty && index < products.length) {
//                                 _buyProduct(_products[index]);
//                               } else {
//                                 print("No products available or index out of range");
//                               }
//                             }else if(PurchaseAmount == null){
//                               if (products.isNotEmpty && index < products.length) {
//                                 _buyProduct(_products[index]);
//                               } else {
//                                 print("No products available or index out of range");
//                               }
//                             }
//
//                           },
//                           child: Container(
//                             width: double.maxFinite,
//                             margin: EdgeInsets.symmetric(vertical: 15),
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                             decoration: BoxDecoration(
//                               color:activePlan == true ? Colors.grey.shade400 : primaryDark,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: TextClass(
//                               align: TextAlign.center,
//                               size: 18,
//                               fontWeight: FontWeight.w500,
//                               title: activePlan == false ? "Active" : "Select",
//                               fontColor: Colors.white,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           )
//       ),
//     );
//   }
// }
