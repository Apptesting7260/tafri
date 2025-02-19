import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/addphoto/controller/addphoto_controller.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/funfact/models/funfactquest_model.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/language/models/langauagemodel.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:signin_with_linkedin/signin_with_linkedin.dart';
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
    // profileAlertPopUp();
    bioController.value.addListener(() {
      currentLength.value = bioController.value.text.length;
      capitalLetter(bioController.value);
    });
    ocupatController.addListener(() {
      capitalLetter(ocupatController);
    },);
    organiController.addListener(() {
      capitalLetter(organiController);
    },);
    locController.addListener(() {
      capitalLetter(locController);
    },);

    super.onInit();
  }

  var bioController = TextEditingController(text: profileController.profileData.value.result?.profile?.bio ?? '').obs;
  var currentLength = (profileController.profileData.value.result?.profile?.bio?.length ?? 0).obs;
  TextEditingController locController = TextEditingController(text: profileController.profileData.value.result?.location ?? '');
  var timeZone = (profileController.profileData.value.result?.location ?? '').obs;
  TextEditingController ocupatController = TextEditingController(text: profileController.profileData.value.result?.profile?.occupation ?? '');
  TextEditingController organiController = TextEditingController(text: profileController.profileData.value.result?.profile?.organisationName ?? '');


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

  // void capitalLetter(TextEditingController controller) {
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

  /// for capital letter


  String? token = LocalStorage.getToken();
  String? uid = LocalStorage.getUid();

  profileAlertPopUp({void Function()? completeOnTap,void Function()? doLatterTap}) async  {
    print('bio == ${profileController.profileData.value.result?.profile?.bio}');
    if(profileController.profileData.value.result?.profile == null || profileController.profileData.value.result?.profile?.bio == null || profileController.profileData.value.result!.profile!.bio!.isEmpty ||
        profileController.profileData.value.result?.profile?.occupation == null || profileController.profileData.value.result!.profile!.occupation!.isEmpty ||
        profileController.profileData.value.result!.location == null || profileController.profileData.value.result!.location!.isEmpty || profileController.profileData.value.result!.profile!.languageId!.isEmpty ||
        profileController.profileData.value.result!.profile!.activityTitles!.isEmpty || profileController.profileData.value.result!.profile!.funFactsAboutMe!.isEmpty || profileController.profileData.value.result?.profile?.profilePhoto == null) {
      Future.delayed(const Duration(seconds: 0), () {
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
                          onTap: completeOnTap ?? () {
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
                        onTap: doLatterTap ?? () {
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
    }else{
      Get.back();
    }
  }

///************************************************language select code  ****************
  RxList selectedLanguageList = [].obs;

  removeSelectLan(index) {
    selectedLanguageList.removeAt(index);
    selectedLanguageList.reversed;
  }

  Rx<bool> isShowLangReqError = false.obs;

  changeIsShowLangError(val) {
    isShowLangReqError.value = val;
  }

///************************************************Get verified code****************
  Rx<int> isInstaVerified = (profileController.profileData.value.result?.profile?.verifyInstagram == null ? 0 : int.parse(profileController.profileData.value.result?.profile?.verifyInstagram)).obs;
  Rx<int> isLinkdinVerified = (profileController.profileData.value.result?.profile?.verifyLinkedin == null ? 0 : int.parse(profileController.profileData.value.result?.profile?.verifyLinkedin)).obs;

  changeVerifyInsta(val) {
    if(val == 1) {
      Get.toNamed(Routes.instaLoginScreen);
    }else{
      isInstaVerified.value = val;
    }
  }

  changeVerifyLinkdin(BuildContext context,val) {
    if(val == 1) {
      verifyLinkedin(context, val);
    }else{
      isLinkdinVerified.value = val;
    }
  }

  var linkedinId = (profileController.profileData.value.result?.profile?.linkedinID ?? '').obs;
  var linkedinName = (profileController.profileData.value.result?.profile?.linkedinName ?? '').obs;
  var linkedinEmail = (profileController.profileData.value.result?.profile?.linkedinMail ?? '').obs;

  var instaID = (profileController.profileData.value.result?.profile?.instaId ?? '').obs;
  var instaName = (profileController.profileData.value.result?.profile?.instaName ?? '').obs;

  Future<void> verifyLinkedin(BuildContext context,int val) async{
    await SignInWithLinkedIn.logout();
    SignInWithLinkedIn.signIn(
      context,
      config: LinkedInConfig(
        clientId: '78ks11ldl2tbj5',
        clientSecret: 'WPL_AP1.lZgN5e2rsrBh5kcY.0+11GA==',
        redirectUrl: '${EndPoints.redirectSuccessUrl}',
        scope: ['openid', 'profile', 'email'],
      ),
      onGetAuthToken: (data) {
        log('Auth token data: ${data.toJson()}');
      },
      onGetUserProfile: (tokenData, user) {
        log('user == ${user.toJson()} \n token == ${tokenData.toJson()}');
        linkedinId.value = user.sub.toString();
        linkedinName.value = user.name.toString();
        linkedinEmail.value = user.email.toString();
        isLinkdinVerified.value = val;
      },
      onSignInError: (error) {
        log('Error on sign in: $error');
      },
    );
  }


  var instaLoading = false.obs;
  Future<void> verifyInsta({required String code}) async {
    instaLoading.value = true;
    try {
      var url = Uri.parse('https://api.instagram.com/oauth/access_token');

      var request = http.MultipartRequest('POST', url)
        ..fields['client_id'] = '9550333448334536'
        ..fields['client_secret'] = 'da91dd23619e4cb00af9d23cc67b5e15'
        ..fields['grant_type'] = 'authorization_code'
        ..fields['redirect_uri'] = EndPoints.redirectSuccessUrl
        ..fields['code'] = code;

      print('send data == ${request.fields}');

      var response = await request.send();

      var responseBody = await response.stream.bytesToString();
      print('insta response == ${response.statusCode} \n $responseBody');
      if(response.statusCode == 200){
        var data = jsonDecode(responseBody);
        var token = data['access_token'];
        await getInstaData(token: token);
      }else{
        Get.back();
        showTostMsg('Login failed. Please try again.');
      }
    } catch (e) {
      Get.back();
      showTostMsg('Login failed. Please try again.');
      print('insta error == ${e.toString()}');
    }
    instaLoading.value = false;
  }


  Future<void> getInstaData({required String token}) async{

    try{
      var url = Uri.parse('https://graph.instagram.com/v22.0/me?fields=user_id,username&access_token=$token');
      var request = http.MultipartRequest('GET', url);
      var response = await request.send();

      var responseBody = await response.stream.bytesToString();
      print('insta user data response == ${response.statusCode} \n $responseBody');
      if(response.statusCode == 200){
        var data = jsonDecode(responseBody);
        instaID.value = data['user_id'];
        instaName.value = data['username'];
        isInstaVerified.value = 1;
        Get.back();
        // await socialUpdate();
      }else{
        Get.back();
        showTostMsg('Login failed. Please try again.');
      }
    }catch(e){
      Get.back();
      showTostMsg('Login failed. Please try again.');
      print('get insta data error == ${e.toString()}');
    }

  }


  // jayesh.nbt@gmail.com
  // Nbt@123@#


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
              selectedLanguageList.add({
                'id': i.id,
                "lang": i.name
              });
            }
          }
          print('lang == ${selectedLanguageList}');
        } else {
          showTostMsg("Something went wrong");
          print('lang error ==');
        }
      } else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('Session expired. Please login again.');
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else {
        print('lang error =');
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
                if (subcategory.status == '1' && subcategory.isSelected == true) {
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
          print('act error ==');
          showTostMsg("Something went wrong");
        }
      } else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('Session expired. Please login again.');
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else {
        print('act error');
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
  RxList<TextEditingController> textEditingList = <TextEditingController>[].obs;
  Map<int, String> idToQuestionMap = {};
  RxList<DropdownMenuItem<int>> questionList = <DropdownMenuItem<int>>[].obs;

  addFunFactDeta(String ques, String ans, int? id) {
    funFactListDeta.add({"question": ques, "answer": ans, "id": id});
    textEditingList.add(TextEditingController());
  }

  removeFunFactDeta(index) {
    if (index >= 0 && index < funFactListDeta.length) {
      funFactListDeta.removeAt(index);
      textEditingList.removeAt(index);
    } else {
      print('Index out of range');
    }
  }

  ///************************************************funfact api****************
  Rx<bool> isLoadingFunFactQuest = false.obs;
  Rx<FunfactQuestModel> funFactQuetionList = FunfactQuestModel().obs;

  Future<void> funfactQuestionApi() async {
    isLoadingFunFactQuest.value = true;
    print('uid == ${uid}');
    try {
      final response = await api.get("${EndPoints.funFactQestiApiUrl}$uid",
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        FunfactQuestModel body = FunfactQuestModel.fromJson(response.body);
        questionList.clear();
        idToQuestionMap.clear();
        textEditingList.clear();
        body.result?.forEach((e) {
          idToQuestionMap[e.id!] = e.question!;
          questionList.add(DropdownMenuItem(
            value: e.id,
            child: Text(e.question.toString()),
          ));
        });
        print("questionList == ${questionList}");
        print('question map == ${idToQuestionMap}');
        if (body.status == true) {
          funFactQuetionList.value = body;
          for(var i in funFactQuetionList.value.result!){
            if(i.isSelected == true){
              funFactListDeta.add({
                "question": i.question,
                "answer": i.answer,
                "id": i.id
              });
              textEditingList.add(TextEditingController(text: i.answer ?? ''));
            }
            // textEditingList.add(TextEditingController(text: i.answer ?? ''));
          }
          print('selected ques == ${funFactListDeta}');
          print('controller == ${textEditingList}');
          print('length == ${textEditingList.length}');
        } else {
          print('fun error ==');
          debugPrint("error=funfact statu false");
          showTostMsg("Something went wrong");
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
      request.fields['location'] = locController.value.text.trim();
      request.fields['language_id'] = jsonEncode(selectedLanguageList.map((element) => element['id'].toString(),).toList());
      if (addPhotoController.selectedImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "profile_photo", addPhotoController.selectedImage.value!.path));
      }
      request.fields["fun_facts_about_me"] = jsonEncode(funFactListDeta.map((element){
        return {
          "question": element['id'].toString(),
          "answer": element['answer'].toString()
        };
      }).toList());
      request.fields['verify_instagram'] = jsonEncode(isInstaVerified.value);
      request.fields['verify_linkedin'] = jsonEncode(isLinkdinVerified.value);
      request.fields['activity_interests'] = jsonEncode(selectedActivity);
      print('send data ==  ${jsonEncode(int.parse(uid.toString()))} ==  ${bioController.value.text.trim()} == ${ocupatController.value.text.trim()} == ${organiController.value.text.trim()} == ${jsonEncode(selectedLanguageList.map((element) => element['id'].toString(),).toList())} == ${jsonEncode(isLinkdinVerified.value)} == ${jsonEncode(isInstaVerified.value)} == ${jsonEncode(funFactListDeta.map((element){
        return {
          "question": element['id'].toString(),
          "answer": element['answer'].toString()
        };
      }).toList())} == ${jsonEncode(selectedActivity)} == ${locController.value.text.trim()}');
      var responseRes = await request.send();
      var resDeta = await responseRes.stream.toBytes();
      var responseString = String.fromCharCodes(resDeta);
      log("gk===statusCode profile=${responseRes.statusCode}");
      log("gk===responseString profile=${responseString}");
      var jsonResponse = jsonDecode(responseString);
      if (responseRes.statusCode == 200) {
        await profileController.viewProfile();
        showTostMsg("${jsonResponse['message']}");
      } else if (responseRes.statusCode == 401) {
        showTostMsg("${jsonResponse['message']}");
        print('submit error ==');
      }else if(responseRes.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('${jsonResponse['message']}');
      } else {
        print('submit error');
        showTostMsg("Something went wrong");
      }
    } catch (e) {
      debugPrint("error==$e");
      showTostMsg("Something went wrong");
    }
    isLoadingProfile.value = false;
  }




  var bioLoading = false.obs;

  Future<void> bioProfile() async{

    String? token = LocalStorage.getToken();
    String? uid = LocalStorage.getUid();
    print('token == $token        $uid');

    var body = {
      'user_id' : uid,
      'bio' : bioController.value.text.trim().toString()
    };

    var header = {"Authorization": "Bearer $token"};

    bioLoading.value = true;
    try{
      final response = await api.post('${EndPoints.bioprofile}', jsonEncode(body), headers: header);
      print(response.statusCode);
      if(response.statusCode == 200){
        var data = response.body;
        if(data['status'] == true){
          await profileController.viewProfile();
          bioLoading.value = false;
          Get.back();
        }else{
          print('profile error ==');
          showTostMsg('Something went wrong');
          bioLoading.value = false;
        }
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        print('profile error');
        showTostMsg('Something went wrong');
        bioLoading.value = false;
      }
    }catch(e){
      showTostMsg('Something went wrong');
      bioLoading.value = false;
      print('error == ${e.toString()}');
    }

  }



  var locationLoading = false.obs;

  Future<void> locationUpdate() async{

    if(timeZone.value.isEmpty){
      showTostMsg('Please select complete location',gravity: ToastGravity.CENTER);
      return;
    }

    String? token = LocalStorage.getToken();
    String? uid = LocalStorage.getUid();
    print('token == $token        $uid');

    var body = {
      'user_id' : uid,
      'location' : locController.value.text.trim(),
      'time_zone': timeZone.value
    };

    var header = {"Authorization": "Bearer $token"};

    locationLoading.value = true;
    try{
      final response = await api.post('${EndPoints.locationprofile}', jsonEncode(body), headers: header);
      print(response.statusCode);
      if(response.statusCode == 200){
        var data = response.body;
        if(data['status'] == true){
          locationLoading.value = false;
          Get.back();
          await profileController.viewProfile();
        }else{
          print('profile error ==');
          showTostMsg('Something went wrong');
          locationLoading.value = false;
        }
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        print('profile error');
        showTostMsg('Something went wrong');
        locationLoading.value = false;
      }
    }catch(e){
      showTostMsg('Something went wrong');
      locationLoading.value = false;
      print('error == ${e.toString()}');
    }

  }



  var occLoading = false.obs;

  Future<void> occUpdate() async{

    String? token = LocalStorage.getToken();
    String? uid = LocalStorage.getUid();
    print('token == $token        $uid');

    var body = {
      'user_id' : uid,
      'occupation' : ocupatController.value.text.trim().toString(),
      'organisation_name' : organiController.value.text.trim().toString(),
    };

    var header = {"Authorization": "Bearer $token"};

    occLoading.value = true;
    try{
      final response = await api.post('${EndPoints.occupationprofile}', jsonEncode(body), headers: header);
      print(response.statusCode);
      if(response.statusCode == 200){
        var data = response.body;
        if(data['status'] == true){
          occLoading.value = false;
          Get.back();
          await profileController.viewProfile();
        }else{
          print('profile error ==');
          showTostMsg('Something went wrong');
          occLoading.value = false;
        }
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        print('profile error');
        showTostMsg('Something went wrong');
        occLoading.value = false;
      }
    }catch(e){
      showTostMsg('Something went wrong');
      occLoading.value = false;
      print('error == ${e.toString()}');
    }

  }



  var langLoading = false.obs;

  Future<void> langUpdate() async{

    String? token = LocalStorage.getToken();
    String? uid = LocalStorage.getUid();
    print('token == $token        $uid');

    var body = {
      'user_id' : uid,
      'language_id' : selectedLanguageList.map((element) => element['id'].toString(),).toList()
    };

    var header = {"Authorization": "Bearer $token"};

    langLoading.value = true;
    try{
      final response = await api.post('${EndPoints.langprofile}', jsonEncode(body), headers: header);
      print(response.statusCode);
      if(response.statusCode == 200){
        var data = response.body;
        if(data['status'] == true){
          langLoading.value = false;
          Get.back();
          await profileController.viewProfile();
        }else{
          print('profile error ==');
          showTostMsg('Something went wrong');
          langLoading.value = false;
        }
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        print('profile error');
        showTostMsg('Something went wrong');
        langLoading.value = false;
      }
    }catch(e){
      showTostMsg('Something went wrong');
      langLoading.value = false;
      print('error == ${e.toString()}');
    }

  }



  var actintLoading = false.obs;

  Future<void> actintUpdate() async{

    String? token = LocalStorage.getToken();
    String? uid = LocalStorage.getUid();
    print('token == $token        $uid');

    var body = {
      'user_id' : uid,
      'activity_interests' :  selectedActivity
    };

    var header = {"Authorization": "Bearer $token"};

    actintLoading.value = true;
    try{
      final response = await api.post('${EndPoints.actintprofile}', jsonEncode(body), headers: header);
      print(response.statusCode);
      if(response.statusCode == 200){
        var data = response.body;
        if(data['status'] == true){
          actintLoading.value = false;
          Get.back();
          await profileController.viewProfile();
        }else{
          print('profile error ==');
          showTostMsg('Something went wrong');
          actintLoading.value = false;
        }
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        print('profile error');
        showTostMsg('Something went wrong');
        actintLoading.value = false;
      }
    }catch(e){
      showTostMsg('Something went wrong');
      actintLoading.value = false;
      print('error == ${e.toString()}');
    }

  }


  bool validateTextFields() {
    for (var controller in textEditingList) {
      if (controller.value.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  bool validateQuestion(){
    for(var i in funFactListDeta){
      if(i['id'] == null){
        return false;
      }
    }
    return true;
  }

  bool validateQues(){
    for(var i in funFactListDeta){
      if(i['question'].toString().isEmpty){
        return false;
      }
    }
    return true;
  }


  Rxn<int> existingItemIndex = Rxn<int>();

  var funfactLoading = false.obs;

  Future<void> funfactUpdate() async{

    String? token = LocalStorage.getToken();
    String? uid = LocalStorage.getUid();
    print('token == $token        $uid');

    if(!validateTextFields()){
      showTostMsg('Please enter your answer',gravity: ToastGravity.CENTER);
      return;
    } else if(!validateQues()){
      showTostMsg("Please select question.",gravity: ToastGravity.CENTER);
      return;
    }else if(!validateQuestion()){
      showTostMsg('Please remove duplicate questions.', gravity: ToastGravity.CENTER);
      return;
    }

    var body = {
      'user_id' : uid,
      'fun_facts_about_me' : funFactListDeta.map((element){
        return {
          "question": element['id'].toString(),
          "answer": element['answer'].toString()
        };
      }).toList()
    };

    var header = {"Authorization": "Bearer $token"};

    funfactLoading.value = true;
    try{
      final response = await api.post('${EndPoints.funfactprofile}', jsonEncode(body), headers: header);
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200){
        var data = response.body;
        if(data['status'] == true){
          await profileController.viewProfile();
          showTostMsg('Fun fact updated successfully');
          funfactLoading.value = false;
        }else{
          print('profile error ==');
          showTostMsg('Something went wrong');
          funfactLoading.value = false;
        }
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        print('profile error');
        showTostMsg('Something went wrong');
        funfactLoading.value = false;
      }
    }catch(e){
      showTostMsg('Something went wrong');
      funfactLoading.value = false;
      print('error == ${e.toString()}');
    }

  }


  var socialLoading = false.obs;

  Future<void> socialUpdate() async{

    String? token = LocalStorage.getToken();
    String? uid = LocalStorage.getUid();
    print('token == $token        $uid');

    var body = {
      'user_id' : uid,
      'verify_instagram' : isInstaVerified.value,
      'verify_linkedin' : isLinkdinVerified.value,
      'instagram_id': instaID.value,
      'instagram_name': instaName.value,
      'linkedin_id': linkedinId.value,
      'linkedin_email': linkedinEmail.value,
      'linkedin_name': linkedinName.value,
    };

    print('body == ${body}');

    var header = {"Authorization": "Bearer $token"};

    socialLoading.value = true;
    try{
      final response = await api.post('${EndPoints.socialprofile}', jsonEncode(body), headers: header);
      print(response.body);
      if(response.statusCode == 200){
        var data = response.body;
        if(data['status'] == true){
          socialLoading.value = false;
          Get.back();
          await profileController.viewProfile();
        }else{
          print('profile error ==');
          showTostMsg('${data['error']}');
          socialLoading.value = false;
        }
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        var data = response.body;
        print('profile error');
        showTostMsg('${data['error']}');
        socialLoading.value = false;
      }
    }catch(e){
      showTostMsg('Something went wrong');
      socialLoading.value = false;
      print('error == ${e.toString()}');
    }

  }




 /// place api
  RxList<Map<String, dynamic>> places = <Map<String,dynamic>>[].obs;
  RxString _searchTerm = ''.obs;
  var latitude = ''.obs;
  var longitude = ''.obs;
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

  Future<List<Map<String,dynamic>>> searchPlaces(String searchTerm) async {
    // final response = await placesApi.searchByText(
    //   searchTerm,
    // );
    final response = await placesApi.autocomplete(searchTerm);
    // if(data.isOkay){
    //   print("=== ${data.predictions[0].id}  ${data.predictions[0].description}  ${data.predictions[0].matchedSubstrings}");
    // }
    if (response.isOkay) {
      print('location == ${response.predictions}');
      return response.predictions.map((e) => {'des':e.description,'id':e.placeId},).toList();
    } else {
      return [];
    }
  }

  Future<void> getLatLang(var placeId) async {
    if (placeId != null) {
      var placeDetails = await getPlaceDetails(placeId!);
      updateLatLong(placeDetails['lat'], placeDetails['lng']);
      getTimeZone(lat: latitude.value,long: longitude.value);
      print("place Id ${placeId}");
      print('Latitude: ${placeDetails['lat']}');
      print('Longitude: ${placeDetails['lng']}');
      print('House Number: ${placeDetails['houseNumber']}');
      print('Street Name: ${placeDetails['streetName']}');
      print('Street Type: ${placeDetails['streetType']}');
      print('City: ${placeDetails['city']}');
      print('Postal Code: ${placeDetails['postalCode']}');
      print(
          'State (Administrative Area): ${placeDetails['administrativeArea']}');

      print('Country: ${placeDetails['country']}');
    }
  }

  Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyCPAaERVd6ZlHs_EVKdaBixFIoYWW_-SL0';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['result'];
      final geometry = result['geometry']['location'];
      final addressComponents = result['address_components'];

      print('Full Address Components: $addressComponents');

      double lat = geometry['lat'];
      double lng = geometry['lng'];
      String houseNumber = '';
      String streetName = '';
      String streetType = '';
      String city = '';
      String postalCode = '';
      String administrativeArea = '';
      String country = '';

      // Loop through addressComponents to extract the details
      addressComponents.forEach((component) {
        List types = component['types'];

        print('Component Types: $types'); // Print types for each component

        if (types.contains('street_number')) {
          houseNumber = component['long_name'];
        } else if (types.contains('route')) {
          streetName = component['long_name'];
        } else if (types.contains('locality')) {
          city = component['long_name'];
        } else if (types.contains('postal_code')) {
          postalCode = component['long_name'];
        } else if (types.contains('administrative_area_level_1')) {
          administrativeArea = component['long_name'];
        } else if (types.contains('country')) {
          country = component['long_name'];
        }
      });

      return {
        'lat': lat,
        'lng': lng,
        'houseNumber': houseNumber,
        'streetName': streetName,
        'streetType': streetType, // Optional if you extract it
        'city': city,
        'postalCode': postalCode,
        'administrativeArea': administrativeArea,
        'country': country,
      };
    } else {
      throw Exception('Failed to load place details');
    }
  }

  var timeZoneLoading = false.obs;
  Future<void> getTimeZone({required String lat,required String long}) async{
    timeZone.value = '';

    timeZoneLoading.value = true;
    var timeStamp = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    final url = 'https://maps.googleapis.com/maps/api/timezone/json?location=$lat,$long&timestamp=$timeStamp&key=AIzaSyAP3QLpyPPT0ba8RnZCCEIHpMLnh_hPNRM';

    try{
      final response = await api.get(url);
      print('timezone == ${response.statusCode}    ${response.body}');
      if(response.statusCode == 200){
        var data = response.body;
        timeZone.value = data['timeZoneId'];
        print('time zone == ${timeZone.value}');
      }
    }catch(e){
      print('timezone error == ${e.toString()}');
    }

    timeZoneLoading.value = false;

  }

  void updateLatLong(double lat, double long) {
    latitude.value = lat.toString();
    longitude.value = long.toString();
    print('lat == ${latitude.value}   lon == ${longitude.value}');
  }


  ///

  var deleteloading = false.obs;

  Future<void> deleteUser() async{

    var header = {"Authorization": "Bearer $token"};

    deleteloading.value = true;
    try{
      final response = await api.delete(EndPoints.deleteUser, headers: header);
      print('delete user == ${response.body}');
      if(response.statusCode == 200){
        GoogleSignIn().signOut();
        Get.find<SocketController>().deleteUser();
        // LocalStorage.removeToken();
        // debugPrint("gk==getUid=${LocalStorage.getUid()}=token=${LocalStorage.getToken()}=");
        // if (LocalStorage.getToken() == null || LocalStorage.getUid() == null) {
        //   Get.offAllNamed(Routes.initialPage);
        // }
      }
    }catch(e){
      showTostMsg('Something went wrong');
      deleteloading.value = false;
      print('error == ${e.toString()}');
    }

  }

}
