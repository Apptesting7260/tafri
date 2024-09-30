import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NoHostedScreen extends StatelessWidget {
  final double? height;
  const NoHostedScreen({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width*0.7,
      height: height ?? Get.height*0.5,
      child: Image.asset('assets/images/no_activity_hosted.png'),
    );
  }
}
