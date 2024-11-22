import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/controller/mymembership_controller.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/switchplan/switchplanui.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../utils/colors.dart';

class MyMemberShipUi extends GetWidget<MymembershipController> {
  MyMemberShipUi({super.key});

  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SmartRefresher(
        controller: controller.refreshController,
        header: CommonUi.refreshHeader(),
        onRefresh: () async{
          paymentController.getPlan();
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
                          : controller.homeController
                                  .homeData.value.result!.planType!.isNotEmpty
                              ? SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                            Text(
                                              controller.homeController
                                                  .homeData.value.result!.planType! == 'monthly' ?  'Monthly' : "Annual",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              controller.homeController
                                                  .homeData.value.result!.planType! == 'monthly' ? 'You are in a 1-week free trial.' : "You are in a 3-month free trial.",
                                              style: TextStyle(
                                                  color: clrGreyTextLight,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              controller.homeController
                                                  .homeData.value.result!.planType! == 'monthly' ? "Your plan will renew for the regular price every month until canceled." : "Your plan will renew for the regular price every year until canceled.",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: clrGrey5D5C5E),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.035,
                                      ),
                                      SizedBox(
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
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      paymentController.profileController.profileData.value.result?.cancelDate != null ?  IgnorePointer(
                                        ignoring: true,
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          height: Res.h_btn,
                                          child: CustomElevatedButton(
                                              onTap: () {},
                                              backgroundClr: clrWhite,
                                              borderClr: clrBlacke,
                                              child: Text(
                                                "Cancelled",
                                                style: TextStyle(
                                                    color: clrBlacke,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700),
                                              )),
                                        ),
                                      ) : Obx(() => Opacity(
                                        opacity: paymentController.cancelSubLoading.value ? 0.5 : 1,
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          height: Res.h_btn,
                                          child: CustomElevatedButton(
                                              onTap: () async{
                                                await paymentController.cancelSub();
                                              },
                                              backgroundClr: clrWhite,
                                              borderClr: clrBlacke,
                                              child: paymentController.cancelSubLoading.value ? CommonUi.buttonLoading(color: clrBlacke) : Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: clrBlacke,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700),
                                              )),
                                        ),
                                      ),)
                                    ],
                                  ),
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
                                                    horizontal: 10, vertical: 18),
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
                                                                            TextSpan(
                                                                              text:
                                                                              "${paymentController.getWeek(int.parse(data.trailDays.toString()))} free",
                                                                              style: TextStyle(
                                                                                  color:
                                                                                  clrYellowText),
                                                                            ),
                                                                            TextSpan(
                                                                                text:
                                                                                " then €${data.price}/${data.billingPeriod == 'monthly' ? 'month' : data.billingPeriod == 'yearly' ? 'year' : ''}",
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
                                          // Obx(() => GestureDetector(
                                          //   onTap: () {
                                          //     controller.updatePlan(1);
                                          //   },
                                          //   child: Container(
                                          //     padding: const EdgeInsets.symmetric(
                                          //         horizontal: 10, vertical: 18),
                                          //     decoration: BoxDecoration(
                                          //         color: controller.choosePlan.value == 1 ? clrGreyLight : clrWhite,
                                          //         borderRadius:
                                          //         BorderRadius.circular(10),
                                          //         border: Border.all(
                                          //             color: clrGrey
                                          //                 .withOpacity(0.3))),
                                          //     child: Row(
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //       children: [
                                          //         Radio(
                                          //           value: 1,
                                          //           groupValue: controller.choosePlan.value,
                                          //           onChanged: (val) {
                                          //             controller.updatePlan(1);
                                          //           },
                                          //           visualDensity:
                                          //           VisualDensity.compact,
                                          //           activeColor: clrYellow,
                                          //         ),
                                          //         Flexible(
                                          //             child: Row(
                                          //               crossAxisAlignment:
                                          //               CrossAxisAlignment.start,
                                          //               mainAxisAlignment:
                                          //               MainAxisAlignment
                                          //                   .spaceBetween,
                                          //               children: [
                                          //                 Flexible(
                                          //                   child: Column(
                                          //                     crossAxisAlignment:
                                          //                     CrossAxisAlignment
                                          //                         .start,
                                          //                     children: [
                                          //                       const Text(
                                          //                         "Annual",
                                          //                         style: TextStyle(
                                          //                             fontSize: 18,
                                          //                             fontWeight:
                                          //                             FontWeight
                                          //                                 .w600),
                                          //                       ),
                                          //                       RichText(
                                          //                           text: TextSpan(
                                          //                               children: [
                                          //                                 TextSpan(
                                          //                                   text:
                                          //                                   "3 months free",
                                          //                                   style: TextStyle(
                                          //                                       color:
                                          //                                       clrYellowText),
                                          //                                 ),
                                          //                                 TextSpan(
                                          //                                     text:
                                          //                                     " then €23.99/year",
                                          //                                     style: TextStyle(
                                          //                                         color:
                                          //                                         clrGrey5D5C5E))
                                          //                               ])),
                                          //                     ],
                                          //                   ),
                                          //                 ),
                                          //                 Container(
                                          //                   padding: const EdgeInsets
                                          //                       .symmetric(
                                          //                       horizontal: 8,
                                          //                       vertical: 3),
                                          //                   decoration: BoxDecoration(
                                          //                       borderRadius:
                                          //                       BorderRadius
                                          //                           .circular(20),
                                          //                       color: clrYellow),
                                          //                   child: const Text(
                                          //                     "Best value",
                                          //                     style: TextStyle(
                                          //                         fontSize: 10),
                                          //                   ),
                                          //                 )
                                          //               ],
                                          //             ))
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),),
                                          // SizedBox(
                                          //   height: Get.height * 0.03,
                                          // ),
                                          // Obx(() => GestureDetector(
                                          //   onTap: () {
                                          //     controller.updatePlan(2);
                                          //   },
                                          //   child: Container(
                                          //     padding: const EdgeInsets.symmetric(
                                          //         horizontal: 10, vertical: 18),
                                          //     decoration: BoxDecoration(
                                          //         color: controller.choosePlan.value == 2 ? clrGreyLight : clrTransparent,
                                          //         borderRadius:
                                          //         BorderRadius.circular(10),
                                          //         border: Border.all(
                                          //             color: clrGrey
                                          //                 .withOpacity(0.3))),
                                          //     child: Row(
                                          //       crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //       children: [
                                          //         Radio(
                                          //           value: 2,
                                          //           groupValue: controller.choosePlan.value,
                                          //           onChanged: (val) {
                                          //             controller.updatePlan(2);
                                          //           },
                                          //           visualDensity:
                                          //           VisualDensity.compact,
                                          //           activeColor: clrYellow,
                                          //         ),
                                          //         Flexible(
                                          //           child: Column(
                                          //             crossAxisAlignment:
                                          //             CrossAxisAlignment.start,
                                          //             children: [
                                          //               const Text("Monthly",
                                          //                   style: TextStyle(
                                          //                       fontSize: 18,
                                          //                       fontWeight:
                                          //                       FontWeight
                                          //                           .w600)),
                                          //               RichText(
                                          //                   text:
                                          //                   TextSpan(children: [
                                          //                     TextSpan(
                                          //                       text: "1 week free",
                                          //                       style: TextStyle(
                                          //                           color:
                                          //                           clrYellowText),
                                          //                     ),
                                          //                     TextSpan(
                                          //                         text:
                                          //                         " then €3.99/month",
                                          //                         style: TextStyle(
                                          //                             color:
                                          //                             clrGrey5D5C5E))
                                          //                   ])),
                                          //             ],
                                          //           ),
                                          //         )
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),),
                                          SizedBox(
                                            height: Get.height * 0.03,
                                          ),
                                          RichText(
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
                                                    text: " Terms of Service",
                                                    style: TextStyle(
                                                        color: clrYellowText,
                                                        decoration: TextDecoration
                                                            .underline,
                                                        height: 1.5)),
                                                TextSpan(
                                                  text: " and",
                                                  style: TextStyle(
                                                      color: clrGrey5D5C5E,
                                                      height: 1.5),
                                                ),
                                                TextSpan(
                                                    text: " Privacy Policy.",
                                                    style: TextStyle(
                                                        color: clrYellowText,
                                                        decoration: TextDecoration
                                                            .underline,
                                                        height: 1.5)),
                                                TextSpan(
                                                  text:
                                                      " After the free trial, your membership will auto-renew annually at ${paymentController.choosePlan.value != (-1) ? '€${paymentController.price.value}' : 'regular price'} unless cancelled. You authorise charges for late cancellations and no-shows. These policies ensure a committed and genuine community.",
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
                                              if(paymentController.profileController.profileData.value.result?.cardSave == false) {
                                                if (paymentController.selectedPlan.value == 'yearly') {
                                                  await paymentController
                                                      .createCustomer(
                                                      '${paymentController.profileController
                                                          .profileData.value
                                                          .result
                                                          ?.firstName} ${paymentController.profileController
                                                          .profileData.value
                                                          .result?.lastName}',
                                                      '${paymentController.profileController
                                                          .profileData.value
                                                          .result?.email}',
                                                      'yearly',paymentController.price.value);
                                                  await controller.homeController.homePageApi();
                                                } else if (paymentController.selectedPlan.value == 'monthly') {
                                                  await paymentController
                                                      .createCustomer(
                                                      '${paymentController.profileController
                                                          .profileData.value
                                                          .result
                                                          ?.firstName} ${paymentController.profileController
                                                          .profileData.value
                                                          .result?.lastName}',
                                                      '${paymentController.profileController
                                                          .profileData.value
                                                          .result?.email}',
                                                      'monthly',paymentController.price.value);
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
                                                  await paymentController.createSub("${paymentController.profileController.profileData.value.result?.customerId}", paymentController.price.value, '12 months', 'Yearly Membership');
                                                  await controller.homeController
                                                      .homePageApi();
                                                } else
                                                if (paymentController.selectedPlan.value ==
                                                    'monthly') {
                                                  paymentController.planType.value = 'monthly';
                                                 await paymentController.createSub('${paymentController.profileController.profileData.value.result?.customerId}', paymentController.price.value, '1 month', 'Monthly Membership');
                                                  await controller.homeController
                                                      .homePageApi();
                                                } else {
                                                  showTostMsg(
                                                      'Please select any plan.');
                                                }
                                              }
                                            },
                                            backgroundClr: clrBlacke,
                                            child: paymentController.loading.value ? CommonUi.buttonLoading() : Text(
                                              paymentController.choosePlan.value != (-1) ? "Start ${paymentController.getWeek(int.parse(paymentController.freeDays.value))} free" : 'Select plan',
                                              style: TextStyle(
                                                  color: clrWhite,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            )),),
                                    ),),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                  ],
                                ),
                ))),
      ),
    );
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
