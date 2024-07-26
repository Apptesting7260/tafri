import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/size.dart';
import 'package:readmore/readmore.dart';
import 'controller/explorelist_controller.dart';

class ExploreUi extends GetWidget<ExploreListController>{
  const ExploreUi({super.key});
// var controller= Get.put(ExploreController());
  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: h*0.070,
          padding: const EdgeInsets.only(bottom: 20),
          child: CustoElevatedBtn(
              padhor: 10,
              onTap: () {
                Get.toNamed(Routes.mapActivityUi);
              },
              backgroundClr: clrWhite,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/mapbtnicon.png",
                    height: 15,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Map",
                    style: TextStyle(color: clrBlacke,fontWeight: FontWeight.w600),
                  )
                ],
              )),
        ),
      ),
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                          height: Res.h_btn,
                          width: Get.width * 0.76,
                          child: const CustoTextFormField(
                            hintText: "Anywhere • any week",
                            sufixIcon: Icon(Icons.search),
                          )),
                    ),
                     SizedBox(
                      width: w*.01,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.filterExploreUi);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        margin:  EdgeInsets.only(bottom:h*.006 ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: clrBlacke),
                        child: Image.asset("assets/icons/filtericon.png",height: w*.07,),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              SizedBox(
                height: h*.048,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: Res.Defalt_side_margin),
                    itemCount: 7,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 7),
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        height: h*.035,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: index == 1 ? clrBlacke : clrGreyLight),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: h*.032,
                              width: h*.032,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: clrWhite),
                              child: Image.asset(index==1?"assets/icons/artsicon.png":index==2?"assets/icons/learningicon.png":
                              "assets/icons/sportsicon.png",
                                color: clrBlacke,
                              ),
                            ),
                             SizedBox(
                              width: w*0.015,
                            ),
                            Text(
                              index==1? "Arts":index==2? "Learning":"Sports",
                              style: TextStyle(
                                  color: index != 1 ? clrBlacke : clrWhite,fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: w*0.015,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Expanded(
                child: Obx((){
                  return Container(
                    margin:  EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                    child: ListView.builder(
                        itemCount: controller.exploreListData.value.length??0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Map singelDeta=controller.exploreListData.value[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.exploreView);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: h*.25,
                                    child: Stack(
                                      // clipBehavior: Clip.none,
                                      children: [
                                        CarouselSlider(
                                          options: CarouselOptions(
                                              height: h*.25, viewportFraction: 1,
                                          onPageChanged: (currIndex,CarouselPageChangedReason reason){
                                                controller.changeIndicator(index,currIndex);
                                            debugPrint(" currIndex $currIndex reason=$reason");

                                          }
                                          ),
                                          items: singelDeta['img'].map<Widget>((i) {
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
                                                      "$i",
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
                                                child:Text( singelDeta['lable'],style: const TextStyle(fontWeight: FontWeight.w600),),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  controller.changeFav(index);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                      color: clrWhite,
                                                      borderRadius:
                                                      BorderRadius.circular(100)),
                                                  child:singelDeta['isFav']?Icon(Icons.favorite,size: 20,color: clrYellow,) :const Icon(
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
                                            margin: const EdgeInsets.only(bottom: 7),
                                            height: 16,
                                            child: ListView.builder(
                                                itemCount:  singelDeta['img'].length??0,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 1.5),
                                                    child: Icon(
                                                      Icons.circle,color:singelDeta['currentCroIndex']==index?clrYellow: clrWhite,
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
                                              Text(
                                              singelDeta['title'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: h*.003,
                                            ),
                                            Text(
                                              singelDeta['location'],
                                              style: TextStyle(
                                                  color: clrGreyDark),
                                            ),
                                            Text(
                                              singelDeta['time'],
                                              style: TextStyle(
                                                  color: clrGreyDark),
                                            ),
                                            Text(
                                              "Up to ${singelDeta['poststotal']} people | ${singelDeta['leftposts']} spot left",
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
                                                singelDeta['hostImg'],
                                                fit: BoxFit.cover,
                                              )),
                                            Text( singelDeta['hostname'],style: TextStyle(fontWeight: FontWeight.w700),)
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  ReadMoreText(
                                    singelDeta['des'],
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
                  ) ;
                }),
              )
            ],
          )),
    );
  }
}


