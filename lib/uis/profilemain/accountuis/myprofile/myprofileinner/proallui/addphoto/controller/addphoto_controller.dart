import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/routes/routes.dart';
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


  CustomImageCropController cropController = CustomImageCropController();
  var cropLoading = false.obs;

  Future<XFile> convertImage(Uint8List imageBytes, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(imageBytes);
    return XFile(filePath);
  }

  Future<void> cropPhoto() async{

    cropLoading.value = true;
    try{
      final image = await cropController.onCropImage();
      if(image != null){
        print('croped image == ${image}');
        final cropImage = await convertImage(image.bytes, 'PlusOnes_${DateTime.now().microsecondsSinceEpoch}.jpg');
        selectedImage.value = cropImage;
        Get.back();
      }
    }catch(e){
      print('crop errror == ${e.toString()}');
    }
    cropLoading.value = false;

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
      print('response == ${jsonResponse}');
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
        showTostMsg("${jsonResponse['message']}");
      }
    } catch (e) {
      debugPrint("error==$e");
      showTostMsg("${e.toString()}");
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
            Get.back();
            Get.toNamed(Routes.cropPhotoScreen,arguments: image);
          }

        }, child: Center(
          child: Text('Select from library',style: TextStyle(
            fontSize: 18,
            color: clrBlacke,
            fontWeight: FontWeight.w500
          ),),
        )),CupertinoActionSheetAction(onPressed: () async{
          final XFile? image = await picker.pickImage(source: ImageSource.camera);
          if(image != null){
            Get.back();
            Get.toNamed(Routes.cropPhotoScreen,arguments: image);
          }


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
