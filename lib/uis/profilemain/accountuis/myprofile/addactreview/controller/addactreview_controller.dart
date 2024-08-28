import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/tostmsg.dart';
import '../../../../../../networking/apiservices.dart';
import '../../../../../../networking/endpoints.dart';
import '../../../../../../utils/local_storage.dart';
import '../../activity/previousactivity/controller/previousacti_controller.dart';

class AddactreviewController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  final PreviousActiController preController = Get.find<PreviousActiController>();

  TextEditingController textController = TextEditingController();

  final api = ApiServices();
  var addreviewLoading = false.obs;
  // var addData = addDataModal().obs;
  var addError = ''.obs;


  Future<void> addreviewapi(String? id, double rating) async{


    Map body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
      'rating': rating,
      'review': textController.text.toString(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    addreviewLoading.value = true;

    try{
      final response = await api.post(EndPoints.addactreview, body, headers: header);
      if(response.statusCode == 200){

        addError.value = '';
        print('home data == ${response.body}');
        // addData.value = addDataModal.fromJson(response.body);
        var responsedata = response.body;
        if(responsedata['status'] == true) {
          // alertRequestNotAccepted();
          showTostMsg('Your review has been added');
          textController.clear();
          rating = 0;
          // await preController.actapi(id);
          await preController.showapi(id);
          // Get.back();

        }
      }else{
        print('error == ${response.body}');
        addError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      addError.value = e.toString();
    }

    addreviewLoading.value = false;

  }



}