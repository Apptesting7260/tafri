import 'package:get/get.dart';

class PushnotisettingController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxBool notificationsVal=false.obs;
  RxBool emailVal=false.obs;
  changenotificationsVal(){
    notificationsVal.value=!notificationsVal.value;
  }
  changeemailVal(){
    emailVal.value=!emailVal.value;
  }
}