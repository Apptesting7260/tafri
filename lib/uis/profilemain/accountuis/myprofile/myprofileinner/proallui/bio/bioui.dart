import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../../../utils/colors.dart';
import '../../controller/myprofileinn_controller.dart';

class BioUi extends GetWidget<MyprofileInnController>{
    BioUi({super.key});
  final _formState=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(child: Padding(
        padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        child: Column(
          children: [
              SizedBox(
              height: h*.007,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width:h*.05,
                    height:h*.05,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Icon(Icons.arrow_back_ios)),
                  ),
                ),
                const Text(
                  "Bio",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                  SizedBox(
                  width: w*.06,
                ),
              ],
            ),
            SizedBox(
              height: Get.height*0.03,
            ),
            Expanded(
              child: Column(
                children: [
                  const Text("Share a bit about yourself helps members understand you better and find like-minded activity partners.",style: TextStyle(fontSize: 15),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Form(
                    key: _formState,
                    child: TextFormField(
                      controller: controller.bioController,
                      validator: (val){
                        if(val==null || val.isEmpty || val==''){
                          return "Please tell about yourself";
                        }
                      },
                      keyboardType:TextInputType.text,
                      maxLines: 8,
                      maxLength: 350,
                      decoration: InputDecoration(

                          hintText: "Introduce yourself...",
                          hintStyle: TextStyle(fontWeight: FontWeight.w400,color: clrGreyTextLight),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          fillColor: clrGreyLight,
                          filled: true,
                          border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(10))
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Res.h_btn,width: double.maxFinite,child: CustoElevatedBtn(onTap: (){
              // if(_formState.currentState!.validate()){
              Get.back();
              // }
            } ,backgroundClr:clrBlacke, child: Text("Save",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            SizedBox(
              height: Get.height*0.01,
            ),
          ],
        ),
      )),
    );
  }
}
