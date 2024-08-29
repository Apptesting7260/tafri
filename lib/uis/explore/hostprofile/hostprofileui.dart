import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/explore/hostprofile/controller/hostprofile_controller.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors.dart';
import '../../../utils/common.dart';
import '../../../utils/custom_radio.dart';
import '../../../utils/error_widget.dart';
import '../../../utils/size.dart';

class HostProfileUi extends GetWidget<HostProfileController>{
   HostProfileUi({super.key});

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => alertReport(),
      child: Scaffold(
        body: SafeArea(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonUi.appBar(),
                      const Text(
                        "Host profile",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        child: PopupMenuButton(
                          elevation: 5,
                          icon: Icon(Icons.more_vert,size: 30,),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              child: Text("Report"),
                              value: 1,
                            )
                          ],
                          onSelected: (val) {
                            if (val == 1) {
                              alertReport();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Obx(() => controller.hostLoading.value ? Expanded(
                    child: Center(
                      child: CommonUi.scaffoldLoading(color: clrYellow),
                    ),
                  ) : controller.hostError.value.isNotEmpty ? Expanded(
                      child: Center(child: ErrorScreen())
                  ) : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          // Center(
                          //   child: Container(
                          //     clipBehavior: Clip.hardEdge,
                          //     height: 100,
                          //     width: 100,
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(100),
                          //         image: const DecorationImage(
                          //             image: AssetImage("assets/images/proimg.png"),
                          //             fit: BoxFit.cover)
                          //     ),
                          //   ),
                          // ),
                          Center(
                            child: Obx(
                                  () => ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                    imageUrl:
                                    '${controller.hostData..value.result?.profile?.profilePhoto}',
                                    fit: BoxFit.cover,
                                    height: Get.height * .14,
                                    width: Get.width * .3,
                                    placeholder: (context, url) => Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Container(
                                            height: Get.height * .14,
                                            width: Get.width * .3,
                                            color: clrGrey,
                                          ),
                                        )),
                                    errorWidget: (context, url, error) {
                                      print('error == $error');
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Container(
                                          height: Get.height * .14,
                                          width: Get.width * .3,
                                          color: clrGreyLight,
                                          child: Image.asset(
                                            'assets/icons/manicon.png',
                                            color: clrGrey,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${controller.hostData.value.result?.firstName} ${controller.hostData.value.result?.lastName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.verified,
                                    color: clrYellow,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.007,
                          ),
                          Center(
                              child: Text(
                                "${controller.hostData.value.result?.age} years old |  ${controller.getPronoun(controller.hostData.value.result?.gender)}",
                                style: TextStyle(color: clrGreyTextLight, fontSize: 14, fontWeight: FontWeight.w400),
                              )),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          // Row(
                          //   children: [
                          //     Flexible(
                          //       child: Container(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 12, vertical: 12),
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(10),
                          //             color: clrGreyLight),
                          //         child: Column(
                          //           children: [
                          //             Text(
                          //               controller.hostData.value.result!.attendanceRate.toString(),
                          //               style: TextStyle(
                          //                   color: clrYellowText.withOpacity(0.8),
                          //                   fontSize: 19,
                          //                   fontWeight: FontWeight.w800),
                          //             ),
                          //             const Text(
                          //                 "Attendance Rate",
                          //                 textAlign: TextAlign.center
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: Get.width * 0.02,
                          //     ),
                          //     Flexible(
                          //       child: Container(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 12, vertical: 12),
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(10),
                          //             color: clrGreyLight),
                          //         child: Column(
                          //           children: [
                          //             Text(
                          //               controller.hostData.value.result!.activitiesJoined.toString(),
                          //               style: TextStyle(
                          //                   color: clrYellowText.withOpacity(0.8),
                          //                   fontSize: 19,
                          //                   fontWeight: FontWeight.w800),
                          //             ),
                          //             const Text(
                          //               "Activities Joined",
                          //               textAlign: TextAlign.center,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: Get.width * 0.02,
                          //     ),
                          //     Flexible(
                          //       child: Container(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 12, vertical: 12),
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(10),
                          //             color: clrGreyLight),
                          //         child: Column(
                          //           children: [
                          //             Text(
                          //               controller.hostData.value.result!.activitiesHosted.toString(),
                          //               style: TextStyle(
                          //                   color: clrYellowText.withOpacity(0.8),
                          //                   fontSize: 19,
                          //                   fontWeight: FontWeight.w800),
                          //             ),
                          //             const Text(
                          //                 "Activities Hosted",
                          //                 textAlign: TextAlign.center
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: clrGreyLight),
                                  child: Column(
                                    children: [
                                      // TweenAnimationBuilder<int>(
                                      //   tween: IntTween(
                                      //       begin: 0,
                                      //       end: int.parse(profileController
                                      //           .profileData
                                      //           .value
                                      //           .result!
                                      //           .attendanceRate
                                      //           .toString()
                                      //           .split('%')[0])),
                                      //   duration: const Duration(seconds: 1),
                                      //   builder: (context, value, child) {
                                      //     return Text(
                                      //       '$value%',
                                      //       style: TextStyle(
                                      //           color: clrYellowText.withOpacity(0.8),
                                      //           fontSize: 22,
                                      //           fontWeight: FontWeight.w700),
                                      //     );
                                      //   },
                                      // ),
                                      Text(
                                        '${controller.hostData.value.result?.attendanceRate ?? 0}',
                                        style: TextStyle(
                                            color: clrYellowText.withOpacity(0.8),
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const Text(
                                        "Attendance",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ), const Text(
                                        "Rate",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.028,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: clrGreyLight),
                                  child: Column(
                                    children: [
                                      // TweenAnimationBuilder<int>(
                                      //   tween: IntTween(
                                      //       begin: 0,
                                      //       end: int.parse(profileController
                                      //           .profileData
                                      //           .value
                                      //           .result!
                                      //           .activitiesJoined
                                      //           .toString())),
                                      //   duration: const Duration(seconds: 1),
                                      //   builder: (context, value, child) {
                                      //     return Text(
                                      //       '$value',
                                      //       style: TextStyle(
                                      //           color: clrYellowText.withOpacity(0.8),
                                      //           fontSize: 22,
                                      //           fontWeight: FontWeight.w700),
                                      //     );
                                      //   },
                                      // ),
                                      Text(
                                        '${controller.hostData.value.result?.activitiesJoined ?? 0}',
                                        style: TextStyle(
                                            color: clrYellowText.withOpacity(0.8),
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const Text(
                                        "Activities",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),const Text(
                                        "Joined",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.028,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: clrGreyLight),
                                  child: Column(
                                    children: [
                                      // TweenAnimationBuilder<int>(
                                      //   tween: IntTween(
                                      //       begin: 0,
                                      //       end: int.parse(profileController
                                      //           .profileData
                                      //           .value
                                      //           .result!
                                      //           .activitiesHosted
                                      //           .toString())),
                                      //   duration: const Duration(seconds: 1),
                                      //   builder: (context, value, child) {
                                      //     return Text(
                                      //       '$value',
                                      //       style: TextStyle(
                                      //           color: clrYellowText.withOpacity(0.8),
                                      //           fontSize: 22,
                                      //           fontWeight: FontWeight.w700),
                                      //     );
                                      //   },
                                      // ),
                                      Text(
                                        '${controller.hostData.value.result?.activitiesHosted ?? 0}',
                                        style: TextStyle(
                                            color: clrYellowText.withOpacity(0.8),
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const Text("Activities",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12)),
                                      const Text("Hosted",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Bio",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                controller.hostData.value.result
                                    ?.profile?.bio !=
                                    null ? Text("${controller.hostData.value.result?.profile?.bio}",
                                    style: TextStyle(color: clrGreyTextLight)) : CommonUi.emptySizeBox(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Location",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                Text(
                                    controller.hostData.value.result!.location.toString(),
                                    style: TextStyle(color: clrGreyTextLight)
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Job",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                controller.hostData.value.result
                                    ?.profile?.occupation !=
                                    null ? Text("${controller.hostData.value.result?.profile?.occupation}",
                                    style: TextStyle(color: clrGreyTextLight)) : CommonUi.emptySizeBox(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Languages",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // Wrap(
                                //   spacing: 8,
                                //   runSpacing: 8,
                                //   children: [
                                //     Container(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 13, vertical: 5),
                                //       decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(15),
                                //           color: clrWhite),
                                //       child: const Text("English"),
                                //     ),
                                //     Container(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 13, vertical: 5),
                                //       decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(15),
                                //           color: clrWhite),
                                //       child: const Text("Spanish"),
                                //     )
                                //   ],
                                // )
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    ...?controller.hostData.value.result
                                        ?.profile?.languageNames
                                        ?.map((language) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: clrWhite,
                                        ),
                                        child: Text(language),
                                      );
                                    }).toList(),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Interests",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 15),
                                ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // const Text("Sports and fitness",
                                //     style: TextStyle(
                                //         fontSize: 13, fontWeight: FontWeight.w800)),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // Wrap(
                                //   spacing: 8,
                                //   runSpacing: 8,
                                //   children: [
                                //     Container(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 13, vertical: 5),
                                //       decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(15),
                                //           color: clrWhite),
                                //       child: Row(
                                //         mainAxisSize: MainAxisSize.min,
                                //         children: [
                                //           Image.asset(
                                //             "assets/icons/cycleicon.png",
                                //             height: 20,
                                //           ),
                                //           const SizedBox(
                                //             width: 4,
                                //           ),
                                //           const Text("Cycling"),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // const Text("Social",
                                //     style: TextStyle(
                                //         fontSize: 13, fontWeight: FontWeight.w800)),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // Wrap(
                                //   spacing: 8,
                                //   runSpacing: 8,
                                //   children: [
                                //     Container(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 13, vertical: 5),
                                //       decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(15),
                                //           color: clrWhite),
                                //       child: Row(
                                //         mainAxisSize: MainAxisSize.min,
                                //         children: [
                                //           Image.asset(
                                //             "assets/icons/dinner.png",
                                //             height: 20,
                                //           ),
                                //           const SizedBox(
                                //             width: 4,
                                //           ),
                                //           const Text("Dining out"),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // const Text(
                                //   "Learning",
                                //   style: TextStyle(
                                //       fontSize: 13, fontWeight: FontWeight.w800),
                                // ),
                                // const SizedBox(
                                //   height: 5,
                                // ),
                                // Wrap(
                                //   spacing: 8,
                                //   runSpacing: 8,
                                //   children: [
                                //     Container(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 13, vertical: 5),
                                //       decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(15),
                                //           color: clrWhite),
                                //       child: Row(
                                //         mainAxisSize: MainAxisSize.min,
                                //         children: [
                                //           Image.asset(
                                //             "assets/icons/languagetrn.png",
                                //             height: 20,
                                //           ),
                                //           const SizedBox(
                                //             width: 4,
                                //           ),
                                //           const Text("Language exchange"),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  height: Get.height * .008,
                                ),
                                Wrap(
                                    spacing: Get.width * .02,
                                    runSpacing: Get.height * .01,
                                    children: controller.interestList.map(
                                          (e) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.white),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.network(
                                                e.icon.toString(),
                                                height: 20,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(e.title.toString()),
                                            ],
                                          ),
                                        );
                                      },
                                    ).toList())
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: clrGreyLight),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Fun facts about ${controller.hostData.value.result?.firstName}",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controller.hostData.value.result?.profile?.funFactsAboutMe?[index].question}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                      Text(
                                          "${controller.hostData.value.result?.profile?.funFactsAboutMe?[index].answer}",
                                          style: TextStyle(color: clrGreyTextLight)),
                                    ],
                                  ),
                                  itemCount: controller.hostData.value
                                      .result?.profile?.funFactsAboutMe?.length ??
                                      0,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          controller.hostData.value.result!.upcomingActivities!.isEmpty
                              ? SizedBox()
                              :  Text(
                            "Upcoming activities",
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          // ListView.builder(
                          //     itemCount: controller.hostData.value.result?.upcomingActivities?.length,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     shrinkWrap: true,
                          //     itemBuilder: (context, index) {
                          //       return Container(
                          //         margin: const EdgeInsets.symmetric(vertical: 5),
                          //         padding: const EdgeInsets.symmetric(
                          //             vertical: 10, horizontal: 10),
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             color: clrGreyLight),
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               controller.hostData.value
                          //                   .result?.upcomingActivities?[index].formattedDate ?? '',
                          //               style: TextStyle(color: clrGreyDark),
                          //             ),
                          //             SizedBox(
                          //               height: Get.height * 0.003,
                          //             ),
                          //             Row(
                          //               children: [
                          //                 Container(
                          //                   clipBehavior: Clip.hardEdge,
                          //                   height: 57,
                          //                   width: 57,
                          //                   decoration: BoxDecoration(
                          //                     borderRadius: BorderRadius.circular(10),
                          //                   ),
                          //                   child: Image.asset(
                          //                     "assets/images/parkimage.png",
                          //                     fit: BoxFit.cover,
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   width: Get.width * 0.02,
                          //                 ),
                          //                 Expanded(
                          //                   child: Container(
                          //                     padding: const EdgeInsets.symmetric(
                          //                         horizontal: 10, vertical: 10),
                          //                     decoration: BoxDecoration(
                          //                         color: clrWhite,
                          //                         borderRadius:
                          //                         BorderRadius.circular(5)),
                          //                     child: Column(
                          //                       crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                       children: [
                          //                         const Text(
                          //                           "10KM Vondelpark run",
                          //                           style: TextStyle(
                          //                               fontSize: 14,
                          //                               fontWeight: FontWeight.w500),
                          //                         ),
                          //                         Text(
                          //                             "Padel next, 1055 AH, Amsterdam ",
                          //                             style: TextStyle(
                          //                                 color: clrGreyDark,
                          //                                 fontSize: 12)),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 )
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     }),
                          // SizedBox(
                          //   height: Get.height * 0.015,
                          // ),
                          // const Text(
                          //   "Previous activities",
                          //   style: TextStyle(fontWeight: FontWeight.w800),
                          // ),
                          // SizedBox(
                          //   height: Get.height * 0.015,
                          // ),
                          // ListView.builder(
                          //     itemCount: 1,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     shrinkWrap: true,
                          //     itemBuilder: (context, index) {
                          //       return Container(
                          //         margin: const EdgeInsets.symmetric(vertical: 5),
                          //         padding: const EdgeInsets.symmetric(
                          //             vertical: 10, horizontal: 10),
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(5),
                          //             color: clrGreyLight),
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               "20 May",
                          //               style: TextStyle(color: clrGreyDark),
                          //             ),
                          //             SizedBox(
                          //               height: Get.height * 0.003,
                          //             ),
                          //             Column(
                          //               children: [
                          //                 Row(
                          //                   children: [
                          //                     Container(
                          //                       clipBehavior: Clip.hardEdge,
                          //                       height: 57,
                          //                       width: 57,
                          //                       decoration: BoxDecoration(
                          //                         borderRadius:
                          //                         BorderRadius.circular(10),
                          //                       ),
                          //                       child: Image.asset(
                          //                         "assets/images/parkimage.png",
                          //                         fit: BoxFit.cover,
                          //                       ),
                          //                     ),
                          //                     SizedBox(
                          //                       width: Get.width * 0.02,
                          //                     ),
                          //                     Expanded(
                          //                       child: Container(
                          //                         padding: const EdgeInsets.symmetric(
                          //                             horizontal: 10, vertical: 10),
                          //                         decoration: BoxDecoration(
                          //                             color: clrWhite,
                          //                             borderRadius:
                          //                             BorderRadius.circular(5)),
                          //                         child: Column(
                          //                           crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                           children: [
                          //                             const Text(
                          //                               "Salsa night at Tulp",
                          //                               style: TextStyle(
                          //                                   fontSize: 14,
                          //                                   fontWeight:
                          //                                   FontWeight.w500),
                          //                             ),
                          //                             Text("Confirm attendance",
                          //                                 style: TextStyle(
                          //                                     color: clrYellowText,
                          //                                     fontSize: 12)),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     )
                          //                   ],
                          //                 ),
                          //                 const SizedBox(
                          //                   height: 8,
                          //                 ),
                          //                 Row(
                          //                   children: [
                          //                     Container(
                          //                       clipBehavior: Clip.hardEdge,
                          //                       height: 57,
                          //                       width: 57,
                          //                       decoration: BoxDecoration(
                          //                         borderRadius:
                          //                         BorderRadius.circular(10),
                          //                       ),
                          //                       child: Image.asset(
                          //                         "assets/images/cofee.png",
                          //                         fit: BoxFit.cover,
                          //                       ),
                          //                     ),
                          //                     SizedBox(
                          //                       width: Get.width * 0.02,
                          //                     ),
                          //                     Expanded(
                          //                       child: Container(
                          //                         padding: const EdgeInsets.symmetric(
                          //                             horizontal: 10, vertical: 10),
                          //                         decoration: BoxDecoration(
                          //                             color: clrWhite,
                          //                             borderRadius:
                          //                             BorderRadius.circular(5)),
                          //                         child: Column(
                          //                           crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                           children: [
                          //                             const Text(
                          //                               "Sunday morning coffee",
                          //                               style: TextStyle(
                          //                                   fontSize: 14,
                          //                                   fontWeight:
                          //                                   FontWeight.w500),
                          //                             ),
                          //                             Text("Cancelled",
                          //                                 style: TextStyle(
                          //                                     color: clrGreyTextLight,
                          //                                     fontSize: 12)),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     )
                          //                   ],
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     }),
                          ListView.builder(
                              itemCount: controller.hostData.value
                                  .result?.upcomingActivities?.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: Get.height * 0.01),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: clrGreyLight),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.hostData.value
                                            .result?.upcomingActivities?[index].formattedDate ?? '',
                                        style: TextStyle(color: clrGreyDark),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.003,
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       clipBehavior: Clip.hardEdge,
                                      //       height: h * .075,
                                      //       width: h * .075,
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(10),
                                      //       ),
                                      //       child: Image.asset(
                                      //         "assets/images/parkimage.png",
                                      //         fit: BoxFit.cover,
                                      //       ),
                                      //     ),
                                      //     SizedBox(
                                      //       width: Get.width * 0.02,
                                      //     ),
                                      //     Expanded(
                                      //       child: Container(
                                      //         padding: const EdgeInsets.symmetric(
                                      //             horizontal: 10, vertical: 10),
                                      //         decoration: BoxDecoration(
                                      //             color: clrWhite,
                                      //             borderRadius:
                                      //             BorderRadius.circular(5)),
                                      //         child: Column(
                                      //           crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //           children: [
                                      //             Text(
                                      //               "10KM Vondelpark run",
                                      //               style: TextStyle(
                                      //                   fontSize: 14,
                                      //                   fontWeight: FontWeight.w600),
                                      //             ),
                                      //             Text(
                                      //                 "Padel next, 1055 AH, Amsterdam ",
                                      //                 style: TextStyle(
                                      //                     color: clrGreyDark,
                                      //                     fontSize: 12)),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                      ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: controller.hostData.value
                                            .result?.upcomingActivities?[index].activities?.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context,ind) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 12),
                                            child: Row(
                                              children: [
                                                // Container(
                                                //   clipBehavior: Clip.hardEdge,
                                                //   height: h * .075,
                                                //   width: h * .075,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius:
                                                //     BorderRadius.circular(10),
                                                //   ),
                                                //   child: Image.asset(
                                                //     "assets/images/parkimage.png",
                                                //     fit: BoxFit.cover,
                                                //   ),
                                                // ),
                                                Container(
                                                  clipBehavior: Clip.hardEdge,
                                                  height: Get.height * .075,
                                                  width: Get.height * .075,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: controller.hostData.value.result?.upcomingActivities?[index].activities?[ind].banners != null &&
                                                      controller.hostData.value.result!.upcomingActivities![index].activities![ind].banners!.isNotEmpty
                                                      ? CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl: controller.hostData.value.result!.upcomingActivities![index].activities![ind].banners![0],
                                                    placeholder: (context, url) => Shimmer.fromColors(
                                                      baseColor: grey300,
                                                      highlightColor: grey100,
                                                      child: Container(
                                                        color: grey300,
                                                      ),
                                                    ),
                                                  )
                                                      : Image.asset(
                                                    "assets/images/parkimage.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                        color: clrWhite,
                                                        borderRadius:
                                                        BorderRadius.circular(5)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          controller.hostData.value.result?.upcomingActivities?[index].activities?[ind].name.toString() ?? '',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                        Text(
                                                            controller.hostData.value.result!.upcomingActivities![index].activities![ind].location.toString() ?? '',
                                                            style: TextStyle(
                                                                color: clrGreyTextLight,
                                                                fontSize: 12)
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          controller.hostData.value.result!.previousActivities!.isEmpty
                              ? SizedBox()
                              :Text(
                            "Previous activities",
                            style:
                            TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          ListView.builder(
                              itemCount: controller.hostData.value
                                  .result?.previousActivities?.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.previousActivityUi,
                                        arguments: {"isHost": false});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: clrGreyLight),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.hostData.value.result!.previousActivities![index].formattedDate ?? '',
                                          style: TextStyle(color: clrGreyDark),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.003,
                                        ),
                                        ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: controller.hostData.value
                                              .result?.previousActivities?[index].activities?.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context,ind) {
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 12),
                                              child: Row(
                                                children: [
                                                  // Container(
                                                  //   clipBehavior: Clip.hardEdge,
                                                  //   height: h * .075,
                                                  //   width: h * .075,
                                                  //   decoration: BoxDecoration(
                                                  //     borderRadius:
                                                  //     BorderRadius.circular(10),
                                                  //   ),
                                                  //   child: Image.asset(
                                                  //     "assets/images/parkimage.png",
                                                  //     fit: BoxFit.cover,
                                                  //   ),
                                                  // ),
                                                  Container(
                                                    clipBehavior: Clip.hardEdge,
                                                    height: Get.height * .075,
                                                    width: Get.height * .075,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: controller.hostData.value.result?.previousActivities?[index].activities?[ind].banners != null &&
                                                        controller.hostData.value.result!.previousActivities![index].activities![ind].banners!.isNotEmpty
                                                        ? CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: controller.hostData.value.result!.previousActivities![index].activities![ind].banners![0],
                                                      placeholder: (context, url) => Shimmer.fromColors(
                                                        baseColor: grey300,
                                                        highlightColor: grey100,
                                                        child: Container(
                                                          color: grey300,
                                                        ),
                                                      ),
                                                    )
                                                        : Image.asset(
                                                      "assets/images/parkimage.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                          color: clrWhite,
                                                          borderRadius:
                                                          BorderRadius.circular(5)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            controller.hostData.value.result?.previousActivities?[index].activities?[ind].name.toString() ?? '',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                          ),
                                                          Text(
                                                              controller.hostData.value.result!.previousActivities![index].activities![ind].status.toString() ?? '',
                                                              style: TextStyle(
                                                                  color: clrGreyTextLight,
                                                                  fontSize: 12)
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  alertReport() {
    Get.dialog(AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      content: SizedBox(
        width: double.maxFinite,
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
                  "Report user",
                  style: TextStyle(fontSize: 20
                      , fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Why are you reporting this user?",
              style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(() => SizedBox(
                height: 30,
                child: CustomRadioButton(
                    text: "Fake profile or spam",
                    activeColor: clrYellow,
                    value: 1,
                    groupValue: controller.selectedValue.value,
                    onChanged: (val) {
                      controller.updateSelectedValue(val);
                    }
                )
            ),),
            const SizedBox(
              height: 5,
            ),
            Divider(
              color: clrBlacke.withOpacity(.15),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() => SizedBox(
                height: 30,
                child: CustomRadioButton(
                    text: "Inappropriate or offensive behaviour",
                    activeColor: clrYellow,
                    value: 2,
                    groupValue: controller.selectedValue.value,
                    onChanged: (val) {
                      controller.updateSelectedValue(val);
                    }
                )
            ),),
            const SizedBox(
              height: 5,
            ),
            Divider(
              color: clrBlacke.withOpacity(.15),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() => SizedBox(
                height: 30,
                child: CustomRadioButton(
                    text: "Harrassment or abuse",
                    activeColor: clrYellow,
                    value: 3,
                    groupValue: controller.selectedValue.value,
                    onChanged: (val) {
                      controller.updateSelectedValue(val);
                    }
                )
            ),),
            const SizedBox(
              height: 5,
            ),
            Divider(
              color: clrBlacke.withOpacity(.15),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() => SizedBox(
                height: 30,
                child: CustomRadioButton(
                    text: "Other",
                    activeColor: clrYellow,
                    value: 4,
                    groupValue: controller.selectedValue.value,
                    onChanged: (val) {
                      controller.updateSelectedValue(val);
                    }
                )
            ),),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: formkey,
              child: CustoTextFormField(
                validation: (value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter something';
                  }else{
                    return null;
                  }
                },
                controll: controller.reportDescriptionController,
                hintText: "Please provide more details about what happened. We will review your report and take appropriate action.",
                maxLines: 5,
                borderRadius: 15,
                hintSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Opacity(
              opacity: controller.reportuserLoading.value ? 0.5 : 1,
              child: SizedBox(
                  width: double.maxFinite,
                  height: Get.height * .07,
                  child: CustomElevatedButton(
                      onTap: (){
                        if(controller.selectedValue.value == 4){
                          if(formkey.currentState!.validate()){
                            controller.reportUser(controller.hostData.value.result?.id.toString());
                          }
                        }else if(controller.selectedValue.value != 0){
                          controller.reportUser(controller.hostData.value.result?.id.toString());
                        }
                        else{
                          showTostMsg('Please select any reason');
                        }
                      },
                      child: controller.reportuserLoading.value
                          ? CommonUi.buttonLoading()
                          : Text(
                        "Submit",
                        style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),
                      ),
                      backgroundClr: clrBlacke
                  )
              ),
            ),),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
