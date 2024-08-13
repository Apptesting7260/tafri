import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/addphoto/controller/addphoto_controller.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/funfact/models/funfactquest_model.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/language/models/langauagemodel.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
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

  static ProfilemainController profileController =
  Get.find<ProfilemainController>();

  @override
  void onInit() {
    languageApi();
    funfactQuestionApi();
    activityGetDataApi();
    tabController = TabController(length: 2, vsync: this);
    profileAlertPopUp();
    super.onInit();
  }

  TextEditingController bioController = TextEditingController(text: profileController.profileData.value.result?.profile?.bio ?? '');
  TextEditingController locController = TextEditingController(text: profileController.profileData.value.result?.location ?? '');
  TextEditingController ocupatController = TextEditingController(text: profileController.profileData.value.result?.profile?.occupation ?? '');
  TextEditingController organiController = TextEditingController(text: profileController.profileData.value.result?.profile?.organisationName ?? '');

  String? token = LocalStorage.getToken();
  String? uid = LocalStorage.getUid();

  profileAlertPopUp() async  {
    if(profileController.profileData.value.result?.profile == null) {
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
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
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
  }

///************************************************language select code  ****************
  RxList selectedLanguageList = [].obs;
  RxList selectedLanguageID = [].obs;

  removeSelectLan(index) {
    selectedLanguageList.removeAt(index);
    selectedLanguageID.removeAt(index);
    selectedLanguageID.reversed;
    selectedLanguageList.reversed;
    print(selectedLanguageID);
  }

  Rx<bool> isShowLangReqError = false.obs;

  changeIsShowLangError(val) {
    isShowLangReqError.value = val;
  }

///************************************************Get verified code****************
  Rx<int> isInstaVerified = 0.obs;
  Rx<int> isLinkdinVerified = 0.obs;

  changeVerifyInsta(val) {
    isInstaVerified.value = val;
  }

  changeVerifyLinkdin(val) {
    isLinkdinVerified.value = val;
  }

///************************************************language get dropdown api ****************
  Rx<bool> isLanLoading = false.obs;
  Rx<LanguageModel> langListData = LanguageModel().obs;

  Future<void> languageApi() async {
    isLanLoading.value = true;
    try {
      final response = await api.get("${EndPoints.languageListApiUrl}$uid",
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        LanguageModel body = LanguageModel.fromJson(response.body);
        if (body.status == true) {
          langListData.value = body;
          for(var i in langListData.value.result!){
            if(i.status == '1' && i.isSelected == true){
              selectedLanguageID.add(i.id);
              selectedLanguageList.add({
                'id': i.id,
                "lang": i.name
              });
            }
          }
          print('id == ${selectedLanguageID}');
          print('lang == ${selectedLanguageList}');
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

  ///************************************************Activity get api ****************
  Rx<bool> isLoadingActivity = false.obs;
  Rx<ActivityModel> activityListData = ActivityModel().obs;

  Future<void> activityGetDataApi() async {
    isLoadingActivity.value = true;
    print(token);
    try {
      final response = await api.get("${EndPoints.getCategoryApiUrl}$uid",
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        ActivityModel body = ActivityModel.fromJson(response.body);
        if (body.status == true) {
          activityListData.value = body;

          for (var activity in activityListData.value.result!) {
            if (activity.status == '1') {
              for (var subcategory in activity.subcategories!) {
                if (subcategory.status == '1' && subcategory.isSelected == false) {
                  String activityId = activity.id.toString();
                  String subcategoryId = subcategory.id.toString();
                  if (selectedActivity.containsKey(activityId)) {
                    selectedActivity[activityId]?.add(subcategoryId);
                  } else {
                    selectedActivity[activityId] = [subcategoryId];
                  }
                }
              }
            }
          }

          // for(int i = 0;i < activityListData.value.result!.length;i++){
          //   if(activityListData.value.result?[i].status == '1'){
          //     for(int j = 0;j < activityListData.value.result![i].subcategories!.length;j++){
          //       if(activityListData.value.result![i].subcategories?[j].status == '1' && activityListData.value.result![i].subcategories?[j].isSelected == true){
          //         String activityId = activityListData.value.result![i].id.toString();
          //         String subcategoryId = activityListData.value.result![i].subcategories![j].id.toString();
          //         if (selectedActivity.containsKey(activityId)) {
          //           selectedActivity[activityId]?.add(subcategoryId);
          //         } else {
          //           selectedActivity[activityId] = [subcategoryId];
          //         }
          //       }
          //     }
          //   }
          // }

          print('selected activity == ${selectedActivity}');

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

///************************************************Activity selected btn algo ****************

  var selectedActivity = {}.obs;

  void updateSelectedSubcategories(String? categoryId, String? subcategoryId, bool? isSelected) {
    if (isSelected!) {
      if (selectedActivity.containsKey(categoryId)) {
        selectedActivity[categoryId]!.add(subcategoryId);
      } else {
        selectedActivity[categoryId] = [subcategoryId];
      }
    } else {
      selectedActivity[categoryId]?.remove(subcategoryId);
      if (selectedActivity[categoryId]?.isEmpty ?? false) {
        selectedActivity.remove(categoryId);
      }
    }
    activityListData.refresh();
    print(selectedActivity);
  }

  bool hasAtLeastThreeTotalValues(var map) {
    int totalCount = 0;
    for (var entry in map.entries) {
      List<String?> values = entry.value;
      totalCount += values.length;
    }
    return totalCount >= 3;
  }

  // changeActivitySelect(catindex, catId, subCatListIndex, subCatId, isSelected) {
  //   if (isSelected == true) {
  //     selectedCatIds.add(catId);
  //     selectedSubCatIds.add(subCatId);
  //   } else {
  //     for (int i = 0; i < selectedCatIds.length; i++) {
  //       if (selectedCatIds[i] == catId) {
  //         selectedCatIds.removeAt(i);
  //       }
  //     }
  //     for (int i = 0; i < selectedSubCatIds.length; i++) {
  //       if (selectedSubCatIds[i] == subCatId) {
  //         selectedSubCatIds.removeAt(i);
  //       }
  //     }
  //   }
  //
  //   activityListData.value.result?[catindex].subcategories?[subCatListIndex]
  //       .isSelected = isSelected;
  //   activityListData.refresh();
  //   selectedCatIds.refresh();
  //   selectedSubCatIds.refresh();
  //   debugPrint("gk==selectedCatIds=${selectedCatIds}");
  //   debugPrint("gk==selectedSubCatIds=${selectedSubCatIds}");
  // }

///************************************************funfact ****************
  var funFactListDeta = [].obs;
  var funFactListForApi = [].obs;
  RxList<DropdownMenuItem<int>> questionList = <DropdownMenuItem<int>>[].obs;

  addFunFactDeta(String ques, String ans, String id) {
    funFactListDeta.add({"question": ques, "answer": ans, "id": id});
  }

  removeFunFactDeta(index) {
    if (index >= 0 && index < funFactListDeta.length) {
      funFactListDeta.removeAt(index);
    } else {
      print('Index out of range');
    }
  }

  ///************************************************funfact api****************
  Rx<bool> isLoadingFunFactQuest = false.obs;
  Rx<FunfactQuestModel> funFactQuetionList = FunfactQuestModel().obs;

  Future<void> funfactQuestionApi() async {
    isLoadingFunFactQuest.value = true;
    try {
      final response = await api.get("${EndPoints.funFactQestiApiUrl}$uid",
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        FunfactQuestModel body = FunfactQuestModel.fromJson(response.body);
        questionList.clear();
        body.result?.forEach((e) {
          questionList.add(DropdownMenuItem(
            value: e.id,
            child: Text(e.question.toString()),
          ));
        });
        print("questionList == ${questionList}");
        if (body.status == true) {
          funFactQuetionList.value = body;
          for(var i in funFactQuetionList.value.result!){
            if(i.isSelected == true){
              funFactListDeta.add({
                "question": i.question,
                "answer": i.answer,
                "id": i.id
              });
            }
          }
          print('selected ques == ${funFactListDeta}');
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

  ///************************************************My profile mulipart api ****************
  AddphotoController addPhotoController = Get.put(AddphotoController());
  Rx<bool> isLoadingProfile = false.obs;

  Future<void> myProfileSubmit() async {
    isLoadingProfile.value = true;
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(EndPoints.completeProfileApiUrl));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['user_id'] = jsonEncode(int.parse(uid!));
      request.fields['bio'] = bioController.value.text.trim();
      request.fields['occupation'] = ocupatController.value.text.trim();
      request.fields['organisation_name'] = organiController.value.text.trim();
      request.fields['language_id'] = jsonEncode(selectedLanguageID);
      if (addPhotoController.selectedImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "profile_photo", addPhotoController.selectedImage.value!.path));
      }
      request.fields['verify_instagram'] = jsonEncode(isInstaVerified.value);
      request.fields['verify_linkedin'] = jsonEncode(isLinkdinVerified.value);
      print('send data ==  ${jsonEncode(int.parse(uid.toString()))} ==  ${bioController.value.text.trim()} == ${ocupatController.value.text.trim()} == ${organiController.value.text.trim()} == ${jsonEncode(selectedLanguageID)} == ${jsonEncode(isLinkdinVerified.value)} == ${jsonEncode(isInstaVerified.value)}');
      var responseRes = await request.send();
      var resDeta = await responseRes.stream.toBytes();
      var responseString = String.fromCharCodes(resDeta);
      log("gk===statusCode profile=${responseRes.statusCode}");
      log("gk===responseString profile=${responseString}");
      var jsonResponse = jsonDecode(responseString);
      if (responseRes.statusCode == 200) {
        showTostMsg("${jsonResponse['message']}");
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


 /// place api
  RxList<PlacesSearchResult> places = <PlacesSearchResult>[].obs;
  RxString _searchTerm = ''.obs;
  final placesApi = GoogleMapsPlaces(apiKey: 'AIzaSyAP3QLpyPPT0ba8RnZCCEIHpMLnh_hPNRM');

  void onSearchChanged(String value, BuildContext context) async {
    print(value);
    _searchTerm.value = value;
    if (_searchTerm.isNotEmpty) {
      final results = await searchPlaces(
        _searchTerm.value,
      );
      places.value = results;
    }
  }

  Future<List<PlacesSearchResult>> searchPlaces(String searchTerm) async {
    final response = await placesApi.searchByText(
      searchTerm,
    );
    if (response.isOkay) {
      print('location == ${response.results}');
      return response.results;
    } else {
      return [];
    }
  }
  ///


}
