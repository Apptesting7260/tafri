import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width*0.7,
      height: Get.height*0.5,
      child: Image.asset('assets/images/error.png'),
    );
  }
}
