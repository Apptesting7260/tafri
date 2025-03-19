import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  final PaymentController controller = Get.find<PaymentController>();
  late WebViewController _controller;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {

          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) async{
          },
          onUrlChange: (change) async{
            var url = change.url;
            print('url change == ${change.url}');
            print('load stop == ${url}');
            print(
                'url match ${url.toString().trim() == '${EndPoints.redirectSuccessUrl}'}');
            if (url.toString().trim() ==
                '${EndPoints.redirectSuccessUrl}') {
              await controller.getPayDetail(controller.paymentId.value);
            }else if(url.toString().trim() == '${EndPoints.redirectCancelUrl}'){
              showTostMsg('Your payment has been cancelled');
              Get.back();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(controller.paymentUrl.value));
    super.initState();
  }

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
                  WebViewWidget(controller: _controller),
                  controller.loading.value ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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



// class PaymentScreen extends GetWidget<PaymentController> {
//   const PaymentScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 15,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
//               child: CommonUi.appBar(),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Expanded(
//               child: Obx(() => Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   WebViewWidget(controller: controller)
//                   // InAppWebView(
//                   //   initialSettings: InAppWebViewSettings(
//                   //   ),
//                   //   initialUrlRequest: URLRequest(
//                   //       url: WebUri.uri(Uri.parse(controller.paymentUrl.value))),
//                   //   onLoadStart: (controlle, url) async {
//                   //     // print(
//                   //     //     'url match ${url.toString().trim() == 'https://urlsdemo.online/plusone/api/redirect-success-url'}');
//                   //     // if (url.toString().trim() ==
//                   //     //     'https://urlsdemo.online/plusone/api/redirect-success-url') {
//                   //     //   await controller.getPay(controller.paymentId.value);
//                   //     // }
//                   //   },
//                   //   onLoadStop: (controlle, url) async{
//                   //     print('load stop == ${url}');
//                   //     print(
//                   //         'url match ${url.toString().trim() == 'https://urlsdemo.online/plusone/api/redirect-success-url'}');
//                   //     if (url.toString().trim() ==
//                   //         'https://urlsdemo.online/plusone/api/redirect-success-url') {
//                   //       await controller.getPayDetail(controller.paymentId.value);
//                   //     }else if(url.toString().trim() == 'https://urlsdemo.online/plusone/api/redirect-cancel-url'){
//                   //       showTostMsg('Your payment has been cancelled');
//                   //       Get.back();
//                   //     }
//                   //   },
//                   //   onConsoleMessage: (controlle, consoleMessage) {
//                   //     print('msg == ${consoleMessage}');
//                   //   },
//                   // ),
//                   controller.loading.value ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CommonUi.scaffoldLoading(color: clrYellow),
//                       const SizedBox(height: 10,),
//                       Text('Please wait...',style: TextStyle(
//                           fontSize: 16,
//                           color: clrBlacke,
//                           fontWeight: FontWeight.w500
//                       ),)
//                     ],
//                   ) : const SizedBox()
//                 ],
//               ),),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
