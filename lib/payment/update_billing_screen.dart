import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/payment/payment_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:webview_flutter/webview_flutter.dart';


class UpdateBillingScreen extends StatefulWidget {
  const UpdateBillingScreen({super.key});

  @override
  State<UpdateBillingScreen> createState() => _UpdateBillingScreenState();
}

class _UpdateBillingScreenState extends State<UpdateBillingScreen> {

  final PaymentController controller = Get.find<PaymentController>();
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
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
            print('load stop == ${url}');
            print(
                'url match ${url.toString().trim() == '${EndPoints.redirectSuccessUrl}'}');
            if (url.toString().trim() ==
                '${EndPoints.redirectSuccessUrl}') {
              await controller.getBilling(controller.billingId.value);
              // await controller.getPayDetail(controller.paymentId.value);
            }else if(url.toString().trim() == '${EndPoints.redirectCancelUrl}'){
              showTostMsg('Your payment has been cancelled');
              Get.back();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(controller.billingUrl.value));
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
                  // InAppWebView(
                  //   initialUrlRequest: URLRequest(
                  //       url: WebUri.uri(Uri.parse(controller.billingUrl.value))),
                  //   onLoadStart: (controlle, url) async {
                  //
                  //   },
                  //   onLoadStop: (controlle, url) async{
                  //     print('load stop == ${url}');
                  //     print(
                  //         'url match ${url.toString().trim() == 'https://urlsdemo.online/plusone/api/redirect-success-url'}');
                  //     if (url.toString().trim() ==
                  //         'https://urlsdemo.online/plusone/api/redirect-success-url') {
                  //       await controller.getBilling(controller.billingId.value);
                  //       // await controller.getPayDetail(controller.paymentId.value);
                  //     }else if(url.toString().trim() == 'https://urlsdemo.online/plusone/api/redirect-cancel-url'){
                  //       showTostMsg('Your payment has been cancelled');
                  //       Get.back();
                  //     }
                  //   },
                  //   onConsoleMessage: (controlle, consoleMessage) {
                  //     print('msg == ${consoleMessage}');
                  //   },
                  // ),
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


// class UpdateBillingScreen extends GetWidget<PaymentController> {
//   const UpdateBillingScreen({super.key});
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
//                   // InAppWebView(
//                   //   initialUrlRequest: URLRequest(
//                   //       url: WebUri.uri(Uri.parse(controller.billingUrl.value))),
//                   //   onLoadStart: (controlle, url) async {
//                   //
//                   //   },
//                   //   onLoadStop: (controlle, url) async{
//                   //     print('load stop == ${url}');
//                   //     print(
//                   //         'url match ${url.toString().trim() == 'https://urlsdemo.online/plusone/api/redirect-success-url'}');
//                   //     if (url.toString().trim() ==
//                   //         'https://urlsdemo.online/plusone/api/redirect-success-url') {
//                   //       await controller.getBilling(controller.billingId.value);
//                   //       // await controller.getPayDetail(controller.paymentId.value);
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
