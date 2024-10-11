import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/payment/payment_model.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';

class PaymentController extends GetxController{


  String baseUrl = 'https://api.mollie.com/v2/';
  static String apiKey = 'test_x5n28NeK3FaaUdTB3bpnE2AErsSBpR';

  var header = {
    'Authorization': 'Bearer $apiKey'
  };

  final api = ApiServices();
  var paymentUrl = ''.obs;
  var paymentId = ''.obs;
  var loading = false.obs;

  var customerId = ''.obs;
  var planType = ''.obs;
  Future<void> createCustomer(String name,String email,String plan) async{

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
        await createPayment(plan == 'monthly' ? '3.99' : '23.99', customerId.value);
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
      'redirectUrl': 'https://urlsdemo.online/plusone/api/redirect-success-url',
      'cancelUrl': 'https://urlsdemo.online/plusone/api/redirect-cancel-url'
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
        mandateID.value = data['mandateId'];
        cardToken.value = data['details']['cardToken'];
        await createSub(customerId.value, planType.value == 'monthly' ? '3.99' : '23.99', planType.value == 'monthly' ? '1 month' : '12 months', planType.value == 'monthly' ? 'Monthly Membership' : 'Yearly Membership');
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

    DateTime now = DateTime.now();
    DateTime oneMonthFromNow = planType.value == 'monthly' ? DateTime(now.year, now.month + 1, now.day + 7,now.hour,now.minute,now.second) : DateTime(now.year + 1,now.month + 3,now.day,now.hour,now.minute,now.second);
    String startDate = DateFormat('yyyy-MM-dd').format(oneMonthFromNow);

    var body = {
      "amount": {
        "currency": "EUR",
        "value": amount,
      },
      'interval': duration,
      'description': description,
      'startDate': startDate
    };

    print('sub send data == ${body}');


    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String subscriptionDate = formatter.format(now);

    String endDate = formatter.format(oneMonthFromNow);
    print(endDate);

    try{
      final response = await api.post(url, body,headers: header);
      var data = jsonDecode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        await saveCard(customerId.value, mandateID.value, cardToken.value, planType.value, amount, paymentId.value, subscriptionDate, data['id'],endDate);
      }else{

      }
      print('create sub == ${response.body}');
      print('create sub code == ${response.statusCode}');
    }catch(e){
      print('mollie sub error == ${e.toString()}');
    }

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









  // Future<void> capturePayment() async{
  //
  //   var body = {
  //     'description': 'Testing'
  //   };
  //
  //   try{
  //     final response = await api.post('$baseUrl/$paymentId/captures', body,headers: header);
  //     print('capture == ${response.body}');
  //     if(response.statusCode == 200 || response.statusCode == 201){
  //
  //     }else{
  //
  //     }
  //   }catch(e){
  //     print('capture error == ${e.toString()}');
  //   }
  // }

  // Future<void> createMandate() async{
  //   var body = {
  //     'consumerName': 'Test',
  //     'customerId': customerId.value,
  //     'method': 'creditcard'
  //   };
  //
  //   try{
  //     final response = await api.post('${baseUrl}customers/${customerId.value}/mandates', body,headers: header);
  //     print('mandate == ${response.body}');
  //   }catch(e){}
  // }


  Future<void> saveCard(String customerID,String mandateID,String cardToken,String plan,String amount,String transactionID,String date,String subscriptionID,String endDate) async{
    var body = {
      'customerId': customerID,
      'merchantId': mandateID,
      'cartToken': cardToken,
      'plan_type': plan,
      'amount': amount,
      'transction_id': transactionID,
      'subscription_date': date,
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
      }else{
        showTostMsg('Something went wrong. Please try again');
      }
    }catch(e){
      showTostMsg('Something went wrong. Please try again');
      print('save card error == ${e.toString()
      }');
    }
  }


  var allCustomer = AllCustomerModal().obs;
  Future<void> getCustomer(String email) async{
    var url = '${baseUrl}customers';
    try{
      final response = await api.get(url,headers: header);
      print('get customer == ${response.body}');
      if(response.statusCode == 200 || response.statusCode == 201) {
        allCustomer.value = AllCustomerModal.fromJson(jsonDecode(response.body));

        if(checkCustomer(email)){
          createSub(customerId.value, '3.99', '1 month', 'Monthly membership');
        }else{

        }

      }
    }catch(e,stacktrace){
      print('get customer error == ${e.toString()}');
      print(stacktrace);
    }

  }


  bool checkCustomer(String email) {
    if (allCustomer.value.embedded?.customers != null) {
      for (var e in allCustomer.value.embedded!.customers!) {
        if (e.email == email) {
          print('email == ${e.email}');
          print('id == ${e.id}');
          customerId.value = e.id!;
          return true;
        }
      }
    }
    return false;
  }



}