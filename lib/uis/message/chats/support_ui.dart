import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

class SupportUi extends StatelessWidget {
  SupportUi({super.key});

  var loading = false.obs;
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                child: CommonUi.appBar(),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: InAppWebView(
                  initialSettings: InAppWebViewSettings(
                    javaScriptEnabled: true
                  ),
                  initialUrlRequest: URLRequest(
                      url: WebUri.uri(Uri.parse(
                          'https://tawk.to/chat/67517d524304e3196aecb339/1ieb533e1'))),
                  onProgressChanged: (controller, progress) {
                    print('load == ${progress}');
                    loading.value = progress == 100 ? false : true;
                  },

                  onWebViewCreated: (controller) async{
                    webViewController = controller;
                  },
                  onLoadStop: (controller, url) async{
                    controller.evaluateJavascript(source: '''
            Tawk_API = Tawk_API || {};
            Tawk_API.visitor = {
              name: "John Doe",
              email: "john.doe@example.com"
            };
          ''');

                  },
                ),
              ),
            ],
          ),
          Obx(
            () => loading.value
                ? CommonUi.scaffoldLoading(color: clrYellow)
                : SizedBox(),
          )
        ],
      )),
    );
  }
}
