
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/explore/hostprofile/hostprofileui.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/activity/previousactivity/controller/previousacti_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/size.dart';

import '../../../../../../routes/routes.dart';
import '../../addactreviewui.dart';
import '../attendlist/attendlistui.dart';

class PreviousActivityUi extends GetWidget<PreviousActiController>{
  const PreviousActivityUi({super.key});

  // ExploreViewController exploreViewController=Get.put(ExploreViewController());
  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            children: [
                SizedBox(
                height: h*.012,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: h*.05,
                      height: h*.05,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: clrGreyLight,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(child: Icon(Icons.arrow_back_ios)),
                    ),
                  ),
                  const Expanded(child: Center(child: Text("Activity",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),))),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: 30,
                          height: 32,
                          decoration: BoxDecoration(
                            color: clrBlacke,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset("assets/icons/uploadicon.png",color: clrWhite,height: 20,width: 20,),//
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 20,
                        child: PopupMenuButton(

                          elevation: 5,
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 1,
                              child: Text("Report"),
                            )
                          ],
                          onSelected: (val) {
                            if (val == 1) {
                              // alertActivityReport();
                            }
                          },
                        ),
                      ),
                    ],
                  ),


                ],
              ),
              SizedBox(
                height: Get.height*0.01,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: h*.25,
                        child: Stack(
                          // clipBehavior: Clip.none,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  height:h*.25, viewportFraction: 1),
                              items: [1, 2, 3].map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        clipBehavior: Clip.hardEdge,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        height: double.maxFinite,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(18)),
                                        child: Image.asset(
                                          "assets/images/cofee.png",
                                          fit: BoxFit.cover,
                                          height: h*.25,
                                          width: double.maxFinite,
                                        ));
                                  },
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: clrWhite,
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: const Text("Coffee",style: TextStyle(fontWeight: FontWeight.w700),),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: clrWhite,
                                        borderRadius:
                                        BorderRadius.circular(100)),
                                    child: const Icon(
                                      Icons.favorite_border,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 7),
                                height: 16,
                                child: ListView.builder(
                                    itemCount: 3,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1.5),
                                        child: Icon(
                                          Icons.circle,
                                          color: clrWhite,
                                          size: 8,
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Picnic in the park",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                Text("Vondelpark",style: TextStyle(fontSize: 14,color:clrGreyDark,fontWeight: FontWeight.w500),),
                                Text("13 March 2024 | 2:30 PM - 6:00PM",style: TextStyle(fontSize: 14,color:clrGreyTextLight,fontWeight: FontWeight.w500),),
                                Text("Up to 3 people | 1 spot left",style: TextStyle(color: clrYellowText,fontSize: 14,fontWeight: FontWeight.w500),),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Get.toNamed(Routes.hostProfileUi);
                            },
                            child: Column(
                              children: [
                                Container(
                                    height: h*.055,
                                    width: h*.055,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(100)),
                                    child: Image.asset(
                                      "assets/images/girldp.png",
                                      fit: BoxFit.cover,
                                    )),
                                const Text("Jenny",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text("Hey guys! Looking to brighten up your morning? How about joining me for a coffee break at the local café around 10 AM? I'm extending an invite to three fellow coffee lovers to join the chat and caffeine boost. Let's turn strangers into friends over a cup of joe! Hope to see you there for a delightful break. ☕️👋",style: TextStyle(fontSize: 14,color:clrGreyTextLight),),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Going",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                          Get.arguments['isHost'] ==true? InkWell(onTap: (){
                            Get.toNamed(Routes.attendList);
                            
                          },child: Text("See All",style: TextStyle(color: clrYellow,fontWeight: FontWeight.w600,fontSize: 16),)):SizedBox(
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height*0.01,
                      ),
                      SizedBox(
                        height: h*.075,
                        child: ListView.builder(itemCount: 2,scrollDirection: Axis.horizontal,shrinkWrap: true,itemBuilder: (context,index){
                          return Container(
                            margin: const EdgeInsets.only(right: 5),
                            clipBehavior: Clip.hardEdge,
                            height: h*.075,
                            width: h*.075,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset("assets/images/cofee.png",fit: BoxFit.cover,),
                          ) ;
                        }),
                      ),
                      SizedBox(
                        height: Get.height*0.03,
                      ),
                      SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                        // Get.toNamed(Routes.adda);
                        Get.to((){
                          return const AddActReviewUi() ;
                        });
                      }, backgroundClr: clrBlacke, child: Text("Add review",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      const Text("Reviews",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                      SizedBox(
                        height: Get.height*0.01,
                      ),
                      ListView.builder(itemCount: 2,shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),itemBuilder: (context,index){
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    clipBehavior: Clip.hardEdge,
                                    height: h*.055,
                                    width: h*.055,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Image.asset("assets/images/cofee.png",fit: BoxFit.cover,),
                                  ),
                                  SizedBox(
                                    width: Get.width*0.01,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Jone Due",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                      RatingBar(
                                        // tapOnlyMode:true
                                        ignoreGestures: true,
                                        initialRating: 4.5,
                                        allowHalfRating: true,
                                        itemSize: 20,
                                        ratingWidget:RatingWidget(full: Icon(
                                          Icons.star,
                                          color: clrYellow,
                                          size: 20,
                                        ), half: Icon(
                                          Icons.star_half,
                                          color: clrYellow,
                                          size: 20,
                                        ),
                                          empty: Icon(
                                            Icons.star_border,
                                            color: clrYellow,
                                            size: 20,
                                          ),) , onRatingUpdate: (rating) {
                                        print(rating);
                                      },),
                                    ],
                                  )
                                ],
                              ),
                              Text("Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",style: TextStyle(color: clrGreyTextLight),)
                            ],
                          ),
                        ) ;
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
