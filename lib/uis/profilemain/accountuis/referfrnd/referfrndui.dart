import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../utils/colors.dart';

class ReferFrndUi extends GetWidget{
  const ReferFrndUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   CommonUi.appBar(),
                    const Text("Invite friends",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
                      SizedBox(
                      width: w*.07,
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                const Image(image: AssetImage("assets/images/refer.png"),),
                const Text("Invite friends and enjoy a free 6-month membership",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text("Once your friend signs up and successfully joins an event, you both receive 6 months of free membership.",textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: clrGreyTextLight),),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustoElevatedBtn(onTap: (){
                  Share.share('check out my website https://example.com');
                }, backgroundClr: clrBlacke, child: Text("Invite friends",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),)))
              ],
            ),
          )),
    );
  }
}
