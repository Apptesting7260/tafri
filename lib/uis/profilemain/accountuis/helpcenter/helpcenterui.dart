import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/customexpension.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';

class HelpCenterUi extends GetWidget{
  HelpCenterUi({super.key});
  bool isOpen=false;
  List listExpension=[
    {'isOpen':false},
    {'isOpen':false},
    {'isOpen':false},
    {'isOpen':false},
    {'isOpen':false},
    {'isOpen':false},
    {'isOpen':false},
  ];
  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonUi.appBar(),
                    const Text("Help center",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
                      SizedBox(
                      width: h*.025,
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                          SizedBox(
                          height: Res.h_btn,
                          child: const CustoTextFormField(sufixIcon: Icon(Icons.search),hintText: "Search",),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        const Text("FAQs",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),

                        const CustomExpansionWidget(title: Text("What is Plus Ones? ",style: TextStyle(fontSize: 15),), body: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.",style: TextStyle(fontSize: 15))),
                        SizedBox(
                          height: Get.height * 0.013,
                        ),
                        const CustomExpansionWidget(title: Text("Can you explain your membership? ",style: TextStyle(fontSize: 15)), body: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.",style: TextStyle(fontSize: 15))),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: double.maxFinite,
                    height: Res.h_btn,
                    child: CustomElevatedButton(child: Text("Contact Support",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),), onTap: (){
                      custoSupportAlert();
                    }, backgroundClr: clrBlacke),
                  ),
                ),
              ],
            ),
          )),
    );
  }
  custoSupportAlert() async {
    Get.dialog(AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        content: SizedBox(
          width: Get.width * 0.87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 35,
                  )),
              Center(
                child: Image.asset(
                  "assets/icons/msgcustosupport.png",
                  height:Get.height*.085,
                ),
              ),
                SizedBox(
                height:Get.height*.012,
              ),
              SizedBox(
                width: double.maxFinite,
                height: Res.h_btn,
                child: CustomElevatedButton(onTap: () {
                  Get.toNamed(Routes.poSupportChat);
                },
                  backgroundClr: clrBlacke,
                  child: Text("Chat with support",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),),),
              ),
                SizedBox(
                height: Get.height*.012,
              ),
              Center(
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                          TextSpan(text: "Or email us at",style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w500)),
                          WidgetSpan(child: InkWell(onTap: (){},child: Text(" info@plusonesapp.com",style: TextStyle(color: clrYellowText,fontWeight: FontWeight.w500),),))
                        ]
                    )),
              ),
              const SizedBox(
                height: 10,
              ),

            ],
          ),
        )));
  }
}
