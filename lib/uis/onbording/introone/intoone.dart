import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors.dart';
import 'controller/intro_controller.dart';

class IntroOneUi extends GetWidget<IntroController> {
  IntroOneUi({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onbordingone.jpg'),
            colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * .26,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Plus",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                            color: clrWhite),
                      ),
                      Text("Ones",
                          style: TextStyle(
                              fontSize: 50,
                              color: clrYellow,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  Text(
                    "Find your +1s to \n  enjoy activities \n together",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: clrWhite,
                        fontWeight: FontWeight.w700,
                        fontSize: 32),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * .25),
              InkWell(
                onTap: () {
                  Get.bottomSheet(BottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      enableDrag: false,
                      onClosing: () {},
                      builder: (context) {
                        return Obx(
                          () => Opacity(
                            opacity: controller.loading.value ? 0.5 : 1,
                            child: Container(
                                width: double.maxFinite,
                                height: screenHeight * .5,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 7),
                                          alignment: Alignment.center,
                                          height: screenHeight * .005,
                                          width: screenWidth * .12,
                                          decoration: BoxDecoration(
                                              color: clrGrey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * .03,
                                      ),
                                      const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        "We need your mobile number to verify your account.",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: Get.height * .03,
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          controller:
                                              controller.mobnoController,
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return 'Please enter your mobile number';
                                            } else if (!controller
                                                .validatePhoneNumber(
                                                    val,
                                                    controller.initialSelection
                                                        .value)) {
                                              return 'Invalid mobile number for the selected country';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                              hintText: "Mobile number",
                                              hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 0),
                                              filled: true,
                                              fillColor: clrGreyLight,
                                              prefixIcon: CountryCodePicker(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                    color: clrBlacke),
                                                onChanged: (code) {
                                                  debugPrint(
                                                      "=====${code.runtimeType}");
                                                  controller
                                                      .changeCountryCode(code);
                                                },
                                                initialSelection: controller
                                                    .initialSelection.value,
                                                favorite: ['+31'],
                                                showCountryOnly: false,
                                                showOnlyCountryWhenClosed:
                                                    false,
                                                alignLeft: false,
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                            // Error border
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            // Error border when focused
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: Get.height * 0.025),
                                      SizedBox(
                                          width: double.maxFinite,
                                          height: Res.h_btn,
                                          child: CustomElevatedButton(
                                            onTap: () {
                                              if (!controller.loading.value) {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  controller.checkMobNoApi();
                                                }
                                              }
                                            },
                                            backgroundClr: clrBlacke,
                                            child: Obx(
                                              () => controller.loading.value
                                                  ? CommonUi.buttonLoading()
                                                  : Text(
                                                      "Next",
                                                      style: TextStyle(
                                                          color: clrWhite,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                    ),
                                            ),
                                          )),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Center(
                                        child: InkWell(
                                          onTap: () {
                                            Get.back();
                                            controller.mobnoController.clear();
                                            controller.initialSelection.value = 'NL';
                                            controller.countryCode.value = '+31';
                                            Get.toNamed(Routes.loginWithMobNo);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                      "Already have a Account ?",
                                                      style: TextStyle(
                                                          color: clrGreyDark,
                                                          fontWeight:
                                                          FontWeight.w300,
                                                          fontSize: 12)),
                                                  const TextSpan(text: ' '),
                                                  TextSpan(
                                                      text: "Login",
                                                      style: TextStyle(
                                                          color: clrYellowText,
                                                          fontWeight:
                                                          FontWeight.w300,
                                                          fontSize: 12,
                                                          decoration: TextDecoration
                                                              .underline)),
                                                ])),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "By registering you accept our",
                                                  style: TextStyle(
                                                      color: clrGreyDark,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12)),
                                              const TextSpan(text: ' '),
                                              TextSpan(
                                                  text: "Terms of Use",
                                                  style: TextStyle(
                                                      color: clrYellowText,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12,
                                                      decoration: TextDecoration
                                                          .underline)),
                                              TextSpan(
                                                  text: " and",
                                                  style: TextStyle(
                                                      color: clrGreyDark,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12)),
                                              const TextSpan(text: ' '),
                                              TextSpan(
                                                  text: "Privacy Policy",
                                                  style: TextStyle(
                                                      color: clrYellowText,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12,
                                                      decoration: TextDecoration
                                                          .underline)),
                                            ])),
                                      ),
                                      SizedBox(height: screenHeight * 0.04),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "Need Help? Contact ",
                                                  style: TextStyle(
                                                      color: clrBlacke,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12)),
                                              TextSpan(
                                                  text: "info@plusonesapp.com",
                                                  style: TextStyle(
                                                      color: clrYellowText,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12)),
                                            ])),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }));
                },
                child: Container(
                  height: screenHeight * .065,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: clrYellow),
                  child: const Center(
                    child: Text(
                      'Sign up',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .014,
              ),
              SizedBox(
                width: double.maxFinite,
                height: screenHeight * .065,
                child: CustomElevatedButton(
                  onTap: () {
                    controller.mobnoController.clear();
                    controller.initialSelection.value = 'NL';
                    controller.countryCode.value = '+31';
                    Get.toNamed(Routes.loginWithMobNo);
                  },
                  backgroundClr: clrWhite,
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: clrBlacke,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Nunito'),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:plusone/uis/components/custoelevatedbtn.dart';
// import '../../../routes/routes.dart';
// import '../../../utils/colors.dart';
// import 'controller/intro_controller.dart';
//
// class IntroOneUi extends GetWidget<IntroController> {
//   IntroOneUi({super.key});
//
//   // final _formKey=GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       body: Container(
//         // width: double.maxFinite,
//         // height: double.maxFinite,
//         width: Get.width,
//         height: Get.height,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/onbordingone.jpg'),
//             colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
//             fit: BoxFit.cover,
//           ), //colorFilter:ColorFilter.mode(clrBlacke.withOpacity(0.5), BlendMode.lighten)
//         ),
//         padding: const EdgeInsets.all(0),
//         margin: const EdgeInsets.all(0),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Plus",
//                         style: TextStyle(
//                             fontSize: 50,
//                             fontWeight: FontWeight.w700,
//                             color: clrWhite),
//                       ),
//                       Text("Ones",
//                           style: TextStyle(
//                               fontSize: 50,
//                               color: clrYellow,
//                               fontWeight: FontWeight.w700)),
//                     ],
//                   ),
//                   Text(
//                     "Find your +1s to \n  enjoy activities \n together",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: clrWhite,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 32),
//                   ),
//                 ],
//               ),
//               SizedBox(height: Get.height * .25),
//               Container(
//                 height: Get.height * .065,
//                 width: Get.width,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100), color: clrYellow),
//                 child: const Center(
//                   child: Text(
//                     'Sign up',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * .014,
//               ),
//               SizedBox(
//                   width: double.maxFinite,
//                   height: Get.height * .065,
//                   child: CustomElevatedButton(
//                       onTap: () {
//                         Get.toNamed(Routes.loginWithMobNo);
//                       },
//                       backgroundClr: clrWhite,
//                       child: Text(
//                         "Log in",
//                         style: TextStyle(
//                             color: clrBlacke,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             fontFamily: 'Nunito'),
//                       ))),
//               SizedBox(
//                 height: Get.height * .06
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
