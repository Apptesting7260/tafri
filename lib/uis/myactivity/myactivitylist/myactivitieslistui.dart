import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/myactivity/myactivitylist/controller/myacti_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/size.dart';

class  MyActivitiesListUi extends GetWidget<MyactiController>{
  const MyActivitiesListUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("My Activities",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
              ),
              SizedBox(
                height: Get.height * 0.004,
              ),
              TabBar(
                tabAlignment: TabAlignment.start,
                indicatorColor: clrYellow,
                dividerHeight: 0,
                isScrollable: true,
                unselectedLabelColor:clrBlacke,
                labelColor:clrYellow,
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                labelStyle: const TextStyle(fontWeight: FontWeight.w800,fontSize: 18),
                tabs: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 9),
                    child: Text(
                      "Attending",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 9),
                    child: Text("Hosting"),
                  )
                ],
                controller: controller.tabController,
              ),
              Flexible(
                child: Container(
                  padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Expanded(
                        child: TabBarView(controller: controller.tabController, children: [
                          ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Upcoming activities",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),

                              ListView.builder(itemCount: 2,physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder: (context,index){
                                return InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.upcommingUserActiUi);
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
                                        Text("25 May",style: TextStyle(color: clrGreyDark),),
                                        SizedBox(
                                          height: Get.height*0.003,
                                        ),
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
                                                    const Text("Padel with Joris",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                                    Text("Padel next, 1055 AH, Amsterdam ",style: TextStyle(color: clrGreyDark,fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),

                              const Text("Previous activities",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),

                              ListView.builder(itemCount: 2,physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder: (context,index){
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
                                        Text("25 May",style: TextStyle(color: clrGreyDark),),
                                        SizedBox(
                                          height: Get.height*0.003,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        const Text("Padel with Joris",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                                        Text("Completed",style: TextStyle(color: clrGreyDark,fontSize: 12)),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 3),
                                                          child: Row(
                                                            children: [
                                                              Flexible(child: Text("Rate and review your activity",style: TextStyle(color: clrYellowText,fontSize: 12,fontWeight: FontWeight.w600))),
                                                              SizedBox(
                                                                width: w*.00,
                                                              ),
                                                              Icon(Icons.arrow_right,size: 18,color: clrYellowText,)
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                             SizedBox(
                                              height: h*.008,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  clipBehavior: Clip.hardEdge,
                                                  height: 57,
                                                  width: 57,
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
                                                        const Text("Padel with Joris",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                                        Text("Cancelled",style: TextStyle(color: clrGreyDark,fontSize: 12)),
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
                              })
                            ],
                          ),
//////////////////////////////Upcoming activities(for host )
                          ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Upcoming activities",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),

                              ListView.builder(itemCount: 2,physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder: (context,index){
                                return InkWell(
                                  onTap: (){
                                    Get.toNamed(Routes.hostUpcommingActiview);
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
                                        Text("25 May",style: TextStyle(color: clrGreyDark),),
                                        SizedBox(
                                          height: Get.height*0.003,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              clipBehavior: Clip.hardEdge,
                                              height:h*.075,
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
                                                    const Text("Padel with Joris",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                                    Text("Padel next, 1055 AH, Amsterdam ",style: TextStyle(color: clrGreyDark,fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),

                              const Text("Previous activities",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),

                              ListView.builder(itemCount: 2,physics: const NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder: (context,index){
                                return InkWell(
                                  onTap: (){

                                    Get.toNamed(Routes.previousActivityUi,arguments: {"isHost":true});

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
                                        Text("25 May",style: TextStyle(color: clrGreyDark),),
                                        SizedBox(
                                          height: Get.height*0.003,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  const Text("Padel with Joris",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                                                  Text("Completed",style: TextStyle(color: clrGreyDark,fontSize: 12)),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 23,
                                                              child: CustoElevatedBtn(onTap: (){}, backgroundClr: clrGreyLight,padhor: 10, child: Row(children: [
                                                                Image.asset("assets/icons/repeaticon.png",height: 10,),
                                                                const SizedBox(width: 2,),
                                                                Text("Repeat",style: TextStyle(color: clrBlacke,fontSize: 10))
                                                              ],)),
                                                            )

                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 3),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Flexible(child: Text("Confirm attendance",style: TextStyle(color: clrYellowText,fontSize: 12,fontWeight: FontWeight.w600))),

                                                              Icon(Icons.arrow_right,size: 18,color: clrYellowText,)
                                                            ],
                                                          ),
                                                        ),
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
                                                        const Text("Padel with Joris",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                                        Text("Cancelled",style: TextStyle(color: clrGreyDark,fontSize: 12)),
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
                              })
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}