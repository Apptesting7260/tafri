import 'package:get/get.dart';

class ViewNotifiController extends GetxController{
  @override
  void onInit() {
    String msg = Get.arguments;
    message.value = msg;
    super.onInit();
  }

  RxString message = ''.obs;

}