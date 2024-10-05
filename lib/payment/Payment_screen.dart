import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

class PaymentScreen extends GetWidget<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(height: 15,),
           Padding(
             padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
             child: CommonUi.appBar(),
           ),
            SizedBox(height: 15,),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri.uri(Uri.parse(controller.paymentUrl.value))
                ),
                onLoadStart: (controlle, url) async{
                  if(url.toString() == 'https://docs.mollie.com/reference/handling-errors'){
                    await controller.getPay(controller.paymentId.value);
                  }
                },
                onLoadStop: (controller, url) {
                  print('load stop == ${url}');
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print('msg == ${consoleMessage}');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
