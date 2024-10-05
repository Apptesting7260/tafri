import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/onbording/login/controller/loginno_controller.dart';
import 'package:plusone/utils/size.dart';
import '../../../utils/colors.dart';
import '../../../utils/common.dart';
import '../../components/custoelevatedbtn.dart';

class LoginWithNoUi extends GetWidget<LoginnoController> {
  LoginWithNoUi({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Opacity(
          opacity: controller.googleLoading.value || controller.appleLoading.value ? 0.3 : 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/onbordingone.jpg"),
                    colorFilter:
                        ColorFilter.mode(Colors.black26, BlendMode.darken),
                    fit: BoxFit.cover,
                  ), //colorFilter:ColorFilter.mode(clrBlacke.withOpacity(0.5), BlendMode.lighten)
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
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
                      ),
                      SizedBox(
                          width: double.maxFinite,
                          height: Res.h_btn,
                          child: CustomElevatedButton(
                              onTap: () {
                                Get.bottomSheet(BottomSheet(
                                    enableDrag: false,
                                    onClosing: () {},
                                    builder: (context) {
                                      return Container(
                                          width: double.maxFinite,
                                          height: h * .45,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Res.Defalt_side_margin),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(vertical: 7),
                                                    alignment: Alignment.center,
                                                    height: h * .005,
                                                    width: w * .12,
                                                    decoration: BoxDecoration(
                                                        color: clrGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * .03,
                                                ),
                                                const Text(
                                                  "Log in",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(
                                                  height: Get.height * .01,
                                                ),
                                                Text(
                                                  "We need your phone number to verify your account",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: clrGreyDark),
                                                ),
                                                SizedBox(
                                                  height: h * .025,
                                                ),
                                                Form(
                                                  key: _formKey,
                                                  child: TextFormField(
                                                    validator: (val) {
                                                      if (val == null ||
                                                          val.isEmpty) {
                                                        debugPrint(
                                                            "=====error");
                                                        return "Please enter your mobile number";
                                                      } else if (!controller
                                                          .validatePhoneNumber(
                                                              val,
                                                              controller
                                                                  .initialSelection
                                                                  .value)) {
                                                        return 'Invalid mobile number for the selected country';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        controller.mobNoCon,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Mobile number",
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15,
                                                                vertical: 0),
                                                        filled: true,
                                                        fillColor: clrGreyLight,
                                                        prefixIcon:
                                                            CountryCodePicker(
                                                          onChanged: (code) {
                                                            debugPrint(
                                                                "===${code.runtimeType}");
                                                            controller
                                                                .changeCountryCode(
                                                                    code);
                                                          },
                                                          initialSelection:
                                                              controller
                                                                  .initialSelection
                                                                  .value,
                                                          favorite: [
                                                            '+31',
                                                          ],
                                                          showCountryOnly:
                                                              false,
                                                          showOnlyCountryWhenClosed:
                                                              false,
                                                          alignLeft: false,
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
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
                                                SizedBox(
                                                  height: h * .025,
                                                ),
                                                Obx(() {
                                                  return Opacity(
                                                    opacity: controller
                                                            .isLoadingLogin
                                                            .value
                                                        ? 0.5
                                                        : 1,
                                                    child: SizedBox(
                                                      width: double.maxFinite,
                                                      height: Res.h_btn,
                                                      child:
                                                          CustomElevatedButton(
                                                              onTap: () {
                                                                if (!controller
                                                                    .isLoadingLogin
                                                                    .value) {
                                                                  if (_formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    controller
                                                                        .loginApi();
                                                                  }
                                                                }
                                                                // AccountStatusDialog.show(context, 'deleted');
                                                              },
                                                              backgroundClr:
                                                                  clrBlacke,
                                                              child: controller
                                                                      .isLoadingLogin
                                                                      .value
                                                                  ? CommonUi
                                                                      .buttonLoading()
                                                                  : Text(
                                                                      "Next",
                                                                      style: TextStyle(
                                                                          color:
                                                                              clrWhite,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              16),
                                                                    )),
                                                    ),
                                                  );
                                                }),
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
                                                            "By login you accept our",
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
                                                SizedBox(
                                                  height: h * .025,
                                                ),
                                              ],
                                            ),
                                          ));
                                    }));
                              },
                              backgroundClr: clrYellow,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: clrBlacke,
                                    size: 22,
                                  ),
                                  SizedBox(
                                    width: h * .01,
                                  ),
                                  Text(
                                    "Log in with phone number",
                                    style: TextStyle(
                                        color: clrBlacke,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ],
                              ))),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Text(
                        "Or log in with",
                        style: TextStyle(color: clrWhite),
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.signInWithGoogle(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  color: clrWhite,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Image.asset(
                                "assets/icons/googleicon.png",
                                height: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w * 0.04,
                          ),
                          Platform.isIOS ? GestureDetector(
                            onTap: () {
                              controller.appleSignIn(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  color: clrWhite,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Image.asset(
                                "assets/icons/appleicon.png",
                                height: 18,
                              ),
                            ),
                          ) : SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
              controller.googleLoading.value || controller.appleLoading.value
                  ? CommonUi.scaffoldLoading(color: clrYellow)
                  : CommonUi.emptySizeBox(),
            ],
          ),
        ),
      ),
    );
  }
}


class AccountStatusDialog {
  static void show(BuildContext context, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // To fit the content
            children: [
              Text(
                'Your account has been $status for some unknown reason. Please contact support to resolve this issue.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // Space between text and button
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.contactSupport);
                },
                child: Text('Contact Support'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
