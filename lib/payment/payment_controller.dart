import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/payment/payment_model.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/modal/plan_modal.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';

class PaymentController extends GetxController{

  @override
  void onInit() {
    customerId.value = profileController.profileData.value.result?.cardDetail?.customerId ?? "";
    mandateID.value = profileController.profileData.value.result?.cardDetail?.mandateId ?? '';
    cardToken.value = profileController.profileData.value.result?.cardDetail?.cardToken ?? '';
    print('card details == ${customerId.value}   ${mandateID.value}  ${cardToken.value}');
    getPlan();

    profileController.profileData.value.result?.planType == 'monthly' ? updateSelectedValue(0) : updateSelectedValue(1);
    purchasedPlan.value = profileController.profileData.value.result?.planType ?? '';

    profileController.profileData.value.result?.restartPlan?.planType == 'monthly' ? restartUpdateSelectedValue(0) : restartUpdateSelectedValue(1);
    restartPurchasedPlan.value = profileController.profileData.value.result?.restartPlan?.planType ?? '';

    referalController.text = profileController.profileData.value.result?.referalApplied ?? '';
    referalController.addListener(() {
      final text = referalController.text;
      final cleanedText = _removeExtraSpaces(text).toUpperCase();
      if (text != cleanedText) {
        referalController.value = TextEditingValue(
          text: cleanedText,
          selection: TextSelection.collapsed(offset: cleanedText.length),
        );
      }
    });
    super.onInit();
  }

