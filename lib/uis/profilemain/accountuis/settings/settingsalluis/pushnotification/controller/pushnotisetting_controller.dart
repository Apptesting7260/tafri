import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/local_storage.dart';

import '../../../../../../../networking/endpoints.dart';



class PushnotisettingController extends GetxController{
  
  static ProfilemainController profilemainController = Get.find<ProfilemainController>();
  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  

  Rx<int> notificationsVal = (profilemainController.profileData.value.result?.pushNotificaions == null ? 0 : int.parse(profilemainController.profileData.value.result?.pushNotificaions ?? '0')).obs;
  Rx<int> emailVal = (profilemainController.profileData.value.result?.emailNotifications == null ? 0 : int.parse(profilemainController.profileData.value.result?.emailNotifications ?? '0')).obs;

  changenotificationsVal(val) {
    notificationsVal.value = val;
    changeNotApi();
  }

  changeemailVal(val) {
    emailVal.value = val;
    changeNotApi();
  }

  var api = ApiServices();

  Future<void> changeNotApi() async{

    Map body = {
      'user_id': LocalStorage.getUid(),
      'push_notificaions': notificationsVal.value.toString(),
      'email_notifications': emailVal.value.toString(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };


    try{
      final response = await api.post(EndPoints.notifications, body,headers: header);
      if(response.statusCode == 200){
        print('change data == ${response.body}');
        profilemainController.viewProfile();
      }else{
        print('error == ${response.body}');
      }
    }catch(e){
      print('changeFav api error == ${e.toString()}');
    }


  }

  
}