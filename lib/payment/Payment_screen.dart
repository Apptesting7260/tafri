import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';

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
              child: Obx(() => Stack(
                alignment: Alignment.center,
                children: [
                  InAppWebView(
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
                      }else if(url.toString().trim() == 'https://urlsdemo.online/plusone/api/redirect-cancel-url'){
                        showTostMsg('Your payment has been cancelled');
                        Get.back();
                      }
                    },
                    onConsoleMessage: (controlle, consoleMessage) {
                      print('msg == ${consoleMessage}');
                    },
                  ),
                  controller.loading.value ? Column(
                    children: [
                      CommonUi.scaffoldLoading(color: clrYellow),
                      const SizedBox(height: 10,),
                      Text('Please wait...',style: TextStyle(
                          fontSize: 16,
                          color: clrBlacke,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ) : const SizedBox()
                ],
              ),),
            )
          ],
        ),
      ),
    );
  }
}
