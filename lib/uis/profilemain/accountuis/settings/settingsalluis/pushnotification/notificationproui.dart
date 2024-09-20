import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/common.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/custom_switch.dart';
import '../../../../../../utils/size.dart';
import 'controller/pushnotisetting_controller.dart';

class NotificationProUi extends GetWidget<PushnotisettingController>{
  const NotificationProUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Text("Notifications",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.035,
              ),
              Expanded(
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Push notifications",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          Obx(() => CustomSwitch(
                              value: controller.notificationsVal.value == 1 ? true : false,
                              onChanged: (val){
                                controller.changenotificationsVal(
                                    controller.notificationsVal.value == 1 ? 0 : 1
                                );
                              }
                          ),),
                          // Container(height: 30,width: 40,child: FittedBox(fit: BoxFit.fill,child: Switch(activeTrackColor:clrYellow,value: true, onChanged: (val){},activeColor: clrWhite,focusColor: clrWhite,trackOutlineColor: WidgetStateProperty.all(clrTransparent))))
                        ],
                      ),
                      Divider(color: clrGreyLight,height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Email",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                          Obx(() => CustomSwitch(
                              value: controller.emailVal.value == 1 ? true : false,
                              onChanged: (val){
                                controller.changeemailVal(
                                    controller.emailVal.value == 1 ? 0 : 1
                                );
                              }
                          ),),
                          // Container(height: 30,width: 40,child: FittedBox(fit: BoxFit.fill,child: Switch(activeTrackColor:clrYellow,value: false, onChanged: (val){},activeColor: clrWhite,focusColor: clrWhite,inactiveThumbColor: clrWhite,trackOutlineColor: WidgetStateProperty.all(clrTransparent),)))
                        ],
                      ),
                      Divider(color: clrGreyLight,height: 25,),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}