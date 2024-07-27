import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/language/models/langauagemodel.dart';
import 'package:plusone/utils/local_storage.dart';
import '../../../../../../networking/apiservices.dart';
import '../../../../../../networking/endpoints.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/size.dart';
import '../../../../../../utils/tostmsg.dart';
import '../../../../../components/custoelevatedbtn.dart';
import '../proallui/activityinterest/models/activitymodel.dart';

class MyprofileInnController extends GetxController with GetTickerProviderStateMixin{
  final api = ApiServices();
  late TabController tabController;
  @override
  void onInit() {
    languageApi();
    activityGetDataApi();
    tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero,(){
      return ProfileAlertPopUp();
    });
    // TODO: implement onInit
    super.onInit();
  }
  TextEditingController bioController=TextEditingController();
  TextEditingController locController=TextEditingController();
  TextEditingController ocupatController=TextEditingController();
  TextEditingController organiController=TextEditingController();
  TextEditingController langController=TextEditingController();

  Map profileDeta={
    'user_id':'',
    'bio':'',
    'occupation':'',
    'organisation_name':'',
    'language_id':'',
    'category_id':'',
    'subcategory_id':'',
    'questions':'',
    'answers':'',
    'profile_photo':'',
    'verify_instagram':'',
    'verify_linkedin':'',
  };

  ProfileAlertPopUp() async {
    Future.delayed(Duration(seconds: 3), () {
      return Get.dialog(AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 0),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  SizedBox(
                  height:Get.height*.012,
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Just a few more details to complete your profile.",textAlign: TextAlign.center,style: TextStyle(fontSize: 14),),
                  ),
                ),
                  SizedBox(
                  height: Get.height*.012,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width*0.6,
                    height: Res.h_btn,
                    child: CustoElevatedBtn(onTap: (){
                      Get.back();
                    }, backgroundClr: clrBlacke, child: Text("Complete Now",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),)),
                  ),
                ),
                  SizedBox(
                  height:Get.height*.007,
                ),
                Center(
                  child: InkWell(onTap: (){
                    Get.back();
                  },child: Text("I will do it later",style: TextStyle(color: clrGreyTextLight,fontSize: 13),)),
                )
              ],
            ),
          )));
    });
  }
//************************************************language select code  ****************
  RxList selectedLanguageList = [].obs;
  removeSelectLan(index){
    selectedLanguageList.removeAt(index);
    selectedLanguageList.reversed;
  }
//************************************************Get verified code ****************
  Rx<int> isInstaVerified=0.obs;
  Rx<int> isLinkdinVerified=0.obs;
  changeVerifyInsta(val){
    isInstaVerified.value=val;
  }
  changeVerifyLinkdin(val){
    isLinkdinVerified.value=val;
  }
//************************************************language get dropdown api ****************
  Rx<bool> isLanLoading=false.obs;
  Rx<LanguageModel> langListData = LanguageModel().obs;
  Future<void> languageApi()async{

    isLanLoading.value=true;
    String? token=LocalStorage.getToken();
    try{

      final response = await api.get(EndPoints.languageListApiUrl,headers: {"Authorization":"Bearer $token"});
      if(response.statusCode==200){
      LanguageModel body=LanguageModel.fromJson(response.body);
        if(body.status==true){
          langListData.value=body;
        }else{
          showTostMsg("Something went wrong");
        }
      }else{
        showTostMsg("Something went wrong");
      }
    }catch(e){
      debugPrint("error==$e");
      showTostMsg("Something went wrong");
    }
    isLanLoading.value=false;
  }

  //************************************************Activity get api ****************
  Rx<bool> isLoadingActivity=false.obs;
  Rx<ActivityModel> activityListData = ActivityModel().obs;
  Future<void> activityGetDataApi()async{
    isLoadingActivity.value=true;
    String? token=LocalStorage.getToken();
    try{
      final response = await api.get(EndPoints.getCategoryApiUrl,headers: {"Authorization":"Bearer $token"});
      if(response.statusCode==200){
        ActivityModel body=ActivityModel.fromJson(response.body);
        if(body.status==true){
          activityListData.value=body;
          debugPrint("gk=====activity listdeta=${response.body}");
        }else{
          showTostMsg("Something went wrong");
        }
      }else{
        showTostMsg("Something went wrong");
      }
    }catch(e){
      debugPrint("error==$e");
      showTostMsg("Something went wrong");
    }
    isLoadingActivity.value=false;
  }
//************************************************Activity selected btn algo ****************
// List selectedInterestIds=[];
  var selectedCatIds=[].obs;
  var selectedSubCatIds=[].obs;
  changeActivitySelect(catindex,catId,subCatListIndex,subCatId,isSelected){
    if(isSelected==true){
      selectedCatIds.add(catId);
      selectedSubCatIds.add(subCatId);
    }else{
      for(int i=0 ;i<selectedCatIds.length;i++){
        if(selectedCatIds[i]==catId){
          selectedCatIds.removeAt(i);
        }
      }
      for(int i=0 ;i<selectedSubCatIds.length;i++){
        if(selectedSubCatIds[i]==subCatId){
          selectedSubCatIds.removeAt(i);
        }
      }
    }

    activityListData.value.result?[catindex].subcategories?[subCatListIndex].isSelected=isSelected;
    activityListData.refresh();
    selectedCatIds.refresh();
    selectedSubCatIds.refresh();
    debugPrint("gk==selectedCatIds=${selectedCatIds}");
    debugPrint("gk==selectedSubCatIds=${selectedSubCatIds}");
  }

  //************************************************My profile mulipart api ****************
  Rx<bool> isLoadingProfile=false.obs;
  Future<void> myProfileSubmit()async{
    isLoadingProfile.value=true;
    String? token=LocalStorage.getToken();
    try{
      // final response = await api.get(EndPoints.getCategoryApiUrl,headers: {"Authorization":"Bearer $token"});
      // final response = await api.(EndPoints.getCategoryApiUrl,headers: {"Authorization":"Bearer $token"});
      var request = http.MultipartRequest('POST', Uri.parse(EndPoints.completeProfileApiUrl));
      var uid=LocalStorage.getUid();
      request.fields['user_id']="$uid";
      request.fields['bio']="$uid";
      request.fields['occupation']="$uid";
      request.fields['organisation_name']="$uid";
      request.fields['language_id']="$uid";
      request.fields['category_id']="$uid";
      request.fields['subcategory_id']="$uid";
      request.fields['questions']="$uid";
      request.fields['answers']="$uid";
      request.fields['profile_photo']="$uid";
      request.fields['verify_instagram']="$uid";
      request.fields['verify_linkedin']="$uid";
      var response = await request.send();
      if(response.statusCode==200){
        // ActivityModel body=ActivityModel.fromJson(response.body);
        // if(body.status==true){
        //   activityListData.value=body;
        //   debugPrint("gk=====activity listdeta=${response.body}");
        // }else{
          showTostMsg("Profile data submitted successfully");
        // }
      }else{
        showTostMsg("Something went wrong");
      }
    }catch(e){
      debugPrint("error==$e");
      showTostMsg("Something went wrong");
    }
    isLoadingProfile.value=false;
  }
}