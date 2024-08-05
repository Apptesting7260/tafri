import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/model/profile_view_model.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/activityinterest/models/activitymodel.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';

class ProfilemainController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    viewProfile();
  }

  final api = ApiServices();

  var profileData = ProfileViewModel().obs;

  var profileLoading = false.obs;

  List<Subcategory> interestList = [];

  Future<void> viewProfile() async{

    String? token = LocalStorage.getToken();
    String? uid = LocalStorage.getUid();
    print('token == $token        $uid');
    var header = {"Authorization": "Bearer $token"};

    profileLoading.value = true;
    try{
      final response = await api.get('${EndPoints.profileViewUrl}$uid',headers: header);
      var data = ProfileViewModel.fromJson(response.body);
      if(data.status == true){
        profileData.value = data;

        if(data.result?.profile?.activityTitles != null){
          for(var i in data.result!.profile!.activityTitles!){
            if (i.subcategories != null) {
              interestList.addAll(i.subcategories!);
            }
          }
        }

        for (var subcategory in interestList) {
          print('Title: ${subcategory.title}, Icon: ${subcategory.icon}');
        }

        profileLoading.value = false;
      }else{
        showTostMsg('Something went wrong');
        profileLoading.value = false;
      }
    }catch(e){
      showTostMsg('Something went wrong');
      profileLoading.value = false;
      print('error == ${e.toString()}');
    }

  }

}