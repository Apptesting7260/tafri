import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/modal/plan_modal.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MymembershipController extends GetxController {
  //
  // @override
  // void onClose() {
  //   super.dispose();
  //   print("dispose");
  //   subscription.cancel();
  // }
  //
  @override
  void onInit() {
    print('On in it callles');
    super.onInit();
    // getPlan();
    // streamFunction();
    // homeController.homeData.value.result?.planType == 'monthly' ? updateSelectedValue(2) : updateSelectedValue(1);
  }

  final ExploreListController homeController =
  Get.find<ExploreListController>();

  // final api = ApiServices();
  //
  // var choosePlan = (-1).obs;
  // var price = ''.obs;
  // var freeDays = ''.obs;
  // var selectedPlan = ''.obs;
  //
  // void updatePlan(int value,String planPrice,String freeDay,String plan){
  //   choosePlan.value = value;
  //   price.value = planPrice;
  //   freeDays.value = freeDay;
  //   selectedPlan.value = plan;
  // }

  var selectedval = (-1).obs;

  void updateSelectedValue(int? value) {
    selectedval.value = value!;
  }


  RefreshController refreshController = RefreshController(initialRefresh: false);

  // var plans = GetPlanModal().obs;
  // var plansLoading = false.obs;
  // var planError = ''.obs;
  // Future<void> getPlan() async{
  //   var header = {
  //     'Authorization' : 'Bearer ${LocalStorage.getToken()}'
  //   };
  //   plansLoading.value = true;
  //   try{
  //     final response = await api.get('${EndPoints.getPlan}',headers: header);
  //     print('get plan == ${response.body}   \n   ${response.statusCode}');
  //     if(response.statusCode == 200){
  //       planError.value = '';
  //       plans.value = GetPlanModal.fromJson(response.body);
  //     }else{
  //       planError.value = 'error';
  //     }
  //   }catch(e){
  //     planError.value = e.toString();
  //     print('get plan error == ${e.toString()}');
  //   }
  //   plansLoading.value = false;
  // }
  //
  //
  // String getWeek(int days) {
  //   switch (days) {
  //     case 7:
  //       return '1 week';
  //     case 14:
  //       return '2 weeks';
  //     case 21:
  //       return '3 weeks';
  //     case 28:
  //       return '4 weeks';
  //     case 30:
  //     case 31:
  //       return '1 month';
  //     case 60:
  //     case 61:
  //       return '2 months';
  //     case 90:
  //     case 91:
  //       return '3 months';
  //     case 180:
  //     case 181:
  //       return '6 months';
  //     case 365:
  //       return '12 months (1 year)';
  //     default:
  //       if (days < 7) {
  //         return '$days days';
  //       } else if (days > 7 && days < 30) {
  //         int weeks = days ~/ 7;
  //         return '$weeks weeks';
  //       } else {
  //         int months = days ~/ 30;
  //         return '$months months';
  //       }
  //   }
  // }


// var buttonLoadingMonthly = false.obs;
  // var buttonLoadingYearly = false.obs;
  //
  // final InAppPurchase inAppPurchase = InAppPurchase.instance;
  // late StreamSubscription<List<PurchaseDetails>> subscription;
  // // bool? isPremium = PrefUtils().getSubscriptionStatus();
  //
  // final api = ApiServices();
  //
  // void streamFunction() {
  //   print('stream');
  //   subscription = inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
  //       print("Comin here in func");
  //
  //       if (purchaseDetailsList.isEmpty) {
  //         showTostMsg('No previous records found.');
  //       } else {
  //         listenToPurchaseUpdated(purchaseDetailsList);
  //       }
  //     },
  //     onDone: () {
  //       print("in the on done");
  //       subscription.cancel();
  //     },
  //     onError: (error) {
  //       print('Error in purchaseStream: $error');
  //     },
  //   );
  // }
  //
  // void checkIfAvailable() async {
  //   print('called');
  //   await inAppPurchase.restorePurchases();
  // }
  //
  // Future<void> listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
  //   for(var purchaseDetails in purchaseDetailsList) {
  //     buttonLoadingMonthly.value = false;
  //     buttonLoadingYearly.value = false;
  //     // if (purchaseDetails.status == PurchaseStatus.pending) {
  //     //   print("Pending Status");
  //     // } else {
  //        if (purchaseDetails.status == PurchaseStatus.purchased ||
  //           purchaseDetails.status == PurchaseStatus.restored) {
  //         if (purchaseDetails.status == PurchaseStatus.restored) {
  //           await subscriptionAPi(
  //               is_recover: 'true',
  //               transaction_id: purchaseDetails.purchaseID.toString(),
  //               transaction_date: purchaseDetails.transactionDate.toString(),
  //               planType: Platform.isIOS
  //                   ? purchaseDetails.productID == 'Annual'
  //                   ? 'yearly_plan'
  //                   : 'monthly_plan'
  //                   : purchaseDetails.productID,
  //               allData: purchaseDetails.verificationData.localVerificationData,
  //               pay_type: purchaseDetails.verificationData.source);
  //           print(
  //               "Verification Data Local 1  => ${purchaseDetails.verificationData.localVerificationData}");
  //         } else {
  //           print("The status is --> ${purchaseDetails.status}");
  //           print("Verified purchase");
  //           print("Purchase Id => ${purchaseDetails.purchaseID}");
  //           print(
  //               "Pending Complete Purchase => ${purchaseDetails.pendingCompletePurchase}");
  //           print("Product Id => ${purchaseDetails.productID}");
  //           print("Status => ${purchaseDetails.status}");
  //           print("Transaction Date => ${purchaseDetails.transactionDate}");
  //           print(
  //               "Verification Data Local 2  => ${purchaseDetails.verificationData.localVerificationData}");
  //           print(
  //               "Verification Data Server => ${purchaseDetails.verificationData.serverVerificationData}");
  //           print(
  //               "Verification Data Source => ${purchaseDetails.verificationData.source}");
  //           print("This time we are calling backend api");
  //
  //           await subscriptionAPi(
  //               is_recover: 'false',
  //               transaction_id: purchaseDetails.purchaseID.toString(),
  //               transaction_date: purchaseDetails.transactionDate.toString(),
  //               planType: purchaseDetails.productID == 'Annual'
  //                   ? 'yearly_plan'
  //                   : 'monthly_plan',
  //               allData: purchaseDetails.verificationData.localVerificationData,
  //               pay_type: purchaseDetails.verificationData.source);
  //         }
  //       } else if (purchaseDetails.status == PurchaseStatus.error) {
  //          print("Error status ${purchaseDetails.error?.message}");
  //        }
  //        if (purchaseDetails.pendingCompletePurchase) {
  //         print('complete purchase called');
  //         await inAppPurchase.completePurchase(purchaseDetails);
  //       }
  //     }
  // }
  //
  // Future<void> getYearly() async {
  //   buttonLoadingYearly.value = true;
  //   final bool available = await inAppPurchase.isAvailable();
  //   print('availablity == $available');
  //   if (!available) {
  //     print('not available');
  //     return;
  //   }
  //
  //   String yearlyID = 'Annual';
  //   final response = await inAppPurchase
  //       .queryProductDetails({yearlyID});
  //
  //   if (response.notFoundIDs.isNotEmpty) {
  //     print(response.productDetails);
  //     print(response.notFoundIDs);
  //     print(response.productDetails.length);
  //     print("no Id found ");
  //   } else {
  //     final ProductDetails productDetails = response.productDetails.first;
  //     final PurchaseParam purchaseParam =
  //     PurchaseParam(productDetails: productDetails);
  //
  //     inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  //   }
  //   buttonLoadingYearly.value = false;
  // }
  //
  // Future<void> getMonthly() async {
  //   buttonLoadingMonthly.value = true;
  //   final bool available = await inAppPurchase.isAvailable();
  //   print('availablity == $available');
  //   if (!available) {
  //     print('not available');
  //     return;
  //   }
  //
  //   String monthlyID = 'Monthly';
  //   final response = await inAppPurchase
  //       .queryProductDetails({monthlyID});
  //
  //   if (response.notFoundIDs.isNotEmpty) {
  //     print("no Id found ${response.notFoundIDs}");
  //   }else {
  //     final ProductDetails productDetails = response.productDetails.first;
  //     final PurchaseParam purchaseParam =
  //     PurchaseParam(productDetails: productDetails);
  //
  //     inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  //   }
  //   buttonLoadingMonthly.value = false;
  // }
  //
  //
  // var apiLoading = false.obs;
  // Future<void> subscriptionAPi(
  //     {required String transaction_id,
  //       required String transaction_date,
  //       required String planType,
  //       required String allData,
  //       required String pay_type,
  //       required String is_recover}) async {
  //   apiLoading.value = true;
  //
  //   String date = timeConvfunc(timestampMs: int.parse(transaction_date));
  //
  //   var body = {
  //     'transaction_id': transaction_id,
  //     'date': date,
  //     'plan_type': planType,
  //     'all_json_data': allData,
  //     'status': 'active',
  //     'pay_type': pay_type,
  //     'test_type': 'sandbox',
  //     'is_recover': is_recover,
  //   };
  //
  //   var headers = {
  //   'Authorization': "Bearer ${LocalStorage.getToken()}"
  //   };
  //   print('to == ${LocalStorage.getToken()}');
  //
  //   print('send data == $body');
  //
  //   try {
  //     var response = await api.post('${EndPoints.subscriptionUrl}', body,headers: headers);
  //    print('subscription response == ${response.body}');
  //     if (response.statusCode == 200 && response.body['status'] == 'Success') {
  //       showTostMsg('You are now a premium user.');
  //       homeController.homePageApi();
  //     } else {
  //       showTostMsg('Error occured!');
  //     }
  //   } catch (e) {
  //     print('subscription error == ${e.toString()}');
  //   }
  //   apiLoading.value = false;
  // }
  //
  // String timeConvfunc({required int timestampMs}) {
  //   // Convert the Unix timestamp to a DateTime object
  //   DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampMs);
  //
  //   // Format the DateTime object to a readable string
  //   String readableDate = dateTime.toUtc().toString();
  //   int index = readableDate.indexOf('.');
  //   readableDate = readableDate.substring(0, index);
  //   print(readableDate);
  //   return readableDate;
  // }
  //
  //
  //
  // Future<void> buySubscription() async{
  //   if(selectedval.value == 1){
  //     await getYearly();
  //   }else if(selectedval.value == 2){
  //     await getMonthly();
  //   }else{
  //     showTostMsg('Please choose any plan');
  //   }
  // }
  //
  // Future<void> subscribe() async{
  //   if(choosePlan.value == 1){
  //     await getYearly();
  //   }else if(choosePlan.value == 2){
  //     await getMonthly();
  //   }else{
  //     showTostMsg('Please select plan');
  //   }
  // }

}
