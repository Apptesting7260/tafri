import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custodropdownbtn.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/utils/size.dart';

import '../../../../../../../utils/colors.dart';

class LanguagesProUi extends GetWidget{
  const LanguagesProUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(child: Padding(
        padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        child: Column(
          children: [
              SizedBox(
              height:h*.01
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width:h*.05,
                    height:h*.05,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Icon(Icons.arrow_back_ios)),
                  ),
                ),
                const Text(
                  "Languages",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                  SizedBox(
                  width: w*.06,
                ),
              ],
            ),
            SizedBox(
              height: Get.height*0.03,
            ),
            Expanded(
              child: Column(
                children: [
                  const Text("Share what languages you speak and find members who share common languages.",style: TextStyle(fontSize: 15),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                    SizedBox(
                    height: Res.h_btn,
                    child: const CustoDropDownBtn(itemList: [DropdownMenuItem(value: 1,child: Text("Hindi"),),DropdownMenuItem(value: 2,child: Text("English"),)], hindtext: "Select language"),
                  ),

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
