import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/colors.dart';

class NoActivityScreen extends StatelessWidget {
  final double? height;
  NoActivityScreen({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width*0.7,
          height: height ?? Get.height*0.25,
          child: Image.asset('assets/images/no activity.png'),
        ),
        const SizedBox(height: 10,),
        Text('No activity found',style: TextStyle(
          color: clrBlacke,
          fontWeight: FontWeight.bold
        ),)
      ],
    );
  }
}
