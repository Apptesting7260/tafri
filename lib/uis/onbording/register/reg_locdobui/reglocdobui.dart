import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../components/custoelevatedbtn.dart';
import '../../introone/intoone.dart';
import 'controller/reglocdob_controller.dart';

class RegLocDOBUi extends GetWidget<ReglocdobController> {
    RegLocDOBUi({super.key});
  // ReglocdobController redLocCon=Get.find(ReglocdobController());
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 10,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: h * .01,
                      ),
                      CommonUi.appBar(),
                      SizedBox(
                        height: h * .04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: h * .008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrYellow),
                          ),
                          Container(
                            height: h * .008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrYellow),
                          ),
                          Container(
                            height: h * .008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrYellow),
                          ),
                          Container(
                            height: h * .008,
                            width: Get.width * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * .04,
                      ),
                      const Text(
                        "Location and age",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: h * .02,
                      ),
                      const Text(
                        "This information helps us suggest local activities and ensures a safe and relevant experience for everyone.",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: h * .035,
                      ),
                      const Text(
                        "Where do you live?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(
                        height: h * .01,
                      ),
                      Form(
                        key: _formKey,
                        child: CustoTextFormField(
                          validation: (val) {
                            if (val == null || val.isEmpty) {
                              return "Location is required";
                            } else {
                              return null;
                            }
                          },
                          controll: controller.locationController,
                          hintText: "Enter your location",
                          sufixIcon: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: const Image(
                                image:
                                    AssetImage("assets/icons/locationicon.png"),
                                height: 3,
                                width: 3,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: h * .025,
                      ),
                      const Text(
                        "What’s your date of birth?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(
                        height: h * .01,
                      ),
                      Obx(() {
                        return InkWell(
                          onTap: () async {
                            DateTime? dob = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                initialDate: controller.dob.value == ''
                                    ? DateTime.now()
                                    : DateTime.parse(controller.dobForCalender
                                        .value)); //controller.dob.value
                            if (dob != null) {
                              print("gk=====$dob");
                              controller.changeDob(dob);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: clrGreyLight,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    child: const Image(
                                      image: AssetImage(
                                          "assets/icons/calendericon.png"),
                                      height: 20,
                                      width: 20,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  controller.dob.value == ''
                                      ? "DD/MM/YYYY"
                                      : "${controller.dob}",
                                  style: TextStyle(color: clrGreyTextLight),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                      Obx((){
                        return controller.dob.value == ''&& controller.isShowDobErr.value==true? Padding(
                          padding: const EdgeInsets.only(left: 14,top: 5),
                          child: Text("DOB is required.",style: TextStyle(color:clrRedErr,fontSize: 12),),
                        ):const SizedBox() ;
                      }),
                      Obx((){
                        return controller.isOld.value && controller.isShowDobErr.value==true ? Padding(
                          padding: const EdgeInsets.only(left: 14,top: 5),
                          child: Text("Age should be greater than 18 years.",style: TextStyle(color:clrRedErr,fontSize: 12),),
                        ) : const SizedBox() ;
                      }),
                      SizedBox(
                        height: h * .035,
                      ),
                      Obx(() => Opacity(
                        opacity: controller.loading.value ? 0.5 : 1,
                        child: SizedBox(
                            width: double.maxFinite,
                            height: Res.h_btn,
                            child: CustomElevatedButton(
                                onTap: () {
                                  if(!controller.loading.value){
                                    controller.changeShowDobVal(true);
                                    if(_formKey.currentState!.validate()){
                                      if(controller.dob.value != ''){
                                        if(!controller.isOld.value){
                                          controller.registerLocation();
                                        }
                                      }
                                    }
                                  }
                                },
                                backgroundClr: clrBlacke,
                                child: controller.loading.value ? CommonUi.fourDotLoading() : Text(
                                  "Continue",
                                  style: TextStyle(
                                      color: clrWhite,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ))),
                      ),),
                      SizedBox(
                        height: h * .02,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.visibility_outlined,
                            color: clrYellow,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  width: Get.width * 0.8,
                                  child: Text(
                                      "Your location and age will be visible to other members",
                                      style: TextStyle(color: clrBlacke))),
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
                      Text("Already have an account? ",
                          style: TextStyle(color: clrGreyDark, fontSize: 12)),
                      InkWell(
                          onTap: () {
                            Get.offAllNamed(Routes.initialPage);
                          },
                          child: Text("Log In",
                              style: TextStyle(
                                  color: clrYellowText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)))
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
