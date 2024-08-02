import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/profilemain/accountuis/mymembership/switchplan/switchplanui.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../utils/colors.dart';

class MyMemberShipUi extends GetWidget{
  const MyMemberShipUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SafeArea(

          child: Padding(
            padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonUi.appBar(),
                      const Text("My membership",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
                        SizedBox(
                        width:w*.05,
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.035,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,vertical: 20
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: clrGreyLight,
                        border: Border.all(color: clrGrey.withOpacity(0.4))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Annual",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                        SizedBox(height: 5,),
                        Text("You are in a 3-month free trial.",style: TextStyle(color: clrGreyTextLight,fontSize: 14,fontWeight: FontWeight.w700),),
                        Text("Starting 1 June, your plan will renew for the regular price of €23.99 every year until canceled. ",style: TextStyle(fontSize: 13,color: clrGrey5D5C5E),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.035,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: Res.h_btn,
                    child: CustomElevatedButton(onTap: (){
                      Get.toNamed(Routes.switchPlanProUi);
                    }, backgroundClr: clrBlacke, child: Text("Switch plan",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),)),
                  )


                ],
              ),
            ),
          )),
    );
  }
}
