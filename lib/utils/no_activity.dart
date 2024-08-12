import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NoActivityScreen extends StatelessWidget {
  final double? height;
  NoActivityScreen({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width*0.7,
      height: height ?? Get.height*0.5,
      child: Image.asset('assets/images/no activity.png'),
    );
  }
}
