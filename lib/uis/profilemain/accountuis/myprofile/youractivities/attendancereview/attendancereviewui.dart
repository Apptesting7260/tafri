import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../components/custoelevatedbtn.dart';
import '../../../../../components/custofilterbtn.dart';

class AttendanceReviewUi extends GetWidget{
  const AttendanceReviewUi({super.key});

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
            margin: EdgeInsets.only(left: 13, bottom: 7, top: 7),
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
        title: Text(
          "Attendance review",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Please tell us who attended your activity.",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              Text(
                "We use this information to keep members accountable for attendance.",
                style: TextStyle(color: clrGreyTextLight,fontSize: 14,fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Container(
                                        height: h*.05,
                                        width: h*.05,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(100)),
                                        child: Image.asset(
                                          "assets/images/girldp.png",
                                          fit: BoxFit.cover,
                                        )),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Flexible(child: Text("Isabelle Wilson",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),))
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      alertRemove();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        color: clrBlacke,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: clrWhite,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        color: clrYellow,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: clrWhite,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.008,
                          ),
                          Divider(
                            color: clrGreyLight,
                            height: 8,
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
  alertRemove() {
    Future.delayed(Duration.zero,(){
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child:  Text(
                  "Are you sure?",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),

                SizedBox(
                height: Get.height*.013,
              ),
              Center(child: Text("Are you sure Geraldine couldn't make it? They'll be notified and charged with a no-show fee.",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),


                SizedBox(
                height: Get.height*.023,
              ),
              Row(
                  children: [
                    Expanded(child: SizedBox(
                      height: Res.h_btn,
                      child: CustoFilterBtn(borderClr: clrBlacke,lable: Text("Cancel",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),), ontap: (){
                        Get.back();
                        // alertCancelRequestConfirmation();
                      }, backgroundClr: Get.theme.scaffoldBackgroundColor),
                    )),
                    SizedBox(
                      width: Get.width*0.05,
                    ),
                    Expanded(child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                      Get.back();
                    }, backgroundClr: clrBlacke, child: Text("Yes, no-show",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),),


                  ]
              ),
                SizedBox(
                height:Get.height*.013,
              ),
            ],
          ),
        ),
      ));
    });
  }
}
