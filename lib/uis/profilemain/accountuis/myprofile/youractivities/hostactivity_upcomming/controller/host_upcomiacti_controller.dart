import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../../../networking/apiservices.dart';
import '../../../../../../../networking/endpoints.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../../utils/local_storage.dart';
import '../../../../../../components/custoelevatedbtn.dart';
import '../../../../../../explore/explorelist/controller/explorelist_controller.dart';
import '../../../../../../explore/exploreview/model/exploreviewui_model.dart';
import '../../../../../../myactivity/myactivitylist/controller/myacti_controller.dart';
import 'package:http/http.dart' as http;

class HostUpcomiActiController extends GetxController  with GetTickerProviderStateMixin{
  late TabController tabController;

  final MyactiController myactiController = Get.find<MyactiController>();
  final ExploreListController exploreListController = Get.find<ExploreListController>();
  RefreshController refreshController = RefreshController(initialRefresh: false);


  /// for map
  GoogleMapController? mapController;
  RxSet<Marker> markers = <Marker>{}.obs;
  Future<void> addMarkerWithImage() async {
    if (actData.value
        .activity?.banners?[0]
        .toString() != null && actData.value.activity!.banners![0].isNotEmpty) {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId('activity_marker'),
          position: LatLng(double.parse(actData.value
              .activity!.latitude!), double.parse(actData.value
              .activity!
              .longitude!)),
          infoWindow: InfoWindow(
            title: actData.value
                .activity!.name
                .toString(), // Title from arguments
          ),
          icon: BitmapDescriptor.defaultMarker, // Set custom icon
        ),
      );
      print('Marker added at ${actData.value
          .activity!.latitude}, ${actData.value
          .activity!
          .longitude} with icon: ${actData.value
          .activity!
          .banners?[0]
          .toString()}');
      update();
    }
  }
  /// for map

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
        // if(actData.value.activity?.requestStatus == 'reject'){
        //   // alertRequestNotAccepted();
        // }
      }else{
        print('act error == ${response.body}');
        actError.value = 'ERROR';
      }
    }catch(e){
      print('error == ${e.toString()}');
      actError.value = e.toString();
    }

    activityLoading.value = false;

  }

  Future<void> refresh()async{
    await hostactapi(Get.arguments);
    refreshController.refreshCompleted();
  }

  var accuserLoading = false.obs;
  var accuserData = ActDataModal().obs;
  var accuserError = ''.obs;

  Future<void> acceptuserapi(String? userid,Rx<bool?>? loading) async{

    loading?.value = true;

    Map body = {
      'activity_id': actData.value.activity?.id.toString(),
      'user_id': userid.toString()
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    accuserLoading.value = true;

    try{
      final response = await http.post(Uri.parse(EndPoints.acceptuser), body: body, headers: header);
      if(response.statusCode == 200){
        accuserError.value = '';
        print('home data == ${response.body}');
        accuserData.value = ActDataModal.fromJson(jsonDecode(response.body));
        print('work data == ${response.body}');
        hostactapi(actData.value.activity?.id.toString());
      }else{
        print('error == ${response.body}');
        accuserError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      accuserError.value = e.toString();
    }

    loading?.value = false;
    accuserLoading.value = false;

  }


  var rejuserLoading = false.obs;
  var rejuserData = ActDataModal().obs;
  var rejuserError = ''.obs;

  Future<void> rejectuserapi(String? userid,Rx<bool?>? loading) async{

    loading?.value = true;
    Map body = {
      'activity_id': actData.value.activity?.id.toString(),
      'user_id': userid
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    rejuserLoading.value = true;

    try{
      final response = await http.post(Uri.parse(EndPoints.rejectuser), body: body, headers: header);
      if(response.statusCode == 200){
        rejuserError.value = '';
        print('home data == ${response.body}');
        rejuserData.value = ActDataModal.fromJson(jsonDecode(response.body));
        hostactapi(actData.value.activity?.id.toString());
      }else{
        print('error == ${response.body}');
        rejuserError.value = 'ERROR';
      }
    }catch(e){
      print('error == ${e.toString()}');
      rejuserError.value = e.toString();
    }
    loading?.value = false;
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
        var data = response.body;
        print('error == ${response.body}');
        delError.value = 'ERROR';
        showTostMsg(data['message']);
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


  bool checkHour(BuildContext context,{
    required String startDate,
    required String startTime,
    required String hours,
  }) {
    final String date = startDate;
    final String startAt = startTime;
    final int cancellationHours = int.parse(hours);

    final String combinedDateTime = "$date $startAt";
    print('date == ${date}');
    print('sttime == ${startAt}');
    print('time == ${combinedDateTime}');
    DateTime? activityStartTime;
    final DateFormat formatWithMinutes = DateFormat("yyyy-MM-dd h:mm a");
    final DateFormat formatWithoutMinutes = DateFormat("yyyy-MM-dd h a");

    try {
      activityStartTime = formatWithMinutes.parse(combinedDateTime);
    } catch (_) {
      activityStartTime = formatWithoutMinutes.parse(combinedDateTime);
    }

    final DateTime cutoffTime = activityStartTime.subtract(Duration(hours: cancellationHours));

    final DateTime now = DateTime.now();

    if (now.isAfter(cutoffTime)) {
      return true;
    } else {
      return false;
    }
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