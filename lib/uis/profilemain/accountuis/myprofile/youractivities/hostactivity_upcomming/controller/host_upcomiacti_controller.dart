import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import '../../../../../../../networking/apiservices.dart';
import '../../../../../../../networking/endpoints.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../../utils/local_storage.dart';
import '../../../../../../components/custoelevatedbtn.dart';
import '../../../../../../explore/explorelist/controller/explorelist_controller.dart';
import '../../../../../../explore/exploreview/model/exploreviewui_model.dart';
import '../../../../../../myactivity/myactivitylist/controller/myacti_controller.dart';

class HostUpcomiActiController extends GetxController  with GetTickerProviderStateMixin{
  late TabController tabController;

  final MyactiController myactiController = Get.find<MyactiController>();
  final ExploreListController exploreListController = Get.find<ExploreListController>();


  @override
  void onInit() {
    // alertActivityPending();
    var id = Get.arguments;
    hostactapi(id);
    tabController=TabController(length: 2, vsync: this);
    super.onInit();
  }

  changeIndicator(currentIndex) {
    actData.value.activity?.circleIndex?.value = currentIndex;
  }


  final api = ApiServices();
  var activityLoading = false.obs;
  var actData = ActDataModal().obs;
  var actError = ''.obs;

  Future<void> hostactapi(String? id) async{

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
          // alertRequestNotAccepted();
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


  var accuserLoading = false.obs;
  var accuserData = ActDataModal().obs;
  var accuserError = ''.obs;

  Future<void> acceptuserapi(String? userid) async{

    Map body = {
      'activity_id': actData.value.activity?.id,
      'user_id': userid
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    accuserLoading.value = true;

    try{
      final response = await api.post(EndPoints.acceptuser, body, headers: header);
      if(response.statusCode == 200){
        accuserError.value = '';
        print('home data == ${response.body}');
        accuserData.value = ActDataModal.fromJson(response.body);
        hostactapi(actData.value.activity?.id.toString());
      }else{
        print('error == ${response.body}');
        accuserError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      accuserError.value = e.toString();
    }

    accuserLoading.value = false;

  }


  var rejuserLoading = false.obs;
  var rejuserData = ActDataModal().obs;
  var rejuserError = ''.obs;

  Future<void> rejectuserapi(String? userid) async{

    Map body = {
      'activity_id': actData.value.activity?.id,
      'user_id': userid
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    rejuserLoading.value = true;

    try{
      final response = await api.post(EndPoints.rejectuser, body, headers: header);
      if(response.statusCode == 200){
        rejuserError.value = '';
        print('home data == ${response.body}');
        rejuserData.value = ActDataModal.fromJson(response.body);
        hostactapi(actData.value.activity?.id.toString());
      }else{
        print('error == ${response.body}');
        rejuserError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      rejuserError.value = e.toString();
    }

    rejuserLoading.value = false;

  }

  var remuserLoading = false.obs;
  var remuserData = ActDataModal().obs;
  var remuserError = ''.obs;

  Future<void> removeuserapi(String? userid) async{

    Map body = {
      'activity_id': actData.value.activity?.id,
      'user_id': userid
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    remuserLoading.value = true;

    try{
      final response = await api.post(EndPoints.removeuser, body, headers: header);
      if(response.statusCode == 200){
        remuserError.value = '';
        print('home data == ${response.body}');
        remuserData.value = ActDataModal.fromJson(response.body);
        hostactapi(actData.value.activity?.id.toString());
      }else{
        print('error == ${response.body}');
        remuserError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      remuserError.value = e.toString();
    }

    remuserLoading.value = false;

  }


  var delLoading = false.obs;
  var delData = ActDataModal().obs;
  var delError = ''.obs;

  Future<void> deleteactapi(String? id) async{



    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    delLoading.value = true;

    try{
      final response = await api.delete('${EndPoints.deleteact}$id' , headers: header);
      if(response.statusCode == 200){
        delError.value = '';
        print('home data == ${response.body}');
        delData.value = ActDataModal.fromJson(response.body);
        Get.back();
        showTostMsg('Your activity has been deleted');
        myactiController.attendingActivity();
        myactiController.hostingActivity();
        exploreListController.homePageApi();

      }else{
        print('error == ${response.body}');
        delError.value = 'ERROR';
        showTostMsg('there has been some error try again');
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      delError.value = e.toString();
    }

    delLoading.value = false;

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