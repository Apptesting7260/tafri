import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/size.dart';
import '../../../explore/exploreview/exploreviewui.dart';
import 'controller/myfavourite_controller.dart';

class FavouriteListUi extends GetWidget<MyfavouriteController>{
   FavouriteListUi({super.key});

  final ExploreListController homeController = Get.find<ExploreListController>();

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
                child: Obx(() => controller.myfavouriteLoading.value ? Center(
                  child: CommonUi.scaffoldLoading(color: clrYellow),
                ) : controller.favError.value.isNotEmpty ? ErrorScreen() : controller.favData.value.result!.isEmpty ? Center(
                  child: SizedBox(
                    width: Get.width*0.7,
                    height: Get.height*0.5,
                    child: Image.asset('assets/images/empty fav.png'),
                  ),
                ) : controller.favData.value.result!.
                where((result) =>
                result.status == 'approved').isNotEmpty ? ListView.builder(
                    itemCount: controller.favData.value.result?.
                    where((result) =>
                    result.status == 'approved').length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var  resultData = controller.favData.value.result?.
                      where((result) =>
                      result.status == 'approved').toList();

                      // var data = controller.favData.value.result![index];
                      print('Circle Index for index $index: ${controller.favData.value.result?[index].circleIndex?.value}');

                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.exploreView,arguments: resultData[index].id.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
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
                                          height: h*.25,
                                          viewportFraction: 1,
                                          onPageChanged: (currIndex, CarouselPageChangedReason reason) {
                                            controller.changeIndicator(index, currIndex);
                                            debugPrint(" currIndex $currIndex reason=$reason");
                                          }
                                      ),
                                      items:  resultData?[index].banners?.map<Widget>((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            // return Container(
                                            //     clipBehavior: Clip.hardEdge,
                                            //     width: MediaQuery.of(context).size.width,
                                            //     height: double.maxFinite,
                                            //     margin: const EdgeInsets.symmetric(
                                            //         horizontal: 0),
                                            //     decoration: BoxDecoration(
                                            //         borderRadius:
                                            //         BorderRadius.circular(18)),
                                            //     child: Image.asset(
                                            //       "assets/images/cofee.png",
                                            //       fit: BoxFit.cover,
                                            //       height: h*.25,
                                            //       width: double.maxFinite,
                                            //     ));
                                            return Container(
                                                clipBehavior: Clip.hardEdge,
                                                width: MediaQuery.of(context).size.width,
                                                height: double.maxFinite,
                                                margin: const EdgeInsets.symmetric(horizontal: 0),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  height: h * .26,
                                                  width: double.maxFinite,
                                                  imageUrl: "$i",
                                                  placeholder: (context, url) => Shimmer.fromColors(
                                                    baseColor: grey300,
                                                    highlightColor: grey100,
                                                    child: Container(
                                                      width: double.maxFinite,
                                                      height: h * .26,
                                                      decoration: BoxDecoration(
                                                        color: grey300,
                                                        borderRadius: BorderRadius.circular(18),
                                                      ),
                                                    ),
                                                  ),
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
                                            child: Text(
                                              resultData![index].subcategoryTitle.toString(),
                                              style: TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async{
                                              var id = resultData[index].id.toString();
                                              await controller.changeFavApi(id).then((value) {
                                                if(value == true){
                                                 homeController.homePageApi();
                                                }
                                              },
                                              );

                                              controller.favData.refresh();
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
                                            itemCount: resultData[index].banners?.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 1.5),
                                                child: Obx(
                                                      () => Icon(
                                                    Icons.circle,
                                                    color: resultData[index].circleIndex?.value == index ? clrYellow : clrWhite,
                                                    size: 8,
                                                  ),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                         Text(
                                           resultData[index].name.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          resultData[index].location.toString(),
                                          style: TextStyle(
                                              color: clrGreyDark),
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          // "13 March 2024 | 2:30 PM - 6:00PM",
                                          '${resultData[index].date} | ${resultData[index].startAt} - ${resultData[index].endAt}',
                                          style: TextStyle(
                                              color: clrGreyDark),
                                        ),
                                        SizedBox(height: h * .008,),
                                        Text(
                                          "Up to ${resultData[index].maxPeople} people | ${resultData[index].spotLeft} ${resultData[index].spotLeft! > 1 ? 'spots left' : 'spot left'}",
                                          style: TextStyle(color: clrYellowText, fontSize: 13),
                                        ),

                                        // Text(
                                        //   "Up to ${resultData[index].maxPeople} people | ${resultData[index].spotLeft} spot left",
                                        //   style: TextStyle(
                                        //       color: clrYellowText, fontSize: 13),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      onTap: (){
                                        Get.toNamed(Routes.hostProfileUi,arguments: resultData[index].hostId.toString());
                                      },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // Container(
                                        //     height: h*.05,
                                        //     width: h*.05,
                                        //     decoration: BoxDecoration(
                                        //         borderRadius:
                                        //         BorderRadius.circular(100)),
                                        //     child: Image.network(
                                        //       data.profilePhoto.toString(),
                                        //       fit: BoxFit.cover,
                                        //     )),
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          child:
                                          CachedNetworkImage(
                                            height: 40,
                                            width: 40,
                                            fit:
                                            BoxFit.cover,
                                            imageUrl:
                                            '${resultData[index].profilePhoto}',
                                            errorWidget: (context, url, error) =>
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: clrGreyLight,
                                                      shape: BoxShape.circle
                                                  ),
                                                  child: Image.asset("assets/icons/manicon.png",
                                                    color: clrGrey,fit: BoxFit.cover,),
                                                ),
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                                  baseColor: grey300,
                                                  highlightColor: grey100,
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      color: grey300,
                                                      borderRadius: BorderRadius.circular(18),
                                                    ),
                                                  ),
                                                ),
                                          ),
                                        ),
                                        SizedBox(height: 3,),
                                        Text(resultData[index].hostName.toString(),style: TextStyle(fontWeight: FontWeight.w700),)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 13),
                                child: ReadMoreText(
                                  resultData[index].description.toString(),
                                  style: TextStyle(color: clrGreyDark),
                                  trimMode: TrimMode.Line,
                                  trimLines: 2,
                                  colorClickableText: Colors.pink,
                                  trimCollapsedText: 'Learn more',
                                  trimExpandedText: 'Learn less',
                                  moreStyle:
                                  TextStyle(color: clrBlacke,fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      );
                    }) : Center(
                  child: SizedBox(
                    width: Get.width*0.7,
                    height: Get.height*0.5,
                    child: Image.asset('assets/images/empty fav.png'),
                  ),
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}