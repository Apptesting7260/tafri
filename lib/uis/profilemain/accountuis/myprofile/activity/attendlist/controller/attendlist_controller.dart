import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/activity/attendlist/model/attendlist_model.dart';
import 'package:plusone/utils/local_storage.dart';

class AttendlistController extends GetxController{

  // String? id;

  @override
  void onInit() {
    // TODO: implement onInit
    String? id = Get.arguments;
    attlistapi(id);
    super.onInit();
  }

  final api = ApiServices();
  var activityLoading = false.obs;
  var attData = AttendancelistModel().obs;
  var attError = ''.obs;

  Future<void> attlistapi(String? id) async{

    Map body = {
      'activity_id': id,
      // 'user_id': LocalStorage.getUid()
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    activityLoading.value = true;

    try{
      final response = await api.post(EndPoints.attlist, body, headers: header);
      if(response.statusCode == 200){
        attError.value = '';
        print('home data == ${response.body}');
       attData.value = AttendancelistModel.fromJson(response.body);
      }else{
        print('error == ${response.body}');
        attError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      attError.value = e.toString();
    }

    activityLoading.value = false;

  }







}