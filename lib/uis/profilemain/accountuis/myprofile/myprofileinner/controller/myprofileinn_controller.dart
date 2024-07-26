import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/size.dart';
import '../../../../../components/custoelevatedbtn.dart';

class MyprofileInnController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero,(){
      return ProfileAlertPopUp();
    });
    // TODO: implement onInit
    super.onInit();
  }

  ProfileAlertPopUp() async {
    Future.delayed(Duration(seconds: 3), () {
      return Get.dialog(AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 0),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          content: SizedBox(
            width: Get.width * 0.87,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                    child: Text(
                      "Almost there! ",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    )),
                  SizedBox(
                  height:Get.height*.012,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Just a few more details to complete your profile.",textAlign: TextAlign.center,style: TextStyle(fontSize: 14),),
                  ),
                ),
                  SizedBox(
                  height: Get.height*.012,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width*0.6,
                    height: Res.h_btn,
                    child: CustoElevatedBtn(onTap: (){
                      Get.back();
                    }, backgroundClr: clrBlacke, child: Text("Complete Now",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),)),
                  ),
                ),
                  SizedBox(
                  height:Get.height*.007,
                ),
                Center(
                  child: InkWell(onTap: (){
                    Get.back();
                  },child: Text("I will do it later",style: TextStyle(color: clrGreyTextLight,fontSize: 13),)),
                )
              ],
            ),
          )));
    });
  }
}