import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/uis/onbording/introone/controller/intro_controller.dart';
import 'package:plusone/uis/onbording/login/controller/loginno_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';

class CodeVerifyUi extends GetWidget<IntroController> {
  CodeVerifyUi({super.key});

  TextEditingController pinController = TextEditingController();
  final LoginnoController loginnoController = Get.find<LoginnoController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    String from = Get.arguments['from'];
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
                    from == 'login'
                        ? Text(
                            "${loginnoController.countryCode.value} ${loginnoController.mobNoCon.value.text}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          )
                        : Text(
                            "${controller.countryCode.value} ${controller.mobnoController.value.text}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                    SizedBox(
                      height: h * 0.04,
                    ),
                    //pin cofe fields gk
                    Form(
                      key: _formKey,
                      child: PinCodeTextField(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter otp';
                          } else if (value.length < 6) {
                            return 'Enter 6 digit otp';
                          } else {
                            return null;
                          }
                        },
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
                          selectedColor: clrYellow
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
                        onCompleted: (v) async {
                          if(Get.isRegistered<ExploreListController>()){
                            Get.delete<ExploreListController>();
                          }
                          String? token = Get.arguments['token'];
                          String? uId = Get.arguments['uid'];
                          pinController.text = v;
                          var verify = from == 'login'
                              ? await loginnoController.verifyOtp(
                                  loginnoController.verificationID.value,
                                  pinController.value.text.trim())
                              : await controller.verifyOtp(
                                  controller.verificationID.value,
                                  pinController.value.text.trim());
                          if(verify){
                            if(from == 'signup'){
                              await controller.checkMobNoApi();
                            }else{
                              LocalStorage.saveToken(token!);
                              LocalStorage.saveUid(uId!);
                              Get.offAllNamed(Routes.navbarUi);
                            }
                          }
                          // if (verify) {
                          //   if (currentStep == 0) {
                          //     Get.offNamed(Routes.nameAddUi);
                          //     // Get.toNamed(Routes.navbarUi);
                          //   } else if (currentStep == 1) {
                          //     Get.offNamed(Routes.genderaddUi);
                          //   } else if (currentStep == 2) {
                          //     Get.offNamed(Routes.regLocDobui);
                          //   } else if (currentStep == 3) {
                          //     Get.offNamed(Routes.regEmailui);
                          //   } else {
                          //     LocalStorage.saveToken(token!);
                          //     LocalStorage.saveUid(uId!);
                          //     Get.offAllNamed(Routes.navbarUi);
                          //   }
                          // }
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          pinController.text = value;
                          // setState(() {
                          //   // currentText = value;
                          // });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                    Obx(
                      () => Opacity(
                        opacity: from == 'login'
                            ? (loginnoController.otpVerify.value ? 0.5 : 1)
                            : (controller.otpVerify.value || controller.loading.value ? 0.5 : 1),
                        child: SizedBox(
                            width: double.maxFinite,
                            height: Res.h_btn,
                            child: CustomElevatedButton(
                              onTap: () async {
                                if(Get.isRegistered<ExploreListController>()){
                                  Get.delete<ExploreListController>();
                                }
                                String? token = Get.arguments['token'];
                                String? uId = Get.arguments['uid'];
                                if (_formKey.currentState!.validate()) {
                                  var verify = from == 'login'
                                      ? await loginnoController.verifyOtp(
                                          loginnoController
                                              .verificationID.value,
                                          pinController.value.text.trim())
                                      : await controller.verifyOtp(
                                          controller.verificationID.value,
                                          pinController.value.text.trim());
                                  if (verify) {
                                    if(from == 'signup') {
                                      await controller.checkMobNoApi();
                                    }else{
                                      LocalStorage.saveToken(token!);
                                      LocalStorage.saveUid(uId!);
                                      Get.offAllNamed(Routes.navbarUi);
                                    }
                                    // if (currentStep == 0) {
                                    //   Get.offNamed(Routes.nameAddUi);
                                    // } else if (currentStep == 1) {
                                    //   Get.offNamed(Routes.genderaddUi);
                                    // } else if (currentStep == 2) {
                                    //   Get.offNamed(Routes.regLocDobui);
                                    // } else if (currentStep == 3) {
                                    //   Get.offNamed(Routes.regEmailui);
                                    // } else {
                                    //   LocalStorage.saveToken(token!);
                                    //   LocalStorage.saveUid(uId!);
                                    //   Get.offAllNamed(Routes.navbarUi);
                                    // }
                                  }
                                }
                                // if (currentStep == 0) {
                                //   Get.toNamed(Routes.nameAddUi);
                                // } else if (currentStep == 1) {
                                //   Get.toNamed(Routes.genderaddUi);
                                // } else if (currentStep == 2) {
                                //   Get.toNamed(Routes.regLocDobui);
                                // } else if (currentStep == 3) {
                                //   Get.toNamed(Routes.regEmailui);
                                // }else{
                                //   LocalStorage.saveToken(token!);
                                //   LocalStorage.saveUid(uId!);
                                //   Get.toNamed(Routes.navbarUi);
                                // }
                              },
                              backgroundClr: clrBlacke,
                              child: from == 'login'
                                  ? (loginnoController.otpVerify.value
                                      ? CommonUi.buttonLoading()
                                      : Text(
                                          "Verify",
                                          style: TextStyle(
                                              color: clrWhite,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ))
                                  : (controller.otpVerify.value || controller.loading.value
                                      ? CommonUi.buttonLoading()
                                      : Text(
                                          "Verify",
                                          style: TextStyle(
                                              color: clrWhite,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        )),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("I didn’t receive a code.",
                            style: TextStyle(
                                color: clrGreyDark,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                        from == 'login'
                            ? OtpTimerButton(
                                buttonType: ButtonType.text_button,
                                controller: loginnoController.otpTimerButtonController,
                                loadingIndicatorColor: clrBlacke,
                                onPressed: () {
                                  print('resend otp');
                                  loginnoController.resendOtp().then((value) {
                                    if(value){
                                      pinController.clear();
                                    }
                                  },);
                                },
                                text: Text('Resend',
                                    style: TextStyle(color: clrYellowText)),
                                duration: 60)
                            : OtpTimerButton(
                                buttonType: ButtonType.text_button,
                                controller: controller.otpTimerButtonController,
                                loadingIndicatorColor: clrBlacke,
                                onPressed: () {
                                  print('resend otp');
                                  controller.resendOtp().then((value) {
                                    if(value){
                                      pinController.clear();
                                    }
                                  },);
                                },
                                text: Text('Resend',
                                    style: TextStyle(color: clrYellowText)),
                                duration: 60),
                      ],
                    ),
                    // RichText(
                    //     textAlign: TextAlign.center,
                    //     text: TextSpan(children: [
                    //       TextSpan(
                    //           text: "I didn’t receive a code. ",
                    //           style: TextStyle(
                    //               color: clrGreyDark,
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w400)),
                    //       // WidgetSpan(child: OtpTimerButton(
                    //       //     buttonType: ButtonType.text_button,
                    //       //     onPressed: () {
                    //       //       print('resend otp');
                    //       //     },
                    //       //     text: Text('Resend',style: TextStyle(color: clrYellowText)),
                    //       //     duration: 20))
                    //       TextSpan(
                    //           text: "Resend",
                    //           style: TextStyle(color: clrYellowText)),
                    //     ])),
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
