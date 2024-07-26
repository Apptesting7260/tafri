import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/size.dart';
import '../../../../utils/colors.dart';
import '../../../components/custoelevatedbtn.dart';

class UpCommingActiUserController extends GetxController{
  @override
  void onInit() {
    alertRequestAccepted();
    super.onInit();
  }

  alertRequestAccepted() {
    return Future.delayed(Duration.zero,(){
      return  Get.dialog(AlertDialog(
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
                height: Get.height*.012,
              ),
              Center(child: Text("Congratulations! Your activity request is accepted by the host.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),
               SizedBox(
                height: Get.height*.024,
              ),
              SizedBox(width: double.maxFinite,height:Res.h_btn,child: CustoElevatedBtn(onTap: (){
                Get.back();
              }, backgroundClr: clrBlacke, child: Text("Go to activity",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
               SizedBox(
                height: Get.height*.012,
              ),
            ],
          ),
        ),
      )).then((val){
        return alertRequestNotAccepted();
      });
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

            const SizedBox(
              height: 10,
            ),
            Center(child: Text("The host couldn't accept your request this time. Check other activities available.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),
              SizedBox(
              height:Get.height*.025,
            ),
            SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustoElevatedBtn(onTap: (){
              Get.back();
            }, backgroundClr: clrBlacke, child: Text("Explore more",style: TextStyle(color: clrWhite,fontWeight: FontWeight.w700,fontSize: 16),))),
              SizedBox(
              height: Get.height*.012,
            ),
          ],
        ),
      ),
    ));
  }
}