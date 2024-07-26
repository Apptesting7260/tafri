import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../../components/custoelevatedbtn.dart';
import 'controller/addphoto_controller.dart';

class AddPhotoUi extends GetWidget<AddphotoController> {
  const AddPhotoUi({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Icon(Icons.arrow_back_ios)),
                  ),
                ),
                const Text(
                  "Add a profile photo",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: Get.height*0.03,
            ),
            Expanded(
              child: ListView(
                children: [
                  const Text("Upload a recent photo of yourself. Only members can see your profile photo.",style: TextStyle(fontSize: 16),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(

                          children: [
                            Obx((){
                              return Container(
                                  clipBehavior: Clip.hardEdge,
                                  height: 180,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: clrYellow.withOpacity(0.1)
                                  ),
                                  child:controller.selectedImage.value !=null ?Image.file(File(controller.selectedImage!.value!.path),fit: BoxFit.cover,): Image.asset("assets/icons/manicon.png",color: clrYellow.withOpacity(0.4),)
                              );
                            }),
                            const SizedBox(height: 0,)
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: ()async{
                              final ImagePicker picker = ImagePicker();
// Pick an image.
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              if(image !=null){
                                controller.changePhoto(image);
                              }
                            },
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: clrYellow
                              ),
                              child: Icon(Icons.camera_alt,color: clrWhite,),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height*0.03,
                  ),

                  Text("Make sure your photo is clear and in focus, from the shoulders up, and only include yourself.",textAlign: TextAlign.center,style: TextStyle(color: clrGreyTextLight.withOpacity(0.7)),)
                ],
              ),
            ),
            SizedBox(height: Res.h_btn,width: double.maxFinite,child: CustoElevatedBtn(onTap: (){} ,backgroundClr:clrBlacke, child: Text("Upload Photo",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            SizedBox(
              height: Get.height*0.01,
            ),
          ],
        ),
      )),
    );
  }
}
