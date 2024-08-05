import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/model/profile_view_model.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/addphoto/controller/addphoto_controller.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/funfact/models/funfactquest_model.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/language/models/langauagemodel.dart';
import 'package:plusone/utils/local_storage.dart';
import '../../../../../../networking/apiservices.dart';
import '../../../../../../networking/endpoints.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/size.dart';
import '../../../../../../utils/tostmsg.dart';
import '../../../../../components/custoelevatedbtn.dart';
import '../proallui/activityinterest/models/activitymodel.dart';

class MyprofileInnController extends GetxController
    with GetTickerProviderStateMixin {
  final api = ApiServices();
  late TabController tabController;

  @override
  void onInit() {
    languageApi();
    funFactQuetionList();
    activityGetDataApi();
    tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () {
      return profileAlertPopUp();
    });
    // TODO: implement onInit
    super.onInit();
  }

  TextEditingController bioController = TextEditingController();
  TextEditingController locController = TextEditingController();
  TextEditingController ocupatController = TextEditingController();
  TextEditingController organiController = TextEditingController();
  TextEditingController langController = TextEditingController();

  Map profileDeta = {
    'user_id': '',
    'bio': '',
    'occupation': '',
    'organisation_name': '',
    'language_id': '',
    'category_id': '',
    'subcategory_id': '',
    'questions': '',
    'answers': '',
    'profile_photo': '',
    'verify_instagram': '',
    'verify_linkedin': '',
  };

  profileAlertPopUp() async {
    Future.delayed(const Duration(seconds: 3), () {
      return Get.dialog(AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 0),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          content: SizedBox(
            width: Get.width * 0.87,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                    child: Text(
                  "Almost there! ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                )),
                SizedBox(height: Get.height * .012),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Just a few more details to complete your profile.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * .015,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width * 0.6,
                    height: Res.h_btn,
                    child: CustomElevatedButton(
                        onTap: () {
                          Get.back();
                        },
                        backgroundClr: clrBlacke,
                        child: Text(
                          "Complete Now",
                          style: TextStyle(
                              color: clrWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                Center(
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "I will do it later",
                        style: TextStyle(
                            color: clrGreyTextLight,
                            fontSize: 13,
                            decoration: TextDecoration.underline),
                      )),
                )
              ],
            ),
          )));
    });
  }

//************************************************language select code  ****************
  RxList selectedLanguageList = [].obs;

  removeSelectLan(index) {
    selectedLanguageList.removeAt(index);
    selectedLanguageList.reversed;
  }

  Rx<bool> isShowLangReqError = false.obs;

  changeIsShowLangError(val) {
    isShowLangReqError.value = val;
  }

//************************************************Get verified code****************
  Rx<int> isInstaVerified = 0.obs;
  Rx<int> isLinkdinVerified = 0.obs;

  changeVerifyInsta(val) {
    isInstaVerified.value = val;
  }

  changeVerifyLinkdin(val) {
    isLinkdinVerified.value = val;
  }

//************************************************language get dropdown api ****************
  Rx<bool> isLanLoading = false.obs;
  Rx<LanguageModel> langListData = LanguageModel().obs;

  Future<void> languageApi() async {
    isLanLoading.value = true;
    String? token = LocalStorage.getToken();
    String? uID = LocalStorage.getUid();
    try {
      final response = await api.get("${EndPoints.languageListApiUrl}$uID",
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        LanguageModel body = LanguageModel.fromJson(response.body);
        if (body.status == true) {
          langListData.value = body;
        } else {
          showTostMsg("Something went wrong");
        }
      } else {
        showTostMsg("Something went wrong");
      }
    } catch (e) {
      debugPrint("error==$e");
      showTostMsg("Something went wrong");
    }
    isLanLoading.value = false;
  }

  //************************************************Activity get api ****************
  Rx<bool> isLoadingActivity = false.obs;
  Rx<ActivityModel> activityListData = ActivityModel().obs;

  Future<void> activityGetDataApi() async {
    isLoadingActivity.value = true;
    String? token = LocalStorage.getToken();
    String? uID = LocalStorage.getUid();
    print(token);
    try {
      final response = await api.get("${EndPoints.getCategoryApiUrl}$uID",
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        ActivityModel body = ActivityModel.fromJson(response.body);
        if (body.status == true) {
          activityListData.value = body;
          debugPrint("gk=====activity listdeta=${response.body}");
        } else {
          showTostMsg("Something went wrong");
        }
      } else {
        showTostMsg("Something went wrong");
      }
    } catch (e) {
      debugPrint("error==$e");
      showTostMsg("Something went wrong");
    }
    isLoadingActivity.value = false;
  }

