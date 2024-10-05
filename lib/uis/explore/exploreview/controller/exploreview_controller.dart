import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../networking/apiservices.dart';
import '../../../../networking/endpoints.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/local_storage.dart';
import '../../../components/custoelevatedbtn.dart';
import '../../../components/custotextfield.dart';
import '../model/exploreviewui_model.dart';
import '../model/requestmodel.dart';

class ExploreViewController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    // alertAddaMessage();
    String id = Get.arguments;
    actapi(id);
    super.onInit();
  }

  RefreshController refreshController = RefreshController(initialRefresh: false);
  RefreshController refreshController1 = RefreshController(initialRefresh: false);
  Future<void> refreshApi() async{
    await actapi(Get.arguments);
    refreshController.refreshCompleted();
    refreshController1.refreshCompleted();
  }

  RxBool isFav=false.obs;

  Rx<int> isReqSent=1.obs;  //1= not send, 2= sended
  changeReqSent(val){
    isReqSent.value=val;
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
        showTostMsg('Activity request has been cancelled');
        // Get.back();
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
        // Get.back();
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



  var requestData = Requestmodel().obs;

  Rx<bool> isLoadingRequest = false.obs;

  var waitlistMsgController = TextEditingController();
  var formKey = GlobalKey<FormState>();

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
      print("status code ${response.statusCode}");
      if(response.statusCode == 200){
        print('change data == ${response.body}');
        requestData.value = Requestmodel.fromJson(response.body);
        actData.value.activity?.requestStatus = requestData.value.requestStatus;
        actData.value.activity?.spotLeft = requestData.value.spotsLeft;
        actData.refresh();
        if(requestData.value.requestStatus == 'accept'){
          alertRequestAccepted();
        }else if(requestData.value.requestStatus == 'pending'){
          alertRequestSent();
        }
        // await actapi(id);
      }else if(response.statusCode == 403){
        showTostMsg('${response.body['message']}');
      } else{
        print('error == ${response.body}');
        showTostMsg('Something went wrong');
      }
    }catch(e){
      showTostMsg('Something went wrong');
      print('changeFav api error == ${e.toString()}');
    }

    isLoadingRequest.value = false;

  }



  changeIndicator(currentIndex) {
    actData.value.activity?.circleIndex?.value = currentIndex;
  }


  final api = ApiServices();
  var activitypage = false.obs;
  var actData = ActDataModal().obs;
  var actError = ''.obs;


  Future<void> actapi(String? id) async{


    Map body = {
      'id': id,
      'user_id': LocalStorage.getUid()
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

    activitypage.value = false;

  }
  
  

  alertAddaMessage(String? id) {
    Future.delayed(Duration.zero,(){
      Get.dialog(AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        contentPadding: const EdgeInsets.only(top: 20,bottom: 15),
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
                          size: 28,
                        )),
                    const Flexible(
                      child: Text(
                        "Add a message",
                        style: TextStyle(fontSize: 18
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
                color: clrBlacke.withOpacity(0.1),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formKey,
                  child: CustoTextFormField(
                    hintText: "Hi! I’d like to join you for...",
                    maxLines: 4,
                    borderRadius: 15,
                    controll: waitlistMsgController,
                    validation: (value) {
                      if(value == null || value.isEmpty){
                        return 'Please type any message';
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
              ),
                SizedBox(
                height:  Get.height*.024,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: () async{
                  if(formKey.currentState!.validate()){
                    Get.back();
                    await requestApi(id);
                  }
                }, backgroundClr: clrBlacke, child: Text("Send Request",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
              ),
                SizedBox(
                height:  Get.height*.014,
              ),
            ],
          ),
        ),
      ));
    });
  }
  alertRequestAccepted() {
    Get.dialog(AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      contentPadding: const EdgeInsets.symmetric(vertical: 22),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
              child: Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,)),
            ),
            const Center(
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Request Accepted!",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),
            ),

              SizedBox(
              height:Get.height*.014,
            ),
            Center(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Text("Congratulations! Your activity request is accepted by the host.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,),
            )),
              SizedBox(
              height: Get.height*.024,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                Get.offAllNamed(Routes.navbarUi);
              }, backgroundClr: clrBlacke, child: Text("Go to activity",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            ),
              SizedBox(
              height: Get.height*.014,
            ),
          ],
        ),
      ),
    ));
  }
  alertRequestSent() {
    Get.dialog(AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      contentPadding: const EdgeInsets.symmetric(vertical: 30),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
              child: Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child:  Text(
                  "Request Sent!",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),
            ),

              SizedBox(
              height:Get.height*.014,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(child: Text("We will let you know once the host responds to your request. Make sure you turn on the app notification to receive timely updates.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),
            ),
              SizedBox(
              height: Get.height*.024,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                Get.offAllNamed(Routes.navbarUi);
              }, backgroundClr: clrBlacke, child: Text("Go to activity",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            ),
              SizedBox(
              height: Get.height*.014,
            ),
          ],
        ),
      ),
    ));
  }
  alertRequestNotAccepted() {
    Get.dialog(AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18)
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      contentPadding: const EdgeInsets.only(top: 10,bottom: 15),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
              SizedBox(
              height: Get.height*.007,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(onTap: (){Get.back();},child: const Icon(Icons.close)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(child: Image.asset("assets/icons/iicon.png",height: 65,)),
            ),
              SizedBox(
              height: Get.height*.02,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child:  Text(
                  "Request not accepted",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),
            ),

              SizedBox(
              height: Get.height*.014,
            ),
            Center(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text("The host couldn't accept your request this time. Check other activities available.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,),
            )),
              SizedBox(
              height:Get.height*.024,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                Get.offAllNamed(Routes.navbarUi);
              }, backgroundClr: clrBlacke, child: Text("Explore more",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            ),
              SizedBox(
              height:Get.height*.014,
            ),
          ],
        ),
      ),
    ));
  }
}