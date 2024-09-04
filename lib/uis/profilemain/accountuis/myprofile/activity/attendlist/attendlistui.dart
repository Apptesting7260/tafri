import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/colors.dart';
import 'controller/attendlist_controller.dart';

class AttendListUi extends GetWidget<AttendlistController>{
  const AttendListUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leadingWidth: 55,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 13, bottom: 7, top: 7),
            clipBehavior: Clip.hardEdge,
            width: h*.04,
            height: h*.04,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
            decoration: BoxDecoration(
                color: clrGreyLight, borderRadius: BorderRadius.circular(10)),
            child: const Center(child: Icon(Icons.arrow_back_ios)),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Attendance list",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical:  h*.02,),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Container(
                                  height: h*.055,
                                  width:  h*.055,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(100)),
                                  child: Image.asset(
                                    "assets/images/girldp.png",
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                width: Get.width*0.02,
                              ),
                              const Flexible(child: Text("Isabelle Wilson",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),))
                            ],
                          ),
                        ),
                        index >=0? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                            color:index ==0?clrGreyLight: clrYellow,
                          ),
                          child: Row(
                            children: [
                              Image.asset(index ==0?"assets/icons/closecircle.png":"assets/icons/congratesicon.png",height: 13,color: clrBlacke,),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(index ==0?"Not joined":"Joined",style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w500,fontSize: 12),),
                            ],
                          ),
                        ):const SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: Get.height*0.008,
                    ),
                    Divider(
                      color: clrGreyLight,
                      height: 8,
                    ),
                    SizedBox(
                      height: Get.height*0.003,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
