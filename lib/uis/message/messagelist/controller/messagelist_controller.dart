import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/message/messagelist/modal/notification_model.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessagelistController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
    getNotification();
  }

  
  var notData = NotificationModal().obs;
  var notLoading = false.obs;
  var notError = ''.obs;
  final api = ApiServices();
  RefreshController refreshController = RefreshController(initialRefresh: false);

  var header = {
    'Authorization': 'Bearer ${LocalStorage.getToken()}'
  };
  
  Future<void> getNotification() async{
    notLoading.value = true;
    try{
      final response = await api.get(EndPoints.getNot,headers: header);
      print(response.body);
      if(response.statusCode == 200){
        notError.value = '';
        notData.value = NotificationModal.fromJson(response.body);
      }else{
        notError.value = 'error';
      }
    }catch(e,stacktrace){
      notError.value = e.toString();
      print('not error == ${stacktrace}');
    }
    notLoading.value = false;
  }

  Future<void> deleteNot(String id) async{

    try{
      final response = await api.delete('${EndPoints.deleteNot}$id',headers: header);
      print(response.body);
      if(response.statusCode == 200){
        getNotification();
      }else{
        showTostMsg('Please try again');
      }
    }catch(e){
      showTostMsg('Please try again');
      print('delete not error == ${e.toString()}');
    }
  }




}