import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/customexpension.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/profilemain/accountuis/helpcenter/controller/helpcenter_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/no_activity.dart';
import 'package:plusone/utils/size.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';

class HelpCenterUi extends GetWidget<HelpcenterController>{
  HelpCenterUi({super.key});
  bool isOpen=false;
  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
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
                Obx(() => controller.activityLoading.value
                    ? Expanded(child: Center(child: CommonUi.scaffoldLoading(color: clrYellow)))
                    : controller.attError.value.isNotEmpty
                    ? Expanded(child: Center(child: ErrorScreen()))
                    : controller.helpData.value.result == null
                    ? Expanded(child: Center(child: NoActivityScreen()))
                    : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                          SizedBox(
                          height: Res.h_btn,
                          child: CustoTextFormField(
                            sufixIcon: Icon(Icons.search),
                            hintText: "Search",
                            onChanged: (val){
                              controller.searchQuery.value = val;
                              controller.filterHelpData();
                            },
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        const Text("FAQs",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: controller.filteredHelpData.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = controller.filteredHelpData[index];
                              return CustomExpansionWidget(
                                  title: Text(
                                    item.name.toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  body: Text(
                                      item.description.toString(),
                                      style: TextStyle(fontSize: 15)
                                  )
                              );
                            }, separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 20,);
                          },),
                        ),
                        SizedBox(
                          height: Get.height * 0.013,
                        ),
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
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        content: Column(
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
            SizedBox(
              height: 5,
            ),
            Center(
              child: Image.asset(
                "assets/icons/msgcustosupport.png",
                height:Get.height*.085,
              ),
            ),
              SizedBox(
              height:Get.height*.015,
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
              height: Get.height*.015,
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Or email us at",style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w500)),
                  InkWell(onTap: (){},child: Text(" info@plusonesapp.com",style: TextStyle(color: darkYellow,fontWeight: FontWeight.w600),),)
                ],
              ),
            ),
            // Center(
            //   child: RichText(
            //       textAlign: TextAlign.center,
            //       text: TextSpan(
            //           children: [
            //             TextSpan(text: "Or email us at",style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w500)),
            //             WidgetSpan(child: InkWell(onTap: (){},child: Text(" info@plusonesapp.com",style: TextStyle(color: clrYellowText,fontWeight: FontWeight.w500),),))
            //           ]
            //       )),
            // ),
            const SizedBox(
              height: 30,
            ),

          ],
        )));
  }
}
