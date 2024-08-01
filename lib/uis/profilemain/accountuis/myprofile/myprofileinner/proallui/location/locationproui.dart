import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../../../utils/colors.dart';
import '../../controller/myprofileinn_controller.dart';

class LocationProUi extends GetWidget<MyprofileInnController>{
  LocationProUi({super.key});
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
              const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonUi.appBar(),
                const Text(
                  "Location",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                  SizedBox(
                  width: w*.06,
                ),
              ],
            ),
            SizedBox(
              height: Get.height*0.035,
            ),
            Expanded(
              child: Column(
                children: [
                  const Text("Share where you are based to join activities nearby.",style: TextStyle(fontSize: 15),),
                  SizedBox(
                    height: Get.height*0.025,
                  ),
                  // Obx((){
                  //   return ;
                  // })
                  Form(
                    key: _formState,
                    child: SizedBox(
                      child: CustoTextFormField(
                        controll: controller.locController,
                        validation: (val){
                          if(val==null || val.isEmpty || val==''){
                            return "Location is required";
                          }
                          return null;
                        },
                        hintText: "Amsterdam, Netherlands",
                        sufixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset("assets/icons/locationicon.png",height: Get.height*.04,),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Res.h_btn,width: double.maxFinite,child: CustoElevatedBtn(onTap: (){
              if(_formState.currentState!.validate()){
                Get.back();
              }
            } ,backgroundClr:clrBlacke, child: Text("Save",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}
