// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:plusone/routes/routes.dart';
// import 'package:plusone/uis/components/custotextfield.dart';
// import 'package:plusone/uis/explore/map/controller/mapactivity_controller.dart';
// import 'package:plusone/utils/colors.dart';
// import 'package:plusone/utils/common.dart';
// import 'package:plusone/utils/size.dart';
// import 'package:readmore/readmore.dart';
// import 'package:shimmer/shimmer.dart';
//
// class MapActivityUi extends GetWidget<MapActivityController> {
//   const MapActivityUi({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var h = Get.height;
//     var w = Get.width;
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: [
//           SizedBox(
//             height: Get.height * 0.02,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 13),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 SizedBox(
//                     height: Res.h_btn,
//                     width: Get.width * 0.75,
//                     child: const CustoTextFormField(
//                       hintText: "Any activity ",
//                       sufixIcon: Icon(Icons.search),
//                     )),
//                 SizedBox(
//                   width: w * .03,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Get.toNamed(Routes.filterExploreUi);
//                     // Get.to(() {
//                     //   return  ExploreFilterUi();
//                     // });
//                   },
//                   child: Container(
//                     height: h * 0.057,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: clrBlacke),
//                     child: Image.asset("assets/icons/filtericon.png"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: Get.height * 0.02,
//           ),
//           Obx(
//             () => controller.mapLoading.value
//                 ? Expanded(
//                     child: Center(
//                         child: CommonUi.scaffoldLoading(color: clrYellow)))
//                 : Container(
//               height: h,
//                   width: w,
//                   child: Stack(
//                     children: [
//                       GoogleMap(
//                         onMapCreated:
//                             (GoogleMapController googleMapController) {
//                           controller.mapController = googleMapController;
//                           controller.addMarkers();
//                         },
//                         initialCameraPosition: CameraPosition(
//                           target: controller.currentLocation.value != null
//                               ? LatLng(
//                                   controller.currentLocation.value!.latitude!,
//                                   controller
//                                       .currentLocation.value!.longitude!)
//                               : controller.initialPosition,
//                           zoom: 14.0,
//                         ),
//                         myLocationEnabled: true,
//                         myLocationButtonEnabled: true,
//                         markers: Set<Marker>.of(controller.markers),
//                         // mapType: MapType.hybrid,
//                       ),
//                       // Align(
//                       //   alignment: Alignment.bottomCenter,
//                       //   child: buildBottomSheet(context),
//                       // ),
//                                 DraggableScrollableSheet(
//                                   initialChildSize: 0.5,
//                                   minChildSize: 0.4,
//                                   maxChildSize: 1.0,
//                                   expand: true,
//                                   builder:
//                   (BuildContext context, ScrollController scrollController) {
//                                     return Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius:
//                       BorderRadius.vertical(top: Radius.circular(30)),
//                     ),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                             height: 20,
//                             child: Container(
//                               width: 80,
//                               child: Divider(
//                                 height: 3,
//                               ),
//                             )),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Res.Defalt_side_margin),
//                             child: ListView.builder(
//                                 physics: ScrollPhysics(),
//                                 itemCount: controller
//                                     .homeData.result?.activities
//                                     ?.where((activity) =>
//                                 activity.status == 'approved')
//                                     .length,
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   var activityData = controller
//                                       .homeData.result?.activities
//                                       ?.where((activity) =>
//                                   activity.status == 'approved')
//                                       .toList();
//                                   return InkWell(
//                                     onTap: () {
//                                       if (controller.homeData.result
//                                           ?.profileComplete ==
//                                           false &&
//                                           controller.homeData.result
//                                               ?.membershipStatus ==
//                                               false) {
//                                         controller.showHomePop();
//                                       } else {
//                                         Get.toNamed(Routes.exploreView,
//                                             arguments: activityData?[index]
//                                                 .id
//                                                 .toString());
//                                       }
//                                     },
//                                     child: Container(
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 10),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             height: h * .26,
//                                             child: Stack(
//                                               children: [
//                                                 CarouselSlider(
//                                                   options: CarouselOptions(
//                                                       height: h * .26,
//                                                       viewportFraction: 1,
//                                                       onPageChanged: (currIndex,
//                                                           CarouselPageChangedReason
//                                                           reason) {
//                                                         controller
//                                                             .changeIndicator(
//                                                             index,
//                                                             currIndex);
//                                                         debugPrint(
//                                                             " currIndex $currIndex reason=$reason");
//                                                       }),
//                                                   items: activityData?[index]
//                                                       .banners
//                                                       ?.map<Widget>((i) {
//                                                     return Builder(
//                                                       builder: (BuildContext
//                                                       context) {
//                                                         return Container(
//                                                             clipBehavior: Clip
//                                                                 .hardEdge,
//                                                             width: MediaQuery
//                                                                 .of(context)
//                                                                 .size
//                                                                 .width,
//                                                             height:
//                                                             double
//                                                                 .maxFinite,
//                                                             margin:
//                                                             const EdgeInsets
//                                                                 .symmetric(
//                                                                 horizontal:
//                                                                 0),
//                                                             decoration: BoxDecoration(
//                                                                 borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                     18)),
//                                                             child:
//                                                             CachedNetworkImage(
//                                                               fit: BoxFit.cover,
//                                                               height: h * .26,
//                                                               width: double
//                                                                   .maxFinite,
//                                                               imageUrl: "$i",
//                                                               placeholder: (context,
//                                                                   url) =>
//                                                                   Shimmer
//                                                                       .fromColors(
//                                                                     baseColor:
//                                                                     grey300,
//                                                                     highlightColor:
//                                                                     grey100,
//                                                                     child:
//                                                                     Container(
//                                                                       width: double
//                                                                           .maxFinite,
//                                                                       height:
//                                                                       h * .26,
//                                                                       decoration:
//                                                                       BoxDecoration(
//                                                                         color:
//                                                                         grey300,
//                                                                         borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             18),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                             ));
//                                                       },
//                                                     );
//                                                   }).toList(),
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 10,
//                                                       vertical: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                     children: [
//                                                       Container(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .symmetric(
//                                                             horizontal: 10,
//                                                             vertical: 5),
//                                                         decoration: BoxDecoration(
//                                                             color: clrWhite,
//                                                             borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                 20)),
//                                                         child: Text(
//                                                           '${activityData?[index].subcategoryTitle}',
//                                                           style: const TextStyle(
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .w600),
//                                                         ),
//                                                       ),
//                                                       InkWell(
//                                                         onTap: () async {
//                                                           if (controller
//                                                               .homeData
//                                                               .result
//                                                               ?.profileComplete ==
//                                                               false &&
//                                                               controller
//                                                                   .homeData
//                                                                   .result
//                                                                   ?.membershipStatus ==
//                                                                   false) {
//                                                             controller
//                                                                 .showHomePop();
//                                                           } else {
//                                                             var id =
//                                                             activityData?[
//                                                             index]
//                                                                 .id
//                                                                 .toString();
//                                                             await controller
//                                                                 .changeFavApi(
//                                                                 id)
//                                                                 .then(
//                                                                   (value) {
//                                                                 if (value ==
//                                                                     true) {
//                                                                   activityData?[
//                                                                   index]
//                                                                       .isFav = !activityData[
//                                                                   index]
//                                                                       .isFav!;
//                                                                 }
//                                                               },
//                                                             );
//                                                             // controller.homeData.refresh();
//                                                           }
//                                                           // controller
//                                                           //     .changeFav(
//                                                           //         index);
//                                                         },
//                                                         child: Container(
//                                                           padding:
//                                                           const EdgeInsets
//                                                               .all(6),
//                                                           decoration: BoxDecoration(
//                                                               color: clrWhite,
//                                                               borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                   100)),
//                                                           child: activityData?[
//                                                           index]
//                                                               .isFav ==
//                                                               true
//                                                               ? Icon(
//                                                             Icons
//                                                                 .favorite,
//                                                             size: 20,
//                                                             color:
//                                                             clrYellow,
//                                                           )
//                                                               : const Icon(
//                                                             Icons
//                                                                 .favorite_border,
//                                                             size: 20,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Align(
//                                                   alignment:
//                                                   Alignment.bottomCenter,
//                                                   child: Container(
//                                                     margin:
//                                                     const EdgeInsets.only(
//                                                         bottom: 7),
//                                                     height: 16,
//                                                     child: ListView.builder(
//                                                         itemCount:
//                                                         activityData?[index]
//                                                             .banners
//                                                             ?.length,
//                                                         shrinkWrap: true,
//                                                         scrollDirection:
//                                                         Axis.horizontal,
//                                                         itemBuilder: (context,
//                                                             indicatorIndex) {
//                                                           return Padding(
//                                                             padding:
//                                                             const EdgeInsets
//                                                                 .symmetric(
//                                                                 horizontal:
//                                                                 1.5),
//                                                             child: Obx(
//                                                                   () => Icon(
//                                                                 Icons.circle,
//                                                                 color: activityData?[index]
//                                                                     .circleIndex
//                                                                     ?.value ==
//                                                                     indicatorIndex
//                                                                     ? clrYellow
//                                                                     : clrWhite,
//                                                                 size: 8,
//                                                               ),
//                                                             ),
//                                                           );
//                                                         }),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: Get.height * 0.02,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                             children: [
//                                               Flexible(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       "${activityData?[index].name}",
//                                                       style: const TextStyle(
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                           FontWeight.w600),
//                                                     ),
//                                                     SizedBox(
//                                                       height: h * .005,
//                                                     ),
//                                                     Text(
//                                                       '${activityData?[index].location}',
//                                                       style: TextStyle(
//                                                           color: clrGreyDark),
//                                                     ),
//                                                     SizedBox(
//                                                       height: h * .005,
//                                                     ),
//                                                     Text(
//                                                       '${activityData?[index].formattedDate} | ${activityData?[index].startAt} - ${activityData?[index].endAt}',
//                                                       style: TextStyle(
//                                                           color: clrGreyDark),
//                                                     ),
//                                                     SizedBox(
//                                                       height: h * .008,
//                                                     ),
//                                                     Text(
//                                                       "Up to ${activityData?[index].maxPeople} people | ${activityData?[index].spotLeft} ${activityData![index].spotLeft! == 1 ? 'spot left' : 'spots left'}",
//                                                       style: TextStyle(
//                                                           color: clrYellowText,
//                                                           fontSize: 13),
//                                                     ),
//
//                                                     // Text(
//                                                     //   "Up to ${activityData?[index].maxPeople} people | "${activityData?[index].spotLeft} ${activityData?[index].spotLeft > 1 ? 'spots left' : 'spot left'}"
//                                                     //     style:
//                                                     //       TextStyle(color: clrYellowText, fontSize: 13),
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 width: 5,
//                                               ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   Get.toNamed(
//                                                       Routes.hostProfileUi,
//                                                       arguments:
//                                                       activityData?[index]
//                                                           .hostId
//                                                           .toString());
//                                                 },
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                                   children: [
//                                                     ClipRRect(
//                                                       borderRadius:
//                                                       BorderRadius.circular(
//                                                           100),
//                                                       child: CachedNetworkImage(
//                                                         height: 40,
//                                                         width: 40,
//                                                         fit: BoxFit.cover,
//                                                         imageUrl:
//                                                         '${activityData?[index].profilePhoto}',
//                                                         errorWidget: (context,
//                                                             url, error) =>
//                                                             Container(
//                                                               height: 40,
//                                                               width: 40,
//                                                               padding:
//                                                               const EdgeInsets
//                                                                   .all(10),
//                                                               decoration: BoxDecoration(
//                                                                   color:
//                                                                   clrGreyLight,
//                                                                   shape: BoxShape
//                                                                       .circle),
//                                                               child: Image.asset(
//                                                                 "assets/icons/manicon.png",
//                                                                 color: clrGrey,
//                                                                 fit: BoxFit.cover,
//                                                               ),
//                                                             ),
//                                                         placeholder: (context,
//                                                             url) =>
//                                                             Shimmer.fromColors(
//                                                               baseColor: grey300,
//                                                               highlightColor:
//                                                               grey100,
//                                                               child: Container(
//                                                                 height: 40,
//                                                                 width: 40,
//                                                                 decoration:
//                                                                 BoxDecoration(
//                                                                   color: grey300,
//                                                                   borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                       18),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 3,
//                                                     ),
//                                                     Text(
//                                                       '${activityData?[index].hostName}',
//                                                       style: const TextStyle(
//                                                           fontWeight:
//                                                           FontWeight.w700),
//                                                     )
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: Get.height * 0.015,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 13),
//                                             child: ReadMoreText(
//                                               '${activityData?[index].description}',
//                                               style:
//                                               TextStyle(color: clrGreyDark),
//                                               trimMode: TrimMode.Line,
//                                               trimLines: 2,
//                                               colorClickableText: Colors.pink,
//                                               trimCollapsedText: 'Learn more',
//                                               trimExpandedText: 'Learn less',
//                                               moreStyle: TextStyle(
//                                                   color: clrBlacke,
//                                                   fontWeight: FontWeight.w700),
//                                               lessStyle: TextStyle(
//                                                   color: clrBlacke,
//                                                   fontWeight: FontWeight.w700),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ),
//                         ),
//                       ],
//                     ));
//                                   },
//                                 )
//                     ],
//                   ),
//                 ),
//           ),
//         ],
//       )),
//       // bottomSheet: buildBottomSheet(context),
//     );
//   }
//
//   Widget? buildBottomSheet(BuildContext context) {
//     var h = Get.height;
//     var w = Get.width;
//     showModalBottomSheet(
//         context: context,
//         isDismissible: true,
//         isScrollControlled: true,
//         showDragHandle: true,
//         builder: (context) => DraggableScrollableSheet(
//               initialChildSize: 0.5,
//               minChildSize: 0.4,
//               maxChildSize: 1.0,
//               builder:
//                   (BuildContext context, ScrollController scrollController) {
//                 return Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(30)),
//                     ),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                             height: 20,
//                             child: Container(
//                               width: 80,
//                               child: Divider(
//                                 height: 3,
//                               ),
//                             )),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Res.Defalt_side_margin),
//                             child: ListView.builder(
//                                 physics: ScrollPhysics(),
//                                 itemCount: controller
//                                     .homeData.result?.activities
//                                     ?.where((activity) =>
//                                         activity.status == 'approved')
//                                     .length,
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   var activityData = controller
//                                       .homeData.result?.activities
//                                       ?.where((activity) =>
//                                           activity.status == 'approved')
//                                       .toList();
//                                   return InkWell(
//                                     onTap: () {
//                                       if (controller.homeData.result
//                                                   ?.profileComplete ==
//                                               false &&
//                                           controller.homeData.result
//                                                   ?.membershipStatus ==
//                                               false) {
//                                         controller.showHomePop();
//                                       } else {
//                                         Get.toNamed(Routes.exploreView,
//                                             arguments: activityData?[index]
//                                                 .id
//                                                 .toString());
//                                       }
//                                     },
//                                     child: Container(
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 10),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             height: h * .26,
//                                             child: Stack(
//                                               children: [
//                                                 CarouselSlider(
//                                                   options: CarouselOptions(
//                                                       height: h * .26,
//                                                       viewportFraction: 1,
//                                                       onPageChanged: (currIndex,
//                                                           CarouselPageChangedReason
//                                                               reason) {
//                                                         controller
//                                                             .changeIndicator(
//                                                                 index,
//                                                                 currIndex);
//                                                         debugPrint(
//                                                             " currIndex $currIndex reason=$reason");
//                                                       }),
//                                                   items: activityData?[index]
//                                                       .banners
//                                                       ?.map<Widget>((i) {
//                                                     return Builder(
//                                                       builder: (BuildContext
//                                                           context) {
//                                                         return Container(
//                                                             clipBehavior: Clip
//                                                                 .hardEdge,
//                                                             width: MediaQuery
//                                                                     .of(context)
//                                                                 .size
//                                                                 .width,
//                                                             height:
//                                                                 double
//                                                                     .maxFinite,
//                                                             margin:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                                     horizontal:
//                                                                         0),
//                                                             decoration: BoxDecoration(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             18)),
//                                                             child:
//                                                                 CachedNetworkImage(
//                                                               fit: BoxFit.cover,
//                                                               height: h * .26,
//                                                               width: double
//                                                                   .maxFinite,
//                                                               imageUrl: "$i",
//                                                               placeholder: (context,
//                                                                       url) =>
//                                                                   Shimmer
//                                                                       .fromColors(
//                                                                 baseColor:
//                                                                     grey300,
//                                                                 highlightColor:
//                                                                     grey100,
//                                                                 child:
//                                                                     Container(
//                                                                   width: double
//                                                                       .maxFinite,
//                                                                   height:
//                                                                       h * .26,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     color:
//                                                                         grey300,
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             18),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ));
//                                                       },
//                                                     );
//                                                   }).toList(),
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 10,
//                                                       vertical: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Container(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .symmetric(
//                                                                 horizontal: 10,
//                                                                 vertical: 5),
//                                                         decoration: BoxDecoration(
//                                                             color: clrWhite,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         20)),
//                                                         child: Text(
//                                                           '${activityData?[index].subcategoryTitle}',
//                                                           style: const TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600),
//                                                         ),
//                                                       ),
//                                                       InkWell(
//                                                         onTap: () async {
//                                                           if (controller
//                                                                       .homeData
//                                                                       .result
//                                                                       ?.profileComplete ==
//                                                                   false &&
//                                                               controller
//                                                                       .homeData
//                                                                       .result
//                                                                       ?.membershipStatus ==
//                                                                   false) {
//                                                             controller
//                                                                 .showHomePop();
//                                                           } else {
//                                                             var id =
//                                                                 activityData?[
//                                                                         index]
//                                                                     .id
//                                                                     .toString();
//                                                             await controller
//                                                                 .changeFavApi(
//                                                                     id)
//                                                                 .then(
//                                                               (value) {
//                                                                 if (value ==
//                                                                     true) {
//                                                                   activityData?[
//                                                                           index]
//                                                                       .isFav = !activityData[
//                                                                           index]
//                                                                       .isFav!;
//                                                                 }
//                                                               },
//                                                             );
//                                                             // controller.homeData.refresh();
//                                                           }
//                                                           // controller
//                                                           //     .changeFav(
//                                                           //         index);
//                                                         },
//                                                         child: Container(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(6),
//                                                           decoration: BoxDecoration(
//                                                               color: clrWhite,
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           100)),
//                                                           child: activityData?[
//                                                                           index]
//                                                                       .isFav ==
//                                                                   true
//                                                               ? Icon(
//                                                                   Icons
//                                                                       .favorite,
//                                                                   size: 20,
//                                                                   color:
//                                                                       clrYellow,
//                                                                 )
//                                                               : const Icon(
//                                                                   Icons
//                                                                       .favorite_border,
//                                                                   size: 20,
//                                                                 ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Align(
//                                                   alignment:
//                                                       Alignment.bottomCenter,
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                             bottom: 7),
//                                                     height: 16,
//                                                     child: ListView.builder(
//                                                         itemCount:
//                                                             activityData?[index]
//                                                                 .banners
//                                                                 ?.length,
//                                                         shrinkWrap: true,
//                                                         scrollDirection:
//                                                             Axis.horizontal,
//                                                         itemBuilder: (context,
//                                                             indicatorIndex) {
//                                                           return Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                                     horizontal:
//                                                                         1.5),
//                                                             child: Obx(
//                                                               () => Icon(
//                                                                 Icons.circle,
//                                                                 color: activityData?[index]
//                                                                             .circleIndex
//                                                                             ?.value ==
//                                                                         indicatorIndex
//                                                                     ? clrYellow
//                                                                     : clrWhite,
//                                                                 size: 8,
//                                                               ),
//                                                             ),
//                                                           );
//                                                         }),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: Get.height * 0.02,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Flexible(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       "${activityData?[index].name}",
//                                                       style: const TextStyle(
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.w600),
//                                                     ),
//                                                     SizedBox(
//                                                       height: h * .005,
//                                                     ),
//                                                     Text(
//                                                       '${activityData?[index].location}',
//                                                       style: TextStyle(
//                                                           color: clrGreyDark),
//                                                     ),
//                                                     SizedBox(
//                                                       height: h * .005,
//                                                     ),
//                                                     Text(
//                                                       '${activityData?[index].formattedDate} | ${activityData?[index].startAt} - ${activityData?[index].endAt}',
//                                                       style: TextStyle(
//                                                           color: clrGreyDark),
//                                                     ),
//                                                     SizedBox(
//                                                       height: h * .008,
//                                                     ),
//                                                     Text(
//                                                       "Up to ${activityData?[index].maxPeople} people | ${activityData?[index].spotLeft} ${activityData![index].spotLeft! == 1 ? 'spot left' : 'spots left'}",
//                                                       style: TextStyle(
//                                                           color: clrYellowText,
//                                                           fontSize: 13),
//                                                     ),
//
//                                                     // Text(
//                                                     //   "Up to ${activityData?[index].maxPeople} people | "${activityData?[index].spotLeft} ${activityData?[index].spotLeft > 1 ? 'spots left' : 'spot left'}"
//                                                     //     style:
//                                                     //       TextStyle(color: clrYellowText, fontSize: 13),
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 width: 5,
//                                               ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   Get.toNamed(
//                                                       Routes.hostProfileUi,
//                                                       arguments:
//                                                           activityData?[index]
//                                                               .hostId
//                                                               .toString());
//                                                 },
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               100),
//                                                       child: CachedNetworkImage(
//                                                         height: 40,
//                                                         width: 40,
//                                                         fit: BoxFit.cover,
//                                                         imageUrl:
//                                                             '${activityData?[index].profilePhoto}',
//                                                         errorWidget: (context,
//                                                                 url, error) =>
//                                                             Container(
//                                                           height: 40,
//                                                           width: 40,
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(10),
//                                                           decoration: BoxDecoration(
//                                                               color:
//                                                                   clrGreyLight,
//                                                               shape: BoxShape
//                                                                   .circle),
//                                                           child: Image.asset(
//                                                             "assets/icons/manicon.png",
//                                                             color: clrGrey,
//                                                             fit: BoxFit.cover,
//                                                           ),
//                                                         ),
//                                                         placeholder: (context,
//                                                                 url) =>
//                                                             Shimmer.fromColors(
//                                                           baseColor: grey300,
//                                                           highlightColor:
//                                                               grey100,
//                                                           child: Container(
//                                                             height: 40,
//                                                             width: 40,
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               color: grey300,
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           18),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 3,
//                                                     ),
//                                                     Text(
//                                                       '${activityData?[index].hostName}',
//                                                       style: const TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.w700),
//                                                     )
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: Get.height * 0.015,
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 13),
//                                             child: ReadMoreText(
//                                               '${activityData?[index].description}',
//                                               style:
//                                                   TextStyle(color: clrGreyDark),
//                                               trimMode: TrimMode.Line,
//                                               trimLines: 2,
//                                               colorClickableText: Colors.pink,
//                                               trimCollapsedText: 'Learn more',
//                                               trimExpandedText: 'Learn less',
//                                               moreStyle: TextStyle(
//                                                   color: clrBlacke,
//                                                   fontWeight: FontWeight.w700),
//                                               lessStyle: TextStyle(
//                                                   color: clrBlacke,
//                                                   fontWeight: FontWeight.w700),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ),
//                         ),
//                       ],
//                     ));
//               },
//             ));
//     return null;
//   }
// }




