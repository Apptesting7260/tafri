import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/explore/filter/explorefilterui.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/size.dart';
import 'package:readmore/readmore.dart';

class MapActivityUi extends GetWidget{
  const MapActivityUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        height: Res.h_btn,
                        width: Get.width * 0.75,
                        child: const CustoTextFormField(
                          hintText: "Any activity ",
                          sufixIcon: Icon(Icons.search),
                        )),
                     SizedBox(
                      width: w*.03,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.filterExploreUi);
                        // Get.to(() {
                        //   return  ExploreFilterUi();
                        // });
                      },
                      child: Container(
                        height: h*0.057,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: clrBlacke),
                        child: Image.asset("assets/icons/filtericon.png"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                  onTap: () {
                    Get.bottomSheet(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
                        DraggableScrollableSheet(
                            initialChildSize: 0.5,
                            minChildSize: 0.0,
                            maxChildSize: 1,
                            // elevation: 0,
                            //   onClosing: () {},
                            builder: (context,scrollController) {
                              return SingleChildScrollView(
                                controller: scrollController,
                                child: Container(
                                  // clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      color: clrWhite,
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                  ),
                                  child: Column(mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: Get.width*0.2,
                                          padding:const EdgeInsets.symmetric(vertical: 2),
                                          margin:const EdgeInsets.symmetric(vertical: 5),
                                          decoration: BoxDecoration(
                                              color: clrGreyLight,
                                              borderRadius: BorderRadius.circular(20)
                                          ),

                                        ),
                                      ),
                                      Container(
                                        margin:
                                        const EdgeInsets.symmetric(horizontal: 13),
                                        child:  ListView.builder(
                                            itemCount: 5,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
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
                                                                    child: Container(
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
                                                                Text(
                                                                  "Vondelpark",
                                                                  style: TextStyle(
                                                                      color: clrGreyDark),
                                                                ),
                                                                Text(
                                                                  "13 March 2024 | 2:30 PM - 6:00PM",
                                                                  style: TextStyle(
                                                                      color: clrGreyDark),
                                                                ),
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
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }));
                  },
                  child: Image.asset("assets/images/map.png"))
            ],
          )),
    );
  }
}
