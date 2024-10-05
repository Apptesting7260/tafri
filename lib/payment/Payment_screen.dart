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
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
              child: CommonUi.appBar(),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: WebUri.uri(Uri.parse(controller.paymentUrl.value))),
                onLoadStart: (controlle, url) async {
                  // print(
                  //     'url match ${url.toString().trim() == 'https://urlsdemo.online/plusone/api/redirect-success-url'}');
                  // if (url.toString().trim() ==
                  //     'https://urlsdemo.online/plusone/api/redirect-success-url') {
                  //   await controller.getPay(controller.paymentId.value);
                  // }
                },
                onLoadStop: (controlle, url) async{
                  print('load stop == ${url}');
                  print(
                      'url match ${url.toString().trim() == 'https://urlsdemo.online/plusone/api/redirect-success-url'}');
                  if (url.toString().trim() ==
                      'https://urlsdemo.online/plusone/api/redirect-success-url') {
                    await controller.getPay(controller.paymentId.value);
                  }
                },
                onConsoleMessage: (controlle, consoleMessage) {
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