  String _removeExtraSpaces(String input) {
    return input.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  final ProfilemainController profileController =
  Get.find<ProfilemainController>();

  var choosePlan = (-1).obs;
  var price = ''.obs;
  var freeDays = ''.obs;
  var selectedPlan = ''.obs;
  var planID = ''.obs;

  void updatePlan(int value,String planPrice,String freeDay,String plan,String id){
    choosePlan.value = value;
    price.value = planPrice;
    freeDays.value = freeDay;
    selectedPlan.value = plan;
    planID.value = id;
  }

  var plans = GetPlanModal().obs;
  var plansLoading = false.obs;
  var planError = ''.obs;
  Future<void> getPlan() async{
    var header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };
    plansLoading.value = true;
    try{
      final response = await api.get('${EndPoints.getPlan}',headers: header);
      print('get plan == ${response.body}   \n   ${response.statusCode}');
      if(response.statusCode == 200){
        planError.value = '';
        plans.value = GetPlanModal.fromJson(response.body);
      }else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('Session expired. Please login again.');
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        planError.value = 'error';
      }
    }catch(e){
      planError.value = e.toString();
      print('get plan error == ${e.toString()}');
    }
    plansLoading.value = false;
  }


  String getWeek(int days) {
    switch (days) {
      case 7:
        return '1 week';
      case 14:
        return '2 weeks';
      case 21:
        return '3 weeks';
      case 28:
        return '4 weeks';
      case 30:
      case 31:
        return '1 month';
      case 60:
      case 61:
        return '2 months';
      case 90:
      case 91:
        return '3 months';
      case 180:
      case 181:
        return '6 months';
      case 365:
        return '12 months (1 year)';
      default:
        if (days < 7) {
          return  days > 1 ? '$days days' : '$days day';
        } else if (days > 7 && days < 30) {
          int weeks = days ~/ 7;
          return '$weeks ${weeks > 1 ? 'weeks' : 'week'}';
        } else {
          int months = days ~/ 30;
          return '$months months';
        }
    }
  }


  String matchPlan(String name) {
    for(var i in plans.value.result!){
      print('per == ${i.billingPeriod}');
      print('name == ${name.toString() == i.billingPeriod.toString()}\n ${name}   ${i.billingPeriod}');
      if(name.toString() == i.billingPeriod.toString()){
        print('match found');
        return getWeek(int.parse(i.trailDays.toString()));
      }
    }
    return '';
  }

  String getAmount(String name){
    for(var i in plans.value.result!){
      if(name.toString() == i.billingPeriod.toString()){
        return i.price.toString();
      }
    }
    return '';
  }




  String baseUrl = 'https://api.mollie.com/v2/';
  // static String apiKey = 'test_x5n28NeK3FaaUdTB3bpnE2AErsSBpR';
  static String apiKey = 'live_jdRv2AhgqCQryKw8Rm4NdxCsx77FTy';

  var header = {
    'Authorization': 'Bearer $apiKey'
  };

  final api = ApiServices();
  var paymentUrl = ''.obs;
  var paymentId = ''.obs;
  var loading = false.obs;

  var customerId = ''.obs;
  var planType = ''.obs;
  Future<void> createCustomer(String name,String email,String plan,String amount) async{

    planType.value = plan;
    var body = {
      'name': name,
      'email': email,
    };
    loading.value = true;
    try{
      final response = await api.post('${baseUrl}customers', body,headers: header);
      print('send data == ${body} \n cust response == ${response.body}');
      if(response.statusCode == 200 || response.statusCode == 201) {
        loading.value = false;
        var data = jsonDecode(response.body);
        customerId.value = data['id'];
        await createPayment(amount, customerId.value);
      }else{
        showTostMsg('Something went wrong.Please try again');
      }
    }catch(e){
      showTostMsg('Something went wrong.Please try again');
      print('error == ${e.toString()}');
    }
    loading.value = false;
  }


  Future<void> createPayment(String amount,String customerID) async{

    var body = jsonEncode({
      "amount": {
        "currency": "EUR",
        "value": amount,
      },
      'description': "Authorize card for future payments",
      'method': 'creditcard',
      "sequenceType": "first",
      // "sequenceType": "recurring",
      "customerId": customerID,
      // "mandateId": 'mdt_GVSvwruSn7',
      'redirectUrl': '${EndPoints.redirectSuccessUrl}',
      'cancelUrl': '${EndPoints.redirectCancelUrl}'
    });
    loading.value = true;
    try{
      final response = await api.post("${baseUrl}payments", body,headers: header);
      print('payment bd == ${response.body}');
      print('payment st == ${response.statusCode}');
      if(response.statusCode == 200 || response.statusCode == 201){
        loading.value = false;
        var body = jsonDecode(response.body);
        print('url === ${body['_links']['checkout']['href']}');
        paymentUrl.value = body['_links']['checkout']['href'];
        paymentId.value = body['id'];
        await Get.toNamed(Routes.paymentScreen);
      }else{
        loading.value = false;
        showTostMsg('Something went wrong.Please try again.');
      }
    }catch(e){
      showTostMsg('Something went wrong.Please try again.');
      print('error == ${e.toString()}');
    }
    loading.value = false;

  }

  var mandateID = ''.obs;
  var cardToken = ''.obs;
  Future<void> getPay(String paymentId) async{
    loading.value = true;
    try{
      final response = await api.get('${baseUrl}payments/$paymentId',headers: header);
      print('get == ${response.statusCode}      ${response.body}');
      if(response.statusCode == 200 || response.statusCode == 201){
        final data = jsonDecode(response.body);
        print('respos == ${response.body}');
        print('cust == ${data['customerId']}  ${data['mandateId']}  ${data['details']['cardToken']}');
        if(data['status'] == 'paid'){
          mandateID.value = data['mandateId'];
          cardToken.value = data['details']['cardToken'];
          await createSub(customerId.value, price.value, planType.value == 'monthly' ? '1 month' : '12 months', planType.value == 'monthly' ? 'Monthly Membership' : 'Yearly Membership');
        }else{
          showTostMsg('${data['details']['failureMessage']}');
        }
        // await saveCard(data['customerId'], data['mandateId'], data['details']['cardToken']);
        // Get.back();
      }else{
        showTostMsg('Something went wrong.Please try again.');
      }
    }catch(e){
      showTostMsg('Something went wrong.Please try again.');
      print('get payment error == ${e.toString()}');
    }
    loading.value = false;

  }


  Future<void> createSub(String customerID,String amount,String duration,String description) async{
    var url = '${baseUrl}customers/$customerID/subscriptions';
    loading.value = true;
    DateTime now = DateTime.now();
    DateTime oneMonthFromNow = profileController.profileData.value.result?.cardDetail?.cardSave == false ? (planType.value == 'monthly' ? DateTime(now.year, now.month + 1, now.day + int.parse(freeDays.value),now.hour,now.minute,now.second) : DateTime(now.year + 1,now.month,now.day + int.parse(freeDays.value),now.hour,now.minute,now.second)) : (planType.value == 'monthly' ? DateTime(now.year, now.month, now.day,now.hour,now.minute,now.second) : DateTime(now.year,now.month,now.day,now.hour,now.minute,now.second));
    String startDate = DateFormat('yyyy-MM-dd').format(oneMonthFromNow);

    var body = {
      "amount": {
        "currency": "EUR",
        "value": amount,
      },
      'interval': duration,
      'description': description,
      'startDate': startDate,
      'webhookUrl': '${EndPoints.mollieWebhook}'
    };

    print('sub send data == ${body}');


    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String subscriptionDate = formatter.format(now);

    String endDate = profileController.profileData.value.result?.cardDetail?.cardSave == false ? formatter.format(oneMonthFromNow) : formatter.format(planType.value == 'monthly' ? DateTime(now.year, now.month + 1, now.day,now.hour,now.minute,now.second) : DateTime(now.year+1,now.month,now.day,now.hour,now.minute,now.second));
    print(endDate);

    try{
      final response = await api.post(url, body,headers: header);
      var data = jsonDecode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        await saveCard(customerId.value, mandateID.value, cardToken.value, planType.value, amount, paymentId.value, subscriptionDate, data['id'],endDate);
      }else{
        showTostMsg('Failed.Please try again.');
      }
      print('create sub == ${response.body}');
      print('create sub code == ${response.statusCode}');
    }catch(e){
      print('mollie sub error == ${e.toString()}');
    }
    loading.value = false;
  }


  alertRequestSent(dynamic Function() onVerifyTap) {
    Get.dialog(AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(vertical: 30),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Padding(padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            //   child: Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,)),
            // ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child:  Text(
                  "Verify card!",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(
              height:Get.height*.014,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(child: Text("Before proceeding,We need to verify your card.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),
            ),
            SizedBox(
              height: Get.height*.024,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: SizedBox(height: Res.h_btn,child: CustomElevatedButton(onTap: () {
                    Get.back();
                  }, borderClr: clrBlacke,backgroundClr: clrWhite, child: Text("Back",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),)))),
                  SizedBox(width: 10,),
                  Expanded(child: SizedBox(height: Res.h_btn,child: CustomElevatedButton(onTap: onVerifyTap, backgroundClr: clrBlacke, child: Text("Verify",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),)))),
                ],
              ),
            ),
            SizedBox(
              height: Get.height*.014,
            ),
          ],
        ),
      ),
    ));
  }


  successPopUp() {
    Get.dialog(AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(vertical: 30),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,),),
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child:  Text(
                  "Congratulations",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(
              height:Get.height*.014,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(child: Text("You are now a PlusOnes member!\nStart connecting and find your perfect activity partners!",style: TextStyle(color: clrGreyTextLight,),textAlign: TextAlign.center,)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: SizedBox(width: Get.width,height: Res.h_btn,child: CustomElevatedButton(onTap: () {
                Get.offAllNamed(Routes.navbarUi);
              }, backgroundClr: clrBlacke, child: Text("Let’s explore",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            ),
            SizedBox(
              height: Get.height*.014,
            ),
          ],
        ),
      ),
    ));
  }

  processingPopUp() {
    Get.dialog(AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(vertical: 30),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,),),
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child:  Text(
                  "Congratulations",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(
              height:Get.height*.014,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(child: Text("We are processing your payment. Once it is completed, you will receive the membership.",style: TextStyle(color: clrGreyTextLight,),textAlign: TextAlign.center,)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: SizedBox(width: Get.width,height: Res.h_btn,child: CustomElevatedButton(onTap: () {
                Get.offAllNamed(Routes.navbarUi);
              }, backgroundClr: clrBlacke, child: Text("Let’s explore",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            ),
            SizedBox(
              height: Get.height*.014,
            ),
          ],
        ),
      ),
    ));
  }



  Future<void> saveCard(String customerID,String mandateID,String cardToken,String plan,String amount,String transactionID,String date,String subscriptionID,String endDate) async{
    var body = {
      'customerId': customerID,
      'merchantId': mandateID,
      'cartToken': cardToken,
      'plan_id': planID.value,
      'amount': amount,
      'transaction_id': transactionID,
      'start_date': date,
      'subscription_id': subscriptionID,
      'currency': 'EUR',
      'end_date': endDate
    };
    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}'
    };
    try{
      final response = await api.post(EndPoints.cardPayment, body,headers: header);
      print('send data==   ${body}\nsave == ${response.body}');
      if(response.statusCode == 200){
        Get.back();
        successPopUp();
        await profileController.viewProfile();
        if(profileController.profileData.value.result?.planType != null){
          profileController.profileData.value.result?.planType == 'monthly' ? updateSelectedValue(0) : updateSelectedValue(1);
          purchasedPlan.value = profileController.profileData.value.result?.planType ?? '';
        }
      }else{
        showTostMsg('Something went wrong. Please try again');
      }
    }catch(e){
      showTostMsg('Something went wrong. Please try again');
      print('save card error == ${e.toString()}');
    }
  }




  var cancelSubLoading = false.obs;
  Future<void> cancelSub({required String id})async{

    cancelSubLoading.value = true;
    var body = {
      'customer_id': profileController.profileData.value.result?.cardDetail?.customerId,
      'subscription_id': id,
    };

    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}'
    };
    try{
      final response = await api.post('${EndPoints.cancelSub}', body,headers: header);
      print('cancel sub response == ${response.body}  \n ${response.statusCode}');
      if(response.statusCode == 200){
        showTostMsg('Your subscription has been cancelled.');
        profileController.viewProfile();
      }else{
        showTostMsg('Something went wrong.Please try again.');
      }
    }catch(e){
      showTostMsg('Something went wrong.');
      print('cancel sub error == ${e.toString()}');
    }
    cancelSubLoading.value = false;

  }

  cancelSubPopUp({required bool inTrail,required dynamic Function() onTap}) async {
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
              const Center(
                  child: Text(
                    "Are you sure?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                  )),
              SizedBox(height: Get.height * .012),
              Center(
                  child: Text(
                    inTrail ? 'Your membership will be canceled at the end of your current trial.' :
                    "Your membership will be canceled at the end of your current billing cycle.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: clrGreyTextLight, fontSize: 16),
                  )),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Res.h_btn,
                      child: CustomElevatedButton(
                        backgroundClr: clrBlacke,
                        onTap: () {
                          Get.back();
                        },

                        child: Text(
                          "Go back",
                          style: TextStyle(
                              color: clrWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: SizedBox(
                      height: Res.h_btn,
                      child: CustomElevatedButton(
                        onTap: onTap,
                        backgroundClr: clrWhite,
                        borderClr: clrBlacke,
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: clrBlacke,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }



  /// new flow


  Future<void> createNewCustomer(String name,String email,String plan,String amount) async{

    planType.value = plan;
    var body = {
      'name': name,
      'email': email,
    };
    loading.value = true;
    try{
      final response = await api.post('${baseUrl}customers', body,headers: header);
      print('send data == ${body} \n cust response == ${response.body}');
      if(response.statusCode == 200 || response.statusCode == 201) {
        loading.value = false;
        var data = jsonDecode(response.body);
        customerId.value = data['id'];
        await createTestPayment(customerId.value);
      }else{
        showTostMsg('Something went wrong.Please try again');
      }
    }catch(e){
      showTostMsg('Something went wrong.Please try again');
      print('error == ${e.toString()}');
    }
    loading.value = false;
  }

  Future<void> createTestPayment(String customerID) async{

    var body = jsonEncode({
      "amount": {
        "currency": "EUR",
        "value": '0.01',
      },
      'description': "Authorize card for future payments",
      // 'method': 'creditcard',
      "sequenceType": "first",
      // "sequenceType": "recurring",
      'webhookUrl': "${EndPoints.mollieWebhook}",
      'metadata': {
        'planid': planID.value,
        'userid': LocalStorage.getUid().toString()
      },
      "customerId": customerID,
      'redirectUrl': '${EndPoints.redirectSuccessUrl}',
      'cancelUrl': '${EndPoints.redirectCancelUrl}'
    });
    loading.value = true;
    try{
      final response = await api.post("${baseUrl}payments", body,headers: header);
      print('payment bd == ${response.body}');
      print('payment st == ${response.statusCode}');
      if(response.statusCode == 200 || response.statusCode == 201){
        loading.value = false;
        var body = jsonDecode(response.body);
        print('url === ${body['_links']['checkout']['href']}');
        paymentUrl.value = body['_links']['checkout']['href'];
        paymentId.value = body['id'];
        await Get.toNamed(Routes.paymentScreen);
      }else{
        loading.value = false;
        showTostMsg('Something went wrong.Please try again.');
      }
    }catch(e){
      showTostMsg('Something went wrong.Please try again.');
      print('error == ${e.toString()}');
    }
    loading.value = false;

  }

  Future<void> getPayDetail(String paymentId) async{
    loading.value = true;
    try{
      final response = await api.get('${baseUrl}payments/$paymentId',headers: header);
      print('get == ${response.statusCode}      ${response.body}');
      if(response.statusCode == 200 || response.statusCode == 201){
        final data = jsonDecode(response.body);
        print('respos == ${response.body}');
        print('cust == ${data['customerId']}  ${data['mandateId']}  ${data['details']['cardToken']}');
        if(data['status'] == 'paid') {
          mandateID.value = data['mandateId'];
          cardToken.value = data['details']['cardToken'];
          Get.back();
          processingPopUp();
          await profileController.viewProfile();
          if(profileController.profileData.value.result?.planType != null){
            profileController.profileData.value.result?.planType == 'monthly' ? updateSelectedValue(0) : updateSelectedValue(1);
            purchasedPlan.value = profileController.profileData.value.result?.planType ?? '';
          }
          // await createMembership(customerId.value, price.value, planType.value == 'monthly' ? '1 month' : '12 months', planType.value == 'monthly' ? 'Monthly Membership' : 'Yearly Membership');
        }else{
          showTostMsg('${data['details']['failureMessage']}');
          Get.back();
        }

      }else{
        showTostMsg('Something went wrong.Please try again.');
        Get.back();
      }
    }catch(e){
      showTostMsg('Something went wrong.Please try again.');
      Get.back();
      print('get payment error == ${e.toString()}');
    }
    loading.value = false;

  }

  Future<void> createMembership(String customerID,String amount,String duration,String description) async{
    var url = '${baseUrl}customers/$customerID/subscriptions';
    loading.value = true;
    DateTime now = DateTime.now();
    DateTime oneMonthFromNow = profileController.profileData.value.result?.cardDetail?.cardSave == false ? (planType.value == 'monthly' ? DateTime(now.year, now.month, now.day + int.parse(freeDays.value),now.hour,now.minute,now.second) : DateTime(now.year,now.month,now.day + int.parse(freeDays.value),now.hour,now.minute,now.second)) : (planType.value == 'monthly' ? DateTime(now.year, now.month, now.day,now.hour,now.minute,now.second) : DateTime(now.year,now.month,now.day,now.hour,now.minute,now.second));
    String startDate = DateFormat('yyyy-MM-dd').format(oneMonthFromNow);

    var body = {
      "amount": {
        "currency": "EUR",
        "value": amount,
      },
      'interval': duration,
      'description': description,
      'startDate': startDate,
      'webhookUrl': '${EndPoints.mollieWebhook}'
    };

    print('sub send data == ${body}');


    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String subscriptionDate = formatter.format(now);

    String endDate = profileController.profileData.value.result?.cardDetail?.cardSave == false ? formatter.format(oneMonthFromNow) : formatter.format(planType.value == 'monthly' ? DateTime(now.year, now.month + 1, now.day,now.hour,now.minute,now.second) : DateTime(now.year+1,now.month,now.day,now.hour,now.minute,now.second));
    print(endDate);

    try{
      final response = await api.post(url, body,headers: header);
      var data = jsonDecode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        await saveCard(customerId.value, mandateID.value, cardToken.value, planType.value, '0.01', paymentId.value, subscriptionDate, data['id'],endDate);
      }else{
        showTostMsg('Failed.Please try again.');
      }
      print('create sub == ${response.body}');
      print('create sub code == ${response.statusCode}');
    }catch(e){
      print('mollie sub error == ${e.toString()}');
    }
    loading.value = false;
  }


  /// new flow




  /// update billing

  updateBilling() async {
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
              const Center(
                  child: Text(
                    "Update billing?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                  )),
              SizedBox(height: Get.height * .012),
              Center(
                  child: Text(
                    "To update your billing, we will need to verify your card by making a test payment.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: clrGreyTextLight, fontSize: 16),
                  )),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Res.h_btn,
                      child: CustomElevatedButton(
                        onTap: () {
                          Get.back();
                        },
                        backgroundClr: clrWhite,
                        borderClr: clrBlacke,
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: clrBlacke,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: SizedBox(
                      height: Res.h_btn,
                      child: CustomElevatedButton(
                        onTap: () {
                          Get.back();
                          updateCard();
                        },
                        backgroundClr: clrBlacke,
                        child: Text(
                          "Update",
                          style: TextStyle(
                              color: clrWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  billingSuccessPopUp() {
    Get.dialog(AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(vertical: 30),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,),),
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child:  Text(
                  "Congratulations",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(
              height:Get.height*.014,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(child: Text("Your card has been verified.",style: TextStyle(color: clrGreyTextLight,),textAlign: TextAlign.center,)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: SizedBox(width: Get.width,height: Res.h_btn,child: CustomElevatedButton(onTap: () {
                Get.back();
              }, backgroundClr: clrBlacke, child: Text("Let’s explore",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            ),
            SizedBox(
              height: Get.height*.014,
            ),
          ],
        ),
      ),
    ));
  }



  var billingLoading = false.obs;
  var billingId = ''.obs;
  var billingUrl = ''.obs;
  var newMandateId = ''.obs;
  var newCardToken = ''.obs;
  Future<void> updateCard() async{

      var body = jsonEncode({
        "amount": {
          "currency": "EUR",
          "value": '0.01',
        },
        'description': "Authorize card for future payments",
        "sequenceType": "first",
        "customerId": customerId.value,
        'redirectUrl': '${EndPoints.redirectSuccessUrl}',
        'cancelUrl': '${EndPoints.redirectCancelUrl}'
      });
      billingLoading.value = true;
      try{
        final response = await api.post("${baseUrl}payments", body,headers: header);
        print('payment bd == ${response.body}');
        print('payment st == ${response.statusCode}');
        if(response.statusCode == 200 || response.statusCode == 201){
          billingLoading.value = false;
          var body = jsonDecode(response.body);
          print('url === ${body['_links']['checkout']['href']}');
          billingUrl.value = body['_links']['checkout']['href'];
          billingId.value = body['id'];
          await Get.toNamed(Routes.updateBilling);
        }else{
          billingLoading.value = false;
          showTostMsg('Something went wrong.Please try again.');
        }
      }catch(e){
        showTostMsg('Something went wrong.Please try again.');
        print('error == ${e.toString()}');
      }
      billingLoading.value = false;

  }


  Future<void> getBilling(String billingID) async{

    loading.value = true;
    try{
      final response = await api.get('${baseUrl}payments/$billingID',headers: header);
      print('get == ${response.statusCode}      ${response.body}');
      if(response.statusCode == 200 || response.statusCode == 201){
        final data = jsonDecode(response.body);
        print('respos == ${response.body}');
        print('cust == ${data['customerId']}  ${data['mandateId']}  ${data['details']['cardToken']}');
        newMandateId.value = data['mandateId'];
        newCardToken.value = data['details']['cardToken'];
        await updateMandateInSub(customerId.value, profileController.profileData.value.result!.subscriptionId.toString(), newMandateId.value);
      }else{
        showTostMsg('Something went wrong.Please try again.');
      }
    }catch(e){
      showTostMsg('Something went wrong.Please try again.');
      print('get payment error == ${e.toString()}');
    }
    loading.value = false;

  }


  Future<void> updateMandate(String mandateId,String cardToken) async{

    var body = {
      'mandate_id': mandateId,
      'cart_token': cardToken,
    };
    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}'
    };
    try{
      final response = await api.post(EndPoints.updateMandate, body,headers: header);
      print('send data==   ${body}\nsave == ${response.body}');
      if(response.statusCode == 200){
        Get.back();
        billingSuccessPopUp();
        profileController.viewProfile();
      }else{
        Get.back();
        // showTostMsg('Something went wrong. Please try again');
      }
    }catch(e){
      // showTostMsg('Something went wrong. Please try again');
      print('update card error == ${e.toString()}');
      Get.back();
    }

  }


  Future<void> updateMandateInSub(String customerID,String subID,String mandateID) async{
    var body = jsonEncode({
      'mandateId': mandateID,
      'webhookUrl': '${EndPoints.mollieWebhook}'
    });
    try{
      final response = await api.patch('${baseUrl}customers/$customerID/subscriptions/$subID', body,headers: header);
      print('update in mollie res == ${response.statusCode}   ${response.body}');
      if(response.statusCode == 200 || response.statusCode == 201){
        await updateMandate(newMandateId.value, newCardToken.value);
      }else{
        showTostMsg("Something went wrong");
        Get.back();
      }
    }catch(e){
      showTostMsg("Something went wrong. Please try again.");
      Get.back();
      print('update mandate in sub error = ${e.toString()}');
    }
  }

  /// update billing




  /// =======  SWITCH PLAN ======= ///

  var selectedval = (-1).obs;
  var purchasedPlan = ''.obs;
  var newAmount = ''.obs;
  var newId = ''.obs;
  var switchLoading = false.obs;

  void updateSelectedValue(int? value) {
    selectedval.value = value!;
  }

  switchPlanPopUp({required dynamic Function() onTap}) async {
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
              const Center(
                  child: Text(
                    "Switch plan",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                  )),
              SizedBox(height: Get.height * .012),
              Center(
                  child: Text(
                    "Do you want to switch your plan?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: clrGreyTextLight, fontSize: 16),
                  )),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Res.h_btn,
                      child: CustomElevatedButton(
                        onTap: () {
                          Get.back();
                        },
                        backgroundClr: clrWhite,
                        borderClr: clrBlacke,
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: clrBlacke,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: SizedBox(
                      height: Res.h_btn,
                      child: CustomElevatedButton(
                        onTap: onTap,
                        backgroundClr: clrBlacke,
                        child: Text(
                          "Switch",
                          style: TextStyle(
                              color: clrWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  switchSuccessPopUp(){
    Get.dialog(AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(vertical: 30),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,),),
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child:  Text(
                  "All set!",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(
              height:Get.height*.014,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(child: Text("Your plan is successfully changed.",style: TextStyle(color: clrGreyTextLight,),textAlign: TextAlign.center,)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: SizedBox(width: Get.width,height: Res.h_btn,child: CustomElevatedButton(onTap: () {
                Get.offAllNamed(Routes.navbarUi);
              }, backgroundClr: clrBlacke, child: Text("Let’s explore",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            ),
            SizedBox(
              height: Get.height*.014,
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> switchPlan({required String planID,required String amount}) async{
    switchLoading.value = true;
    var body = {
      'plan_id': planID,
      'amount': amount,
      'customer_id': profileController.profileData.value.result?.cardDetail?.customerId,
      'subscription_id': profileController.profileData.value.result?.subscriptionId,
    };

    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}'
    };

    try{
      final response = await api.post(EndPoints.switchPlan, body, headers: header);
      print('switch response == ${response.statusCode}     ${response.body}');
      if(response.statusCode == 200){
        Get.back();
        switchSuccessPopUp();
        await profileController.viewProfile();
        profileController.profileData.value.result?.planType == 'monthly' ? updateSelectedValue(0) : updateSelectedValue(1);
        purchasedPlan.value = profileController.profileData.value.result?.planType ?? '';
      }else{
        showTostMsg('Something went wrong. Please try again.');
      }
    }catch(e){
      showTostMsg('Something went wrong');
      print('switch error == ${e.toString()}');
    }
    switchLoading.value = false;
  }


  // Future<void> updateSub({required String amount,required String des,required String duration,required DateTime date}) async{
  //
  //   String startDate = DateFormat('yyyy-MM-dd').format(date);
  //   print('start date == ${startDate}');
  //   DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  //   String endDate = formatter.format(duration == '1 month' ? DateTime(date.year, date.month + 1, date.day,date.hour,date.minute,date.second) : DateTime(date.year+1,date.month,date.day,date.hour,date.minute,date.second));
  //   print('end date == ${endDate}');
  //
  //
  //   var body = jsonEncode({
  //     "amount": {
  //       "currency": "EUR",
  //       "value": amount
  //     },
  //     'description': des,
  //     'interval': duration,
  //     'webhookUrl': EndPoints.mollieWebhook,
  //     // 'startDate': startDate
  //   });
  //
  //   print('body == ${body}');
  //
  //   try{
  //     final response = await api.patch('${baseUrl}customers/${customerId.value}/subscriptions/${profileController.profileData.value.result!.subscriptionId.toString()}', body,headers: header);
  //     print('update sub response == ${response.statusCode}   ${response.body}');
  //     if(response.statusCode == 200 || response.statusCode == 201){
  //       updateSubInDb(trial: true, planID: newId.value, amount: amount, startDate: '', endDate: endDate, subID: '');
  //     }else{
  //       showTostMsg('Something went wrong');
  //     }
  //   }catch(e){
  //     showTostMsg('Something went wrong');
  //     print('update sub error == ${e.toString()}');
  //   }
  //
  // }



  // Future<void> updateSubInDb({required bool trial,required String planID,required String amount,required String startDate,required String endDate,required String subID}) async{
  //
  //   var body = trial == true ? {
  //     'plan_id': planID,
  //     'amount': amount,
  //     'end_date': endDate,
  //   } : {
  //     'plan_id': planID,
  //     'amount': amount,
  //     'start_date': startDate,
  //     'end_date': endDate,
  //     'subscription_id': subID,
  //   };
  //
  //   var header = {
  //     'Authorization': 'Bearer ${LocalStorage.getToken()}'
  //   };
  //
  //   try{
  //     final response = await api.post(EndPoints.switchPlan, body, headers: header);
  //     print('switch == ${response.statusCode}    ${response.body}');
  //   }catch(e){
  //     print('update in db error == ${e.toString()}');
  //   }
  //
  // }


  // Future<void> switchSub({required String customerID,required String subID}) async{
  //
  //   var body = {
  //     'customer_id': customerID,
  //     'subscription_id': subID,
  //   };
  //
  //   var header = {
  //     'Authorization': 'Bearer ${LocalStorage.getToken()}'
  //   };
  //   try{
  //     final response = await api.post('${EndPoints.cancelSub}', body,headers: header);
  //     print('cancel sub response == ${response.body}  \n ${response.statusCode}');
  //     if(response.statusCode == 200){
  //       // profileController.viewProfile();
  //     }else{
  //       showTostMsg('Something went wrong.Please try again.');
  //     }
  //   }catch(e){
  //     showTostMsg('Something went wrong.');
  //     print('switch sub error == ${e.toString()}');
  //   }
  //
  // }


  // Future<void> switchPlanMollie({required String customerID, required String amount, required String duration, required String description, required String date}) async{
  //   var url = '${baseUrl}customers/$customerID/subscriptions';
  //   String startDate = DateFormat('yyyy-MM-dd').format(oneMonthFromNow);
  //
  //   var body = {
  //     "amount": {
  //       "currency": "EUR",
  //       "value": amount,
  //     },
  //     'interval': duration,
  //     'description': description,
  //     'startDate': startDate,
  //     'webhookUrl': '${EndPoints.mollieWebhook}'
  //   };
  //
  //   print('sub send data == ${body}');
  //
  //
  //   DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  //   String subscriptionDate = formatter.format(now);
  //
  //   String endDate = profileController.profileData.value.result?.cardSave == false ? formatter.format(oneMonthFromNow) : formatter.format(planType.value == 'monthly' ? DateTime(now.year, now.month + 1, now.day,now.hour,now.minute,now.second) : DateTime(now.year+1,now.month,now.day,now.hour,now.minute,now.second));
  //   print(endDate);
  //
  //   try{
  //     final response = await api.post(url, body,headers: header);
  //     var data = jsonDecode(response.body);
  //     if(response.statusCode == 200 || response.statusCode == 201){
  //       // await saveCard(customerId.value, mandateID.value, cardToken.value, planType.value, '0.01', paymentId.value, subscriptionDate, data['id'],endDate);
  //     }else{
  //       showTostMsg('Failed.Please try again.');
  //     }
  //     print('create sub == ${response.body}');
  //     print('create sub code == ${response.statusCode}');
  //   }catch(e){
  //     print('mollie sub error == ${e.toString()}');
  //   }
  // }


  /// SWITCH PLAN ///



  /// restart switch plan ///

  var restartSelectedValue = (-1).obs;
  var restartPurchasedPlan = ''.obs;
  var restartNewAmount = ''.obs;
  var restartNewId = ''.obs;
  var restartSwitchLoading = false.obs;

  void restartUpdateSelectedValue(int? value) {
    restartSelectedValue.value = value!;
  }

  Future<void> switchRestartPlan({required String planID,required String amount}) async{
    restartSwitchLoading.value = true;
    var body = {
      'plan_id': planID,
      'amount': amount,
      'customer_id': profileController.profileData.value.result?.cardDetail?.customerId,
      'subscription_id': profileController.profileData.value.result?.restartPlan?.subId,
    };

    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}'
    };

    try{
      final response = await api.post(EndPoints.switchRestartPlan, body, headers: header);
      print('switch response == ${response.statusCode}     ${response.body}');
      if(response.statusCode == 200){
        Get.back();
        switchSuccessPopUp();
        await profileController.viewProfile();
        profileController.profileData.value.result?.restartPlan?.planType == 'monthly' ? restartUpdateSelectedValue(0) : restartUpdateSelectedValue(1);
        restartPurchasedPlan.value = profileController.profileData.value.result?.restartPlan?.planType ?? '';
      }else{
        showTostMsg('Something went wrong. Please try again.');
      }
    }catch(e){
      showTostMsg('Something went wrong');
      print('switch error == ${e.toString()}');
    }
    restartSwitchLoading.value = false;
  }


  /// restart switch plan ///



  /// referral popup ///

  var referalController = TextEditingController();
  var referalLoading = false.obs;


  referSuccessPopUp(var days){
    Get.dialog(AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(onTap: () {
                Get.back();
              },child: const Icon(Icons.close)),
            ),
            Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,),),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(child: Text("Your referral code has been successfully applied. You've received $days days of free membership.",style: TextStyle(color: clrBlacke,fontSize: 15),textAlign: TextAlign.center,)),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }

  referFailPopUp({String? message}){
    Get.dialog(AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(onTap: () {
                Get.back();
              },child: const Icon(Icons.close)),
            ),
            Center(child: Image.asset("assets/images/invalid_refer.png",height: 65,),),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(child: Text(message ?? "Referral code invalid",style: TextStyle(color: clrBlacke,fontSize: 15),textAlign: TextAlign.center,)),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }


  Future<void> applyCode() async{

    if(referalController.value.text.trim().isEmpty){
      showTostMsg("Please enter referal code.");
      return;
    }
    referalLoading.value = true;
    var body = {
      'referral_code': referalController.value.text.trim()
    };

    print('body == ${body}');
    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}'
    };

    try{
      final response = await api.post(EndPoints.referalCode, body,headers: header);
      print('referal response == ${response.statusCode}    ${response.body}');
      print('data == ${response.body['message']}');
      if(response.statusCode == 200){
        profileController.profileData.value.result?.referalApplied = referalController.value.text.trim();
        profileController.profileData.value.result?.myReferDays = profileController.profileData.value.result?.myReferDays ?? 0 + int.parse(response.body['extra_days']);
        profileController.profileData.refresh();
        referSuccessPopUp(response.body['extra_days']);
      }else if(response.statusCode == 400){
        referFailPopUp(message: response.body['message']);
      }else{
        referFailPopUp();
        // showTostMsg('${response.body['message']}');
      }
    }catch(e){
      print('referal code error == ${e.toString()}');
      showTostMsg('Something went wrong. Please try again.');
    }
    referalLoading.value = false;

  }


  /// referral popup ///


//
// class ExternalPurchase {
//   static const MethodChannel _channel =
//       MethodChannel('external_purchase_channel');
//
//   static Future<bool> canPresent() async {
//     return await _channel.invokeMethod<bool>('canPresent') ?? false;
//   }
//
//   static Future<String?> presentNoticeSheet() async {
//     return await _channel.invokeMethod<String>('presentNoticeSheet');
//   }
// }
//
// void handleExternalPurchase() async {
//   bool canUseExternalPurchase = await ExternalPurchase.canPresent();
//
//   if (canUseExternalPurchase) {
//     String? token = await ExternalPurchase.presentNoticeSheet();
//
//     if (token != null) {
//       // Send this token to your server to process the transaction
//       print("External Purchase Token: $token");
//     } else {
//       print("User canceled the external purchase");
//     }
//   } else {
//     print("External purchases not available on this device");
//   }
// }

  static const MethodChannel _channel =
  MethodChannel('external_purchase_channel');

  static Future<bool> canPresent() async {
    return await _channel.invokeMethod<bool>('canPresent') ?? false;
  }

  static Future<String?> presentNoticeSheet() async {
    return await _channel.invokeMethod<String>('presentNoticeSheet');
  }

void handleExternalPurchase() async {
  bool canUseExternalPurchase = await canPresent();

  if (canUseExternalPurchase) {
    String? token = await presentNoticeSheet();

    if (token != null) {
      // Send this token to your server to process the transaction
      showTostMsg('Notice sheet available. Token is ${token}');
      print("External Purchase Token: $token");
    } else {
      showTostMsg('Notice sheet not available');
      print("User canceled the external purchase");
    }
  } else {
    showTostMsg('Purchase not available');
    print("External purchases not available on this device");
  }
}


}