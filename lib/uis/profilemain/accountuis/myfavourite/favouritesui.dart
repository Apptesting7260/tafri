import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/common.dart';
import 'package:readmore/readmore.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/size.dart';
import '../../../explore/exploreview/exploreviewui.dart';

class FavouriteListUi extends GetWidget{
  const FavouriteListUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
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
                  const Text("My favorites",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.015,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.exploreView);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                height: h*.25,
                                child: Stack(
                                  // clipBehavior: Clip.none,
                                  children: [
                                    CarouselSlider(
                                      options: CarouselOptions(
                                          height: h*.25, viewportFraction: 1),
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
                                            child: const Text("Coffee",style: TextStyle(fontWeight: FontWeight.w600),),
                                          ),
                                          InkWell(
                                            onTap: () {

                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                  color: clrWhite,
                                                  borderRadius:
                                                  BorderRadius.circular(100)),
                                              child: Icon(
                                                Icons.favorite,
                                                color: clrYellow,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 7),
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
                                                  color:index==0?clrYellow: clrWhite,
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Picnic in the park",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          "Vondelpark",
                                          style: TextStyle(
                                              color: clrGreyDark),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          "13 March 2024 | 2:30 PM - 6:00PM",
                                          style: TextStyle(
                                              color: clrGreyDark),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          "Up to 3 people | 1 spot left",
                                          style: TextStyle(
                                              color: clrYellowText, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
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
                                      const Text("Jenny",style: TextStyle(fontWeight: FontWeight.w700),)
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              ReadMoreText(
                                "Hey guys! Looking for 2 others who would like to join me for a picnic in the park today ,we all do games and dinner",
                                style: TextStyle(color: clrGreyDark),
                                trimMode: TrimMode.Line,
                                trimLines: 2,
                                colorClickableText: Colors.pink,
                                trimCollapsedText: 'Learn more',
                                trimExpandedText: 'Learn less',
                                moreStyle:
                                TextStyle(color: clrBlacke,fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}