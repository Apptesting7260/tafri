import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';

class MymembershipController extends GetxController {

  @override
  void onClose() {
    super.dispose();
    print("dispose");
    subscription.cancel();
  }

  @override
  void onInit() {
    print('On in it callles');
    super.onInit();
    streamFunction();
    // homeController.homeData.value.result!.planType == 'monthly_plan' ? updateSelectedValue(2) : updateSelectedValue(1);
  }

  final ExploreListController homeController =
  Get.find<ExploreListController>();

  var choosePlan = 0.obs;

  void updatePlan(int value){
    choosePlan.value = value;
  }

  var selectedval = 0.obs;

  void updateSelectedValue(int? value) {
    selectedval.value = value!;
  }

  var buttonLoadingMonthly = false.obs;
  var buttonLoadingYearly = false.obs;

  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;
  // bool? isPremium = PrefUtils().getSubscriptionStatus();

  final api = ApiServices();

  void streamFunction() {
    print('stream');
    subscription = inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
        print("Comin here in func");

        if (purchaseDetailsList.isEmpty) {
          showTostMsg('No previous records found.');
        } else {
          listenToPurchaseUpdated(purchaseDetailsList);
        }
      },
      onDone: () {
        print("in the on done");
        subscription.cancel();
      },
      onError: (error) {
        print('Error in purchaseStream: $error');
      },
    );
  }

  void checkIfAvailable() async {
    print('called');
    await inAppPurchase.restorePurchases();
  }

  Future<void> listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for(var purchaseDetails in purchaseDetailsList) {
      buttonLoadingMonthly.value = false;
      buttonLoadingYearly.value = false;
      // if (purchaseDetails.status == PurchaseStatus.pending) {
      //   print("Pending Status");
      // } else {
         if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          if (purchaseDetails.status == PurchaseStatus.restored) {
            await subscriptionAPi(
                is_recover: 'true',
                transaction_id: purchaseDetails.purchaseID.toString(),
                transaction_date: purchaseDetails.transactionDate.toString(),
                planType: Platform.isIOS
                    ? purchaseDetails.productID == 'Annual'
                    ? 'yearly_plan'
                    : 'monthly_plan'
                    : purchaseDetails.productID,
                allData: purchaseDetails.verificationData.localVerificationData,
                pay_type: purchaseDetails.verificationData.source);
            print(
                "Verification Data Local 1  => ${purchaseDetails.verificationData.localVerificationData}");
          } else {
            print("The status is --> ${purchaseDetails.status}");
            print("Verified purchase");
            print("Purchase Id => ${purchaseDetails.purchaseID}");
            print(
                "Pending Complete Purchase => ${purchaseDetails.pendingCompletePurchase}");
            print("Product Id => ${purchaseDetails.productID}");
            print("Status => ${purchaseDetails.status}");
            print("Transaction Date => ${purchaseDetails.transactionDate}");
            print(
                "Verification Data Local 2  => ${purchaseDetails.verificationData.localVerificationData}");
            print(
                "Verification Data Server => ${purchaseDetails.verificationData.serverVerificationData}");
            print(
                "Verification Data Source => ${purchaseDetails.verificationData.source}");
            print("This time we are calling backend api");

            await subscriptionAPi(
                is_recover: 'false',
                transaction_id: purchaseDetails.purchaseID.toString(),
                transaction_date: purchaseDetails.transactionDate.toString(),
                planType: purchaseDetails.productID == 'Annual'
                    ? 'yearly_plan'
                    : 'monthly_plan',
                allData: purchaseDetails.verificationData.localVerificationData,
                pay_type: purchaseDetails.verificationData.source);
          }
        } else if (purchaseDetails.status == PurchaseStatus.error) {
           print("Error status ${purchaseDetails.error?.message}");
         }
         if (purchaseDetails.pendingCompletePurchase) {
          print('complete purchase called');
          await inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    // }
    // purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    //   buttonLoadingMonthly.value = false;
    //   buttonLoadingYearly.value = false;
    //   if (purchaseDetails.status == PurchaseStatus.pending) {
    //     print("Pending Status");
    //   } else {
    //     if (purchaseDetails.status == PurchaseStatus.error) {
    //       print("Error status");
    //     } else if (purchaseDetails.status == PurchaseStatus.purchased ||
    //         purchaseDetails.status == PurchaseStatus.restored) {
    //       if (purchaseDetails.status == PurchaseStatus.restored) {
    //         await subscriptionAPi(
    //             is_recover: 'true',
    //             transaction_id: purchaseDetails.purchaseID.toString(),
    //             transaction_date: purchaseDetails.transactionDate.toString(),
    //             planType: Platform.isIOS
    //                 ? purchaseDetails.productID == 'Annual'
    //                 ? 'yearly_plan'
    //                 : 'monthly_plan'
    //                 : purchaseDetails.productID,
    //             allData: purchaseDetails.verificationData.localVerificationData,
    //             pay_type: purchaseDetails.verificationData.source);
    //         print(
    //             "Verification Data Local 1  => ${purchaseDetails.verificationData.localVerificationData}");
    //       } else {
    //         print("The status is --> ${purchaseDetails.status}");
    //         print("Verified purchase");
    //         print("Purchase Id => ${purchaseDetails.purchaseID}");
    //         print(
    //             "Pending Complete Purchase => ${purchaseDetails.pendingCompletePurchase}");
    //         print("Product Id => ${purchaseDetails.productID}");
    //         print("Status => ${purchaseDetails.status}");
    //         print("Transaction Date => ${purchaseDetails.transactionDate}");
    //         print(
    //             "Verification Data Local 2  => ${purchaseDetails.verificationData.localVerificationData}");
    //         print(
    //             "Verification Data Server => ${purchaseDetails.verificationData.serverVerificationData}");
    //         print(
    //             "Verification Data Source => ${purchaseDetails.verificationData.source}");
    //         print("This time we are calling backend api");
    //
    //         await subscriptionAPi(
    //             is_recover: 'false',
    //             transaction_id: purchaseDetails.purchaseID.toString(),
    //             transaction_date: purchaseDetails.transactionDate.toString(),
    //             planType: purchaseDetails.productID == 'Annual'
    //                 ? 'yearly_plan'
    //                 : 'monthly_plan',
    //             allData: purchaseDetails.verificationData.localVerificationData,
    //             pay_type: purchaseDetails.verificationData.source);
    //       }
    //     }
    //     if (purchaseDetails.pendingCompletePurchase) {
    //       print('complete purchase called');
    //       await inAppPurchase.completePurchase(purchaseDetails);
    //     }
    //   }
    // });

    // for (var purchaseDetails in purchaseDetailsList) {
    //   if (purchaseDetails.status == PurchaseStatus.purchased) {
    //     // Verify the purchase with your server and unlock the subscription content
    //     if (purchaseDetails.productID == 'Monthly') {
    //
    //       // await getSubs(purchaseDetails.verificationData.localVerificationData);
    //       print("all data ${purchaseDetails.verificationData.localVerificationData}");
    //       print("purchaseToken ${purchaseDetails.purchaseID}");
    //       print("notificationType ${purchaseDetails.status}");
    //       // Assuming `amplitude` is defined and initialized somewhere
    //
    //       Get.back();
    //     } else if (purchaseDetails.productID == 'Annual') {
    //       // await  getSubs(purchaseDetails.verificationData.localVerificationData);
    //
    //       print("all data ${purchaseDetails.verificationData.localVerificationData}");
    //       print("purchaseToken ${purchaseDetails.purchaseID}");
    //       print("notificationType ${purchaseDetails.status}");
    //       // await isPrimeApi();
    //       // Get.back();
    //     }
    //   } else if (purchaseDetails.status == PurchaseStatus.error) {
    //     // Handle the error
    //     print("Purchase Error: ${purchaseDetails.error}");
    //   }
    //   if (purchaseDetails.pendingCompletePurchase) {
    //     InAppPurchase.instance.completePurchase(purchaseDetails);
    //   }
    // }
  }

  Future<void> getYearly() async {
    buttonLoadingYearly.value = true;
    final bool available = await inAppPurchase.isAvailable();
    print('availablity == $available');
    if (!available) {
      print('not available');
      return;
    }

    String yearlyID = 'Annual';
    final response = await inAppPurchase
        .queryProductDetails({yearlyID});

    if (response.notFoundIDs.isNotEmpty) {
      print(response.productDetails);
      print(response.notFoundIDs);
      print(response.productDetails.length);
      print("no Id found ");
    } else {
      final ProductDetails productDetails = response.productDetails.first;
      final PurchaseParam purchaseParam =
      PurchaseParam(productDetails: productDetails);

      inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    }
    buttonLoadingYearly.value = false;
  }

  Future<void> getMonthly() async {
    buttonLoadingMonthly.value = true;
    final bool available = await inAppPurchase.isAvailable();
    print('availablity == $available');
    if (!available) {
      print('not available');
      return;
    }

    String monthlyID = 'Monthly';
    final response = await inAppPurchase
        .queryProductDetails({monthlyID});

    if (response.notFoundIDs.isNotEmpty) {
      print("no Id found ${response.notFoundIDs}");
    }else {
      final ProductDetails productDetails = response.productDetails.first;
      final PurchaseParam purchaseParam =
      PurchaseParam(productDetails: productDetails);

      inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    }
    buttonLoadingMonthly.value = false;
  }

  // List<String> premiumFeatures = [
  //   'Verified badge on profile.',
  //   'Access to phone/video calls.',
  //   'Unlock GoLoca Challenges badges.',
  //   'Direct message to private profiles(max 10/day).',
  //   'Register up to 30 past trips.',
  //   'Create private posting groups.',
  // ];

  var apiLoading = false.obs;
  Future<void> subscriptionAPi(
      {required String transaction_id,
        required String transaction_date,
        required String planType,
        required String allData,
        required String pay_type,
        required String is_recover}) async {
    apiLoading.value = true;

    String date = timeConvfunc(timestampMs: int.parse(transaction_date));

    var body = {
      'transaction_id': transaction_id,
      'date': date,
      'plan_type': planType,
      'all_json_data': allData,
      'status': 'active',
      'pay_type': pay_type,
      'test_type': 'sandbox',
      'is_recover': is_recover,
    };

    var headers = {
    'Authorization': "Bearer ${LocalStorage.getToken()}"
    };
    print('to == ${LocalStorage.getToken()}');

    print('send data == $body');

    try {
      var response = await api.post('${EndPoints.subscriptionUrl}', body,headers: headers);
     print('subscription response == ${response.body}');
      if (response.statusCode == 200 && response.body['status'] == 'Success') {
        showTostMsg('You are now a premium user.');
        homeController.homePageApi();
      } else {
        showTostMsg('Error occured!');
      }
    } catch (e) {
      print('subscription error == ${e.toString()}');
    }
    apiLoading.value = false;
  }

  String timeConvfunc({required int timestampMs}) {
    // Convert the Unix timestamp to a DateTime object
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampMs);

    // Format the DateTime object to a readable string
    String readableDate = dateTime.toUtc().toString();
    int index = readableDate.indexOf('.');
    readableDate = readableDate.substring(0, index);
    print(readableDate);
    return readableDate;
  }



  Future<void> buySubscription() async{
    if(selectedval.value == 1){
      await getYearly();
    }else if(selectedval.value == 2){
      await getMonthly();
    }else{
      showTostMsg('Please choose any plan');
    }
  }

  Future<void> subscribe() async{
    if(choosePlan.value == 1){
      await getYearly();
    }else if(choosePlan.value == 2){
      await getMonthly();
    }else{
      showTostMsg('Please select plan');
    }
  }

}
