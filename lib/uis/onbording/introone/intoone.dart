import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors.dart';
import 'controller/intro_controller.dart';


class IntroOneUi extends GetWidget<IntroController>{
    IntroOneUi({super.key});
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      resizeToAvoidBottomInset:false,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/onbordingone.jpg"),
            colorFilter:ColorFilter.mode(Colors.black26, BlendMode.darken),
            fit: BoxFit.cover,
          ), //colorFilter:ColorFilter.mode(clrBlacke.withOpacity(0.5), BlendMode.lighten)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  height:Res.h_btn,
                  child: CustoElevatedBtn(
                      onTap: () {
                        Get.bottomSheet(BottomSheet(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))),
                            enableDrag: false,
                            onClosing: () {},
                            builder: (context) {
                              return Obx(() =>  Opacity(
                                opacity: controller.loading.value ? 0.5 : 1,
                                child: Container(
                                    width: double.maxFinite,
                                    height: h*.47,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(vertical: 7),
                                              alignment: Alignment.center,
                                              height: h*.005,
                                              width: w*.12,
                                              decoration: BoxDecoration(
                                                  color: clrGrey,
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height*.03,
                                          ),
                                          const Text(
                                            "Sign Up",
                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                                          ),
                                          const Text(
                                            "We need your mobile number to verify your account.",
                                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: Get.height*.02,
                                          ),
                                          Form(
                                            key: _formKey,
                                            child: TextFormField(
                                              controller: controller.mobnoController,
                                              validator: (val){

                                                if( val== null || val.isEmpty){
                                                  debugPrint("=====error");
                                                  return "Mobile Number is required";
                                                }if(val.length <10){
                                                  return "Enter valid mobile number";
                                                }
                                                else{
                                                  return null;
                                                }
                                              },
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.digitsOnly
                                              ],
                                              decoration: InputDecoration(

                                                  hintText: "Mobile number",
                                                  hintStyle: const TextStyle(
                                                      fontWeight: FontWeight.w400,fontSize: 16),
                                                  contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 0),
                                                  filled: true,
                                                  fillColor: clrGreyLight,
                                                  prefixIcon:  CountryCodePicker(
                                                    textStyle: TextStyle(fontWeight: FontWeight.w700,fontSize: 15,color: clrBlacke),
                                                    onChanged: (code){
                                                      debugPrint("===${code.runtimeType}");
                                                      controller.changeCountryCode(code);
                                                    },
                                                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                    initialSelection: controller.initialSelection.value,
                                                    favorite: ['+39', 'FR'],
                                                    // optional. Shows only country name and flag
                                                    showCountryOnly: false,
                                                    // optional. Shows only country name and flag when popup is closed.
                                                    showOnlyCountryWhenClosed: false,
                                                    // optional. aligns the flag and the Text left
                                                    alignLeft: false,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                      borderRadius:
                                                      BorderRadius.circular(30))),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height*0.025,
                                          ),
                                          SizedBox(
                                              width: double.maxFinite,
                                              height:Res.h_btn,
                                              child: CustoElevatedBtn(
                                                onTap: () {
                                                  if(!controller.loading.value){
                                                    if(_formKey.currentState!.validate()){
                                                      controller.checkMobNoApi();
                                                    }
                                                  }
                                                },
                                                backgroundClr: clrBlacke,
                                                child: Obx(() => controller.loading.value ? CommonUi.fourDotLoading() : Text(
                                                  "Next",
                                                  style: TextStyle(color: clrWhite,fontWeight: FontWeight.w700,fontSize: 16),
                                                ),),)
                                          ),
                                          SizedBox(
                                            height:  Get.height*0.025,
                                          ),

                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                      "By registering you accept our",style: TextStyle(color: clrGreyDark,fontWeight: FontWeight.w300,fontSize: 12)),
                                                  TextSpan(
                                                      text: " Terms of Use",
                                                      style: TextStyle(color: clrYellowText,fontWeight: FontWeight.w300,fontSize: 12)),
                                                  TextSpan(text: " and",style: TextStyle(color: clrGreyDark,fontWeight: FontWeight.w300,fontSize: 12)),
                                                  TextSpan(
                                                      text: " Privacy Policy",
                                                      style: TextStyle(color: clrYellowText,fontWeight: FontWeight.w300,fontSize: 12)),
                                                ])),),
                                          SizedBox(
                                            height:h*0.04 ,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                      "Need Help? Contact ",style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w300,fontSize: 12)),
                                                  TextSpan(
                                                      text: "info@plusonesapp.com",
                                                      style: TextStyle(color: clrYellowText,fontWeight: FontWeight.w300,fontSize: 12)),
                                                ])),
                                          ),

                                        ],
                                      ),
                                    )),
                              ),);
                            }));
                      },
                      backgroundClr: clrYellow,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'Nunito')
                      ))),
              SizedBox(
                height: h*.014,
              ),
              SizedBox(
                  width: double.maxFinite,
                  height:  Res.h_btn,
                  child: CustoElevatedBtn(
                      onTap: () {
                        Get.toNamed(Routes.loginWithMobNo);
                      },
                      backgroundClr: clrWhite,
                      child: Text(
                        "Log in",
                        style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Nunito'),
                      ))),
              SizedBox(
                height: h*.06,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
