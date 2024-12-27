import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/message/viewnotification/controller/viewnotifi_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:shimmer/shimmer.dart';
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
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: clrGreyLight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.actTitle.value == 'null' || controller.actImg.value == 'null' || controller.actTitle.value == 'null' ? SizedBox() : GestureDetector(
                        onTap: () {

                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: '${controller.actImg.value}',
                                height: 70,
                                width: 120,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        height: 70,
                                        width: 120,
                                        color: clrGrey,
                                      ),
                                    )),
                                errorWidget: (context, url, error) => Container(
                                  height: 70,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: clrBlacke.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Icon(Icons.image_not_supported_outlined),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text('${controller.actTitle.value}',style: TextStyle(
                              color: clrBlacke,
                              fontWeight: FontWeight.w700
                            ),)
                          ],
                        ),
                      ),
                      controller.actTitle.value == 'null' || controller.actImg.value == 'null' || controller.actTitle.value == 'null' ? SizedBox() :const SizedBox(height: 10,),
                      controller.actTitle.value == 'null' || controller.actImg.value == 'null' || controller.actTitle.value == 'null' ? SizedBox() :const Divider(),
                      controller.actTitle.value == 'null' || controller.actImg.value == 'null' || controller.actTitle.value == 'null' ? SizedBox() :const SizedBox(height: 10,),

                      GestureDetector(
                        onTap: (){
                          if(controller.userID.value != '0') {
                            Get.toNamed(Routes.userProfileui,
                                arguments: controller.userID.value);
                          }
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(100),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: '${controller.userImg.value}',fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(
                              height: 40,
                              width: 40,
                              color: clrWhite,
                              child: Image.asset(
                                'assets/icons/manicon.png',
                                color: clrGrey,
                                scale: 1.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(
                          "${controller.message.value}\n "),
                      const Text("Thank you for being a part of our community! \n\nBest regards, Team PlusOnes")
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
