import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/myactivity/myactivitylist/controller/myacti_controller.dart';
import 'package:plusone/utils/tostmsg.dart';
import '../../../../../../networking/apiservices.dart';
import '../../../../../../networking/endpoints.dart';
import '../../../../../../utils/local_storage.dart';
import '../../activity/previousactivity/controller/previousacti_controller.dart';
import 'package:http/http.dart' as http;

class AddactreviewController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    textController.addListener(capital);
  }

  final PreviousActiController preController = Get.find<PreviousActiController>();

  TextEditingController textController = TextEditingController();
  var rating = 0.0.obs;
  // void capital() {
  //   final text = textController.text;
  //   if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
  //     textController.value = textController.value.copyWith(
  //       text: text[0].toUpperCase() + text.substring(1),
  //       selection: TextSelection.fromPosition(
  //         TextPosition(offset: textController.text.length),
  //       ),
  //     );
  //   }
  // }

  void capital() {
    final text = textController.text;
    if (text.isNotEmpty) {
      final cursorPosition = textController.selection.base.offset;
      final updatedText = _capitalizeAfterPunctuationLogic(text, cursorPosition);
      textController.value = textController.value.copyWith(
        text: updatedText,
        selection: TextSelection.fromPosition(
          TextPosition(offset: updatedText.length),
        ),
      );
    }
  }

  String _capitalizeAfterPunctuationLogic(String text, int cursorPosition) {
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




  final api = ApiServices();
  var addreviewLoading = false.obs;
  // var addData = addDataModal().obs;
  var addError = ''.obs;


  Future<void> addreviewapi(String? id, double ratingg) async{


    var body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
      'rating': ratingg.toString(),
      'review': textController.text.toString(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    addreviewLoading.value = true;

    try{
      final response = await http.post(Uri.parse(EndPoints.addactreview), body: body, headers: header);
      if(response.statusCode == 200){

        addError.value = '';
        print('home data == ${response.body}');
        // addData.value = addDataModal.fromJson(response.body);
        var responsedata = jsonDecode(response.body);
        if(responsedata['status'] == true) {
          // alertRequestNotAccepted();
          showTostMsg('Your review has been added');
          textController.clear();
          Get.back();
          addreviewLoading.value = false;
          preController.actData.value.reviewAdded = true;
          preController.actData.refresh();
          // await preController.actapi(id);
          await preController.showapi(id);
          // Get.back();

        }
      }else{
        var responsedata = jsonDecode(response.body);
        print('error == ${response.body}');
        showTostMsg(responsedata['message']);
        addError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      addError.value = e.toString();
    }

    addreviewLoading.value = false;

  }



}