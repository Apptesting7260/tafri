import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/controller/mymembership_controller.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/switchplan/switchplanui.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../utils/colors.dart';

class MyMemberShipUi extends GetWidget<MymembershipController>{
  const MyMemberShipUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SafeArea(

          child: Padding(
            padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonUi.appBar(),
                      const Text("My membership",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
                        SizedBox(
                        width:w*.05,
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.035,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,vertical: 20
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: clrGreyLight,
                        border: Border.all(color: clrGrey.withOpacity(0.4))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Annual",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                        SizedBox(height: 5,),
                        Text("You are in a 3-month free trial.",style: TextStyle(color: clrGreyTextLight,fontSize: 14,fontWeight: FontWeight.w700),),
                        Text("Starting 1 June, your plan will renew for the regular price of €23.99 every year until canceled. ",style: TextStyle(fontSize: 13,color: clrGrey5D5C5E),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.035,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: Res.h_btn,
                    child: CustomElevatedButton(onTap: (){
                      Get.toNamed(Routes.switchPlanProUi);
                    }, backgroundClr: clrBlacke, child: Text("Switch plan",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),)),
                  )


                ],
              ),
            ),
          )),
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
