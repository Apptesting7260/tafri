import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/onbording/introone/controller/intro_controller.dart';
import 'package:plusone/uis/onbording/login/controller/loginno_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';

class CodeVerifyUi extends GetWidget<IntroController> {
  CodeVerifyUi({super.key});

  TextEditingController pinController = TextEditingController();
  final LoginnoController loginnoController = Get.find<LoginnoController>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    int currentStep = Get.arguments['current step'];
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: h * .07,
                    ),
                    const Text(
                      "Verification Code",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                    const Text(
                      "Please type the verification code sent to ",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    currentStep == 5 ? Text(
                      "${loginnoController.countryCode.value} ${loginnoController.mobNoCon.value.text}",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ) : Text(
                      "${controller.countryCode.value} ${controller.mobnoController.value.text}",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    SizedBox(
                      height: h * 0.04,
                    ),
                    //pin cofe fields gk
                    PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        selectedFillColor: clrGreyLight,
                        inactiveFillColor: clrGreyLight,
                        activeColor: clrGreyLight,
                        // borderRadius: null,
                        fieldHeight: 48,
                        fieldWidth: 50,
                        inactiveColor: clrGreyLight,
                        activeFillColor: clrGreyLight,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      // errorAnimationController: errorController,
                      controller: pinController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        String? token=Get.arguments['token'];
                        String? uId=Get.arguments['uid'];
                        if (currentStep == 0) {
                          Get.toNamed(Routes.nameAddUi);
                          // Get.toNamed(Routes.navbarUi);
                        } else if (currentStep == 1) {
                          Get.toNamed(Routes.genderaddUi);
                        } else if (currentStep == 2) {
                          Get.toNamed(Routes.regLocDobui);
                        } else if (currentStep == 3) {
                          Get.toNamed(Routes.regEmailui);
                        }else{
                          LocalStorage.saveToken(token!);
                          LocalStorage.saveUid(uId!);
                          Get.toNamed(Routes.navbarUi);
                        }
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        // setState(() {
                        //   // currentText = value;
                        // });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        return true;
                      },
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                    SizedBox(
                        width: double.maxFinite,
                        height: Res.h_btn,
                        child: CustoElevatedBtn(
                          onTap: () {
                            String? token=Get.arguments['token'];
                            String? uId=Get.arguments['uid'];
                            if (currentStep == 0) {
                              Get.toNamed(Routes.nameAddUi);
                            } else if (currentStep == 1) {
                              Get.toNamed(Routes.genderaddUi);
                            } else if (currentStep == 2) {
                              Get.toNamed(Routes.regLocDobui);
                            } else if (currentStep == 3) {
                              Get.toNamed(Routes.regEmailui);
                            }else{
                              LocalStorage.saveToken(token!);
                              LocalStorage.saveUid(uId!);
                              Get.toNamed(Routes.navbarUi);
                            }
                          },
                          backgroundClr: clrBlacke,
                          child: Text(
                            "Verify",
                            style: TextStyle(
                                color: clrWhite,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        )),
                    SizedBox(
                      height: h * .025,
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "I didn’t receive a code. ",
                              style: TextStyle(
                                  color: clrGreyDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: "Resend",
                              style: TextStyle(color: clrYellowText)),
                        ])),
                  ],
                ),
              ),
              Column(
                children: [
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Need Help? Contact ",
                            style: TextStyle(
                                color: clrGreyDark,
                                fontSize: 12,
                                fontWeight: FontWeight.w300)),
                        TextSpan(
                            text: "info@plusonesapp.com",
                            style: TextStyle(
                                color: clrYellowText,
                                fontSize: 12,
                                fontWeight: FontWeight.w300)),
                      ])),
                  SizedBox(
                    height: h * .025,
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
