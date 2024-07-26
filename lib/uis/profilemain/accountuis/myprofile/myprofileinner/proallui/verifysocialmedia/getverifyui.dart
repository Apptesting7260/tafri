import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/utils/size.dart';

import '../../../../../../../utils/colors.dart';

class GetVerifyUi extends GetWidget{
  const GetVerifyUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Icon(Icons.arrow_back_ios)),
                  ),
                ),

                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: Get.height*0.03,
            ),
            const Text(
              "Get verified for a safer",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            Row(
              children: [

                const Text(
                  "community",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),const SizedBox(width: 10,),
                Icon(Icons.verified,color: clrYellow,)
              ],
            ),
            SizedBox(
              height: Get.height*0.03,
            ),
            Expanded(
              child: ListView(
                children: [
                  const Text("Help keep our community secure and authentic by optionally verifying your social media accounts. Your information will remain private, and you’ll receive a badge on your profile.",style: TextStyle(fontSize: 16),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Row(
                    children: [
                      Image.asset("assets/icons/insta.png",height: h*.033,),
                        SizedBox(
                        width: w*.04,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Instagram",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            Container(height:h*.044,child: FittedBox(child: Switch(activeTrackColor:clrYellow,value: true, onChanged: (val){},activeColor: clrWhite,focusColor: clrWhite,)))
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height:h*.04,
                    color: clrGreyLight,
                  ),
                  Row(
                    children: [
                      Image.asset("assets/icons/linkdin.png",height:h*.033,),
                        SizedBox(
                        width:w*.04,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("LinkedIn",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                            Container(height:h*.044,child: FittedBox(child: Switch(activeTrackColor:clrYellow,value: true, onChanged: (val){},activeColor: clrWhite,focusColor: clrWhite,)))
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: h*.04,
                    color: clrGreyLight,
                  )

                ],
              ),
            ),
            SizedBox(height: Res.h_btn,width: double.maxFinite,child: CustoElevatedBtn(onTap: (){} ,backgroundClr:clrBlacke, child: Text("Save",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            SizedBox(
              height: Get.height*0.01,
            ),
          ],
        ),
      )),
    );
  }
}