//************************************************Activity selected btn algo ****************
// List selectedInterestIds=[];
  var selectedCatIds = [].obs;
  var selectedSubCatIds = [].obs;

  changeActivitySelect(catindex, catId, subCatListIndex, subCatId, isSelected) {
    if (isSelected == true) {
      selectedCatIds.add(catId);
      selectedSubCatIds.add(subCatId);
    } else {
      for (int i = 0; i < selectedCatIds.length; i++) {
        if (selectedCatIds[i] == catId) {
          selectedCatIds.removeAt(i);
        }
      }
      for (int i = 0; i < selectedSubCatIds.length; i++) {
        if (selectedSubCatIds[i] == subCatId) {
          selectedSubCatIds.removeAt(i);
        }
      }
    }

    activityListData.value.result?[catindex].subcategories?[subCatListIndex]
        .isSelected = isSelected;
    activityListData.refresh();
    selectedCatIds.refresh();
    selectedSubCatIds.refresh();
    debugPrint("gk==selectedCatIds=${selectedCatIds}");
    debugPrint("gk==selectedSubCatIds=${selectedSubCatIds}");
  }

//************************************************funfact ****************
  var funFactListDeta = [].obs;
  var questionList = [].obs;

  addFunFactDeta(q, ans) {
    funFactListDeta.add({"ques": q, "and": ans});
  }

  removeFunFactDeta(index) {
    if (index >= 0 && index < funFactListDeta.length) {
      funFactListDeta.removeAt(index);
    } else {
      print('Index out of range');
    }
  }

  //************************************************funfact api****************
  Rx<bool> isLoadingFunFactQuest = false.obs;
  Rx<FunfactQuestModel> funFactQuetionList = FunfactQuestModel().obs;

  Future<void> funfactQuestionApi() async {
    isLoadingFunFactQuest.value = true;
    String? token = LocalStorage.getToken();
    try {
      final response = await api.get(EndPoints.funFactQestiApiUrl,
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        FunfactQuestModel body = FunfactQuestModel.fromJson(response.body);
        body.result?.map((e) {
          questionList.add(DropdownMenuItem(
            child: Text(e.title.toString()),
            value: e.id,
          ));
        });

        if (body.status == true) {
          funFactQuetionList.value = body;
        } else {
          debugPrint("error=funfact statu false");
          showTostMsg("Something went wrong");
        }
      } else {
        debugPrint("error=funfact statuscode");
        showTostMsg("Something went wrong");
      }
    } catch (e) {
      debugPrint("error=funfact=$e");
      showTostMsg("Something went wrong");
    }
    isLoadingFunFactQuest.value = false;
  }

  //************************************************My profile mulipart api ****************
  AddphotoController addPhotoController = Get.put(AddphotoController());
  Rx<bool> isLoadingProfile = false.obs;

  Future<void> myProfileSubmit() async {
    var uid = LocalStorage.getUid();
    isLoadingProfile.value = true;
    String? token = LocalStorage.getToken();
    log("completeProfileApiUrl=${EndPoints.completeProfileApiUrl}  -=uid=$uid  --bio=${bioController.value.text}-------occupation=${ocupatController.value.text}  language_id=${selectedLanguageList.toString()}    ---category_id=${selectedCatIds.toString()}  -----subcategory_id=${selectedSubCatIds}");
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(EndPoints.completeProfileApiUrl));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['user_id'] = "$uid";
      request.fields['bio'] = bioController.value.text.trim();
      request.fields['occupation'] = ocupatController.value.text.trim();
      request.fields['organisation_name'] = organiController.value.text.trim();
      request.fields['language_id'] = selectedLanguageList.toString();
      request.fields['category_id'] = selectedCatIds.toString();
      request.fields['subcategory_id'] = selectedSubCatIds.toString();
      // request.fields['questions']="$uid";
      // request.fields['answers']="$uid";
      if (addPhotoController.selectedImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "profile_photo", addPhotoController.selectedImage.value!.path));
      }
      request.fields['verify_instagram'] = isInstaVerified.value.toString();
      request.fields['verify_linkedin'] = isLinkdinVerified.value.toString();
      var responseRes = await request.send();
      var resDeta = await responseRes.stream.toBytes();
      var responseString = String.fromCharCodes(resDeta);
      log("gk===statusCode profile=${responseRes.statusCode}");
      log("gk===responseString profile=${responseString}");
      var jsonResponse = jsonDecode(responseString);
      if (responseRes.statusCode == 200) {
        // if(jsonResponse['status']==true){
        //   activityListData.value=body;
        //   debugPrint("gk=====activity listdeta=${response.body}");
        // }else{
        showTostMsg("${jsonResponse['message']}");
        // }
      }
      if (responseRes.statusCode == 401) {
        showTostMsg("${jsonResponse['message']}");
      } else {
        showTostMsg("Something went wrong");
      }
    } catch (e) {
      debugPrint("error==$e");
      showTostMsg("Something went wrong");
    }
    isLoadingProfile.value = false;
  }

}
