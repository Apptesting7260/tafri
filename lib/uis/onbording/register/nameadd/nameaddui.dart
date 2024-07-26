import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plusone/uis/onbording/introone/intoone.dart';
import 'package:plusone/uis/onbording/register/nameadd/controller/nameadd_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../components/custoelevatedbtn.dart';
import '../../../components/custotextfield.dart';

class NameAddUi extends GetWidget<NameAddController>{
  NameAddUi({super.key});

  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: h * .01,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: clrGreyLight,
                                borderRadius: BorderRadius.circular(10)),
                            child:
                            const Center(child: Icon(Icons.arrow_back_ios)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * .03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: h*.008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrYellow),
                          ),
                          Container(
                            height: h*.008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                          ),
                          Container(
                            height: h*.008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                          ),
                          Container(
                            height: h*.008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * .02,
                      ),
                      const Text(
                        "What’s your name?",
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: h * .02,
                      ),
                     Form(
                       key:formKey,
                         child: Column(children: [
                       SizedBox(
                           // height: Res.h_btn,
                           child: CustoTextFormField(
                             validation: (val){
                               if( val== null || val.isEmpty){
                                 return "First name is required";
                               }else{
                                 return null;
                               }
                             },
                             hintText: "First name",
                             controll:controller.fNameController,
                             sufixIcon: Container(
                                 padding: const EdgeInsets.symmetric(
                                     horizontal: 12, vertical: 10),
                                 child: const Image(
                                   image: AssetImage("assets/icons/manicon.png"),
                                   height: 3,
                                   width: 3,
                                 )),
                           )),
                       SizedBox(
                         height: h * .02,
                       ),
                       SizedBox(
                           // height: Res.h_btn,
                           child: CustoTextFormField(
                             validation: (val){
                               if( val== null || val.isEmpty){
                                 return "Last name is required";
                               }else{
                                 return null;
                               }
                             },
                             controll:controller.lNameController,
                             hintText: "Last name",
                             sufixIcon: Container(
                                 padding: const EdgeInsets.symmetric(
                                     horizontal: 12, vertical: 10),
                                 child: const Image(
                                   image: AssetImage("assets/icons/manicon.png"),
                                   height: 3,
                                   width: 3,
                                 )),
                           )),
                     ],)),
                      SizedBox(
                        height: h * .02,
                      ),
                      Obx(() => Opacity(
                        opacity: controller.loading.value ? 0.5 : 1,
                        child: SizedBox(
                            width: double.maxFinite,
                            height: Res.h_btn,
                            child: CustoElevatedBtn(
                              onTap: () {
                                if(!controller.loading.value){
                                  if(formKey.currentState!.validate()){
                                    controller.registerName();
                                  }
                                }
                              },
                              backgroundClr: clrBlacke,
                              child:controller.loading.value ? CommonUi.fourDotLoading() : Text(
                                "Continue",
                                style: TextStyle(color: clrWhite,fontWeight: FontWeight.w700,fontSize: 16),
                              )
                            )
                        ),
                      ),),
                      SizedBox(
                        height: h * .02,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.visibility_outlined,color: clrYellow,),
                          const SizedBox(
                            width: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: Get.width*0.8,child: Text("Only your first name will be visible to other members",style: TextStyle(color: clrBlacke,fontSize: 14,fontWeight: FontWeight.w400))),
                            ],
                          )
                        ],
                      )

                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ",style: TextStyle(color: clrGreyDark)),
                      InkWell(onTap: (){

                        Get.offAllNamed(Routes.initialPage);
                      },child: Text("Log In",style: TextStyle(color: clrYellowText,fontWeight: FontWeight.w700)))
                    ],
                  ),

                  SizedBox(
                    height: h * .02,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
