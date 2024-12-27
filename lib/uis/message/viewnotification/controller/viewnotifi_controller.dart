import 'package:get/get.dart';

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
    super.onInit();
  }

  RxString message = ''.obs;
  var userID = ''.obs;
  var userImg = ''.obs;
  var actId = ''.obs;
  var actImg = ''.obs;
  var actTitle = ''.obs;

}