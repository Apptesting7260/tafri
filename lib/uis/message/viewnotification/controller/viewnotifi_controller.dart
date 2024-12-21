import 'package:get/get.dart';

class ViewNotifiController extends GetxController{
  @override
  void onInit() {
    var data = Get.arguments;
    message.value = data['msg'];
    userID.value = data['userid'];
    userImg.value = data['userimg'];
    super.onInit();
  }

  RxString message = ''.obs;
  var userID = ''.obs;
  var userImg = ''.obs;

}