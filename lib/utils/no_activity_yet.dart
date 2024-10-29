import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/colors.dart';

class NoActivityYetScreen extends StatelessWidget {
  final double? height;
  const NoActivityYetScreen({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width*0.7,
          height: height ?? Get.height*0.5,
          child: Image.asset('assets/images/no activity.png'),
        ),
        const SizedBox(height: 10,),
        Text('You haven’t joined any activities yet',style: TextStyle(
          fontWeight: FontWeight.bold,
          color: clrBlacke
        ),)
      ],
    );
  }
}
