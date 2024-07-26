import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/navbar/navbar.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../utils/colors.dart';
import '../../../components/custoelevatedbtn.dart';
import '../../../components/custotextfield.dart';
import '../../introone/intoone.dart';
import 'controller/regemail_controller.dart';

class RegEmailUi extends GetWidget<RegemailController> {
  RegEmailUi({super.key});

  final _formKey = GlobalKey<FormState>();
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
                                color: clrYellow),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * .02,
                      ),
                      const Text(
                        "What’s your email?",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: h * .02,
                      ),
                      const Text(
                        "We need your email to keep your account secure and send important updates.",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: h * .03,
                      ),
                      Form(
                        key: _formKey,
                        child: CustoTextFormField(
                          validation: (val){
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if( val== null || val.isEmpty){
                              return "Email is required";
                            }else  if (!emailRegex.hasMatch(val)) {
                              return "Please enter valid emailaddress";
                            } else{
                              return null;
                            }
                          },
                        hintText: "Enter email address",
                        sufixIcon: Icon(
                          Icons.mail,
                          color: clrBlacke,
                        ),
                        textKType: TextInputType.emailAddress,
                        controll: controller.emailController,
                      )),
                      SizedBox(
                        height: h * .03,
                      ),
                      Obx(() => Opacity(
                        opacity: controller.loading.value ? 0.5 : 1,
                        child: SizedBox(
                            width: double.maxFinite,
                            height: Res.h_btn,
                            child: CustoElevatedBtn(
                                onTap: () {
                                  if(!controller.loading.value){
                                    if(_formKey.currentState!.validate()){
                                      controller.registerEmail();
                                    }
                                  }
                                },
                                backgroundClr: clrBlacke,
                                child: controller.loading.value ? CommonUi.fourDotLoading() : Text(
                                  "Explore the app",
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
                        children: [
                          Image.asset(
                            "assets/icons/eyeclosedicon.png",
                            width: 25,
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
                                      "Your email will not be visible to other members",
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
                            // Get.offAll(IntroOneUi());
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
