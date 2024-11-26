import 'dart:io';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/proallui/addphoto/controller/addphoto_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

class CropPhotoScreen extends StatelessWidget {
  CropPhotoScreen({super.key});

  final AddphotoController controller = Get.find<AddphotoController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark));
    XFile image = Get.arguments;
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              CustomImageCrop(
                  image: FileImage(File(image.path)),
                  customProgressIndicator: CommonUi.scaffoldLoading(color: clrYellow),
                  imageFit: CustomImageFit.fillVisibleHeight,
                  forceInsideCropArea: true,
                  shape: CustomCropShape.Circle,
                  canRotate: false,
                  overlayColor: const Color.fromRGBO(0, 0, 0, 0.75),
                  drawPath: (p0, {pathPaint}) {
                    return CustomPaint(
                        foregroundPainter: DottedCropPathPainter(p0, pathPaint: Paint()..color = clrWhite..strokeWidth = 1.5..style = PaintingStyle.stroke,dashSpace: 0,dashWidth: 2)
                    );
                  },
                  backgroundColor: clrBlacke,
                  cropController: controller.cropController),
              Padding(
                padding: EdgeInsets.only(left: Res.Defalt_side_margin,right: Res.Defalt_side_margin,top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text('Cancel',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: clrWhite.withOpacity(0.7)
                      ),),
                    ),
                    Text('Edit photo',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: clrWhite
                    ),),
                    Obx(() => controller.cropLoading.value ? CommonUi.fallingDot() : GestureDetector(
                      onTap: () {
                        controller.cropPhoto();
                      },
                      child: Text('Done',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: clrWhite.withOpacity(0.7)
                      ),),
                    ),)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: clrBlacke.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.only(bottom: Get.height*0.05),
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.cropController.addTransition(CropImageData(scale: 0.75));
                        },
                          child: Icon(Icons.remove_circle_outline,
                            color: clrWhite.withOpacity(0.6),size: 30,)
                      ),
                      const SizedBox(width: 15,),
                      GestureDetector(
                        onTap: () {
                          controller.cropController.addTransition(CropImageData(scale: 1.33));
                        },
                          child: Icon(Icons.add_circle_outline,color: clrWhite.withOpacity(0.6),size: 30,)
                      ),
                      const SizedBox(width: 15,),
                      Container(
                        width: 1.5,
                        color: clrWhite.withOpacity(0.4),
                        height: 30,
                      ),
                      const SizedBox(width: 15,),
                      GestureDetector(
                        onTap: () {
                          controller.cropController.reset();
                        },
                        child: Text('Reset',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: clrWhite.withOpacity(0.6)
                        ),),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
