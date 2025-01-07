import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/explore/hostprofile/model/hostprofile_model.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HostProfileController extends GetxController{
  @override
  void onInit() {
    String id = Get.arguments;
    print(id);
    hostapi(id);
    super.onInit();
    reportDescriptionController.addListener(() {
      capitalLetter(reportDescriptionController);
    },);
  }

  RefreshController refreshController = RefreshController(initialRefresh: false);
  RefreshController refreshController1 = RefreshController(initialRefresh: false);

  Future<void> refreshApi() async{
    await hostapi(Get.arguments);
    refreshController.refreshCompleted();
    refreshController1.refreshCompleted();
  }



  String getPronoun(String? gender) {
    if (gender == "female") {
      return "She/Her";
    } else if (gender == "male") {
      return "He/Him";
    } else {
      return "They/Them";
    }
  }

  var selectedValue = 0.obs;

  void updateSelectedValue(int? value) {
    selectedValue.value = value!;
  }


  final api = ApiServices();
  var hostLoading = false.obs;
  var hostData = HostprofileModel().obs;
  var hostError = ''.obs;
  List<Subcategory> interestList = [];


  Future<void> hostapi(String? id) async{


    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    hostLoading.value = true;

    try{
      final response = await api.get('${EndPoints.hostprofile}$id', headers: header);
      if(response.statusCode == 200){
        hostError.value = '';
        print('host data == ${response.body}');
        hostData.value = HostprofileModel.fromJson(response.body);
        interestList.clear();
        if(hostData.value.result?.profile?.activityTitles != null){
          for(var i in hostData.value.result!.profile!.activityTitles!){
            if (i.subcategories != null) {
              interestList.addAll(i.subcategories!);
            }
          }
        }

        for (var subcategory in interestList) {
          print('Title: ${subcategory.title}, Icon: ${subcategory.icon}');
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
        hostError.value = 'ERROR';
      }
    }catch(e, stacktrace){
      print('host api error == ${e.toString()}');
      print('stacktrace: ${stacktrace}');
      hostError.value = e.toString();
    }

    hostLoading.value = false;

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

  var reportuserLoading = false.obs;

  Future<void> reportUser(String? id) async{


    Map body = {
      'host_id': id,
      'user_id': LocalStorage.getUid(),
      'report_reason': getReportReason(selectedValue.value),
      'report_description': reportDescriptionController.text.trim()
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    reportuserLoading.value = true;

    try{
      final response = await api.post(EndPoints.reportuser, body, headers: header);
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

    reportuserLoading.value = false;

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

}