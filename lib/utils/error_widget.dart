import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width*0.7,
          height: Get.height*0.18,
          child: Image.asset('assets/images/error.png'),
        ),
        const SizedBox(height: 10,),
        Text('Error - page not found',style: TextStyle(
          fontWeight: FontWeight.bold,
          color: clrBlacke
        ),)
      ],
    );
  }
}
