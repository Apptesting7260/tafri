import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/controller/myprofileinn_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstaLoginView extends StatefulWidget {
  const InstaLoginView({super.key});

  @override
  State<InstaLoginView> createState() => _InstaLoginViewState();
}

class _InstaLoginViewState extends State<InstaLoginView> {

  late WebViewController _controller;
  final MyprofileInnController controller = Get.find<MyprofileInnController>();

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
            print('url change == ${change.url}');
            print('load stop == ${url}');
            print(
                'url match ${url.toString().trim() == '${EndPoints.redirectSuccessUrl}'}');
            if (url!.startsWith('${EndPoints.redirectSuccessUrl}?code=')) {
              Uri uri = Uri.parse(url);
              print('IG Code == ${uri.queryParameters['code']}');
              var code = uri.queryParameters['code'];
              controller.verifyInsta(code: code!);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.instagram.com/oauth/authorize?enable_fb_login=0&force_authentication=1&client_id=9550333448334536&redirect_uri=https://api.plusonesapp.com/api/redirect-success-url&response_type=code&scope=instagram_business_basic%2Cinstagram_business_manage_messages%2Cinstagram_business_manage_comments%2Cinstagram_business_content_publish%2Cinstagram_business_manage_insights'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            Obx(() => controller.instaLoading.value ? Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonUi.scaffoldLoading(color: clrYellow),
                const SizedBox(height: 10,),
                const Text('Please wait...')
              ],
            )) : const SizedBox())
          ],
        ),
      ),
    );
  }
}
