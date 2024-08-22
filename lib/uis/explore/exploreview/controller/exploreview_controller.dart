import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:plusone/utils/size.dart';

import '../../../../networking/apiservices.dart';
import '../../../../networking/endpoints.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/local_storage.dart';
import '../../../components/custoelevatedbtn.dart';
import '../../../components/custotextfield.dart';
import '../model/exploreviewui_model.dart';

class ExploreViewController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    // alertAddaMessage();
    String id = Get.arguments;
    actapi(id);
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



  bool? isFavs = false;

  Future<bool?> changeFavApi(String? id) async{

    Map body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };


    try{
      final response = await api.post(EndPoints.changeFavurl, body,headers: header);
      if(response.statusCode == 200){
        isFavs = true;
        print('change data == ${response.body}');
        log(isFavs.toString());
        return isFavs;
      }else{
        print('error == ${response.body}');
        return false;
      }
    }catch(e){
      print('changeFav api error == ${e.toString()}');
      return false;

    }


  }



  changeIndicator(currentIndex) {
    actData.value.activity?.circleIndex?.value = currentIndex;
  }


  final api = ApiServices();
  var activitypage = false.obs;
  var actData = actDataModal().obs;
  var actError = ''.obs;


  Future<void> actapi(String? id) async{


    Map body = {
      'id': id,
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    activitypage.value = true;

    try{
      final response = await api.post(EndPoints.activitypage, body, headers: header);
      if(response.statusCode == 200){
        actError.value = '';
        print('home data == ${response.body}');
        actData.value = actDataModal.fromJson(response.body);
      }else{
        print('error == ${response.body}');
        actError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      actError.value = e.toString();
    }

    activitypage.value = false;

  }
  
  

  alertAddaMessage() {
    Future.delayed(Duration.zero,(){
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding: const EdgeInsets.symmetric(vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Say hi to the host and share your interests in the activity. A personal touch makes all the difference! ",style: TextStyle(fontSize: 12),),
              ),

                SizedBox(
                height: Get.height*.014,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: CustoTextFormField(
                  hintText: "Hi! I’d like to join you for...",
                  maxLines: 4,
                  borderRadius: 15,
                ),
              ),
                SizedBox(
                height:  Get.height*.024,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                  Get.back();
                }, backgroundClr: clrBlacke, child: Text("Send Request",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
              ),
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
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
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
            SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
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
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
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
            InkWell(onTap: (){Get.back();},child: const Icon(Icons.close)),
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
            SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
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