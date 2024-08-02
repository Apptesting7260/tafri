import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../components/custoelevatedbtn.dart';

class HostUpcomiActiController extends GetxController  with GetTickerProviderStateMixin{
  late TabController tabController;
  @override
  void onInit() {
    alertActivityPending();
    tabController=TabController(length: 2, vsync: this);
    super.onInit();
  }
  RxInt selectedTab=1.obs;
  changeSlectedTab(val){
    selectedTab.value=val;
  }

  alertActivityPending() {
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
              InkWell(onTap: (){
                Get.back();
              },child: const Icon(Icons.close)),
              Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,)),
              const Center(
                child:  Text(
                  "Activity pending review",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w700),textAlign: TextAlign.center,
                ),
              ),

                SizedBox(
                height:  Get.height*.013,
              ),
              Center(child: Text("Your activity is being reviewed for compliance with our community guidelines. You will be notified once it is approved.",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),
                SizedBox(
                height: Get.height*.023,
              ),
              SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                Get.back();
              }, backgroundClr: clrBlacke, child: Text("View Activity",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
                SizedBox(
                height: Get.height*.013,
              ),
            ],
          ),
        ),
      )).then((val){

        alertActivityApproved();
      });
    });

  }
  alertActivityApproved() {
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
              InkWell(onTap: (){
                Get.back();
              },child: const Icon(Icons.close)),
              Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,)),
              const Center(
                child:  Text(
                  "Activity approved!",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Center(child: Text("Congratulations! Your activity has been approved by the PlusOnes team and will soon be available to other members.",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(child: Text("View Activity",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),), onTap: (){
                Get.back();
              }, backgroundClr: clrBlacke)),
                SizedBox(
                height:Get.height*.013,
              ),
            ],
          ),
        ),
      )).then((val){
        alertActivityNotAccepted();
      });
    });
  }
  alertActivityNotAccepted(){
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
              height:Get.height*.007,
            ),
            InkWell(onTap: (){Get.back();},child: const Icon(Icons.close)),
            Center(child: Image.asset("assets/icons/iicon.png",height: 65,)),
              SizedBox(
              height:  Get.height*.02,
            ),
            const Center(
              child:  Text(
                "Activity not accepted",
                style: TextStyle(fontSize: 19
                    , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Center(child: Text("Your post was not accepted by the PlusOnes team. Please refer to our Community Guidelines or reach out to Support if you have any questions.",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),
              SizedBox(
              height: Get.height*.025,
            ),
            SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(child: Text("Back to home screen",style: TextStyle(color: clrWhite),), onTap: (){
              Get.back();
            }, backgroundClr: clrBlacke)),
              SizedBox(
              height: Get.height*.013,
            ),
          ],
        ),
      ),
    ));
  }
}