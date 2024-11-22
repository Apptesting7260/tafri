import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/no_activity.dart';
import 'package:plusone/utils/size.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../networking/firebase_api.dart';
import 'controller/explorelist_controller.dart';

class ExploreUi extends GetWidget<ExploreListController> {
  const ExploreUi({super.key});

// var controller= Get.put(ExploreController());
  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(

      /// map icon in stack in homepage
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Align(
      //   alignment: Alignment.bottomCenter,
      //   child: Container(
      //     height: h * 0.070,
      //     padding: const EdgeInsets.only(bottom: 20),
      //     child: CustomElevatedButton(
      //         paddingHz: 10,
      //         onTap: () {
      //           if(controller.homeData.value.result?.membershipStatus == true && controller.homeData.value.result?.profileComplete == true) {
      //             Get.toNamed(Routes.mapActivityUi,
      //                 arguments: controller.homeData.value);
      //           }else{
      //             controller.showHomePop();
      //           }
      //           // FirebaseApi.snackBar1('How to create a custom Snackbar that displays at the top ', 'R Programming Tutorial is designed for beginners and experts. This free R Tutorial gives you knowledge basic to advanced of concepts of the R programming language');
      //         },
      //         backgroundClr: clrWhite,
      //         child: Row(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Image.asset(
      //               "assets/icons/mapbtnicon.png",
      //               height: 15,
      //             ),
      //             const SizedBox(
      //               width: 3,
      //             ),
      //             Text(
      //               "Map",
      //               style: TextStyle(
      //                   color: clrBlacke,
      //                   fontWeight: FontWeight.w600
      //               ),
      //             )
      //           ],
      //         )
      //     ),
      //   ),
      // ),
      /// map icon in stack in homepage


      body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
              // const SizedBox(
              //   height: 15,
              // ),


              /// search and filter
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Flexible(
              //         child: SizedBox(
              //             height: Get.height * .07,
              //             width: Get.width * 0.76,
              //             child:  CustoTextFormField(
              //               onTap: () {
              //                 Get.toNamed(Routes.searchActUi);
              //               },
              //               readonly: true,
              //               // hintText: "Anywhere • any week",
              //               hintText: 'Any activity',
              //               sufixIcon: const Icon(Icons.search),
              //             )
              //         ),
              //       ),
              //       SizedBox(
              //         width: w * .03,
              //       ),
              //       InkWell(
              //         onTap: () {
              //           Get.toNamed(Routes.filterExploreUi);
              //         },
              //         child: Image.asset(
              //           "assets/images/filtericon.png",
              //           height: Get.height * .058,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              /// search and filter


              // const SizedBox(
              //   height:110,
              // ),
              Obx(
                () =>
                    controller.homePageLoading.value &&
                            controller.homeData.value.result == null
                        ? Expanded(
                            child: Center(
                              child: CommonUi.scaffoldLoading(color: clrYellow),
                            ),
                          )
                        : controller.homeError.value.isNotEmpty
                            ? Expanded(
                                child: SmartRefresher(
                                onRefresh: () async {
                                  await controller.homePageApi();
                                  controller.refreshController1.refreshCompleted();
                                },
                                controller: controller.refreshController1,
                                header: CommonUi.refreshHeader(),
                                // WaterDropMaterialHeader(
                                //   color: clrWhite,
                                //   backgroundColor: clrYellow,
                                //   distance: 50,
                                // ),
                                child: const Center(
                                  child: ErrorScreen(),
                                ),
                              ))
                            : Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [

                                    /// categories
                                    // Container(
                                    //   height: h * .046,
                                    //   child: ListView.builder(
                                    //     padding: EdgeInsets.only(
                                    //         left: Res.Defalt_side_margin
                                    //     ),
                                    //     itemCount: (controller.homeData.value.result
                                    //                 ?.categories
                                    //                 ?.where((category) =>
                                    //                     category.status == '1')
                                    //                 .length ??
                                    //             0) +
                                    //         1,
                                    //     // Adding +1 for the "All" container
                                    //     shrinkWrap: true,
                                    //     scrollDirection: Axis.horizontal,
                                    //     itemBuilder: (context, index) {
                                    //       if (index == 0) {
                                    //         // "All" container
                                    //         return GestureDetector(
                                    //           onTap: () async {
                                    //             if (controller
                                    //                     .selectedIndex.value !=
                                    //                 index) {
                                    //               controller.selectedIndex.value =
                                    //                   index;
                                    //               controller.categoryID.value =
                                    //                   ''; // Use a special ID for "All"
                                    //               controller.allLoading.value =
                                    //                   true;
                                    //               await controller
                                    //                   .homePageApi(); // Fetch all data
                                    //               controller.allLoading.value =
                                    //                   false;
                                    //             }
                                    //           },
                                    //           child: Obx(
                                    //             () => Container(
                                    //               margin: const EdgeInsets.only(
                                    //                   right: 7),
                                    //               padding: const EdgeInsets.symmetric(
                                    //                 horizontal: 15,
                                    //               ),
                                    //               decoration: BoxDecoration(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(100),
                                    //                 color: controller.selectedIndex
                                    //                             .value ==
                                    //                         index
                                    //                     ? clrBlacke
                                    //                     : clrGreyLight,
                                    //               ),
                                    //               child: Center(
                                    //                 child: controller
                                    //                         .allLoading.value
                                    //                     ? CommonUi.fallingDot()
                                    //                     : Text(
                                    //                         'All',
                                    //                         style: TextStyle(
                                    //                           color: controller.selectedIndex.value == index
                                    //                               ? clrWhite : clrBlacke,
                                    //                           fontWeight:
                                    //                               FontWeight.w700,
                                    //                         ),
                                    //                       ),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         );
                                    //       } else {
                                    //         // Other categories
                                    //         var categoryData = controller
                                    //             .homeData.value.result?.categories
                                    //             ?.where((category) =>
                                    //                 category.status == '1')
                                    //             .toList();
                                    //         var categoryIndex = index -
                                    //             1; // Adjust index for the actual category
                                    //
                                    //         return GestureDetector(
                                    //           onTap: () async {
                                    //             if (controller.selectedIndex.value != index) {
                                    //               controller.selectedIndex.value = index;
                                    //               controller.categoryID.value = categoryData?[categoryIndex].id.toString();
                                    //               categoryData?[categoryIndex].loading?.value = true;
                                    //               await controller.homePageApi();
                                    //               categoryData?[categoryIndex].loading?.value = false;
                                    //             }
                                    //           },
                                    //           child: Obx(
                                    //             () => Container(
                                    //               margin: const EdgeInsets.only(
                                    //                   right: 7),
                                    //               padding:
                                    //                   categoryData![categoryIndex].loading!.value
                                    //                       ? const EdgeInsets.symmetric(
                                    //                           horizontal: 15,
                                    //                         )
                                    //                       : const EdgeInsets.only(
                                    //                           left: 4,
                                    //                           top: 1.5,
                                    //                           bottom: 1.5,
                                    //                           right: 10
                                    //                   ),
                                    //               decoration: BoxDecoration(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(100),
                                    //                 color: controller.selectedIndex.value == index
                                    //                     ? clrBlacke
                                    //                     : clrGreyLight,
                                    //               ),
                                    //               child: categoryData[categoryIndex]
                                    //                       .loading!
                                    //                       .value
                                    //                   ? CommonUi.fallingDot()
                                    //                   : Row(
                                    //                       children: [
                                    //                         ClipRRect(
                                    //                           borderRadius: BorderRadius.circular(
                                    //                               100
                                    //                           ),
                                    //                           child: CachedNetworkImage(
                                    //                             height: 28,
                                    //                             width: 28,
                                    //                             fit: BoxFit.cover,
                                    //                             imageUrl: '${categoryData[categoryIndex].icon}',
                                    //                             errorWidget: (context, url, error) =>
                                    //                                 Icon(
                                    //                                     Icons.error,
                                    //                                     color: clrBlacke
                                    //                                 ),
                                    //                           ),
                                    //                         ),
                                    //                         const SizedBox(
                                    //                             width: 5
                                    //                         ),
                                    //                         Text(
                                    //                           '${categoryData[categoryIndex].title}',
                                    //                           style: TextStyle(
                                    //                             color: controller.selectedIndex.value == index
                                    //                                 ? clrWhite
                                    //                                 : clrBlacke,
                                    //                             fontWeight: FontWeight.w700,
                                    //                           ),
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //             ),
                                    //           ),
                                    //         );
                                    //       }
                                    //     },
                                    //   ),
                                    // ),
                                    /// categories

                                    // SizedBox(
                                    //   height: Get.height * 0.013,
                                    // ),


                                    /// activities listing
                                    // Expanded(
                                    //   child: Obx(() {
                                    //     return Container(
                                    //       margin: EdgeInsets.symmetric(
                                    //           horizontal: Res.Defalt_side_margin),
                                    //       child: SmartRefresher(
                                    //           controller:
                                    //               controller.refreshController,
                                    //           onRefresh: () async {
                                    //             await controller.homePageApi();
                                    //             controller.refreshController.refreshCompleted();
                                    //           },
                                    //           // enablePullDown: controller.showRefreshIndicator.value,
                                    //           header: CommonUi.refreshHeader(),
                                    //           // WaterDropMaterialHeader(
                                    //           //   color: clrWhite,
                                    //           //   backgroundColor: clrYellow,
                                    //           //   distance: 50,
                                    //           // ),
                                    //           child: controller.homeData.value.result!.activities!.isEmpty
                                    //               ? Center(
                                    //                   child: NoActivityScreen(),
                                    //                 )
                                    //               : controller.homeData.value.result!.activities!
                                    //                 .where((element) => element.status == 'approved',).isNotEmpty
                                    //                   ? Padding(
                                    //                     padding: const EdgeInsets.only(bottom: 50.0),
                                    //                     child: ListView.builder(
                                    //                       physics: const ScrollPhysics(),
                                    //                         // controller: controller.scrollController,
                                    //                         itemCount: controller.homeData.value.result?.activities
                                    //                             ?.where((activity) => activity.status == 'approved').length,
                                    //                         shrinkWrap: true,
                                    //                         itemBuilder:
                                    //                             (context, index) {
                                    //                           var activityData = controller
                                    //                               .homeData
                                    //                               .value
                                    //                               .result
                                    //                               ?.activities
                                    //                               ?.where((activity) =>
                                    //                                   activity
                                    //                                       .status ==
                                    //                                   'approved')
                                    //                               .toList();
                                    //                           return InkWell(
                                    //                             onTap: () {
                                    //                               if(controller.homeData.value.result?.profileComplete == true
                                    //                                   &&  controller.homeData.value.result?.membershipStatus == true) {
                                    //                                 if(controller.homeData.value.result?.activities?[index].hostId.toString() == LocalStorage.getUid()){
                                    //                                   Get.toNamed(Routes.hostUpcommingActiview, arguments: controller.homeData.value.result?.activities?[index].id.toString());
                                    //                                 }else {
                                    //                                   Get.toNamed(
                                    //                                       Routes
                                    //                                           .exploreView,
                                    //                                       arguments: activityData?[index]
                                    //                                           .id
                                    //                                           .toString()
                                    //                                   );
                                    //                                 }
                                    //                               } else {
                                    //                                 controller.showHomePop();
                                    //                               }
                                    //                             },
                                    //                             child: Container(
                                    //                               margin:
                                    //                                   const EdgeInsets
                                    //                                       .symmetric(
                                    //                                       vertical:
                                    //                                           10),
                                    //                               child: Column(
                                    //                                 crossAxisAlignment:
                                    //                                     CrossAxisAlignment
                                    //                                         .start,
                                    //                                 children: [
                                    //                                   SizedBox(
                                    //                                     height:
                                    //                                         h * .26,
                                    //                                     child: Stack(
                                    //                                       children: [
                                    //                                         CarouselSlider(
                                    //                                           options: CarouselOptions(
                                    //                                               height: h * .26,
                                    //                                               viewportFraction: 1,
                                    //                                               onPageChanged: (currIndex, CarouselPageChangedReason reason) {
                                    //                                                 controller.changeIndicator(index, currIndex);
                                    //                                                 debugPrint(" currIndex $currIndex reason=$reason");
                                    //                                               }),
                                    //                                           items: activityData?[index]
                                    //                                               .banners
                                    //                                               ?.map<Widget>((i) {
                                    //                                             return Builder(
                                    //                                               builder:
                                    //                                                   (BuildContext context) {
                                    //                                                 return Container(
                                    //                                                     clipBehavior: Clip.hardEdge,
                                    //                                                     width: MediaQuery.of(context).size.width,
                                    //                                                     height: double.maxFinite,
                                    //                                                     margin: const EdgeInsets.symmetric(horizontal: 0),
                                    //                                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
                                    //                                                     child: CachedNetworkImage(
                                    //                                                       fit: BoxFit.cover,
                                    //                                                       height: h * .26,
                                    //                                                       width: double.maxFinite,
                                    //                                                       imageUrl: "$i",
                                    //                                                       placeholder: (context, url) => Shimmer.fromColors(
                                    //                                                         baseColor: grey300,
                                    //                                                         highlightColor: grey100,
                                    //                                                         child: Container(
                                    //                                                           width: double.maxFinite,
                                    //                                                           height: h * .26,
                                    //                                                           decoration: BoxDecoration(
                                    //                                                             color: grey300,
                                    //                                                             borderRadius: BorderRadius.circular(18),
                                    //                                                           ),
                                    //                                                         ),
                                    //                                                       ),
                                    //                                                     ));
                                    //                                               },
                                    //                                             );
                                    //                                           }).toList(),
                                    //                                         ),
                                    //                                         Padding(
                                    //                                           padding: const EdgeInsets
                                    //                                               .symmetric(
                                    //                                               horizontal:
                                    //                                                   10,
                                    //                                               vertical:
                                    //                                                   10),
                                    //                                           child:
                                    //                                               Row(
                                    //                                             mainAxisAlignment:
                                    //                                                 MainAxisAlignment.spaceBetween,
                                    //                                             children: [
                                    //                                               Container(
                                    //                                                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    //                                                 decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(20)),
                                    //                                                 child: Text(
                                    //                                                   '${activityData?[index].subcategoryTitle}',
                                    //                                                   style: const TextStyle(fontWeight: FontWeight.w600),
                                    //                                                 ),
                                    //                                               ),
                                    //                                               InkWell(
                                    //                                                 onTap: () async {
                                    //                                                   if(controller.homeData.value.result?.profileComplete == true
                                    //                                                       &&  controller.homeData.value.result?.membershipStatus == true) {
                                    //                                                     var id = activityData?[index].id.toString();
                                    //                                                     await controller.changeFavApi(id).then(
                                    //                                                           (value) {
                                    //                                                         if (value == true) {
                                    //                                                           activityData?[index].isFav = !activityData[index].isFav!;
                                    //                                                         }
                                    //                                                       },
                                    //                                                     );
                                    //
                                    //                                                     controller.homeData.refresh();
                                    //                                                   } else {
                                    //                                                     controller.showHomePop();
                                    //                                                   }
                                    //
                                    //                                                   // controller
                                    //                                                   //     .changeFav(
                                    //                                                   //         index);
                                    //                                                 },
                                    //                                                 child: Container(
                                    //                                                   padding: const EdgeInsets.all(6),
                                    //                                                   decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(100)),
                                    //                                                   child: activityData?[index].isFav == true
                                    //                                                       ? Icon(
                                    //                                                           Icons.favorite,
                                    //                                                           size: 20,
                                    //                                                           color: clrYellow,
                                    //                                                         )
                                    //                                                       : const Icon(
                                    //                                                           Icons.favorite_border,
                                    //                                                           size: 20,
                                    //                                                         ),
                                    //                                                 ),
                                    //                                               ),
                                    //                                             ],
                                    //                                           ),
                                    //                                         ),
                                    //                                         Align(
                                    //                                           alignment:
                                    //                                               Alignment.bottomCenter,
                                    //                                           child:
                                    //                                               Container(
                                    //                                             margin: const EdgeInsets
                                    //                                                 .only(
                                    //                                                 bottom: 7),
                                    //                                             height:
                                    //                                                 16,
                                    //                                             child: ListView.builder(
                                    //                                                 itemCount: activityData?[index].banners?.length,
                                    //                                                 shrinkWrap: true,
                                    //                                                 scrollDirection: Axis.horizontal,
                                    //                                                 itemBuilder: (context, indicatorIndex) {
                                    //                                                   return Padding(
                                    //                                                     padding: const EdgeInsets.symmetric(horizontal: 1.5),
                                    //                                                     child: Obx(
                                    //                                                       () => Icon(
                                    //                                                         Icons.circle,
                                    //                                                         color: activityData?[index].circleIndex?.value == indicatorIndex ? clrYellow : clrWhite,
                                    //                                                         size: 8,
                                    //                                                       ),
                                    //                                                     ),
                                    //                                                   );
                                    //                                                 }),
                                    //                                           ),
                                    //                                         )
                                    //                                       ],
                                    //                                     ),
                                    //                                   ),
                                    //                                   SizedBox(
                                    //                                     height:
                                    //                                         Get.height *
                                    //                                             0.02,
                                    //                                   ),
                                    //                                   Row(
                                    //                                     mainAxisAlignment:
                                    //                                         MainAxisAlignment
                                    //                                             .spaceBetween,
                                    //                                     crossAxisAlignment:
                                    //                                         CrossAxisAlignment
                                    //                                             .center,
                                    //                                     children: [
                                    //                                       Flexible(
                                    //                                         child:
                                    //                                             Column(
                                    //                                           crossAxisAlignment:
                                    //                                               CrossAxisAlignment.start,
                                    //                                           children: [
                                    //                                             Text(
                                    //                                               "${activityData?[index].name}",
                                    //                                               style:
                                    //                                                   const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    //                                             ),
                                    //                                             SizedBox(
                                    //                                               height:
                                    //                                                   h * .005,
                                    //                                             ),
                                    //                                             Text(
                                    //                                               '${activityData?[index].location}',
                                    //                                               style:
                                    //                                                   TextStyle(color: clrGreyDark),
                                    //                                             ),
                                    //                                             SizedBox(
                                    //                                               height:
                                    //                                                   h * .005,
                                    //                                             ),
                                    //                                             Text(
                                    //                                               '${activityData?[index].formattedDate} ${controller.homeData.value.result?.membershipStatus == true && controller.homeData.value.result?.profileComplete == true ? '| ${activityData?[index].startAt} - ${activityData?[index].endAt}' : ''} ',
                                    //                                               style:
                                    //                                                   TextStyle(color: clrGreyDark),
                                    //                                             ),
                                    //                                             SizedBox(
                                    //                                               height:
                                    //                                                   h * .008,
                                    //                                             ),
                                    //                                             Text(
                                    //                                               "Up to ${activityData?[index].maxPeople} people | ${activityData?[index].spotLeft} ${activityData![index].spotLeft! == 1 ? 'spot left' : 'spots left'}",
                                    //                                               style: TextStyle(color: clrYellowText, fontSize: 13),
                                    //                                             ),
                                    //
                                    //                                             // Text(
                                    //                                             //   "Up to ${activityData?[index].maxPeople} people | "${activityData?[index].spotLeft} ${activityData?[index].spotLeft > 1 ? 'spots left' : 'spot left'}"
                                    //                                             //     style:
                                    //                                             //       TextStyle(color: clrYellowText, fontSize: 13),
                                    //                                             // ),
                                    //                                           ],
                                    //                                         ),
                                    //                                       ),
                                    //                                       const SizedBox(
                                    //                                         width: 5,
                                    //                                       ),
                                    //                                       InkWell(
                                    //                                         onTap:
                                    //                                             () {
                                    //                                           if(controller.homeData.value.result?.profileComplete == true && controller.homeData.value.result?.membershipStatus == true) {
                                    //                                             Get.toNamed(
                                    //                                                 Routes
                                    //                                                     .hostProfileUi,
                                    //                                                 arguments: activityData?[index]
                                    //                                                     .hostId
                                    //                                                     .toString());
                                    //                                           }else{
                                    //                                             controller.showHomePop();
                                    //                                           }
                                    //                                         },
                                    //                                         child:
                                    //                                             Column(
                                    //                                           crossAxisAlignment:
                                    //                                               CrossAxisAlignment.center,
                                    //                                           mainAxisAlignment:
                                    //                                               MainAxisAlignment.center,
                                    //                                           children: [
                                    //                                             ClipRRect(
                                    //                                               borderRadius:
                                    //                                                   BorderRadius.circular(100),
                                    //                                               child:
                                    //                                                   CachedNetworkImage(
                                    //                                                 height: 40,
                                    //                                                 width: 40,
                                    //                                                 fit: BoxFit.cover,
                                    //                                                 imageUrl: '${activityData?[index].profilePhoto}',
                                    //                                                 errorWidget: (context, url, error) => Container(
                                    //                                                   height: 40,
                                    //                                                   width: 40,
                                    //                                                   padding: const EdgeInsets.all(10),
                                    //                                                   decoration: BoxDecoration(color: clrGreyLight, shape: BoxShape.circle),
                                    //                                                   child: Image.asset(
                                    //                                                     "assets/icons/manicon.png",
                                    //                                                     color: clrGrey,
                                    //                                                     fit: BoxFit.cover,
                                    //                                                   ),
                                    //                                                 ),
                                    //                                                 placeholder: (context, url) => Shimmer.fromColors(
                                    //                                                   baseColor: grey300,
                                    //                                                   highlightColor: grey100,
                                    //                                                   child: Container(
                                    //                                                     height: 40,
                                    //                                                     width: 40,
                                    //                                                     decoration: BoxDecoration(
                                    //                                                       color: grey300,
                                    //                                                       borderRadius: BorderRadius.circular(18),
                                    //                                                     ),
                                    //                                                   ),
                                    //                                                 ),
                                    //                                               ),
                                    //                                             ),
                                    //                                             const SizedBox(height: 3,),
                                    //                                             Text(
                                    //                                               '${activityData?[index].hostName}',
                                    //                                               style:
                                    //                                                   const TextStyle(fontWeight: FontWeight.w700),
                                    //                                             )
                                    //                                           ],
                                    //                                         ),
                                    //                                       )
                                    //                                     ],
                                    //                                   ),
                                    //                                   SizedBox(
                                    //                                     height:
                                    //                                         Get.height *
                                    //                                             0.015,
                                    //                                   ),
                                    //                                   Padding(
                                    //                                     padding: const EdgeInsets.only(right: 13),
                                    //                                     child: ReadMoreText(
                                    //                                       '${activityData?[index].description}',
                                    //                                       style: TextStyle(
                                    //                                           color:
                                    //                                               clrGreyDark),
                                    //                                       trimMode:
                                    //                                           TrimMode
                                    //                                               .Line,
                                    //                                       trimLines: 2,
                                    //                                       colorClickableText:
                                    //                                           Colors
                                    //                                               .pink,
                                    //                                       trimCollapsedText:
                                    //                                           'Learn more',
                                    //                                       trimExpandedText:
                                    //                                           'Learn less',
                                    //                                       moreStyle: TextStyle(
                                    //                                           color:
                                    //                                               clrBlacke,
                                    //                                           fontWeight:
                                    //                                               FontWeight
                                    //                                                   .w700),
                                    //                                       lessStyle: TextStyle(
                                    //                                           color:
                                    //                                           clrBlacke,
                                    //                                           fontWeight:
                                    //                                           FontWeight
                                    //                                               .w700),
                                    //                                     ),
                                    //                                   ),
                                    //                                 ],
                                    //                               ),
                                    //                             ),
                                    //                           );
                                    //                         }),
                                    //                   )
                                    //                   : Center(
                                    //                       child: NoActivityScreen(),
                                    //                     )),
                                    //     );
                                    //   }),
                                    // ),
                                    /// activities listing



                                    /// map added in home page
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: Get.height*0.17,bottom: Get.height*0.03),
                                        child: GoogleMap(
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
                                            zoom: 9.0,
                                          ),
                                          myLocationEnabled: true,
                                          myLocationButtonEnabled: true,
                                          markers: Set<Marker>.of(controller.markers),
                                          // mapType: MapType.hybrid,
                                        ),
                                      ),
                                    ),
                                    /// map


                                    // const SizedBox(
                                    //   height: 15,
                                    // ),
                                  ],
                                ),
                              ),
              ),
                ],
              ),



              // DraggableScrollableSheet(
              //   initialChildSize: 0.3,
              //   minChildSize: 0.1,
              //   maxChildSize: 0.9,
              //   // controller: controller.dragController,
              //   builder: (context, scrollController) {
              //   return Container(
              //     decoration: const BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              //     ),
              //     child: Column(
              //       children: [
              //         Container(
              //           height: 5,
              //           width: 40,
              //           margin: const EdgeInsets.symmetric(vertical: 8.0),
              //           decoration: BoxDecoration(
              //             color: Colors.black.withOpacity(0.3),
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //         Expanded(
              //           child: Obx(() {
              //             return Container(
              //               margin: EdgeInsets.symmetric(
              //                   horizontal: Res.Defalt_side_margin),
              //               child: SmartRefresher(
              //                   controller: controller.refreshController,
              //                   onRefresh: () async {
              //                     await controller.homePageApi();
              //                     controller.refreshController.refreshCompleted();
              //                   },
              //                   header: CommonUi.refreshHeader(),
              //                   child: controller.homeData.value.result!.activities!.isEmpty
              //                       ? Center(
              //                     child: NoActivityScreen(),
              //                   )
              //                       : controller.homeData.value.result!.activities!
              //                       .where((element) => element.status == 'approved',).isNotEmpty
              //                       ? Padding(
              //                     padding: const EdgeInsets.only(bottom: 50.0,top: 20),
              //                     child: ListView.builder(
              //                         // physics: BouncingScrollPhysics(),
              //                         // controller: scrollController,
              //                         // controller: controller.scrollController,
              //                         itemCount: controller.homeData.value.result?.activities
              //                             ?.where((activity) => activity.status == 'approved').length,
              //                         shrinkWrap: true,
              //                         itemBuilder:
              //                             (context, index) {
              //                           var activityData = controller
              //                               .homeData
              //                               .value
              //                               .result
              //                               ?.activities
              //                               ?.where((activity) =>
              //                           activity
              //                               .status ==
              //                               'approved')
              //                               .toList();
              //                           return InkWell(
              //                             onTap: () {
              //                               if(controller.homeData.value.result?.profileComplete == true
              //                                   &&  controller.homeData.value.result?.membershipStatus == true) {
              //                                 if(controller.homeData.value.result?.activities?[index].hostId.toString() == LocalStorage.getUid()){
              //                                   Get.toNamed(Routes.hostUpcommingActiview, arguments: controller.homeData.value.result?.activities?[index].id.toString());
              //                                 }else {
              //                                   Get.toNamed(
              //                                       Routes
              //                                           .exploreView,
              //                                       arguments: activityData?[index]
              //                                           .id
              //                                           .toString()
              //                                   );
              //                                 }
              //                               } else {
              //                                 controller.showHomePop();
              //                               }
              //                             },
              //                             child: Container(
              //                               margin:
              //                               const EdgeInsets
              //                                   .symmetric(
              //                                   vertical:
              //                                   10),
              //                               child: Column(
              //                                 crossAxisAlignment:
              //                                 CrossAxisAlignment
              //                                     .start,
              //                                 children: [
              //                                   SizedBox(
              //                                     height:
              //                                     h * .26,
              //                                     child: Stack(
              //                                       children: [
              //                                         CarouselSlider(
              //                                           options: CarouselOptions(
              //                                               height: h * .26,
              //                                               viewportFraction: 1,
              //                                               onPageChanged: (currIndex, CarouselPageChangedReason reason) {
              //                                                 controller.changeIndicator(index, currIndex);
              //                                                 debugPrint(" currIndex $currIndex reason=$reason");
              //                                               }),
              //                                           items: activityData?[index]
              //                                               .banners
              //                                               ?.map<Widget>((i) {
              //                                             return Builder(
              //                                               builder:
              //                                                   (BuildContext context) {
              //                                                 return Container(
              //                                                     clipBehavior: Clip.hardEdge,
              //                                                     width: MediaQuery.of(context).size.width,
              //                                                     height: double.maxFinite,
              //                                                     margin: const EdgeInsets.symmetric(horizontal: 0),
              //                                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
              //                                                     child: CachedNetworkImage(
              //                                                       fit: BoxFit.cover,
              //                                                       height: h * .26,
              //                                                       width: double.maxFinite,
              //                                                       imageUrl: "$i",
              //                                                       placeholder: (context, url) => Shimmer.fromColors(
              //                                                         baseColor: grey300,
              //                                                         highlightColor: grey100,
              //                                                         child: Container(
              //                                                           width: double.maxFinite,
              //                                                           height: h * .26,
              //                                                           decoration: BoxDecoration(
              //                                                             color: grey300,
              //                                                             borderRadius: BorderRadius.circular(18),
              //                                                           ),
              //                                                         ),
              //                                                       ),
              //                                                     ));
              //                                               },
              //                                             );
              //                                           }).toList(),
              //                                         ),
              //                                         Padding(
              //                                           padding: const EdgeInsets
              //                                               .symmetric(
              //                                               horizontal:
              //                                               10,
              //                                               vertical:
              //                                               10),
              //                                           child:
              //                                           Row(
              //                                             mainAxisAlignment:
              //                                             MainAxisAlignment.spaceBetween,
              //                                             children: [
              //                                               Container(
              //                                                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //                                                 decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(20)),
              //                                                 child: Text(
              //                                                   '${activityData?[index].subcategoryTitle}',
              //                                                   style: const TextStyle(fontWeight: FontWeight.w600),
              //                                                 ),
              //                                               ),
              //                                               InkWell(
              //                                                 onTap: () async {
              //                                                   if(controller.homeData.value.result?.profileComplete == true
              //                                                       &&  controller.homeData.value.result?.membershipStatus == true) {
              //                                                     var id = activityData?[index].id.toString();
              //                                                     await controller.changeFavApi(id).then(
              //                                                           (value) {
              //                                                         if (value == true) {
              //                                                           activityData?[index].isFav = !activityData[index].isFav!;
              //                                                         }
              //                                                       },
              //                                                     );
              //
              //                                                     controller.homeData.refresh();
              //                                                   } else {
              //                                                     controller.showHomePop();
              //                                                   }
              //
              //                                                   // controller
              //                                                   //     .changeFav(
              //                                                   //         index);
              //                                                 },
              //                                                 child: Container(
              //                                                   padding: const EdgeInsets.all(6),
              //                                                   decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(100)),
              //                                                   child: activityData?[index].isFav == true
              //                                                       ? Icon(
              //                                                     Icons.favorite,
              //                                                     size: 20,
              //                                                     color: clrYellow,
              //                                                   )
              //                                                       : const Icon(
              //                                                     Icons.favorite_border,
              //                                                     size: 20,
              //                                                   ),
              //                                                 ),
              //                                               ),
              //                                             ],
              //                                           ),
              //                                         ),
              //                                         Align(
              //                                           alignment:
              //                                           Alignment.bottomCenter,
              //                                           child:
              //                                           Container(
              //                                             margin: const EdgeInsets
              //                                                 .only(
              //                                                 bottom: 7),
              //                                             height:
              //                                             16,
              //                                             child: ListView.builder(
              //                                                 itemCount: activityData?[index].banners?.length,
              //                                                 shrinkWrap: true,
              //                                                 scrollDirection: Axis.horizontal,
              //                                                 itemBuilder: (context, indicatorIndex) {
              //                                                   return Padding(
              //                                                     padding: const EdgeInsets.symmetric(horizontal: 1.5),
              //                                                     child: Obx(
              //                                                           () => Icon(
              //                                                         Icons.circle,
              //                                                         color: activityData?[index].circleIndex?.value == indicatorIndex ? clrYellow : clrWhite,
              //                                                         size: 8,
              //                                                       ),
              //                                                     ),
              //                                                   );
              //                                                 }),
              //                                           ),
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   SizedBox(
              //                                     height:
              //                                     Get.height *
              //                                         0.02,
              //                                   ),
              //                                   Row(
              //                                     mainAxisAlignment:
              //                                     MainAxisAlignment
              //                                         .spaceBetween,
              //                                     crossAxisAlignment:
              //                                     CrossAxisAlignment
              //                                         .center,
              //                                     children: [
              //                                       Flexible(
              //                                         child:
              //                                         Column(
              //                                           crossAxisAlignment:
              //                                           CrossAxisAlignment.start,
              //                                           children: [
              //                                             Text(
              //                                               "${activityData?[index].name}",
              //                                               style:
              //                                               const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              //                                             ),
              //                                             SizedBox(
              //                                               height:
              //                                               h * .005,
              //                                             ),
              //                                             Text(
              //                                               '${activityData?[index].location}',
              //                                               style:
              //                                               TextStyle(color: clrGreyDark),
              //                                             ),
              //                                             SizedBox(
              //                                               height:
              //                                               h * .005,
              //                                             ),
              //                                             Text(
              //                                               '${activityData?[index].formattedDate} ${controller.homeData.value.result?.membershipStatus == true && controller.homeData.value.result?.profileComplete == true ? '| ${activityData?[index].startAt} - ${activityData?[index].endAt}' : ''} ',
              //                                               style:
              //                                               TextStyle(color: clrGreyDark),
              //                                             ),
              //                                             SizedBox(
              //                                               height:
              //                                               h * .008,
              //                                             ),
              //                                             Text(
              //                                               "Up to ${activityData?[index].maxPeople} people | ${activityData?[index].spotLeft} ${activityData![index].spotLeft! == 1 ? 'spot left' : 'spots left'}",
              //                                               style: TextStyle(color: clrYellowText, fontSize: 13),
              //                                             ),
              //
              //                                             // Text(
              //                                             //   "Up to ${activityData?[index].maxPeople} people | "${activityData?[index].spotLeft} ${activityData?[index].spotLeft > 1 ? 'spots left' : 'spot left'}"
              //                                             //     style:
              //                                             //       TextStyle(color: clrYellowText, fontSize: 13),
              //                                             // ),
              //                                           ],
              //                                         ),
              //                                       ),
              //                                       const SizedBox(
              //                                         width: 5,
              //                                       ),
              //                                       InkWell(
              //                                         onTap:
              //                                             () {
              //                                           if(controller.homeData.value.result?.profileComplete == true && controller.homeData.value.result?.membershipStatus == true) {
              //                                             Get.toNamed(
              //                                                 Routes
              //                                                     .hostProfileUi,
              //                                                 arguments: activityData?[index]
              //                                                     .hostId
              //                                                     .toString());
              //                                           }else{
              //                                             controller.showHomePop();
              //                                           }
              //                                         },
              //                                         child:
              //                                         Column(
              //                                           crossAxisAlignment:
              //                                           CrossAxisAlignment.center,
              //                                           mainAxisAlignment:
              //                                           MainAxisAlignment.center,
              //                                           children: [
              //                                             ClipRRect(
              //                                               borderRadius:
              //                                               BorderRadius.circular(100),
              //                                               child:
              //                                               CachedNetworkImage(
              //                                                 height: 40,
              //                                                 width: 40,
              //                                                 fit: BoxFit.cover,
              //                                                 imageUrl: '${activityData?[index].profilePhoto}',
              //                                                 errorWidget: (context, url, error) => Container(
              //                                                   height: 40,
              //                                                   width: 40,
              //                                                   padding: const EdgeInsets.all(10),
              //                                                   decoration: BoxDecoration(color: clrGreyLight, shape: BoxShape.circle),
              //                                                   child: Image.asset(
              //                                                     "assets/icons/manicon.png",
              //                                                     color: clrGrey,
              //                                                     fit: BoxFit.cover,
              //                                                   ),
              //                                                 ),
              //                                                 placeholder: (context, url) => Shimmer.fromColors(
              //                                                   baseColor: grey300,
              //                                                   highlightColor: grey100,
              //                                                   child: Container(
              //                                                     height: 40,
              //                                                     width: 40,
              //                                                     decoration: BoxDecoration(
              //                                                       color: grey300,
              //                                                       borderRadius: BorderRadius.circular(18),
              //                                                     ),
              //                                                   ),
              //                                                 ),
              //                                               ),
              //                                             ),
              //                                             const SizedBox(height: 3,),
              //                                             Text(
              //                                               '${activityData?[index].hostName}',
              //                                               style:
              //                                               const TextStyle(fontWeight: FontWeight.w700),
              //                                             )
              //                                           ],
              //                                         ),
              //                                       )
              //                                     ],
              //                                   ),
              //                                   SizedBox(
              //                                     height:
              //                                     Get.height *
              //                                         0.015,
              //                                   ),
              //                                   Padding(
              //                                     padding: const EdgeInsets.only(right: 13),
              //                                     child: ReadMoreText(
              //                                       '${activityData?[index].description}',
              //                                       style: TextStyle(
              //                                           color:
              //                                           clrGreyDark),
              //                                       trimMode:
              //                                       TrimMode
              //                                           .Line,
              //                                       trimLines: 2,
              //                                       colorClickableText:
              //                                       Colors
              //                                           .pink,
              //                                       trimCollapsedText:
              //                                       'Learn more',
              //                                       trimExpandedText:
              //                                       'Learn less',
              //                                       moreStyle: TextStyle(
              //                                           color:
              //                                           clrBlacke,
              //                                           fontWeight:
              //                                           FontWeight
              //                                               .w700),
              //                                       lessStyle: TextStyle(
              //                                         color:
              //                                         clrBlacke,
              //                                         fontWeight:
              //                                         FontWeight
              //                                             .w700),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                             ),
              //                           );
              //                         }),
              //                   )
              //                       : Center(
              //                     child: NoActivityScreen(),
              //                   )),
              //             );
              //           }),
              //         ),
              //       ],
              //     ),
              //   );
              // },),


              /// slideable
              Obx(() => controller.homePageLoading.value && controller.homeData.value.result == null ? SizedBox() : controller.homeError.value.isNotEmpty ? SizedBox() : SlidingUpPanel(
                minHeight: 40,
                maxHeight: Get.height * .77,
                controller: controller.panelController,
                defaultPanelState: PanelState.OPEN,
                color: Colors.transparent,
                isDraggable: (controller.homeData.value.result?.membershipStatus == true && controller.homeData.value.result?.profileComplete == true) ? true : false,
                onPanelSlide: (position) {
                  controller.bottomBarOffset.value = position;
                },
                collapsed: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 5,
                    width: 40,
                    margin: const EdgeInsets.symmetric(vertical: 14.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                panel: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Obx(() {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Res.Defalt_side_margin),
                            child: controller.homeData.value.result!.activities!.isEmpty
                                ? Center(
                              child: NoActivityScreen(),
                            )
                                : controller.homeData.value.result!.activities!
                                .where((element) => element.status == 'approved',).isNotEmpty
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 0.0,top: 30),
                              child: ListView.builder(
                                  controller:controller.scrollController,
                                  physics: controller.isTop.value ? BouncingScrollPhysics() : AlwaysScrollableScrollPhysics(),
                                  itemCount: controller.homeData.value.result?.activities
                                      ?.where((activity) => activity.status == 'approved').length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (context, index) {
                                    var activityData = controller
                                        .homeData
                                        .value
                                        .result
                                        ?.activities
                                        ?.where((activity) =>
                                    activity
                                        .status ==
                                        'approved')
                                        .toList();
                                    return InkWell(
                                      onTap: () {
                                        if(controller.homeData.value.result?.profileComplete == true
                                            &&  controller.homeData.value.result?.membershipStatus == true) {
                                          if(controller.homeData.value.result?.activities?[index].hostId.toString() == LocalStorage.getUid()){
                                            Get.toNamed(Routes.hostUpcommingActiview, arguments: controller.homeData.value.result?.activities?[index].id.toString());
                                          }else {
                                            Get.toNamed(
                                                Routes
                                                    .exploreView,
                                                arguments: activityData?[index]
                                                    .id
                                                    .toString()
                                            );
                                          }
                                        } else {
                                          controller.showHomePop();
                                        }
                                      },
                                      child: Container(
                                        margin:
                                        const EdgeInsets
                                            .symmetric(
                                            vertical:
                                            10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
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
                                                    items: activityData?[index]
                                                        .banners
                                                        ?.map<Widget>((i) {
                                                      return Builder(
                                                        builder:
                                                            (BuildContext context) {
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        10,
                                                        vertical:
                                                        10),
                                                    child:
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
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
                                                            if(controller.homeData.value.result?.profileComplete == true
                                                                &&  controller.homeData.value.result?.membershipStatus == true) {
                                                              var id = activityData?[index].id.toString();
                                                              await controller.changeFavApi(id).then(
                                                                    (value) {
                                                                  if (value == true) {
                                                                    activityData?[index].isFav = !activityData[index].isFav!;
                                                                  }
                                                                },
                                                              );

                                                              controller.homeData.refresh();
                                                            } else {
                                                              controller.showHomePop();
                                                            }

                                                            // controller
                                                            //     .changeFav(
                                                            //         index);
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
                                                    alignment:
                                                    Alignment.bottomCenter,
                                                    child:
                                                    Container(
                                                      margin: const EdgeInsets
                                                          .only(
                                                          bottom: 7),
                                                      height:
                                                      16,
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
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Flexible(
                                                  child:
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                        '${activityData?[index].formattedDate} ${controller.homeData.value.result?.membershipStatus == true && controller.homeData.value.result?.profileComplete == true ? '| ${activityData?[index].startAt} - ${activityData?[index].endAt}' : ''} ',
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

                                                      // Text(
                                                      //   "Up to ${activityData?[index].maxPeople} people | "${activityData?[index].spotLeft} ${activityData?[index].spotLeft > 1 ? 'spots left' : 'spot left'}"
                                                      //     style:
                                                      //       TextStyle(color: clrYellowText, fontSize: 13),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                InkWell(
                                                  onTap:
                                                      () {
                                                    if(controller.homeData.value.result?.profileComplete == true && controller.homeData.value.result?.membershipStatus == true) {
                                                      Get.toNamed(
                                                          Routes
                                                              .hostProfileUi,
                                                          arguments: activityData?[index]
                                                              .hostId
                                                              .toString());
                                                    }else{
                                                      controller.showHomePop();
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
                                                      const SizedBox(height: 3,),
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
                                                style: TextStyle(
                                                    color:
                                                    clrGreyDark),
                                                trimMode:
                                                TrimMode
                                                    .Line,
                                                trimLines: 2,
                                                colorClickableText:
                                                Colors
                                                    .pink,
                                                trimCollapsedText:
                                                'Learn more',
                                                trimExpandedText:
                                                'Learn less',
                                                moreStyle: TextStyle(
                                                    color:
                                                    clrBlacke,
                                                    fontWeight:
                                                    FontWeight
                                                        .w700),
                                                lessStyle: TextStyle(
                                                    color:
                                                    clrBlacke,
                                                    fontWeight:
                                                    FontWeight
                                                        .w700),
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
                            ),
                          ),
                        ),

                        Container(
                          height: h * 0.070,
                          padding: const EdgeInsets.only(bottom: 20),
                          margin: EdgeInsets.only(bottom: 15),
                          child: CustomElevatedButton(
                              paddingHz: 10,
                              onTap: () {
                                if(controller.homeData.value.result?.membershipStatus == true && controller.homeData.value.result?.profileComplete == true) {
                                  if(controller.panelController.isPanelOpen){
                                    controller.panelController.animatePanelToPosition(0,duration: Duration(milliseconds: 500));
                                    controller.scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
                                  }
                                  // Get.toNamed(Routes.mapActivityUi,
                                  //     arguments: controller.homeData.value);
                                }else{
                                  controller.showHomePop();
                                }
                                // FirebaseApi.snackBar1('How to create a custom Snackbar that displays at the top ', 'R Programming Tutorial is designed for beginners and experts. This free R Tutorial gives you knowledge basic to advanced of concepts of the R programming language');
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
                                    style: TextStyle(
                                        color: clrBlacke,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),

                      ],
                    );
                  }),
                ),
              ),),
              /// slideable


              /// search and category
             Obx(() => controller.homePageLoading.value && controller.homeData.value.result == null ? SizedBox() : controller.homeError.value.isNotEmpty ? SizedBox() : Container(
               height: Get.height*0.18,
               color: clrWhite,
               child: Column(
                 children: [
                   Padding(
                     padding: EdgeInsets.only(left: Res.Defalt_side_margin,right: Res.Defalt_side_margin,top: 20),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Flexible(
                           child: SizedBox(
                               height: Get.height * .07,
                               width: Get.width * 0.76,
                               child:  CustoTextFormField(
                                 onTap: () {
                                   Get.toNamed(Routes.searchActUi);
                                 },
                                 readonly: true,
                                 // hintText: "Anywhere • any week",
                                 hintText: 'Any activity',
                                 sufixIcon: const Icon(Icons.search),
                               )
                           ),
                         ),
                         SizedBox(
                           width: w * .03,
                         ),
                         InkWell(
                           onTap: () {
                             Get.toNamed(Routes.filterExploreUi);
                           },
                           child: Image.asset(
                             "assets/images/filtericon.png",
                             height: Get.height * .058,
                           ),
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(
                     height: 15,
                   ),
                   Container(
                     height: h * .046,
                     child: ListView.builder(
                       padding: EdgeInsets.only(
                           left: Res.Defalt_side_margin
                       ),
                       itemCount: (controller.homeData.value.result
                           ?.categories
                           ?.where((category) =>
                       category.status == '1')
                           .length ??
                           0) +
                           1,
                       // Adding +1 for the "All" container
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context, index) {
                         if (index == 0) {
                           // "All" container
                           return GestureDetector(
                             onTap: () async {
                               if (controller
                                   .selectedIndex.value !=
                                   index) {
                                 controller.selectedIndex.value =
                                     index;
                                 controller.categoryID.value =
                                 ''; // Use a special ID for "All"
                                 controller.allLoading.value =
                                 true;
                                 await controller
                                     .homePageApi(); // Fetch all data
                                 controller.allLoading.value =
                                 false;
                               }
                             },
                             child: Obx(
                                   () => Container(
                                 margin: const EdgeInsets.only(
                                     right: 7),
                                 padding: const EdgeInsets.symmetric(
                                   horizontal: 15,
                                 ),
                                 decoration: BoxDecoration(
                                   borderRadius:
                                   BorderRadius.circular(100),
                                   color: controller.selectedIndex
                                       .value ==
                                       index
                                       ? clrBlacke
                                       : clrGreyLight,
                                 ),
                                 child: Center(
                                   child: controller
                                       .allLoading.value
                                       ? CommonUi.fallingDot()
                                       : Text(
                                     'All',
                                     style: TextStyle(
                                       color: controller.selectedIndex.value == index
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
                           var categoryData = controller
                               .homeData.value.result?.categories
                               ?.where((category) =>
                           category.status == '1')
                               .toList();
                           var categoryIndex = index -
                               1; // Adjust index for the actual category

                           return GestureDetector(
                             onTap: () async {
                               if (controller.selectedIndex.value != index) {
                                 controller.selectedIndex.value = index;
                                 controller.categoryID.value = categoryData?[categoryIndex].id.toString();
                                 categoryData?[categoryIndex].loading?.value = true;
                                 await controller.homePageApi();
                                 categoryData?[categoryIndex].loading?.value = false;
                               }
                             },
                             child: Obx(
                                   () => Container(
                                 margin: const EdgeInsets.only(
                                     right: 7),
                                 padding:
                                 categoryData![categoryIndex].loading!.value
                                     ? const EdgeInsets.symmetric(
                                   horizontal: 15,
                                 )
                                     : const EdgeInsets.only(
                                     left: 4,
                                     top: 1.5,
                                     bottom: 1.5,
                                     right: 10
                                 ),
                                 decoration: BoxDecoration(
                                   borderRadius:
                                   BorderRadius.circular(100),
                                   color: controller.selectedIndex.value == index
                                       ? clrBlacke
                                       : clrGreyLight,
                                 ),
                                 child: categoryData[categoryIndex]
                                     .loading!
                                     .value
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
                                         color: controller.selectedIndex.value == index
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
                 ],
               ),
             ),)
              /// search and category



            ],
          )),


    );
  }
}
