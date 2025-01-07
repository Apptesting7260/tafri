import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/myactivity/myactivitylist/model/attending_activity_model.dart';
import 'package:plusone/uis/myactivity/myactivitylist/model/hosting_model.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyactiController extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
    attendingActivity();
    hostingActivity();
  }

  RefreshController attendingRefreshController = RefreshController(initialRefresh: false);
  RefreshController hostingRefreshController = RefreshController(initialRefresh: false);

  final api = ApiServices();
  var attendingData = AttendingActivityModel().obs;
  var attendingLoading = false.obs;
  var attendingError = ''.obs;

  String? uid = LocalStorage.getUid();
  String? token = LocalStorage.getToken();

  Future<void> attendingActivity() async{
    print('a');
    attendingLoading.value = true;
    var header = {
      'Authorization': 'Bearer $token'
    };
    try{
      final response = await api.get("${EndPoints.attendingUrl}$uid",headers: header);
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200){
        attendingError.value = '';
        attendingData.value = AttendingActivityModel.fromJson(response.body);
      }else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('Session expired. Please login again.');
      }else{
        attendingData.value = AttendingActivityModel.fromJson(response.body);
        attendingError.value = '';
      }
    }catch(e){
      attendingError.value = e.toString();
      print('error == ${e.toString()}');
    }
    attendingLoading.value = false;
  }


  var hostingData = HostingActivityModel().obs;
  var hostingLoading = false.obs;
  var hostingError = ''.obs;

  Future<void> hostingActivity() async{
    hostingLoading.value = true;
    var header = {
      'Authorization': 'Bearer $token'
    };
    try{
      final response = await api.get('${EndPoints.hostingUrl}$uid',headers: header);
      if(response.statusCode == 200){
        hostingError.value = '';
        hostingData.value = HostingActivityModel.fromJson(response.body);
      }else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('Session expired. Please login again.');
      }else{
        hostingError.value = '';
        hostingData.value = HostingActivityModel.fromJson(response.body);
      }
    }catch(e){
      print('error == ${e.toString()}');
      hostingError.value = e.toString();
    }
    hostingLoading.value = false;
  }


}