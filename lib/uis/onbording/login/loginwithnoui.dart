
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

class LoginWithNoUi extends GetWidget<LoginnoController>{
   LoginWithNoUi({super.key});
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
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
          padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
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
                        Text("One",
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
                  child: CustoElevatedBtn(
                      onTap: () {
                        Get.bottomSheet(BottomSheet(
                            enableDrag: false,
                            onClosing: () {},
                            builder: (context) {
                              return Container(
                                  width: double.maxFinite,
                                  height: h*.45,
                                  padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
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
                                          "Log in",
                                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: Get.height*.01,
                                        ),
                                         Text(
                                          "We need your phone number to verify your account",
                                          style: TextStyle(fontSize: 14,color: clrGreyDark),
                                        ),
                                        SizedBox(
                                          height: h*.025,
                                        ),
                                        Form(
                                          key:_formKey ,
                                          child: TextFormField(
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
                                            controller: controller.mobNoCon,
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
                                                  onChanged: (code){
                                                    debugPrint("===${code.runtimeType}");
                                                    controller.changeCountryCode(code);
                                                  },
                                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                  initialSelection: controller.initialSelection.value,
                                                  favorite: ['+91','+39', 'FR'],
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
                                          height: h*.025,
                                        ),
                                       Obx((){
                                         return  Opacity(
                                           opacity: controller.isLoadingLogin.value?0.5:1
                                           ,
                                           child: SizedBox(
                                             width: double.maxFinite,
                                             height: Res.h_btn,
                                             child: CustoElevatedBtn(
                                                 onTap: () {
                                                   if(!controller.isLoadingLogin.value){
                                                      if(_formKey.currentState!.validate()){
                                                        controller.loginApi();
                                                      }
                                                   }

                                                 },
                                                 backgroundClr: clrBlacke,
                                                 child:controller.isLoadingLogin.value?CommonUi.fourDotLoading(): Text(
                                                   "Next",
                                                   style: TextStyle(color: clrWhite,fontWeight: FontWeight.w700,fontSize: 16),
                                                 )),
                                           ),
                                         );
                                       }),
                                         SizedBox(
                                          height: h*.025,
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
                          Icon(Icons.call,color: clrBlacke,size: 22,),
                           SizedBox(
                            width: h*.01,
                          ),
                          Text(
                            "Log in with phone number",
                            style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w600,fontSize: 16),
                          ),
                        ],
                      ))),
              SizedBox(
                height: Get.height * 0.015,
              ),
              Text("Or log in with",style: TextStyle(color: clrWhite),),
              SizedBox(
                height: Get.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(color: clrWhite,borderRadius: BorderRadius.circular(100)),
                    child: Image.asset("assets/icons/googleicon.png",height: 18,),
                  ),
                   SizedBox(
                    width: w*0.04,
                  ),
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(color: clrWhite,borderRadius: BorderRadius.circular(100)),
                    child: Image.asset("assets/icons/appleicon.png",height: 18,),
                  ),

                ],
              ),
              SizedBox(
                height:  Get.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}