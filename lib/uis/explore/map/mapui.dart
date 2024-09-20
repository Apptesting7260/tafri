import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/explore/filter/explorefilterui.dart';
import 'package:plusone/uis/explore/map/controller/mapactivity_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

class MapActivityUi extends GetWidget<MapActivityController>{
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
             Obx(() => controller.mapLoading.value ? Expanded(child: Center(child: CommonUi.scaffoldLoading(color: clrYellow))) : Expanded(
               child: Stack(
                 children: [
                   GoogleMap(
                     onMapCreated: (GoogleMapController googleMapController) {
                       controller.mapController = googleMapController;
                       controller.addMarkers();
                     },
                     initialCameraPosition: CameraPosition(
                       target: controller.currentLocation.value != null
                           ? LatLng(controller.currentLocation.value!.latitude!, controller.currentLocation.value!.longitude!)
                           : controller.initialPosition,
                       zoom: 14.0,
                     ),
                     myLocationEnabled: true,
                     myLocationButtonEnabled: true,
                     markers: Set<Marker>.of(controller.markers),
                     // mapType: MapType.hybrid,
                   ),
                   Align(
                     alignment: Alignment.bottomCenter,
                     child: buildBottomSheet(context),
                   ),
                 ],
               ),
             ),),
              // InkWell(
              //     onTap: () {
              //       Get.bottomSheet(
              //           isScrollControlled: true,
              //           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
              //           DraggableScrollableSheet(
              //               initialChildSize: 0.5,
              //               minChildSize: 0.0,
              //               maxChildSize: 1,
              //               // elevation: 0,
              //               //   onClosing: () {},
              //               builder: (context,scrollController) {
              //                 return SingleChildScrollView(
              //                   controller: scrollController,
              //                   child: Container(
              //                     // clipBehavior: Clip.hardEdge,
              //                     decoration: BoxDecoration(
              //                         color: clrWhite,
              //                         borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              //                     ),
              //                     child: Column(mainAxisSize: MainAxisSize.min,
              //                       children: [
              //                         Center(
              //                           child: Container(
              //                             width: Get.width*0.2,
              //                             padding:const EdgeInsets.symmetric(vertical: 2),
              //                             margin:const EdgeInsets.symmetric(vertical: 5),
              //                             decoration: BoxDecoration(
              //                                 color: clrGreyLight,
              //                                 borderRadius: BorderRadius.circular(20)
              //                             ),
              //
              //                           ),
              //                         ),
              //                         Container(
              //                           margin:
              //                           const EdgeInsets.symmetric(horizontal: 13),
              //                           child:  ListView.builder(
              //                               itemCount: 5,
              //                               shrinkWrap: true,
              //                               physics: const NeverScrollableScrollPhysics(),
              //                               itemBuilder: (context, index) {
              //                                 return InkWell(
              //                                   onTap: () {
              //                                     Get.toNamed(Routes.exploreView);
              //                                   },
              //                                   child: Container(
              //                                     margin: const EdgeInsets.symmetric(vertical: 5),
              //                                     child: Column(
              //                                       children: [
              //                                         SizedBox(
              //                                           height: h*.25,
              //                                           child: Stack(
              //                                             // clipBehavior: Clip.none,
              //                                             children: [
              //                                               CarouselSlider(
              //                                                 options: CarouselOptions(
              //                                                     height: h*.25, viewportFraction: 1),
              //                                                 items: [1, 2, 3].map((i) {
              //                                                   return Builder(
              //                                                     builder: (BuildContext context) {
              //                                                       return Container(
              //                                                           clipBehavior: Clip.hardEdge,
              //                                                           width: MediaQuery.of(context)
              //                                                               .size
              //                                                               .width,
              //                                                           height: double.maxFinite,
              //                                                           margin: const EdgeInsets.symmetric(
              //                                                               horizontal: 0),
              //                                                           decoration: BoxDecoration(
              //                                                               borderRadius:
              //                                                               BorderRadius.circular(18)),
              //                                                           child: Image.asset(
              //                                                             "assets/images/cofee.png",
              //                                                             fit: BoxFit.cover,
              //                                                             height: h*.25,
              //                                                             width: double.maxFinite,
              //                                                           ));
              //                                                     },
              //                                                   );
              //                                                 }).toList(),
              //                                               ),
              //                                               Padding(
              //                                                 padding: const EdgeInsets.symmetric(
              //                                                     horizontal: 10, vertical: 10),
              //                                                 child: Row(
              //                                                   mainAxisAlignment:
              //                                                   MainAxisAlignment.spaceBetween,
              //                                                   children: [
              //                                                     Container(
              //                                                       padding: const EdgeInsets.symmetric(
              //                                                           horizontal: 10, vertical: 5),
              //                                                       decoration: BoxDecoration(
              //                                                           color: clrWhite,
              //                                                           borderRadius:
              //                                                           BorderRadius.circular(20)),
              //                                                       child: const Text("Coffee",style: TextStyle(fontWeight: FontWeight.w600),),
              //                                                     ),
              //                                                     InkWell(
              //                                                       child: Container(
              //                                                         padding: const EdgeInsets.all(6),
              //                                                         decoration: BoxDecoration(
              //                                                             color: clrWhite,
              //                                                             borderRadius:
              //                                                             BorderRadius.circular(100)),
              //                                                         child: const Icon(
              //                                                           Icons.favorite_border,
              //                                                           size: 20,
              //                                                         ),
              //                                                       ),
              //                                                     ),
              //                                                   ],
              //                                                 ),
              //                                               ),
              //                                               Align(
              //                                                 alignment: Alignment.bottomCenter,
              //                                                 child: Container(
              //                                                   margin: EdgeInsets.only(bottom: 7),
              //                                                   height: 16,
              //                                                   child: ListView.builder(
              //                                                       itemCount: 3,
              //                                                       shrinkWrap: true,
              //                                                       scrollDirection: Axis.horizontal,
              //                                                       itemBuilder: (context, index) {
              //                                                         return Padding(
              //                                                           padding: const EdgeInsets.symmetric(
              //                                                               horizontal: 1.5),
              //                                                           child: Icon(
              //                                                             Icons.circle,
              //                                                             color:index==0?clrYellow: clrWhite,
              //                                                             size: 8,
              //                                                           ),
              //                                                         );
              //                                                       }),
              //                                                 ),
              //                                               )
              //                                             ],
              //                                           ),
              //                                         ),
              //                                         SizedBox(
              //                                           height: Get.height * 0.02,
              //                                         ),
              //                                         Row(
              //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                                           children: [
              //                                             Flexible(
              //                                               child: Column(
              //                                                 crossAxisAlignment:
              //                                                 CrossAxisAlignment.start,
              //                                                 children: [
              //                                                   const Text(
              //                                                     "Picnic in the park",
              //                                                     style: TextStyle(
              //                                                         fontSize: 16,
              //                                                         fontWeight: FontWeight.w600),
              //                                                   ),
              //                                                   Text(
              //                                                     "Vondelpark",
              //                                                     style: TextStyle(
              //                                                         color: clrGreyDark),
              //                                                   ),
              //                                                   Text(
              //                                                     "13 March 2024 | 2:30 PM - 6:00PM",
              //                                                     style: TextStyle(
              //                                                         color: clrGreyDark),
              //                                                   ),
              //                                                   Text(
              //                                                     "Up to 3 people | 1 spot left",
              //                                                     style: TextStyle(
              //                                                         color: clrYellowText, fontSize: 13),
              //                                                   ),
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                             Column(
              //                                               children: [
              //                                                 Container(
              //                                                     height: h*.05,
              //                                                     width: h*.05,
              //                                                     decoration: BoxDecoration(
              //                                                         borderRadius:
              //                                                         BorderRadius.circular(100)),
              //                                                     child: Image.asset(
              //                                                       "assets/images/girldp.png",
              //                                                       fit: BoxFit.cover,
              //                                                     )),
              //                                                 const Text("Jenny",style: TextStyle(fontWeight: FontWeight.w700),)
              //                                               ],
              //                                             )
              //                                           ],
              //                                         ),
              //                                         SizedBox(
              //                                           height: Get.height * 0.01,
              //                                         ),
              //                                         ReadMoreText(
              //                                           "Hey guys! Looking for 2 others who would like to join me for a picnic in the park today ,we all do games and dinner",
              //                                           style: TextStyle(color: clrGreyDark),
              //                                           trimMode: TrimMode.Line,
              //                                           trimLines: 2,
              //                                           colorClickableText: Colors.pink,
              //                                           trimCollapsedText: 'Learn more',
              //                                           trimExpandedText: 'Learn less',
              //                                           moreStyle:
              //                                           TextStyle(color: clrBlacke,fontWeight: FontWeight.w700),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                 );
              //                               }),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 );
              //               }));
              //     },
              //     child: Image.asset("assets/images/map.png"))
            ],
          )
      ),
    );
  }

  Widget buildBottomSheet(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.5,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child:  Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            // child: ListView.builder(
            //     physics: ScrollPhysics(),
            //     itemCount: controller.homeData.value.result?.activities
            //         ?.where((activity) => activity.status == 'approved').length,
            //     shrinkWrap: true,
            //     itemBuilder:
            //         (context, index) {
            //       var activityData = controller
            //           .homeData
            //           .value
            //           .result
            //           ?.activities
            //           ?.where((activity) =>
            //       activity
            //           .status ==
            //           'approved')
            //           .toList();
            //       return InkWell(
            //         onTap: () {
            //           if(controller.homeData.value.result?.profileComplete == false
            //               &&  controller.homeData.value.result?.membershipStatus == false) {
            //             controller.showHomePop();
            //           } else {
            //             Get.toNamed(
            //                 Routes
            //                     .exploreView,
            //                 arguments:
            //                 activityData?[
            //                 index]
            //                     .id
            //                     .toString());
            //           }
            //
            //
            //         },
            //         child: Container(
            //           margin:
            //           const EdgeInsets
            //               .symmetric(
            //               vertical:
            //               10),
            //           child: Column(
            //             crossAxisAlignment:
            //             CrossAxisAlignment
            //                 .start,
            //             children: [
            //               SizedBox(
            //                 height:
            //                 h * .26,
            //                 child: Stack(
            //                   children: [
            //                     CarouselSlider(
            //                       options: CarouselOptions(
            //                           height: h * .26,
            //                           viewportFraction: 1,
            //                           onPageChanged: (currIndex, CarouselPageChangedReason reason) {
            //                             controller.changeIndicator(index, currIndex);
            //                             debugPrint(" currIndex $currIndex reason=$reason");
            //                           }),
            //                       items: activityData?[index]
            //                           .banners
            //                           ?.map<Widget>((i) {
            //                         return Builder(
            //                           builder:
            //                               (BuildContext context) {
            //                             return Container(
            //                                 clipBehavior: Clip.hardEdge,
            //                                 width: MediaQuery.of(context).size.width,
            //                                 height: double.maxFinite,
            //                                 margin: const EdgeInsets.symmetric(horizontal: 0),
            //                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            //                                 child: CachedNetworkImage(
            //                                   fit: BoxFit.cover,
            //                                   height: h * .26,
            //                                   width: double.maxFinite,
            //                                   imageUrl: "$i",
            //                                   placeholder: (context, url) => Shimmer.fromColors(
            //                                     baseColor: grey300,
            //                                     highlightColor: grey100,
            //                                     child: Container(
            //                                       width: double.maxFinite,
            //                                       height: h * .26,
            //                                       decoration: BoxDecoration(
            //                                         color: grey300,
            //                                         borderRadius: BorderRadius.circular(18),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ));
            //                           },
            //                         );
            //                       }).toList(),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets
            //                           .symmetric(
            //                           horizontal:
            //                           10,
            //                           vertical:
            //                           10),
            //                       child:
            //                       Row(
            //                         mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Container(
            //                             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //                             decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(20)),
            //                             child: Text(
            //                               '${activityData?[index].subcategoryTitle}',
            //                               style: const TextStyle(fontWeight: FontWeight.w600),
            //                             ),
            //                           ),
            //                           InkWell(
            //                             onTap: () async {
            //                               if(controller.homeData.value.result?.profileComplete == false
            //                                   &&  controller.homeData.value.result?.membershipStatus == false) {
            //                                 controller.showHomePop();
            //                               } else {
            //                                 var id = activityData?[index].id.toString();
            //                                 await controller.changeFavApi(id).then(
            //                                       (value) {
            //                                     if (value == true) {
            //                                       activityData?[index].isFav = !activityData[index].isFav!;
            //                                     }
            //                                   },
            //                                 );
            //                                 controller.homeData.refresh();
            //                               }
            //                               // controller
            //                               //     .changeFav(
            //                               //         index);
            //                             },
            //                             child: Container(
            //                               padding: const EdgeInsets.all(6),
            //                               decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(100)),
            //                               child: activityData?[index].isFav == true
            //                                   ? Icon(
            //                                 Icons.favorite,
            //                                 size: 20,
            //                                 color: clrYellow,
            //                               )
            //                                   : const Icon(
            //                                 Icons.favorite_border,
            //                                 size: 20,
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     Align(
            //                       alignment:
            //                       Alignment.bottomCenter,
            //                       child:
            //                       Container(
            //                         margin: const EdgeInsets
            //                             .only(
            //                             bottom: 7),
            //                         height:
            //                         16,
            //                         child: ListView.builder(
            //                             itemCount: activityData?[index].banners?.length,
            //                             shrinkWrap: true,
            //                             scrollDirection: Axis.horizontal,
            //                             itemBuilder: (context, indicatorIndex) {
            //                               return Padding(
            //                                 padding: const EdgeInsets.symmetric(horizontal: 1.5),
            //                                 child: Obx(
            //                                       () => Icon(
            //                                     Icons.circle,
            //                                     color: activityData?[index].circleIndex?.value == indicatorIndex ? clrYellow : clrWhite,
            //                                     size: 8,
            //                                   ),
            //                                 ),
            //                               );
            //                             }),
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 height:
            //                 Get.height *
            //                     0.02,
            //               ),
            //               Row(
            //                 mainAxisAlignment:
            //                 MainAxisAlignment
            //                     .spaceBetween,
            //                 crossAxisAlignment:
            //                 CrossAxisAlignment
            //                     .center,
            //                 children: [
            //                   Flexible(
            //                     child:
            //                     Column(
            //                       crossAxisAlignment:
            //                       CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           "${activityData?[index].name}",
            //                           style:
            //                           const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //                         ),
            //                         SizedBox(
            //                           height:
            //                           h * .005,
            //                         ),
            //                         Text(
            //                           '${activityData?[index].location}',
            //                           style:
            //                           TextStyle(color: clrGreyDark),
            //                         ),
            //                         SizedBox(
            //                           height:
            //                           h * .005,
            //                         ),
            //                         Text(
            //                           '${activityData?[index].formattedDate} | ${activityData?[index].startAt} - ${activityData?[index].endAt}',
            //                           style:
            //                           TextStyle(color: clrGreyDark),
            //                         ),
            //                         SizedBox(
            //                           height:
            //                           h * .008,
            //                         ),
            //                         Text(
            //                           "Up to ${activityData?[index].maxPeople} people | ${activityData?[index].spotLeft} ${activityData![index].spotLeft! == 1 ? 'spot left' : 'spots left'}",
            //                           style: TextStyle(color: clrYellowText, fontSize: 13),
            //                         ),
            //
            //                         // Text(
            //                         //   "Up to ${activityData?[index].maxPeople} people | "${activityData?[index].spotLeft} ${activityData?[index].spotLeft > 1 ? 'spots left' : 'spot left'}"
            //                         //     style:
            //                         //       TextStyle(color: clrYellowText, fontSize: 13),
            //                         // ),
            //                       ],
            //                     ),
            //                   ),
            //                   const SizedBox(
            //                     width: 5,
            //                   ),
            //                   InkWell(
            //                     onTap:
            //                         () {
            //                       Get.toNamed(Routes.hostProfileUi,arguments: activityData?[index].hostId.toString());
            //                     },
            //                     child:
            //                     Column(
            //                       crossAxisAlignment:
            //                       CrossAxisAlignment.center,
            //                       mainAxisAlignment:
            //                       MainAxisAlignment.center,
            //                       children: [
            //                         ClipRRect(
            //                           borderRadius:
            //                           BorderRadius.circular(100),
            //                           child:
            //                           CachedNetworkImage(
            //                             height: 40,
            //                             width: 40,
            //                             fit: BoxFit.cover,
            //                             imageUrl: '${activityData?[index].profilePhoto}',
            //                             errorWidget: (context, url, error) => Container(
            //                               height: 40,
            //                               width: 40,
            //                               padding: const EdgeInsets.all(10),
            //                               decoration: BoxDecoration(color: clrGreyLight, shape: BoxShape.circle),
            //                               child: Image.asset(
            //                                 "assets/icons/manicon.png",
            //                                 color: clrGrey,
            //                                 fit: BoxFit.cover,
            //                               ),
            //                             ),
            //                             placeholder: (context, url) => Shimmer.fromColors(
            //                               baseColor: grey300,
            //                               highlightColor: grey100,
            //                               child: Container(
            //                                 height: 40,
            //                                 width: 40,
            //                                 decoration: BoxDecoration(
            //                                   color: grey300,
            //                                   borderRadius: BorderRadius.circular(18),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(height: 3,),
            //                         Text(
            //                           '${activityData?[index].hostName}',
            //                           style:
            //                           const TextStyle(fontWeight: FontWeight.w700),
            //                         )
            //                       ],
            //                     ),
            //                   )
            //                 ],
            //               ),
            //               SizedBox(
            //                 height:
            //                 Get.height *
            //                     0.015,
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(right: 13),
            //                 child: ReadMoreText(
            //                   '${activityData?[index].description}',
            //                   style: TextStyle(
            //                       color:
            //                       clrGreyDark),
            //                   trimMode:
            //                   TrimMode
            //                       .Line,
            //                   trimLines: 2,
            //                   colorClickableText:
            //                   Colors
            //                       .pink,
            //                   trimCollapsedText:
            //                   'Learn more',
            //                   trimExpandedText:
            //                   'Learn less',
            //                   moreStyle: TextStyle(
            //                       color:
            //                       clrBlacke,
            //                       fontWeight:
            //                       FontWeight
            //                           .w700),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     }),
          )
        );
      },
    );
  }

}
