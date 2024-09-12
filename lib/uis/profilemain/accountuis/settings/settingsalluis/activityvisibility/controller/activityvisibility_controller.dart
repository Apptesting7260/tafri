import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/controller/myprofileinn_controller.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/local_storage.dart';

class ActivityvisibilityController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ps.value = int.parse(proController.profileData.value.result!.previousActivityStatus.toString());
    us.value = int.parse(proController.profileData.value.result!.upcommingActivityStatus.toString());
    print('ps===> $ps  $us');
    if(ps.value == 0){
      previousVisibility.value = false;
    } else{
      previousVisibility.value = true;
    }
    if(us.value == 0){
      upcomingVisibility.value = false;
    } else{
      upcomingVisibility.value = true;
    }
  }

  ProfilemainController proController = Get.find<ProfilemainController>();

  var upcomingVisibility = false.obs;
  var previousVisibility = false.obs;

  changeUpcomingVisibility(){
    upcomingVisibility.value = !upcomingVisibility.value;
    if(upcomingVisibility.value == false){
      us.value = 0;
      actVis();
    } else{
      us.value = 1;
      actVis();
    }
  }

  changePreviousVisibility(){
    previousVisibility.value = !previousVisibility.value;
    if(previousVisibility.value == false){
      ps.value = 0;
      actVis();
    } else{
      ps.value = 1;
      actVis();
    }
  }

  final api = ApiServices();
  var activityLoading = false.obs;
  var attError = ''.obs;

  var us = 0.obs;
  var ps = 0.obs;

  Future<void> actVis() async{

    Map body = {
      'user_id': LocalStorage.getUid(),
      'upcomming_activity_status': us.value.toString(),
      'previous_activity_status': ps.value.toString(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    activityLoading.value = true;

    try{
      final response = await api.post(EndPoints.actVis, body, headers: header);
      print('=====>>>> ${EndPoints.actVis}');
      if(response.statusCode == 200){
        attError.value = '';
        proController.viewProfile();
        print('actVis data == ${response.body}');
      }else{
        print('error == ${response.body}');
        attError.value = 'ERROR';
      }
    }catch(e){
      print('actVis api error == ${e.toString()}');
      attError.value = e.toString();
    }

    activityLoading.value = false;

  }

}