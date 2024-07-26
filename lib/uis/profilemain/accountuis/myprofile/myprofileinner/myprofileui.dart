import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/utils/size.dart';
import '../../../../../utils/colors.dart';
import 'controller/myprofileinn_controller.dart';

class MyProfileUi extends GetWidget<MyprofileInnController>{
  const MyProfileUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
            child: Column(
              children: [
                  SizedBox(
                  height:h*.007,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width:h*.05,
                        height:h*.05,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: clrGreyLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(child: Icon(Icons.arrow_back_ios)),
                      ),
                    ),
                    const Text(
                      "My profile",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                      SizedBox(
                      width: w*.1,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height*0.01,
                ),
                TabBar(
                  indicatorColor: clrYellow,
                  dividerHeight: 0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: clrBlacke,
                  labelColor: clrYellow,
                  labelStyle:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                  tabs: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 9),
                      child: Text(
                        "Edit",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 9),
                      child: Text("View"),
                    )
                  ],
                  controller: controller.tabController,
                ),
                Expanded(child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: h*.03,
                                ),
                                SizedBox(
                                  child: Center(
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height:h*.135,
                                              width:h*.135,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: clrGreyLight
                                              ),
                                              child: Image.asset("assets/icons/manicon.png",color: clrGrey,),
                                            ),
                                              SizedBox(height:h*.02,)
                                          ],
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min
                                            ,
                                            children: [
                                                SizedBox(
                                                width: w*.04,
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  Get.toNamed(Routes.addPhotoProUi);
                            
                                                },
                                                child: Container(
                                                  // height: 100,
                                                  // width: 100,
                                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: clrYellow
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min
                                                    ,
                                                    children: [
                                                      Icon(Icons.camera_alt,color: clrWhite,),
                                                      const SizedBox(width: 5,),
                                                      Text("Add",style: TextStyle(color: clrWhite),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5,),
                                              Image.asset("assets/icons/dangericon.png",height: 23,),
                            
                                            ],
                                          ),
                                        ),
                            
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height*.03
                                  ,
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.bioUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Bio",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                            Text("Add a short bio (Optional)",style: TextStyle(fontSize: 13,color: clrGreyTextLight),),
                                          ],
                                        )),
                                          SizedBox(
                                          width: w*.05,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset("assets/icons/dangericon.png",height: 25,),
                                              SizedBox(
                                              width: w*.01,
                                            ),
                                            const Icon(Icons.arrow_right,size: 30,)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height*.013,
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.locationProUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Location",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                            Text("Amsterdam, Netherlands",style: TextStyle(fontSize: 13,color: clrGreyTextLight),),
                                          ],
                                        )),
                                          SizedBox(
                                          width: w*.05,
                                        ),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Image.asset("assets/icons/dangericon.png",height: 25,),
                                            // SizedBox(
                                            //   width: 5,
                                            // ),
                                            Icon(Icons.arrow_right,size: 30,)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height*.013,
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.occupationProUi);
                            
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Occupation",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                            Text("Add your occupation",style: TextStyle(fontSize: 13,color: clrGreyTextLight),),
                                          ],
                                        )),
                                          SizedBox(
                                          width:  w*.05,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset("assets/icons/dangericon.png",height: 25,),
                                              SizedBox(
                                              width:w*.01,
                                            ),
                                            const Icon(Icons.arrow_right,size: 30,)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height*.013,
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.languageProUi);
                            
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Languages",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                            Text("Select languages you speak",style: TextStyle(fontSize: 13,color: clrGreyTextLight),),
                                          ],
                                        )),
                                          SizedBox(
                                          width:  w*.05,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset("assets/icons/dangericon.png",height: 25,),
                                              SizedBox(
                                              width: w*.01,
                                            ),
                                            const Icon(Icons.arrow_right,size: 30,)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height*.013,
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.activityInterestUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Activity interests",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                            Text("Add 3-10 activities",style: TextStyle(fontSize: 13,color: clrGreyTextLight),),
                                          ],
                                        )),
                                          SizedBox(
                                          width:  w*.05,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset("assets/icons/dangericon.png",height: 25,),
                                              SizedBox(
                                              width: w*.01,
                                            ),
                                            const Icon(Icons.arrow_right,size: 30,)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height*.013,
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.funfactProUi);
                            
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Fun facts about me ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                            Text("Select 1-3 questions",style: TextStyle(fontSize: 13,color: clrGreyTextLight),),
                                          ],
                                        )),
                                          SizedBox(
                                          width: w*.05,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset("assets/icons/dangericon.png",height: 25,),
                                              SizedBox(
                                              width:w*.01,
                                            ),
                                            const Icon(Icons.arrow_right,size: 30,)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height*.013,
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.verifySocialMedProUi);
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrGreyLight
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Verify your social media",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                            Text("Click to verify (Optional)",style: TextStyle(fontSize: 13,color: clrGreyTextLight),),
                                          ],
                                        )),
                                          SizedBox(
                                          width:  w*.05,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset("assets/icons/dangericon.png",height: 25,),
                                              SizedBox(
                                              width: w*.01,
                                            ),
                                            const Icon(Icons.arrow_right,size: 30,)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height*.03,
                                ),
                               
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Res.h_btn,
                            width: double.maxFinite,
                            child: CustoElevatedBtn(onTap: (){}, backgroundClr: clrBlacke, child: Text("Save",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),)),
                          ),
                          SizedBox(
                            height: Get.height*.015,
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                            Center(
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                height: h*.11,
                                width: h*.11,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: const DecorationImage(
                                        image: AssetImage("assets/images/proimg.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Kayla",
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(onTap: (){
                                  verificationAlert();
                                },child: Icon(Icons.verified,color: clrYellow,))
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.007,
                            ),
                            Center(child: Text("25 years old | She/Her",style: TextStyle(color: clrGreyTextLight,fontSize: 13),)),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal:12,vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: clrGreyLight
                                    ),
                                    child: Column(
                                      children: [
                                        Text("100%",style: TextStyle(color: clrYellowText.withOpacity(0.8),fontSize: 22,fontWeight: FontWeight.w700),),
                                        const Text("Attendance Rate",textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width*0.02,
                                ),
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal:12,vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: clrGreyLight
                                    ),
                                    child: Column(
                                      children: [
                                        Text("20",style: TextStyle(color: clrYellowText.withOpacity(0.8),fontSize: 22,fontWeight: FontWeight.w700),),
                                        const Text("Activities Joined",textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
                                      ],
                                    ),
                                  ),
                                ),


                                SizedBox(
                                  width: Get.width*0.02,
                                ),
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal:12,vertical: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: clrGreyLight
                                    ),
                                    child: Column(
                                      children: [
                                        Text("25",style: TextStyle(color: clrYellowText.withOpacity(0.8),fontSize: 20,fontWeight: FontWeight.w700),),
                                        const Text("Activities Hosted",textAlign: TextAlign.center,style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height*0.01,
                            ),
                            Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(horizontal:12,vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: clrGreyLight
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Bio",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                  Text("Hi, I’m Kayla! I love exploring local cafes and meeting new people in the neighborhood. Whether it’s chatting over coffee, discovering new places, or planning community events, I’m always up for a good conversation. Looking forward to connecting with you! ☕️👋",style: TextStyle(color: clrGreyTextLight)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height*0.01,
                            ),
                            Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(horizontal:12,vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: clrGreyLight
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Location",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                  Text("Amsterdam, Netherlands",style: TextStyle(color: clrGreyTextLight)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height*0.01,
                            ),
                            Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(horizontal:12,vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: clrGreyLight
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Job",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                  Text("Creative Strategist at YouTube",style: TextStyle(color: clrGreyTextLight)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height*0.01,
                            ),
                            Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(horizontal:12,vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: clrGreyLight
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Languages",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 16),),
                                    SizedBox(
                                    height: h*.007,
                                  ),
                                  Wrap(
                                    spacing: w*.02,
                                    runSpacing: h*.01,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: clrWhite
                                        ),
                                        child: const Text("English"),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: clrWhite
                                        ),
                                        child: const Text("Spanish"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height*0.01,
                            ),
                            Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(horizontal:12,vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: clrGreyLight
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Interests",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 16),),
                                    SizedBox(
                                    height: h*.008,
                                  ),
                                  Wrap(
                                    spacing: w*.02,
                                    runSpacing: h*.01,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: clrWhite
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset("assets/icons/cycleicon.png",height: 20,),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Text("Cycling"),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: clrWhite
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset("assets/icons/dinner.png",height: 20,),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Text("Dining out"),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: clrWhite
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset("assets/icons/languagetrn.png",height: 20,),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Text("Language exchange"),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: clrWhite
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset("assets/icons/dinner.png",height: 20,),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Text("Dining out"),
                                          ],
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height*0.01,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal:12,vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: clrGreyLight
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Fun facts about Emma",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                                  const Text("Are you a morning person or night owl?",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                                  Text("I'm both! Whether it's sunrise or midnight, I'm always ready to roll.",style: TextStyle(color: clrGreyTextLight)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height*0.015,
                            ),
                            const Text("Upcoming activities",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 16),),
                            SizedBox(
                              height: Get.height*0.015,
                            ),
                            ListView.builder(itemCount: 2,physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder: (context,index){
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: clrGreyLight
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("25 May",style: TextStyle(color: clrGreyDark),),
                                    SizedBox(
                                      height: Get.height*0.003,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          clipBehavior: Clip.hardEdge,
                                          height:h*.075,
                                          width:h*.075,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Image.asset("assets/images/parkimage.png",fit: BoxFit.cover,),
                                        ),
                                        SizedBox(
                                          width: Get.width*0.02,
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                            decoration: BoxDecoration(
                                                color: clrWhite,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text("10KM Vondelpark run",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                                Text("Padel next, 1055 AH, Amsterdam ",style: TextStyle(color: clrGreyDark,fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                            SizedBox(
                              height: Get.height*0.015,
                            ),
                            const Text("Previous activities",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                            SizedBox(
                              height: Get.height*0.015,
                            ),
                            ListView.builder(itemCount: 1,physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){
                                  Get.toNamed(Routes.previousActivityUi,arguments: {"isHost":false});
                                }, 
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: clrGreyLight
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("20 May",style: TextStyle(color: clrGreyDark),),
                                      SizedBox(
                                        height: Get.height*0.003,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                clipBehavior: Clip.hardEdge,
                                                height: h*.075,
                                                width: h*.075,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Image.asset("assets/images/parkimage.png",fit: BoxFit.cover,),
                                              ),
                                              SizedBox(
                                                width: Get.width*0.02,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                  decoration: BoxDecoration(
                                                      color: clrWhite,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text("Salsa night at Tulp",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                                      Text("Confirm attendance",style: TextStyle(color: clrYellowText,fontSize: 12)),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                clipBehavior: Clip.hardEdge,
                                                height:h*.075,
                                                width: h*.075,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Image.asset("assets/images/cofee.png",fit: BoxFit.cover,),
                                              ),
                                              SizedBox(
                                                width: Get.width*0.02,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                  decoration: BoxDecoration(
                                                      color: clrWhite,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text("Sunday morning coffee",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                                      Text("Caffenation, Amsterdam",style: TextStyle(color: clrGreyDark,fontSize: 12)),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            SizedBox(
                              height: Get.height*0.02,
                            ),
                          ],
                        ),
                      ),
                    ]))
              ],
            ),
          )),
    );
  }


  verificationAlert(){
    return Get.dialog(AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 65),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(onTap: (){
            return Get.back() ;
          },child: const Icon(Icons.close,size: 25,)),
            SizedBox(
            height:Get.height*.013,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Icon(Icons.verified,color: clrYellow,size: 40,),
            ),
          ),
            Center(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
            child: const Text("Social media account verified",textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
          ),),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }
}
