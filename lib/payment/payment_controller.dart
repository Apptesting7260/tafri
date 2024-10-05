import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
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

  // var customerId = ''.obs;
  Future<void> createCustomer(String name,String email) async{

    var body = {
      'name': name,
      'email': email,
    };
    loading.value = true;
    try{
      final response = await api.post('${baseUrl}customers', body,headers: header);
      print('send data == ${body} \n cust response == ${response.body}');
      if(response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        // customerId.value = data['id'];
        await createPayment('0.01', data['id']);
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
      'redirectUrl': 'https://docs.mollie.com/reference/handling-errors',
    });

    try{
      final response = await api.post("${baseUrl}payments", body,headers: header);
      print('payment bd == ${response.body}');
      print('payment st == ${response.statusCode}');
      if(response.statusCode == 200 || response.statusCode == 201){
        var body = jsonDecode(response.body);
        print('url === ${body['_links']['checkout']['href']}');
        paymentUrl.value = body['_links']['checkout']['href'];
        paymentId.value = body['id'];
        await Get.toNamed(Routes.paymentScreen);
      }else{
        showTostMsg('Something went wrong.Please try again.');
      }
    }catch(e){
      showTostMsg('Something went wrong.Please try again.');
      print('error == ${e.toString()}');
    }

  }
  
  Future<void> getPay(String paymentId) async{
    try{
      final response = await api.get('${baseUrl}payments/$paymentId',headers: header);
      if(response.statusCode == 200 || response.statusCode == 201){
        final data = jsonDecode(response.body);
        print('respos == ${response.body}');
        print('cust == ${data['customerId']}  ${data['mandateId']}  ${data['details']['cardToken']}');
        await saveCard(data['customerId'], data['mandateId'], data['details']['cardToken']);
        Get.back();
      }else{
        showTostMsg('Something went wrong.Please try again.');
      }
    }catch(e){
      showTostMsg('Something went wrong.Please try again.');
      print('get payment error == ${e.toString()}');
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


  Future<void> saveCard(String customerID,String mandateID,String cardToken) async{
    var body = {
      'customerId': customerID,
      'merchantId': mandateID,
      'cartToken': cardToken
    };
    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}'
    };
    try{
      final response = await api.post(EndPoints.cardPayment, body,headers: header);
      print('save == ${response.body}');
      if(response.statusCode == 200){
        showTostMsg('Your card has been verified.');
      }else{
        showTostMsg('Something went wrong. Please try again');
      }
    }catch(e){
      showTostMsg('Something went wrong. Please try again');
      print('save card error == ${e.toString()
      }');
    }
  }


}