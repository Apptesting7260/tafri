import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';

class ViewNotiUi extends GetWidget{
  const ViewNotiUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: const Text(
                      "Dear Emma Due,\n \nWe noticed that you were unable to attend a recent activity. To ensure activities hosted by our users remain top-notch and enjoyable for everyone, we have a policy that includes a cancellation fee of [Fee Amount].\n Your understanding and cooperation help us maintain the high quality of our activities and ensure a great experience for everyone joining or hosting\n Thank you for being a part of our community! \n\n Best regards, Team PlusOnes"),
                ),
              ],
            ),
          )),
    );
  }
}
