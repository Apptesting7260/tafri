import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/utils/local_storage.dart';

class ViewNotifiController extends GetxController{
  @override
  void onInit() {
    var data = Get.arguments;
    message.value = data['msg'];
    userID.value = data['userid'];
    userImg.value = data['userimg'];
    actId.value = data['activity_id'];
    actImg.value = data['activity_img'];
    actTitle.value = data['activity_title'];
    // hostId.value = data['hostid'];
    waitlistMsg.value = data['waitlist_msg'] ?? '';
    getActivityStatus();
    super.onInit();
  }

  RxString message = ''.obs;
  var userID = ''.obs;
  var userImg = ''.obs;
  var actId = ''.obs;
  var actImg = ''.obs;
  var actTitle = ''.obs;
  var hostId = ''.obs;
  var waitlistMsg = ''.obs;

  final api = ApiServices();

  var actStatus = ''.obs;

  Future<void> getActivityStatus() async{

    var body = {
      'id': actId.value
    };

    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}',
    };

    try{
      print('send data == ${body}');
      final response = await api.post(EndPoints.activityStatusUrl, body,headers: header);
      if(response.statusCode == 200){
        actStatus.value = response.body['activity-status'];
        hostId.value = response.body['host_id'].toString();
      }else{
        actStatus.value = '';
      }
      print('act status == ${response.body}');
    }catch(e){
      actStatus.value = '';
      print('act status error == ${e.toString()}');
    }

  }


}