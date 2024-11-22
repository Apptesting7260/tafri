import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/utils/colors.dart';

import '../../../../../../../../utils/local_storage.dart';
import '../../../../../../../../utils/tostmsg.dart';
import '../../../../../../controller/profilemain_controller.dart';

class AddphotoController extends GetxController {
  // var selectedImage = Rx<XFile?>(null);
  static ProfilemainController profileController =
  Get.find<ProfilemainController>();

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

  String? token = LocalStorage.getToken();
  String? uid = LocalStorage.getUid();


  var photoLoading = false.obs;

  Future<void> photoUpdate() async {
    photoLoading.value = true;
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(EndPoints.editphotoprofile));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['user_id'] = jsonEncode(int.parse(uid!));
      if (selectedImage.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
            "profile_photo", selectedImage.value!.path));
      }
      var responseRes = await request.send();
      var resDeta = await responseRes.stream.toBytes();
      var responseString = String.fromCharCodes(resDeta);
      var jsonResponse = jsonDecode(responseString);
      if (responseRes.statusCode == 200) {
        await profileController.viewProfile();
        selectedImage.value = null;
        Get.back();
        showTostMsg("${jsonResponse['message']}");
      } else if (responseRes.statusCode == 401) {
        showTostMsg("${jsonResponse['message']}");
        print('submit error ==');
      } else {
        print('submit error');
        showTostMsg("Something went wrong");
      }
    } catch (e) {
      debugPrint("error==$e");
      showTostMsg("Something went wrong");
    }
    photoLoading.value = false;
  }


  final ImagePicker picker = ImagePicker();

  imagePopUp(BuildContext context){
    showCupertinoModalPopup(context: context, builder: (context){
      return
        CupertinoActionSheet(actions: [CupertinoActionSheetAction(onPressed: () async{
          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
          if(image != null){
            changePhoto(image);
          }
          Get.back();
        }, child: Center(
          child: Text('Select from library',style: TextStyle(
            fontSize: 18,
            color: clrBlacke,
            fontWeight: FontWeight.w500
          ),),
        )),CupertinoActionSheetAction(onPressed: () async{
          final XFile? image = await picker.pickImage(source: ImageSource.camera);
          if(image != null){
            changePhoto(image);
          }
          Get.back();
        }, child: Center(
          child: Text('Take a photo',style: TextStyle(
              fontSize: 18,
              color: clrBlacke,
              fontWeight: FontWeight.w500
          ),),
        ))],cancelButton: CupertinoActionSheetAction(onPressed: () {
          Get.back();
        },child: Center(
          child: Text('Cancel',style: TextStyle(
            color: clrBlacke,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),),
        ),));
    });
  }


}
