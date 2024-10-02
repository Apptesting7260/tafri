import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/message/viewnotification/controller/viewnotifi_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../utils/colors.dart';

class ViewNotiUi extends GetWidget<ViewNotifiController>{
  const ViewNotiUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonUi.appBar(),
                    const Text("PlusOnes",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                     SizedBox(
                      width: w*.07,
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: clrGreyLight),
                  child: Text(
                      "${controller.message.value}\n \nThank you for being a part of our community! \n\nBest regards, Team PlusOnes"),
                ),
              ],
            ),
          )),
    );
  }
}
