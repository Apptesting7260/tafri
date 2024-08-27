import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/size.dart';
import '../../../../networking/apiservices.dart';
import '../../../../networking/endpoints.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/local_storage.dart';
import '../../../../utils/tostmsg.dart';
import '../../../components/custoelevatedbtn.dart';
import '../../../explore/exploreview/model/exploreviewui_model.dart';
import '../../../explore/exploreview/model/requestmodel.dart';

class UpCommingActiUserController extends GetxController{
  @override
  void onInit() {
    // alertRequestAccepted();
    String id = Get.arguments;
    upactapi(id);
    super.onInit();
  }

  Rx<int> isReqSent=1.obs;  //1= not send, 2= sended
  changeReqSent(val){
    isReqSent.value=val;
  }

  changeIndicator(currentIndex) {
    actData.value.activity?.circleIndex?.value = currentIndex;
  }



  Rx<bool> isLoadingRequest = false.obs;
  var waitlistMsgController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var requestData = Requestmodel().obs;

  Future<void> requestApi(String? id) async{
    isLoadingRequest.value = true;

    Map body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
      'request_type': actData.value.activity?.spotLeft == 0 ? 'waitlist' : 'immediate_join',
      'waitlist_message': actData.value.activity?.spotLeft == 0 ? waitlistMsgController.value.text.trim() : null
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };


    try{
      final response = await api.post(EndPoints.requesttojoin, body,headers: header);
      if(response.statusCode == 200){
        print('change data == ${response.body}');
        requestData.value = Requestmodel.fromJson(response.body);
        actData.value.activity?.requestStatus = requestData.value.requestStatus;
        actData.value.activity?.spotLeft = requestData.value.spotsLeft;
        actData.refresh();
        if(requestData.value.requestStatus == 'accept'){
          alertRequestAccepted();
        }else if(requestData.value.requestStatus == 'pending'){
          // alertRequestSent();
        }
        // await actapi(id);
      }else{
        print('error == ${response.body}');
        showTostMsg('Something went wrong');
      }
    }catch(e){
      showTostMsg('Something went wrong');
      print('changeFav api error == ${e.toString()}');
    }

    isLoadingRequest.value = false;

  }


  final api = ApiServices();
  var activityLoading = false.obs;
  var actData = ActDataModal().obs;
  var actError = ''.obs;

  Future<void> upactapi(String? id) async{

    Map body = {
      'id': id,
      'user_id': LocalStorage.getUid()
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    activityLoading.value = true;

    try{
      final response = await api.post(EndPoints.activitypage, body, headers: header);
      if(response.statusCode == 200){
        actError.value = '';
        print('home data == ${response.body}');
        actData.value = ActDataModal.fromJson(response.body);
        if(actData.value.activity?.requestStatus == 'reject'){
          alertRequestNotAccepted();
        }
      }else{
        print('error == ${response.body}');
        actError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      actError.value = e.toString();
    }

    activityLoading.value = false;

  }

  var selectedValue = 0.obs;

  void updateSelectedValue(int? value) {
    selectedValue.value = value!;
  }

  TextEditingController reportDescriptionController = TextEditingController();

  var reportactivityLoading = false.obs;

  Future<void> reportActivity(String? id) async{


    Map body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
      'report_reason': getReportReason(selectedValue.value),
      'report_description': reportDescriptionController.text.trim()
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    reportactivityLoading.value = true;

    try{
      final response = await api.post(EndPoints.reportactivity, body, headers: header);
      if(response.statusCode == 200){
        print('home data == ${response.body}');
        showTostMsg('Report has been submitted');
        Get.back();
        reportDescriptionController.clear();
        selectedValue.value = 0;
      }else{
        print('error == ${response.body}');

      }
    }catch(e){
      print('home api error == ${e.toString()}');

    }

    reportactivityLoading.value = false;

  }

  String getReportReason(int value) {
    switch (value) {
      case 1:
        return 'Fake profile or spam';
      case 2:
        return 'Inappropriate or offensive behaviour';
      case 3:
        return 'Harassment or abuse';
      case 4:
        return 'Other';
      default:
        return 'Unknown';
    }
  }

  var cancelactivityLoading = false.obs;


  Future<void> cancelActivity(String? id) async{


    Map body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    cancelactivityLoading.value = true;

    try{
      final response = await api.post(EndPoints.cancelactivity, body, headers: header);
      if(response.statusCode == 200){
        print('home data == ${response.body}');
        showTostMsg('Activity has been cancelled');
        Get.back();
      }else{
        print('error == ${response.body}');

      }
    }catch(e){
      print('home api error == ${e.toString()}');

    }

    cancelactivityLoading.value = false;

  }


  var leaveactivityLoading = false.obs;


  Future<void> leaveActivity(String? id) async{


    Map body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    leaveactivityLoading.value = true;

    try{
      final response = await api.post(EndPoints.leaveactivity, body, headers: header);
      if(response.statusCode == 200){
        print('home data == ${response.body}');
        showTostMsg('You have successfuly left the Activity');
        Get.back();
      }else{
        print('error == ${response.body}');

      }
    }catch(e){
      print('home api error == ${e.toString()}');

    }

    leaveactivityLoading.value = false;

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
              SizedBox(width: double.maxFinite,height:Res.h_btn,child: CustomElevatedButton(onTap: (){
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
            SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
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