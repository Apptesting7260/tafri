
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/uis/explore/hostprofile/hostprofileui.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/activity/previousactivity/controller/previousacti_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/custom_radio.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../utils/local_storage.dart';


class PreviousActivityUi extends GetWidget<PreviousActiController>{
  PreviousActivityUi({super.key});

  // ExploreViewController exploreViewController=Get.put(ExploreViewController());

  final ExploreListController exploreListController =
  Get.find<ExploreListController>();

  final formkey = GlobalKey<FormState>();

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
                SizedBox(
                height: h*.012,
              ),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Container(
                  //     clipBehavior: Clip.hardEdge,
                  //     width: h*.05,
                  //     height: h*.05,
                  //     padding:
                  //     const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //     decoration: BoxDecoration(
                  //         color: clrGreyLight,
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: const Center(child: Icon(Icons.arrow_back_ios)),
                  //   ),
                  // ),
                  CommonUi.appBar(),
                  const Expanded(
                      child: Center(
                          child: Text(
                            "Activity",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                          )
                      )
                  ),
                  controller.actData.value.activity?.status == 'pending' ?  InkWell(
                    onTap: () {
                    },
                    child: Image.asset("assets/icons/edits.png",height: 34,width: 34,),
                  ) : Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Share.share('${controller.actData.value.activitySettings?.shareText} https://urlsdemo.online/activity?activityid=${controller.actData.value.activity?.id}&hostId=${controller.actData.value.activity?.hostId}');
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: w * .1,
                          height: h * .05,
                          decoration: BoxDecoration(
                            color: clrBlacke,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset("assets/icons/uploadicon.png",color: clrWhite, height: h * .06,
                              width: w * .06,),//
                          ),
                        ),
                      ),

                      // SizedBox(
                      //   width: 20,
                      //   child: PopupMenuButton(
                      //
                      //     elevation: 5,
                      //     itemBuilder: (context) => [
                      //       const PopupMenuItem(
                      //         value: 1,
                      //         child: Text("Report"),
                      //       )
                      //     ],
                      //     onSelected: (val) {
                      //       if (val == 1) {
                      //         alertActivityReport();
                      //       }
                      //     },
                      //   ),
                      // ),
                      SizedBox(
                        width: w * 0.07,
                        child: Center(
                          child: PopupMenuButton(
                            splashRadius: 0.1,
                            icon: const Icon(Icons.more_vert,size: 30,),
                            elevation: 5,
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 1,
                                child: Text("Report"),
                              )
                            ],
                            onSelected: (val) {
                              if (val == 1) {
                                alertActivityReport();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ),
              SizedBox(
                height: Get.height*0.025,
              ),
              Expanded(
                child:  Obx(
                      () => controller.activitypage.value
                      ? Center(
                    child: CommonUi.scaffoldLoading(color: clrYellow),
                  )
                      : controller.actError.value.isNotEmpty
                      ? const ErrorScreen()
                      : controller.attData.value.result == null ? Center(
                        child: CommonUi.scaffoldLoading(color: clrYellow),
                      ) : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: h*.25,
                        child: Stack(
                          // clipBehavior: Clip.none,
                          children: [
                            // CarouselSlider(
                            //   options: CarouselOptions(
                            //       height:h*.25, viewportFraction: 1),
                            //   items: [1, 2, 3].map((i) {
                            //     return Builder(
                            //       builder: (BuildContext context) {
                            //         return Container(
                            //             clipBehavior: Clip.hardEdge,
                            //             width: MediaQuery.of(context)
                            //                 .size
                            //                 .width,
                            //             height: double.maxFinite,
                            //             margin: const EdgeInsets.symmetric(
                            //                 horizontal: 0),
                            //             decoration: BoxDecoration(
                            //                 borderRadius:
                            //                 BorderRadius.circular(18)),
                            //             child: Image.asset(
                            //               "assets/images/cofee.png",
                            //               fit: BoxFit.cover,
                            //               height: h*.25,
                            //               width: double.maxFinite,
                            //             ));
                            //       },
                            //     );
                            //   }).toList(),
                            // ),
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: h * .26,
                                  viewportFraction: 1,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (currIndex,
                                      CarouselPageChangedReason
                                      reason) {
                                    controller
                                        .changeIndicator(currIndex);
                                    debugPrint(
                                        " currIndex $currIndex reason=$reason");
                                  }),
                              items: controller
                                  .actData.value.activity?.banners?.map<Widget>((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        clipBehavior: Clip.hardEdge,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        height: double.maxFinite,
                                        margin: const EdgeInsets
                                            .symmetric(horizontal: 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(
                                                18)),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          height: h * .26,
                                          width: double.maxFinite,
                                          imageUrl: "$i",
                                          placeholder:
                                              (context, url) =>
                                              Shimmer.fromColors(
                                                baseColor: grey300,
                                                highlightColor: grey100,
                                                child: Container(
                                                  width: double.maxFinite,
                                                  height: h * .26,
                                                  decoration:
                                                  BoxDecoration(
                                                    color: grey300,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(18),
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
                                      controller.actData.value.activity?.subcategoryTitle.toString() ?? '',
                                      style: const TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      var id = controller
                                          .actData.value.activity!.id
                                          .toString();
                                      await controller
                                          .changeFavApi(id)
                                          .then(
                                            (value) {
                                          if (value == true) {
                                            controller.actData.value
                                                .activity?.isFav =
                                            !controller
                                                .actData
                                                .value
                                                .activity!.isFav!;
                                            exploreListController
                                                .homePageApi();
                                          }
                                        },
                                      );

                                      controller.actData.refresh();
                                    },
                                    child: Container(
                                      padding:
                                      const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: clrWhite,
                                          borderRadius:
                                          BorderRadius.circular(
                                              100)),
                                      child: controller.actData.value
                                          .activity?.isFav ==
                                          true
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
                              child: Container(
                                margin:
                                const EdgeInsets.only(bottom: 7),
                                height: 16,
                                child: ListView.builder(
                                    itemCount: controller.actData.value.activity?.banners?.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (context, indicatorIndex) {
                                      return Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 1.5),
                                        child: Obx(
                                              () => Icon(
                                            Icons.circle,
                                            color: controller
                                                .actData
                                                .value
                                                .activity?.circleIndex
                                                ?.value ==
                                                indicatorIndex
                                                ? clrYellow
                                                : clrWhite,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.actData.value.activity!.name.toString(),
                                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  controller.actData.value.activity!.location.toString(),
                                  style: TextStyle(fontSize: 14,color:clrGreyDark,fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  "${controller.actData.value.activity!.formattedDate} | ${controller.actData.value.activity!.startAt} - ${controller.actData.value.activity!.endAt}",
                                  style: TextStyle(fontSize: 14,color:clrGreyTextLight,fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  "${controller.actData.value.activity?.spotPeople} ${controller.actData.value.activity!.spotPeople! > 1 ? 'Persons joined' : 'Person joined'}",
                                  style: TextStyle(color: clrYellowText, fontSize: 13),
                                ),
                                // Text(
                                //   "Up to ${controller.actData.value.activity!.maxPeople} people | ${controller.actData.value.activity!.spotLeft} ${controller.actData.value.activity!.spotLeft! == 1 ? 'spot left' : 'spots left'}",
                                //   style: TextStyle(color: clrYellowText, fontSize: 13),
                                // ),

                                // Text(
                                //   "Up to ${controller.actData.value.activity!.maxPeople} people | ${controller.actData.value.activity!.spotLeft} spot left",
                                //   style: TextStyle(color: clrYellowText,fontSize: 14,fontWeight: FontWeight.w500),
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          // InkWell(
                          //   onTap: (){
                          //     Get.toNamed(Routes.hostProfileUi);
                          //   },
                          //   child: Column(
                          //     children: [
                          //       Container(
                          //           height: h*.055,
                          //           width: h*.055,
                          //           decoration: BoxDecoration(
                          //               borderRadius:
                          //               BorderRadius.circular(100)),
                          //           child: Image.asset(
                          //             "assets/images/girldp.png",
                          //             fit: BoxFit.cover,
                          //           )),
                          //       Text("Jenny",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)
                          //     ],
                          //   ),
                          // )
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.hostProfileUi,arguments: controller.actData.value.activity?.hostId.toString());
                            },
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                // Container(
                                //     height: h*.055,
                                //     width: h*.055,
                                //     decoration: BoxDecoration(
                                //         borderRadius:
                                //         BorderRadius.circular(100)),
                                //     child: Image.asset(
                                //       "assets/images/girldp.png",
                                //       fit: BoxFit.cover,
                                //     )),
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                    '${controller.actData.value.activity!.profilePhoto}',
                                    errorWidget:
                                        (context, url, error) =>
                                        Container(
                                          height: 40,
                                          width: 40,
                                          padding:
                                          const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: clrGreyLight,
                                              shape: BoxShape.circle),
                                          child: Image.asset(
                                            "assets/icons/manicon.png",
                                            color: clrGrey,
                                            fit: BoxFit.cover,
                                          ),
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
                                              borderRadius:
                                              BorderRadius.circular(
                                                  18),
                                            ),
                                          ),
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 3,),
                                Text(
                                  controller.actData.value.activity!.hostName.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        // "Hey guys! Looking to brighten up your morning? How about joining me for a coffee break at the local café around 10 AM? I'm extending an invite to three fellow coffee lovers to join the chat and caffeine boost. Let's turn strangers into friends over a cup of joe! Hope to see you there for a delightful break. ☕️👋",
                        controller.actData.value.activity!.description.toString(),
                        style: TextStyle(fontSize: 14,color:clrGreyTextLight),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text("Going",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                      //     Get.arguments['isHost'] ==true? InkWell(onTap: (){
                      //       Get.toNamed(Routes.attendList);
                      //
                      //     },child: Text("See All",style: TextStyle(color: clrYellow,fontWeight: FontWeight.w600,fontSize: 16),)):SizedBox()
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: Get.height*0.01,
                      // ),
                      // SizedBox(
                      //   height: h*.075,
                      //   child: ListView.builder(itemCount: 2,scrollDirection: Axis.horizontal,shrinkWrap: true,itemBuilder: (context,index){
                      //     return Container(
                      //       margin: const EdgeInsets.only(right: 5),
                      //       clipBehavior: Clip.hardEdge,
                      //       height: h*.075,
                      //       width: h*.075,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(100),
                      //       ),
                      //       child: Image.asset("assets/images/cofee.png",fit: BoxFit.cover,),
                      //     ) ;
                      //   }),
                      // ),

                      controller.actData.value.activity?.status == 'approved' && controller.actData.value.activity?.hostId.toString() == LocalStorage.getUid() ? SizedBox(
                        height: Get.height * 0.04,
                      ) : SizedBox(),
                      controller.actData.value.activity?.status == 'approved' && controller.actData.value.activity?.hostId.toString() == LocalStorage.getUid() ? const Text("You created this activity",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)
                          : controller.actData.value.activity?.status == 'pending' ? SizedBox(
                          width: double.maxFinite,
                          height: Res.h_btn,
                          child: CustomElevatedButton(
                              onTap: () {},
                              backgroundClr: clrGrey,
                              child: Text(
                                "Pending content review",
                                style: TextStyle(
                                    color: clrWhite,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w700),
                              ))) : const SizedBox(),
                      controller.actData.value.activity?.status == 'approved' ? const SizedBox(
                        height: 10,
                      ) : const SizedBox(),

                      // controller.actData.value.activity?.status == 'approved' ? Divider() : SizedBox(),

                      controller.actData.value.activity?.status == 'approved' ?  SizedBox(
                          width: double.maxFinite,
                          height: Res.h_btn,
                          child: CustomElevatedButton(
                              onTap: () {
                                if(controller.actData.value.activity?.groupId != null) {
                                  Get.toNamed(
                                      Routes.chatUi, arguments: {
                                    'gpID': controller.actData.value
                                        .activity?.groupId,
                                  });
                                }else{
                                  showTostMsg('No group exist for this activity');
                                }
                              },
                              backgroundClr: clrBlacke,
                              child: Text(
                                "Message group",
                                style: TextStyle(
                                    color: clrWhite,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w700),
                              )
                          )
                      ) : const SizedBox(),

                      controller.actData.value.activity?.status == 'approved' ? const SizedBox(
                        height: 10,
                      ) : const SizedBox(),


                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         (controller.actData.value.activity?.status == 'completed' && controller.actData.value.markAttendance.toString() == 'true')
                             ?  const Text("Attendees",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),)
                             : const SizedBox(),
                         (controller.actData.value.activity?.status == 'completed' && controller.actData.value.markAttendance.toString() == 'true')
                             ? InkWell(
                                onTap: () {
                                  // Get.to(()=>AttendListUi());
                                  Get.toNamed(Routes.attendList,arguments: controller.actData.value.activity!.id.toString());
                                  // Get.back();
                                },
                                child: controller.attData.value.result!.attendanceList!.isNotEmpty ? Text("See All",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14,color: clrYellowText,decoration: TextDecoration.underline,decorationColor: clrYellowText,),) : SizedBox())
                             : const SizedBox(),
                       ],
                     ),
                      (controller.actData.value.activity?.status == 'completed' && controller.actData.value.markAttendance.toString() == 'true') ?SizedBox(
                        height: Get.height * 0.01,
                      ) : const SizedBox(),
                      (controller.actData.value.activity?.status == 'completed' && controller.actData.value.markAttendance.toString() == 'true') ? SizedBox(
                        height: controller.attData.value.result!.attendanceList!.isNotEmpty ? 52 : 20,
                        child: controller.attData.value.result!.attendanceList!.isNotEmpty? ListView.separated(
                          itemCount: controller.attData.value.result!.attendanceList!.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                    Routes.userProfileui,
                                    arguments: controller.attData.value.result?.attendanceList?[index].userId.toString());
                              },
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  height: 52,
                                  width: 52,
                                  fit: BoxFit.cover,
                                  imageUrl: '${controller.attData.value.result?.attendanceList?[index].profilePhoto}',
                                  errorWidget:
                                      (context, url, error) =>
                                      Container(
                                        height: 52,
                                        width: 52,
                                        padding:
                                        const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: clrGreyLight,
                                            shape: BoxShape.circle),
                                        child: Image.asset(
                                          "assets/icons/manicon.png",
                                          color: clrGrey,
                                          fit: BoxFit.cover,
                                          scale: 1.2,
                                        ),
                                      ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                        baseColor: grey300,
                                        highlightColor: grey100,
                                        child: Container(
                                          height: 52,
                                          width: 52,
                                          decoration: BoxDecoration(
                                            color: grey300,
                                            borderRadius:
                                            BorderRadius.circular(
                                                18),
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                            );
                          }, separatorBuilder: (BuildContext context, int index) {return const SizedBox(width: 10,); },) : const Center(
                            child: Text('No attendees found!',style: TextStyle(
                            fontWeight: FontWeight.w600
                            ),),
                          ),
                      ) : const SizedBox() ,

                      (controller.actData.value.activity?.status == 'completed' && controller.actData.value.markAttendance.toString() == 'false') ? controller.isHost == true ? SizedBox(
                          width: double.maxFinite,
                          height: Res.h_btn,
                          child: CustomElevatedButton(
                              onTap: () {
                                Get.toNamed(Routes.attendReviewUi, arguments: {
                                  'going':controller.actData.value.going,
                                  'actid':controller.actData.value.activity?.id.toString()
                                });
                              },
                              backgroundClr: clrBlacke,
                              child: Text(
                                "Mark attendance",
                                style: TextStyle(
                                    color: clrWhite,
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w700),
                              )
                          )
                      ) : const SizedBox() : const SizedBox(),
                      // controller.actData.value.activity?.status == 'approved' && (controller.actData.value.activity?.hostId.toString() != LocalStorage.getUid().toString()) ?  const SizedBox() :  Center(child: InkWell(
                      //     onTap: (){
                      //       alertDeleteActivity();
                      //     }
                      //     ,child: const Text("Delete activity",style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.w600),))
                      // ),



                      controller.actData.value.activity?.status == 'completed'
                          ? const SizedBox()
                          : controller.actData.value.going!.isNotEmpty ? const Text(
                        "Going",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ) : const SizedBox(),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      controller.actData.value.activity?.status == 'completed'
                          ? const SizedBox()
                          : SizedBox(
                        height: 55,
                        child: ListView.builder(
                            itemCount: controller
                                .actData.value.going?.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 8),
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(
                                      100),
                                  child: CachedNetworkImage(
                                      height: 55,
                                      width: 55,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                      '${controller.actData.value.going?[index].profilePhoto}',
                                      placeholder: (context,
                                          url) =>
                                          Shimmer.fromColors(
                                              baseColor: Colors
                                                  .grey
                                                  .shade300,
                                              highlightColor:
                                              Colors.grey
                                                  .shade100,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    100),
                                                child:
                                                Container(
                                                  height: 55,
                                                  width: 55,
                                                  color:
                                                  clrGrey,
                                                ),
                                              )),
                                      errorWidget: (context,
                                          url, error) {
                                        print(
                                            'error == $error');
                                        return ClipRRect(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              100),
                                          child: Container(
                                            height: 55,
                                            width: 55,
                                            color: clrGreyLight,
                                            child: Image.asset(
                                              'assets/icons/manicon.png',
                                              color: clrGrey,
                                              scale: 1.2,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              );
                            }),
                      ),
                      controller.showreviewData.value.result != null ? SizedBox(
                        height: Get.height*0.03,
                      ) : SizedBox(),
                      (controller.actData.value.activity?.status == 'completed' && controller.isHost == false) ? SizedBox(
                          width: double.maxFinite,
                          height: Res.h_btn,
                          child: CustomElevatedButton(
                              onTap: (){
                        // Get.toNamed(Routes.adda);
                        Get.toNamed(
                            Routes.addReviewUi,
                            arguments: {
                              'id': controller.actData.value.activity?.id.toString(),
                              'hostimg': controller.actData.value.activity?.profilePhoto,
                              'goingimg': controller.actData.value.going,
                              'hostid': controller.actData.value.activity?.hostId.toString()
                            });
                      },
                              backgroundClr: clrBlacke,
                              child: Text(
                                "Add review",
                                style: TextStyle(
                                    color: clrWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              )
                          )
                      ) : const SizedBox(),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),


                      controller.showreviewData.value.result == null ? const SizedBox() : const Text("Reviews",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                      controller.showreviewData.value.result == null ? const SizedBox() : SizedBox(
                        height: Get.height*0.01,
                      ),
                      controller.showreviewData.value.result == null ? const SizedBox() : ListView.separated(
                        itemCount: controller.showreviewData.value.result?.length ?? 0,
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin:
                            const EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Container(
                                    //   margin:
                                    //   const EdgeInsets.only(right: 5),
                                    //   clipBehavior: Clip.hardEdge,
                                    //   height: h * .055,
                                    //   width: h * .055,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(100),
                                    //   ),
                                    //   child: Image.asset(
                                    //     "assets/images/cofee.png",
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(100),
                                      child:
                                      CachedNetworkImage(
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                        imageUrl: '${controller.showreviewData.value.result?[index].profilePhoto}',
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
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          '${controller.showreviewData.value.result?[index].firstName}  ${controller.showreviewData.value.result?[index].lastName}',
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        RatingBar(
                                          // tapOnlyMode:true
                                          ignoreGestures: true,
                                          initialRating: double.parse(controller.showreviewData.value.result![index].rating.toString()),
                                          allowHalfRating: true,
                                          itemSize: 20,
                                          ratingWidget:
                                          RatingWidget(
                                            full: Icon(
                                              Icons.star,
                                              color: clrYellow,
                                              size: 20,
                                            ),
                                            half: Stack(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.grey.shade400, // Light grey for the right side
                                                  size: 20,
                                                ),
                                                ClipRect(
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    widthFactor: 0.5, // Clip the star to show only the left half
                                                    child: Icon(
                                                      Icons.star,
                                                      color: clrYellow, // Yellow for the left side
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            empty: Icon(
                                              Icons.star_border,
                                              color: clrYellow,
                                              size: 20,
                                            ),
                                          ),
                                          onRatingUpdate:
                                              (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  // "Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                                  '${controller.showreviewData.value.result?[index].review}',
                                  style: TextStyle(
                                      color: clrGreyTextLight,fontSize: 14,fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          );
                        }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 5,); },),


                      const SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  alertActivityReport() {
    Get.dialog(AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      content: SizedBox(
        width: double.maxFinite,
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         InkWell(
        //             onTap: () {
        //               Get.back();
        //             },
        //             child: const Icon(
        //               Icons.close,
        //               size: 25,
        //             )),
        //         const Flexible(
        //           child: Text(
        //             "Report activity",
        //             style: TextStyle(fontSize: 19
        //                 , fontWeight: FontWeight.w800),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 1,
        //         ),
        //       ],
        //     ),
        //       SizedBox(
        //       height:Get.height*.02,
        //     ),
        //     const Text(
        //       "Why are you reporting this activity?",
        //       style: TextStyle(fontWeight: FontWeight.w800),
        //     ),
        //       SizedBox(
        //       height: Get.height*.014,
        //     ),
        //     Row(
        //       children: [
        //         SizedBox(height: 30,child: Radio(splashRadius: 0,value: 1, groupValue: 2, onChanged: (val) {})),
        //         const Text("Scam or fraud",style: TextStyle(fontSize: 15),)
        //       ],
        //     ),
        //     Divider(
        //       color: clrGreyLight,
        //     ),
        //     Row(
        //       children: [
        //         SizedBox(height: 30,child: Radio(value: 2, groupValue: 2, onChanged: (val) {})),
        //         const Text("Inappropriate or misleading content",style: TextStyle(fontSize: 15))
        //       ],
        //     ),
        //     Divider(
        //       color: clrGreyLight,
        //     ),
        //     Row(
        //       children: [
        //         SizedBox(height: 30,child: Radio(value: 3, groupValue: 2, onChanged: (val) {})),
        //         const Text("Harrassment or abuse",style: TextStyle(fontSize: 15))
        //       ],
        //     ),
        //     Divider(
        //       color: clrGreyLight,
        //     ),
        //     Row(
        //       children: [
        //         SizedBox(height: 30,child: Radio(value: 4, groupValue: 2, onChanged: (val) {})),
        //         const Text("Other",style: TextStyle(fontSize: 15))
        //       ],
        //     ),
        //     const SizedBox(
        //       height: 10,
        //     ),
        //     const CustoTextFormField(hintText: "Please provide more details about what happened. We will review your report and take appropriate action.",maxLines: 5,),
        //       SizedBox(
        //       height: Get.height*.024,
        //     ),
        //     SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
        //       Get.back();
        //     }, backgroundClr: clrBlacke, child: Text("Submit",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
        //       SizedBox(
        //       height: Get.height*.014,
        //     ),
        //   ],
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 25,
                    )),
                const Text(
                  "Report activity",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Why are you reporting this activity?",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
                  () => SizedBox(
                  height: 30,
                  child: CustomRadioButton(
                      text: "Scam or fraud",
                      activeColor: clrYellow,
                      value: 1,
                      groupValue: controller.selectedValue.value,
                      onChanged: (val) {
                        controller.updateSelectedValue(val);
                      })),
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(
              color: clrBlacke.withOpacity(.15),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
                  () => SizedBox(
                  height: 30,
                  child: CustomRadioButton(
                      text: "Inappropriate or misleading content",
                      activeColor: clrYellow,
                      value: 2,
                      groupValue: controller.selectedValue.value,
                      onChanged: (val) {
                        controller.updateSelectedValue(val);
                      })),
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(
              color: clrBlacke.withOpacity(.15),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
                  () => SizedBox(
                  height: 30,
                  child: CustomRadioButton(
                      text: "Harrassment or abuse",
                      activeColor: clrYellow,
                      value: 3,
                      groupValue: controller.selectedValue.value,
                      onChanged: (val) {
                        controller.updateSelectedValue(val);
                      })),
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(
              color: clrBlacke.withOpacity(.15),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
                  () => SizedBox(
                  height: 30,
                  child: CustomRadioButton(
                      text: "Other",
                      activeColor: clrYellow,
                      value: 4,
                      groupValue: controller.selectedValue.value,
                      onChanged: (val) {
                        controller.updateSelectedValue(val);
                      })),
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: formkey,
              child: CustoTextFormField(
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter something';
                  } else {
                    return null;
                  }
                },
                controll: controller.reportDescriptionController,
                hintText:
                "Please provide more details about what happened. We will review your report and take appropriate action.",
                maxLines: 5,
                borderRadius: 15,
                hintSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
                  () => Opacity(
                opacity: controller.reportactivityLoading.value ? 0.5 : 1,
                child: SizedBox(
                    width: double.maxFinite,
                    height: Get.height * .07,
                    child: CustomElevatedButton(
                        onTap: () {
                          if(controller.selectedValue.value == 4){
                            if(formkey.currentState!.validate()){
                              controller.reportActivity(controller.actData.value.activity?.id.toString());
                            }
                          }else if(controller.selectedValue.value != 0){
                            controller.reportActivity(controller.actData.value.activity?.id.toString());
                          }
                          else{
                            showTostMsg('Please select any reason');
                          }
                        },
                        child: controller.reportactivityLoading.value
                            ? CommonUi.buttonLoading()
                            : Text(
                          "Submit",
                          style: TextStyle(
                              color: clrWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        backgroundClr: clrBlacke)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }

  alertCancelRequest() {
    Future.delayed(Duration.zero, () {
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Cancel request",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                    "Are you sure you want to cancel your request to join this activity?",
                    style: TextStyle(color: clrGreyTextLight,fontSize: 15, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: Get.height * .024,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Expanded(
                      child: SizedBox(
                        height: Res.h_btn,
                        child: CustoFilterBtn(
                            borderClr: clrBlacke,
                            lable: Text(
                              "Yes",
                              style: TextStyle(
                                  color: clrBlacke,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            ontap: () {
                              Get.back();
                              alertCancelRequestConfirmation();
                            },
                            backgroundClr: Get.theme.scaffoldBackgroundColor),
                      )),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  Expanded(
                    child: SizedBox(
                        width: double.maxFinite,
                        height: Res.h_btn,
                        child: CustomElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            backgroundClr: clrBlacke,
                            child: Text(
                              "No",
                              style: TextStyle(
                                  color: clrWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ))),
                  ),
                ]),
              ),
              SizedBox(
                height: Get.height * .014,
              ),
            ],
          ),
        ),
      ));
    });
  }

  alertCancelRequestConfirmation() {
    Future.delayed(Duration.zero, () {
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Confirm cancellation",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Get.height * .014,
              ),
              Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Canceling within 24 hours of the activity will incur a €3 fee. Are you sure you want to proceed?",
                      style: TextStyle(color: clrGreyTextLight,fontSize: 15, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  )),
              SizedBox(
                height: Get.height * .024,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Expanded(
                      child: SizedBox(
                        height: Res.h_btn,
                        child: CustoFilterBtn(
                            borderClr: clrBlacke,
                            lable: Text(
                              "Yes",
                              style: TextStyle(
                                  color: clrBlacke,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            ontap: () {
                              controller.changeReqSent(1);
                              Get.back();
                            },
                            backgroundClr: Get.theme.scaffoldBackgroundColor),
                      )),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  Expanded(
                    child: SizedBox(
                        width: double.maxFinite,
                        height: Res.h_btn,
                        child: CustomElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            backgroundClr: clrBlacke,
                            child: Text(
                              "No",
                              style: TextStyle(
                                  color: clrWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ))),
                  ),
                ]),
              ),
              SizedBox(
                height: Get.height * .014,
              ),
            ],
          ),
        ),
      ));
    });
  }

  alertDeleteActivity() {
    Future.delayed(Duration.zero,(){
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child:  Text(
                  "Are you sure?",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),

              SizedBox(
                height: Get.height*.012,
              ),
              Center(child: Text("Are you sure you want to delete this activity?",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),


              SizedBox(
                height:Get.height*.024,
              ),
              Row(
                  children: [
                    Expanded(child: SizedBox(
                      height: Res.h_btn,
                      child: CustoFilterBtn(borderClr: clrBlacke,lable: Text("Go back",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),), ontap: (){
                        Get.back();
                        // alertCancelRequestConfirmation();
                      }, backgroundClr:Get.theme.scaffoldBackgroundColor),
                    )),
                    SizedBox(
                      width: Get.width*0.05,
                    ),
                    Expanded(child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                      Get.back();
                      alertConfirmCancelActivityFees();
                    }, backgroundClr: clrBlacke, child: Text("Delete",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),),
                  ]
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ));
    });
  }

  alertConfirmCancelActivityFees() {
    Future.delayed(Duration.zero,(){
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child:  Text(
                  "Confirm cancellation",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),

              SizedBox(
                height:Get.height*.013,
              ),
              Center(child: Text("Canceling within 24 hours of the activity will incur a €3 fee. Are you sure you want to proceed?",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),


              SizedBox(
                height: Get.height*.025,
              ),
              Row(
                  children: [
                    Expanded(child: SizedBox(
                      height: Res.h_btn,
                      child: CustoFilterBtn(borderClr: clrBlacke,lable: Text("Yes, cancel",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),), ontap: (){
                        Get.back();
                        alertConfCancelActiAttendies();
                      }, backgroundClr:Get.theme.scaffoldBackgroundColor),
                    )),
                    SizedBox(
                      width: Get.width*0.05,
                    ),
                    Expanded(child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                      Get.back();
                    }, backgroundClr: clrBlacke, child: Text("Go back",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),),


                  ]
              ),
              SizedBox(
                height: Get.width*0.015,
              ),
            ],
          ),
        ),
      ));
    });
  }
  alertConfCancelActiAttendies() {
    Future.delayed(Duration.zero,(){
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child:  Text(
                  "Confirm cancellation",
                  style: TextStyle(fontSize: 20
                      , fontWeight: FontWeight.w700),textAlign: TextAlign.center,
                ),
              ),

              SizedBox(
                height: Get.width*0.013,
              ),
              Center(child: Text("There are already attendees joining your activity. Are you sure you want to cancel?",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),


              SizedBox(
                height: Get.width*0.025,
              ),
              Row(
                  children: [
                    Expanded(child: SizedBox(
                      height: Res.h_btn,
                      child: CustoFilterBtn(borderClr: clrBlacke,lable: Text("Yes, cancel",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),), ontap: (){
                        Get.back();
                        alertConfirmCancelActivity();
                      }, backgroundClr: Get.theme.scaffoldBackgroundColor),
                    )),
                    SizedBox(
                      width: Get.width*0.05,
                    ),
                    Expanded(child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                      Get.back();
                    }, backgroundClr: clrBlacke, child: Text("Go back",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),),
                  ]
              ),
              SizedBox(
                height: Get.width*0.014,
              ),
            ],
          ),
        ),
      ));
    });
  }
  alertConfirmCancelActivity() {
    Future.delayed(Duration.zero,(){
      Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child:  Text(
                  "Confirm cancellation",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Center(child: Text("Are you sure you want to cancel?",style: TextStyle(color: clrGreyTextLight,fontSize: 15),textAlign: TextAlign.center,)),


              SizedBox(
                height: Get.height*0.025,
              ),
              Row(
                  children: [
                    Expanded(child: SizedBox(
                      height:Res.h_btn,
                      child: CustoFilterBtn(borderClr: clrBlacke,lable: Text("Yes, cancel",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),), ontap: (){
                        Get.back();
                        controller.deleteactapi(controller.actData.value.activity?.id.toString());
                        // alertCancelRequestConfirmation();
                      }, backgroundClr:Get.theme.scaffoldBackgroundColor),
                    )),
                    SizedBox(
                      width: Get.width*0.05,
                    ),
                    Expanded(child: SizedBox(width: double.maxFinite,height:Res.h_btn,
                        child: CustomElevatedButton(
                            onTap: (){
                              Get.back();
                              },
                            backgroundClr: clrBlacke,
                            child: Text("Go back",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),),


                  ]
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ));
    });
  }


}
