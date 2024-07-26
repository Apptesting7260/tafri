import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/colors.dart';

class ActivityVisibility extends GetWidget{
  const ActivityVisibility({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: clrGreyLight,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(child: Icon(Icons.arrow_back_ios)),
                    ),
                  ),
                  const Text("Activities visibility",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Expanded(
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(child: Text("Show my upcoming activities to other members",style: TextStyle(fontSize: 16),)),
                          SizedBox(height: 30,width: 40,child: FittedBox(fit: BoxFit.fill,child: Switch(activeTrackColor:clrYellow,value: true, onChanged: (val){},activeColor: clrWhite,focusColor: clrWhite,trackOutlineColor: WidgetStateProperty.all(clrTransparent))))
                        ],
                      ),
                      Divider(color: clrGreyLight,height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(child: Text("Show my previous activities to other members",style: TextStyle(fontSize: 16),)),
                          SizedBox(height: 30,width: 40,child: FittedBox(fit: BoxFit.fill,child: Switch(activeTrackColor:clrYellow,value: false, onChanged: (val){},activeColor: clrWhite,focusColor: clrWhite,inactiveThumbColor: clrWhite,trackOutlineColor: WidgetStateProperty.all(clrTransparent),)))
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
