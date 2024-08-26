import 'package:get/get.dart';

class SwitchplanController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var selectedval = 0.obs;

  void updateSelectedValue(int? value) {
    selectedval.value = value!;
  }

}