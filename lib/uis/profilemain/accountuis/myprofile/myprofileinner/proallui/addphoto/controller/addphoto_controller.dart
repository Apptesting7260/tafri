import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddphotoController extends GetxController {
  // var selectedImage = Rx<XFile?>(null);

  @override
  void onInit() {
    super.onInit();
  }
  Rx<XFile?> selectedImage = Rx<XFile?>(null);
  void changePhoto(XFile? photo) {
    if (photo != null) {
      debugPrint("photo==${photo.path}");
      selectedImage.value = photo;
      debugPrint("selectedImage.value===${selectedImage.value?.path}");
    } else {
      debugPrint("photo is null");
    }
  }
}
