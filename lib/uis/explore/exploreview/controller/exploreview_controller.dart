import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:plusone/utils/size.dart';

import '../../../../utils/colors.dart';
import '../../../components/custoelevatedbtn.dart';
import '../../../components/custotextfield.dart';

class ExploreViewController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    alertAddaMessage();
    super.onInit();
  }
  RxBool isFav=false.obs;
  changeFav(){
    isFav.value=!isFav.value;
  }
  Rx<int> isReqSent=1.obs;  //1= not send, 2= sended
  changeReqSent(val){
    isReqSent.value=val;
  }

  alertAddaMessage() {
    Future.delayed(Duration.zero,(){
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 25,
                      )),
                  const Flexible(
                    child: Text(
                      "Add a message",
                      style: TextStyle(fontSize: 19
                          , fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                ],
              ),
                SizedBox(
                height: Get.height*.02,
              ),
              Divider(
                color: clrGreyLight,
              ),
                SizedBox(
                height: Get.height*.014,
              ),
              const Text("Say hi to the host and share your interests in the activity. A personal touch makes all the difference! ",style: TextStyle(fontSize: 12),),

                SizedBox(
                height: Get.height*.014,
              ),
              const CustoTextFormField(hintText: "Hi! I’d like to join you for...",maxLines: 5,),
                SizedBox(
                height:  Get.height*.024,
              ),
              SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustoElevatedBtn(onTap: (){
                Get.back();
              }, backgroundClr: clrBlacke, child: Text("Send Request",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
                SizedBox(
                height:  Get.height*.014,
              ),
            ],
          ),
        ),
      )).then((val){
        return alertRequestAccepted();
      });
    });
  }
  alertRequestAccepted() {
    Get.dialog(AlertDialog(
      scrollable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: 15),
              child: Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,)),
            ),
            const Center(
              child:  Text(
                "Request Accepted!",
                style: TextStyle(fontSize: 19
                    , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
              ),
            ),

              SizedBox(
              height:Get.height*.014,
            ),
            Center(child: Text("Congratulations! Your activity request is accepted by the host.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),
              SizedBox(
              height: Get.height*.024,
            ),
            SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustoElevatedBtn(onTap: (){
              Get.back();
            }, backgroundClr: clrBlacke, child: Text("Go to activity",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
              SizedBox(
              height: Get.height*.014,
            ),
          ],
        ),
      ),
    )).then((val){
      return alertRequestNotAccepted();
    });
  }
  alertRequestNotAccepted() {
    Get.dialog(AlertDialog(
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
              height: Get.height*.007,
            ),
            InkWell(onTap: (){Get.back();},child: Icon(Icons.close)),
            Center(child: Image.asset("assets/icons/iicon.png",height: 65,)),
              SizedBox(
              height: Get.height*.02,
            ),
            const Center(
              child:  Text(
                "Request not accepted",
                style: TextStyle(fontSize: 19
                    , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
              ),
            ),

              SizedBox(
              height: Get.height*.014,
            ),
            Center(child: Text("The host couldn't accept your request this time. Check other activities available.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),
              SizedBox(
              height:Get.height*.024,
            ),
            SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustoElevatedBtn(onTap: (){
              Get.back();
            }, backgroundClr: clrBlacke, child: Text("Explore more",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
              SizedBox(
              height:Get.height*.014,
            ),
          ],
        ),
      ),
    ));
  }
}