import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/uis/explore/map/controller/mapactivity_controller.dart';
import 'package:plusone/uis/explore/map/navbar/cusnavbar.dart';
import 'package:plusone/uis/navbar/navbar.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../utils/error_widget.dart';
import '../../../utils/no_activity.dart';


class MapActivityUi extends GetWidget<MapActivityController> {
   MapActivityUi({super.key});


  final PanelController _panelController = PanelController();
  final ExploreListController homeController = Get.find<ExploreListController>();


  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
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
                CommonUi.appBar(),
                SizedBox(
                  width: w * .02,
                ),
                SizedBox(
                    height: Res.h_btn,
                    width: Get.width * 0.65,
                    child: const CustoTextFormField(
                      hintText: "Any activity ",
                      sufixIcon: Icon(Icons.search),
                    )),
                SizedBox(
                  width: w * .02,
                ),
                InkWell(
                  onTap: () {
                    Get.offNamed(Routes.filterExploreUi);
                    // Get.to(() {
                    //   return  ExploreFilterUi();
                    // });
                  },
                  child: Container(
                    height: h * 0.057,
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
          Obx(
            () => controller.mapLoading.value
                ? Expanded(
                    child: Center(
                        child: CommonUi.scaffoldLoading(color: clrYellow)))
                : SizedBox(
              height: h * .86,
                  width: w,
                  child: Stack(
                    children: [
                      GoogleMap(
                        onMapCreated:
                            (GoogleMapController googleMapController) {
                          controller.mapController = googleMapController;
                          controller.addMarkers();
                        },
                        initialCameraPosition: CameraPosition(
                          target: controller.currentLocation.value != null
                              ? LatLng(
                                  controller.currentLocation.value!.latitude!,
                                  controller
                                      .currentLocation.value!.longitude!)
                              : controller.initialPosition,
                          zoom: 14.0,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        markers: Set<Marker>.of(controller.markers),
                        // mapType: MapType.hybrid,
                      ),
                      SlidingUpPanel(
                        controller: _panelController,
                        panel: _buildPanelContent(context),
                        minHeight: 25,
                        maxHeight: h * .86,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
                      ),
                    ],
                  ),
                ),
          ),
        ],
      )),
    );
  }

  Widget _buildPanelContent(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
         return Container(
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius:
                   BorderRadius.vertical(top: Radius.circular(30)),
             ),
             child: Column(
               children: [
                 SizedBox(
                   height: 5,
                 ),
                 Container(
                     height: 20,
                     child: Container(
                       width: 80,
                       child: Divider(
                         height: 3,
                       ),
                     )),
                 SizedBox(
                   height: 5,
                 ),
                 Obx(() => homeController.homePageLoading.value &&
                     homeController.homeData.value.result == null
                       ? Expanded(
                     child: Center(
                       child: CommonUi.scaffoldLoading(color: clrYellow),
                     ),
                   )
                       : homeController.homeError.value.isNotEmpty
                       ? Expanded(
                       child: SmartRefresher(
                         onRefresh: () async {
                           await homeController.homePageApi();
                           controller.refreshController1.refreshCompleted();
                         },
                         controller: controller.refreshController1,
                         header: CommonUi.refreshHeader(),
                         child: const Center(
                           child: ErrorScreen(),
                         ),
                       ))
                       : Expanded(
                     child: Column(
                       mainAxisSize: MainAxisSize.max,
                       children: [
                         Container(
                           height: h * .046,
                           child: ListView.builder(
                             padding: EdgeInsets.only(
                                 left: Res.Defalt_side_margin
                             ),
                             itemCount: (homeController.homeData.value.result?.categories?.where((category) => category.status == '1').length ?? 0) + 1,
                             shrinkWrap: true,
                             scrollDirection: Axis.horizontal,
                             itemBuilder: (context, index) {
                               if (index == 0) {
                                 return GestureDetector(
                                   onTap: () async {
                                     if (homeController.selectedIndex.value != index) {
                                       homeController.selectedIndex.value = index;
                                       homeController.categoryID.value = '';
                                       homeController.allLoading.value = true;
                                       await homeController.homePageApi();
                                       homeController.allLoading.value = false;
                                     }
                                   },
                                   child: Obx(
                                         () => Container(
                                       margin: const EdgeInsets.only(
                                           right: 7),
                                       padding: EdgeInsets.symmetric(
                                         horizontal: 15,
                                       ),
                                       decoration: BoxDecoration(
                                         borderRadius:
                                         BorderRadius.circular(100),
                                         color: homeController.selectedIndex.value == index
                                             ? clrBlacke
                                             : clrGreyLight,
                                       ),
                                       child: Center(
                                         child: homeController
                                             .allLoading.value
                                             ? CommonUi.fallingDot()
                                             : Text(
                                           'All',
                                           style: TextStyle(
                                             color: homeController.selectedIndex.value == index
                                                 ? clrWhite : clrBlacke,
                                             fontWeight:
                                             FontWeight.w700,
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                 );
                               } else {
                                 // Other categories
                                 var categoryData = homeController.homeData.value.result?.categories?.where((category) => category.status == '1').toList();
                                 var categoryIndex = index - 1;
                                 return GestureDetector(
                                   onTap: () async {
                                     if (homeController.selectedIndex.value != index) {
                                       homeController.selectedIndex.value = index;
                                       homeController.categoryID.value = categoryData?[categoryIndex].id.toString();
                                       categoryData?[categoryIndex].loading?.value = true;
                                       await homeController.homePageApi();
                                       categoryData?[categoryIndex].loading?.value = false;
                                     }
                                   },
                                   child: Obx(
                                         () => Container(
                                       margin: const EdgeInsets.only(right: 7),
                                       padding: categoryData![categoryIndex].loading!.value
                                           ? EdgeInsets.symmetric(
                                         horizontal: 15,
                                       )
                                           : EdgeInsets.only(
                                           left: 4,
                                           top: 1.5,
                                           bottom: 1.5,
                                           right: 10
                                       ),
                                       decoration: BoxDecoration(
                                         borderRadius:
                                         BorderRadius.circular(100),
                                         color: homeController.selectedIndex.value == index
                                             ? clrBlacke
                                             : clrGreyLight,
                                       ),
                                       child: categoryData[categoryIndex].loading!.value
                                           ? CommonUi.fallingDot()
                                           : Row(
                                         children: [
                                           ClipRRect(
                                             borderRadius: BorderRadius.circular(
                                                 100
                                             ),
                                             child: CachedNetworkImage(
                                               height: 28,
                                               width: 28,
                                               memCacheWidth: 500,
                                               fit: BoxFit.cover,
                                               imageUrl: '${categoryData[categoryIndex].icon}',
                                               errorWidget: (context, url, error) =>
                                                   Icon(
                                                       Icons.error,
                                                       color: clrBlacke
                                                   ),
                                             ),
                                           ),
                                           const SizedBox(
                                               width: 5
                                           ),
                                           Text(
                                             '${categoryData[categoryIndex].title}',
                                             style: TextStyle(
                                               color: homeController.selectedIndex.value == index
                                                   ? clrWhite
                                                   : clrBlacke,
                                               fontWeight: FontWeight.w700,
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 );
                               }
                             },
                           ),
                         ),
                         SizedBox(
                           height: Get.height * 0.013,
                         ),
                         Expanded(
                           child: Obx(() {
                             return Container(
                               margin: EdgeInsets.symmetric(
                                   horizontal: Res.Defalt_side_margin),
                               child: SmartRefresher(
                                   controller:
                                   controller.refreshController,
                                   onRefresh: () async {
                                     await homeController.homePageApi();
                                     controller.refreshController.refreshCompleted();
                                   },
                                   header: CommonUi.refreshHeader(),
                                   child: homeController.homeData.value.result!.activities!.isEmpty
                                       ? Center(
                                     child: NoActivityScreen(),
                                   )
                                       : homeController.homeData.value.result!.activities!
                                       .where((element) => element.status == 'approved',).isNotEmpty
                                       ? Padding(
                                     padding: const EdgeInsets.only(bottom: 50.0),
                                     child: ListView.builder(
                                         physics: ScrollPhysics(),
                                         // controller: controller.scrollController,
                                         itemCount: homeController.homeData.value.result?.activities
                                             ?.where((activity) => activity.status == 'approved').length,
                                         shrinkWrap: true,
                                         itemBuilder:
                                             (context, index) {
                                           var activityData = homeController.homeData.value.result?.activities?.where((activity) => activity.status == 'approved').toList();
                                           return InkWell(
                                             onTap: () {
                                               if(homeController.homeData.value.result?.profileComplete == true
                                                   &&  homeController.homeData.value.result?.membershipStatus == true) {
                                                 Get.toNamed(
                                                     Routes.exploreView, arguments: activityData?[index].id.toString());
                                               } else {
                                                 homeController.showHomePop();
                                               }
                                             },
                                             child: Container(
                                               margin: const EdgeInsets.symmetric(vertical: 10),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   SizedBox(
                                                     height:
                                                     h * .26,
                                                     child: Stack(
                                                       children: [
                                                         CarouselSlider(
                                                           options: CarouselOptions(
                                                               height: h * .26,
                                                               enableInfiniteScroll: false,
                                                               viewportFraction: 1,
                                                               onPageChanged: (currIndex, CarouselPageChangedReason reason) {
                                                                 controller.changeIndicator(index, currIndex);
                                                                 debugPrint(" currIndex $currIndex reason=$reason");
                                                               }),
                                                           items: activityData?[index].banners?.map<Widget>((i) {
                                                             return Builder(
                                                               builder: (BuildContext context) {
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
                                                                       memCacheWidth: 500,
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
                                                                     )
                                                                 );
                                                               },
                                                             );
                                                           }).toList(),
                                                         ),
                                                         Padding(
                                                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                             children: [
                                                               Container(
                                                                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                 decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(20)),
                                                                 child: Text(
                                                                   '${activityData?[index].subcategoryTitle}',
                                                                   style: const TextStyle(fontWeight: FontWeight.w600),
                                                                 ),
                                                               ),
                                                               InkWell(
                                                                 onTap: () async {
                                                                   if(homeController.homeData.value.result?.profileComplete == true
                                                                       &&  homeController.homeData.value.result?.membershipStatus == true) {
                                                                     var id = activityData?[index].id.toString();
                                                                     await homeController.changeFavApi(id).then(
                                                                           (value) {
                                                                         if (value == true) {
                                                                           activityData?[index].isFav = !activityData[index].isFav!;
                                                                         }
                                                                       },
                                                                     );
                                                                     homeController.homeData.refresh();
                                                                   } else {
                                                                     homeController.showHomePop();
                                                                   }
                                                                 },
                                                                 child: Container(
                                                                   padding: const EdgeInsets.all(6),
                                                                   decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(100)),
                                                                   child: activityData?[index].isFav == true
                                                                       ? Icon(
                                                                     Icons.favorite,
                                                                     size: 20,
                                                                     color: clrYellow,
                                                                   )
                                                                       : const Icon(
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
                                                           child:
                                                           Container(
                                                             margin: const EdgeInsets.only(bottom: 7),
                                                             height: 16,
                                                             child: ListView.builder(
                                                                 itemCount: activityData?[index].banners?.length,
                                                                 shrinkWrap: true,
                                                                 scrollDirection: Axis.horizontal,
                                                                 itemBuilder: (context, indicatorIndex) {
                                                                   return Padding(
                                                                     padding: const EdgeInsets.symmetric(horizontal: 1.5),
                                                                     child: Obx(
                                                                           () => Icon(
                                                                         Icons.circle,
                                                                         color: activityData?[index].circleIndex?.value == indicatorIndex ? clrYellow : clrWhite,
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
                                                     height:
                                                     Get.height *
                                                         0.02,
                                                   ),
                                                   Row(
                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                     children: [
                                                       Flexible(
                                                         child:
                                                         Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             Text(
                                                               "${activityData?[index].name}",
                                                               style:
                                                               const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                             ),
                                                             SizedBox(
                                                               height:
                                                               h * .005,
                                                             ),
                                                              Text(
                                                               '${activityData?[index].location}',
                                                               style:
                                                               TextStyle(color: clrGreyDark),
                                                             ),
                                                             SizedBox(
                                                               height:
                                                               h * .005,
                                                             ),
                                                             Text(
                                                               '${activityData?[index].formattedDate} ${homeController.homeData.value.result?.profileComplete == true
                                                                   && homeController.homeData.value.result?.membershipStatus == true ? '| ${activityData?[index].startAt} - ${activityData?[index].endAt}' : ''}',
                                                               style:
                                                               TextStyle(color: clrGreyDark),
                                                             ),
                                                             SizedBox(
                                                               height:
                                                               h * .008,
                                                             ),
                                                             Text(
                                                               "Up to ${activityData?[index].maxPeople} people | ${activityData?[index].spotLeft} ${activityData![index].spotLeft! == 1 ? 'spot left' : 'spots left'}",
                                                               style: TextStyle(color: clrYellowText, fontSize: 13),
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                                       const SizedBox(
                                                         width: 5,
                                                       ),
                                                       InkWell(
                                                         onTap:
                                                             () {
                                                           if(homeController.homeData.value.result?.profileComplete == true
                                                               &&  homeController.homeData.value.result?.membershipStatus == true) {
                                                             Get.toNamed(Routes
                                                                 .hostProfileUi,
                                                                 arguments: activityData?[index]
                                                                     .hostId
                                                                     .toString());
                                                           }else{
                                                             homeController.showHomePop();
                                                           }
                                                         },
                                                         child:
                                                         Column(
                                                           crossAxisAlignment:
                                                           CrossAxisAlignment.center,
                                                           mainAxisAlignment:
                                                           MainAxisAlignment.center,
                                                           children: [
                                                             ClipRRect(
                                                               borderRadius:
                                                               BorderRadius.circular(100),
                                                               child:
                                                               CachedNetworkImage(
                                                                 height: 40,
                                                                 width: 40,
                                                                 fit: BoxFit.cover,
                                                                 memCacheWidth: 500,
                                                                 imageUrl: '${activityData?[index].profilePhoto}',
                                                                 errorWidget: (context, url, error) => Container(
                                                                   height: 40,
                                                                   width: 40,
                                                                   padding: const EdgeInsets.all(10),
                                                                   decoration: BoxDecoration(color: clrGreyLight, shape: BoxShape.circle),
                                                                   child: Image.asset(
                                                                     "assets/icons/manicon.png",
                                                                     color: clrGrey,
                                                                     fit: BoxFit.cover,
                                                                   ),
                                                                 ),
                                                                 placeholder: (context, url) => Shimmer.fromColors(
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
                                                             Text(
                                                               '${activityData?[index].hostName}',
                                                               style:
                                                               const TextStyle(fontWeight: FontWeight.w700),
                                                             )
                                                           ],
                                                         ),
                                                       )
                                                     ],
                                                   ),
                                                   SizedBox(
                                                     height:
                                                     Get.height *
                                                         0.015,
                                                   ),
                                                   Padding(
                                                     padding: const EdgeInsets.only(right: 13),
                                                     child: ReadMoreText(
                                                       '${activityData?[index].description}',
                                                       style: TextStyle(color: clrGreyDark),
                                                       trimMode: TrimMode.Line,
                                                       trimLines: 2,
                                                       colorClickableText: Colors.pink,
                                                       trimCollapsedText: 'Learn more',
                                                       trimExpandedText: 'Learn less',
                                                       moreStyle: TextStyle(
                                                           color: clrBlacke,
                                                           fontWeight: FontWeight.w700
                                                       ),
                                                       lessStyle: TextStyle(
                                                           color: clrBlacke,
                                                           fontWeight: FontWeight.w700
                                                       ),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                           );
                                         }),
                                   )
                                       : Center(
                                     child: NoActivityScreen(),
                                   )
                               ),
                             );
                           }),
                         ),
                         const SizedBox(
                           height: 15,
                         ),
                         Container(
                             height: 86,
                             child: CustomBottomNavbar(currentIndex: 6,)
                         )
                       ],
                     ),
                   ),
                 )
               ],
             )
         );
  }
}