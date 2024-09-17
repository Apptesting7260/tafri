import 'package:get/get.dart';

class PushnotisettingController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxBool notificationsVal=true.obs;
  RxBool emailVal=true.obs;
  changenotificationsVal(){
    notificationsVal.value=!notificationsVal.value;
  }
  changeemailVal(){
    emailVal.value=!emailVal.value;
  }
}