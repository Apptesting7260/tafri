import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../components/custoelevatedbtn.dart';
import '../../../addactreviewui.dart';

class PreviousActiController extends GetxController{
  @override
  void onInit() {
    alertActivityCompleted();
    super.onInit();
  }

  alertActivityCompleted() {
    Future.delayed(Duration.zero,(){
      return Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
                SizedBox(
                height:Get.height*.007,
              ),
              InkWell(onTap: (){Get.back();},child: const Icon(Icons.close)),
              Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,)),
                SizedBox(
                height: Get.height*.02,
              ),
              const Center(
                child:  Text(
                  "Activity completed!",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),

                SizedBox(
                height: Get.height*.014,
              ),
              Center(child: Text("Hope you had fun! We'd love to hear about your experience.",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),
                SizedBox(
                height: Get.height*.024,
              ),
              SizedBox(width: double.maxFinite,height:Res.h_btn,child: CustoElevatedBtn(onTap: (){
                Get.back();
                Get.to((){
                  return const AddActReviewUi() ;
                });
              }, backgroundClr: clrBlacke, child: Text("Add review",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
                SizedBox(
                height: Get.height*.014,
              ),
            ],
          ),
        ),
      ));
    });
  }
}