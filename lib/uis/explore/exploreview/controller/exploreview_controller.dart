import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/explore/exploreview/model/exploreviewui_model.dart';
import 'package:plusone/uis/explore/exploreview/model/requestmodel.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;


class ExploreViewController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    // alertAddaMessage();
    String id = Get.arguments;
    actapi(id);
    getUserLocation();
    addMarkerWithImage();
    super.onInit();
    reportDescriptionController.addListener(() {
      capitalLetter(reportDescriptionController);
    },);
    waitlistMsgController.addListener(() {
      capitalLetter(waitlistMsgController);
    },);
  }

  RefreshController refreshController = RefreshController(initialRefresh: false);
  RefreshController refreshController1 = RefreshController(initialRefresh: false);

  final SocketController socketController = Get.find<SocketController>();

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
  // void firstNameCapital(TextEditingController controller) {
  //   final text = controller.text;
  //   if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
  //     controller.value = controller.value.copyWith(
  //       text: text[0].toUpperCase() + text.substring(1),
  //       selection: TextSelection.fromPosition(
  //         TextPosition(offset: controller.text.length),
  //       ),
  //     );
  //   }
  // }

  void capitalLetter(TextEditingController controller) {
    final text = controller.text;
    if (text.isNotEmpty) {
      final cursorPosition = controller.selection.base.offset;
      final updatedText = _capitalizeAfterPunctuationLogic(text);

      // Only update if the text has actually changed
      if (updatedText != text) {
        controller.value = controller.value.copyWith(
          text: updatedText,
          selection: TextSelection.collapsed(
            offset: cursorPosition, // Preserve cursor position
          ),
        );
      }
    }
  }

  String _capitalizeAfterPunctuationLogic(String text) {
    final buffer = StringBuffer();
    bool capitalizeNext = true;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (capitalizeNext && char != ' ') {
        buffer.write(char.toUpperCase());
        capitalizeNext = false;
      } else {
        buffer.write(char);
      }

      if (char == '.' || char == '!' || char == '?') {
        capitalizeNext = true;
      }
    }

    return buffer.toString();
  }

  // void firstNameCapital(TextEditingController controller) {
  //   final text = controller.text;
  //   if (text.isNotEmpty) {
  //     final cursorPosition = controller.selection.base.offset;
  //     final updatedText = _capitalizeAfterPunctuationLogic(text, cursorPosition);
  //     controller.value = controller.value.copyWith(
  //       text: updatedText,
  //       selection: TextSelection.fromPosition(
  //         TextPosition(offset: updatedText.length),
  //       ),
  //     );
  //   }
  // }
  //
  // String _capitalizeAfterPunctuationLogic(String text, int cursorPosition) {
  //   final buffer = StringBuffer();
  //   bool capitalizeNext = true;
  //
  //   for (int i = 0; i < text.length; i++) {
  //     final char = text[i];
  //     if (capitalizeNext && char != ' ') {
  //       buffer.write(char.toUpperCase());
  //       capitalizeNext = false;
  //     } else {
  //       buffer.write(char);
  //     }
  //
  //     if (char == '.' || char == '!' || char == '?') {
  //       capitalizeNext = true;
  //     }
  //   }
  //
  //   return buffer.toString();
  // }

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
        return 'Scam or fraud';
      case 2:
        return 'Inappropriate or misleading content';
      case 3:
        return 'Harrassment or abuse';
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


  Future<void> leaveActivity(String? id,{required String gpID}) async{

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
        socketController.leaveGroup(gpID: gpID, memberId: LocalStorage.getUid().toString());
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
  // var formKey = GlobalKey<FormState>();

  Future<void> requestApi(String? id) async{
    isLoadingRequest.value = true;

    Map body = {
      'activity_id': id.toString(),
      'user_id': LocalStorage.getUid().toString(),
      'request_type': actData.value.activity?.spotLeft == 0 ? 'waitlist' : 'immediate_join',
      'waitlist_message': waitlistMsgController.value.text.trim()
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    print(" time ${DateTime.now()}");

    try{
      final response = await api.post(EndPoints.requesttojoin, body,headers: header);
      // final response = await http.post(Uri.parse(EndPoints.requesttojoin),body: body,headers: header).timeout(Duration(seconds: 30));
      print(" time ${DateTime.now()} status code ${response.statusCode}   ${response.body} time ${DateTime.now()}");
      // final data = jsonDecode(response.body);
      if(response.statusCode == 200){
        print('change data == ${response.body}   ${DateTime.now()}');
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
      }else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('Session expired. Please login again.');
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      } else{
        print('error == ${response.body}');
        showTostMsg('Something went wrong');
      }
    }catch(e){
      showTostMsg('Something went wrong');
      print('api error == ${e.toString()}');
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
      }else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('Session expired. Please login again.');
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
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


  GoogleMapController? mapController;
  Rxn<loc.LocationData> currentLocation = Rxn<loc.LocationData>();
  LatLng initialPosition = LatLng(52.3731, 4.8922);
  RxSet<Marker> markers = <Marker>{}.obs;
  var mapLoading = false.obs;

  Future<void> getUserLocation() async {
    // mapLoading.value = true;
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    final userLocation = await location.getLocation();
    currentLocation.value = userLocation;
    print('currnet $currentLocation');
  }


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
                child: CustoTextFormField(
                  hintText: "Hi! I’d like to join you for...",
                  maxLines: 4,
                  borderRadius: 15,
                  controll: waitlistMsgController,
                  validation: (value) {
                    // if(value == null || value.isEmpty){
                    //   return 'Please type any message';
                    // }else{
                    //   return null;
                    // }
                  },
                ),
              ),
                SizedBox(
                height:  Get.height*.024,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: () async{
                  // if(formKey.currentState!.validate()){
                    Get.back();
                    await requestApi(id);
                  // }
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
              }, backgroundClr: clrBlacke, child: Text("Go to home screen",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
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
              child: Center(child: Text("Make sure to enable app notifications to receive updates.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),
            ),
              SizedBox(
              height: Get.height*.024,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                Get.offAllNamed(Routes.navbarUi);
              }, backgroundClr: clrBlacke, child: Text("Go to home screen",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
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