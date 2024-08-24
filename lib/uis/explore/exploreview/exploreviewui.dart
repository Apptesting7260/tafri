import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/explore/exploreview/controller/exploreview_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/custom_radio.dart';
import '../../../utils/error_widget.dart';
import '../../../utils/tostmsg.dart';
import '../../components/custotextfield.dart';
import '../explorelist/controller/explorelist_controller.dart';

class ExploreViewUi extends GetWidget<ExploreViewController>{
  ExploreViewUi({super.key});
  ExploreListController exploreListController=Get.find<ExploreListController>();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    // var controller.actData.value.activity! = controller.controller.actData.value.activity!.value.activity!;
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
                  // InkWell(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Container(
                  //     clipBehavior: Clip.hardEdge,
                  //     width: 40,
                  //     height: 40,
                  //     padding:
                  //     const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //     decoration: BoxDecoration(
                  //         color: clrGreyLight,
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: const Center(child: Icon(Icons.arrow_back_ios)),
                  //   ),
                  // ),
                  const Text(
                    "Activity",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Share.share('check out my Activity https://example.com');
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          width: w*.1,
                          height:w*.1,
                          decoration: BoxDecoration(
                            color: clrBlacke,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/icons/uploadicon.png",
                              color: clrWhite,
                              height: w*.06,
                              width: w*.06,
                            ), //
                          ),
                        ),
                      ),
                       SizedBox(
                        width: w*.01,
                      ),
                      SizedBox(
                        width: w*0.07,
                        child: Center(
                          child: PopupMenuButton(
                            splashRadius: 0.1,
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
              SizedBox(
                height: Get.height*0.02,
              ),
              Expanded(
                child: Obx(() => controller.activitypage.value ? Center(
                  child: CommonUi.scaffoldLoading(color: clrYellow),
                ) : controller.actError.value.isNotEmpty ? ErrorScreen() : SingleChildScrollView(
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
                                    onPageChanged: (currIndex, CarouselPageChangedReason reason) {
                                      controller.changeIndicator(currIndex);
                                      debugPrint(" currIndex $currIndex reason=$reason");
                                    }),
                                items: controller.actData.value.activity!.banners?.map<Widget>((i) {
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
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: clrWhite,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: Text(
                                        controller.actData.value.activity!.subcategoryTitle.toString(),
                                        style: TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: (){
                                    //     // log("message");
                                    //     return controller.changeFav();
                                    //   },
                                    //   child: Obx((){
                                    //     return Container(
                                    //       padding: const EdgeInsets.all(6),
                                    //       decoration: BoxDecoration(
                                    //           color: clrWhite,
                                    //           borderRadius:
                                    //           BorderRadius.circular(100)),
                                    //       child: Icon(
                                    //         controller.isFav.value?Icons.favorite:
                                    //       Icons.favorite_border,
                                    //         size: 20,
                                    //         color: controller.isFav.value?clrYellow:null,
                                    //       ),
                                    //     );
                                    //   }),
                                    // ),
                                    InkWell(
                                      onTap: () async{
                                        var id = controller.actData.value.activity!.id.toString();
                                        await controller.changeFavApi(id).then((value) {
                                          if(value == true){
                                            controller.actData.value.activity!.isFav = !controller.actData.value.activity!.isFav!;
                                            exploreListController.homePageApi();
                                          }
                                        },);

                                        controller.actData.refresh();
                                        // controller
                                        //     .changeFav(
                                        //         index);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(color: clrWhite, borderRadius: BorderRadius.circular(100)),
                                        child: controller.actData.value.activity!.isFav == true
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
                              // Align(
                              //   alignment: Alignment.bottomCenter,
                              //   child: Container(
                              //     margin: const EdgeInsets.only(bottom: 7),
                              //     height: 16,
                              //     child: ListView.builder(
                              //         itemCount: 3,
                              //         shrinkWrap: true,
                              //         scrollDirection: Axis.horizontal,
                              //         itemBuilder: (context, index) {
                              //           return Padding(
                              //             padding: const EdgeInsets.symmetric(
                              //                 horizontal: 1.5),
                              //             child: Icon(
                              //               Icons.circle,
                              //               color: clrWhite,
                              //               size: 8,
                              //             ),
                              //           );
                              //         }),
                              //   ),
                              // )
                              Align(
                                alignment:
                                Alignment.bottomCenter,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 7),
                                  height: 16,
                                  child: ListView.builder(
                                      itemCount: controller.actData.value.activity!.banners?.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, indicatorIndex) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 1.5),
                                          child: Obx(() => Icon(
                                              Icons.circle,
                                              color: controller.actData.value.activity!.circleIndex?.value == indicatorIndex
                                                  ? clrYellow : clrWhite,
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
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.actData.value.activity!.name.toString(),
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: h * .005,),
                                  Text(
                                    controller.actData.value.activity!.location.toString(),
                                    style: TextStyle(color:clrGreyDark),
                                  ),
                                  SizedBox(height: h * .005,),
                                  Text(
                                    '${controller.actData.value.activity!.formattedDate} | ${controller.actData.value.activity!.startAt} - ${controller.actData.value.activity!.endAt}',
                                    style: TextStyle(color:clrGreyTextLight),
                                  ),
                                  SizedBox(height: h * .005,),
                                  Text(
                                    "Up to ${controller.actData.value.activity!.maxPeople} people | ${controller.actData.value.activity!.spotLeft} spot left",
                                    style: TextStyle(color: clrYellowText,fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: (){
                                // Get.toNamed(Routes.hostProfileUi,arguments: controller.actData.value.activity!.hostId.toString());
                              },
                              child: Column(
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
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      height: 38,
                                      width: 38,
                                      fit: BoxFit.cover,
                                      imageUrl: '${controller.actData.value.activity!.profilePhoto}',
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            height: 38,
                                            width: 38,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: clrGreyLight,
                                                shape: BoxShape.circle
                                            ),
                                            child: Image.asset(
                                              "assets/icons/manicon.png",
                                              color: clrGrey,fit: BoxFit.cover,),
                                          ),
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                            baseColor: grey300,
                                            highlightColor: grey100,
                                            child: Container(
                                              width: double.maxFinite,
                                              height: h * .05,
                                              decoration: BoxDecoration(
                                                color: grey300,
                                                borderRadius: BorderRadius.circular(18),
                                              ),
                                            ),
                                          ),
                                    ),
                                  ),
                                  Text(
                                    controller.actData.value.activity!.hostName.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w700),)
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text(
                          controller.actData.value.activity!.description.toString(),
                          style: TextStyle(fontSize: 14,color:clrGrey5D5C5E),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        const Text("Going",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                        SizedBox(
                          height: Get.height*0.01,
                        ),
                        SizedBox(
                          height: h*.065,
                          child: ListView.builder(itemCount: 2,scrollDirection: Axis.horizontal,shrinkWrap: true,itemBuilder: (context,index){
                            return Container(
                              margin: const EdgeInsets.only(right: 5),
                              clipBehavior: Clip.hardEdge,
                              height: h*.065,
                              width: h*.065,
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
                        Obx((){
                          print('re');
                          return controller.actData.value.activity!.requestStatus == 'pending'
                              ? SizedBox(
                                  width: double.maxFinite,
                                  height: Res.h_btn,
                                  child: CustomElevatedButton(
                                      onTap: (){},
                                      backgroundClr: clrGrey,
                                      child: Text(
                                        "Pending Host Confirmation",
                                        style: TextStyle(
                                            color: clrWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700
                                        ),
                                      )
                                  )
                          ) : controller.actData.value.activity!.requestStatus == 'accept' ? SizedBox(
                              width: double.maxFinite,
                              height: Res.h_btn,
                              child: CustomElevatedButton(
                                  onTap: (){},
                                  backgroundClr: clrBlacke,
                                  child: Text(
                                    "Join group chat",
                                    style: TextStyle(
                                        color: clrWhite,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),
                                  )
                              )
                          ) : controller.actData.value.activity!.requestStatus == 'reject' ? SizedBox(
                              width: double.maxFinite,
                              height: Res.h_btn,
                              child: CustomElevatedButton(
                                  onTap: (){},
                                  backgroundClr: clrBlacke,
                                  child: Text(
                                    "Request sent",
                                    style: TextStyle(
                                        color: clrWhite,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),
                                  )
                              )
                          ) : controller.actData.value.activity!.requestStatus == 'leave' ? SizedBox(
                              width: double.maxFinite,
                              height: Res.h_btn,
                              child: CustomElevatedButton(
                                  onTap: (){},
                                  backgroundClr: clrBlacke,
                                  child: Text(
                                    "Request sent",
                                    style: TextStyle(
                                        color: clrWhite,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                    ),
                                  )
                              )
                          ) : Opacity(
                            opacity: controller.isLoadingRequest.value ? 0.5 : 1,
                            child: SizedBox(
                                  width: double.maxFinite,
                                  height:Res.h_btn,
                                  child: CustomElevatedButton(
                                      onTap: (){
                                        if(controller.actData.value.activity?.spotLeft == 0){
                                          controller.alertAddaMessage(controller.actData.value.activity!
                                              .id.toString());
                                        }else {
                                          controller.requestApi(
                                              controller.actData.value.activity!
                                                  .id.toString());
                                        }
                                      },
                                      backgroundClr: clrBlacke,
                                      child: controller.isLoadingRequest.value
                                          ? CommonUi.buttonLoading()
                                          : Text( controller.actData.value.activity?.spotLeft == 0 ? 'Join waitlist' :
                                              "Request to join",
                                              style: TextStyle(
                                                  color: clrWhite,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700
                                              ),
                                      )
                                  )
                            ),
                          );
                        }
                        ),
                        Obx((){
                          return controller.actData.value.activity!.requestStatus  == 'pending'
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: h*0.015,
                                    ),
                                    Center(
                                        child: InkWell(
                                        onTap: (){
                                          alertCancelRequest();
                                        },
                                            child: const Text(
                                              "Cancel request",
                                              style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.w600),
                                            )
                                        )
                                    )
                                  ],
                          ) : controller.actData.value.activity!.requestStatus == 'accept' ? Column(
                            children: [
                              SizedBox(
                                height: h*0.015,
                              ),
                              Center(
                                  child: InkWell(
                                      onTap: (){
                                        alertCancelRequest();
                                      },
                                      child: const Text(
                                        "Leave activity",
                                        style: TextStyle(decoration: TextDecoration.underline,fontSize: 16),
                                      )
                                  )
                              )
                            ],
                          ) : const SizedBox();
                        }),
                        SizedBox(
                          height: Get.height*0.01,
                        ),
                      ],
                    ),
                  ),
                )
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
      insetPadding:  EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Why are you reporting this activity?",
                  style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),
                ),
              ],
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
              opacity: controller.reportactivityLoading.value ? 0.5 : 1,
              child: SizedBox(
                  width: double.maxFinite,
                  height: Get.height * .07,
                  child: CustomElevatedButton(
                      onTap: (){
                        // if(controller.selectedValue.value == 4){
                        //   if(formkey.currentState!.validate()){
                        //     controller.reportActivity(controller.actData.value.activity?.id.toString());
                        //   }
                        // }else if(controller.selectedValue.value != 0){
                        //   controller.reportActivity(controller.actData.value.activity?.id.toString());
                        // }
                        // else{
                        //   showTostMsg('Please select any reason');
                        // }
                      },
                      child: controller.reportactivityLoading.value
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


  alertCancelRequest() {
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
                  "Cancel request",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Center(child: Text("Are you sure you want to cancel your request to join this activity?",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),


                SizedBox(
                height:Get.height*.024,
              ),
              Row(
                  children: [
                    Expanded(child: SizedBox(
                      height: Res.h_btn,
                      child: CustoFilterBtn(borderClr: clrBlacke,lable: Text("Yes",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),), ontap: (){
                        Get.back();
                        alertCancelRequestConfirmation();
                      }, backgroundClr: Get.theme.scaffoldBackgroundColor),
                    )),
                    SizedBox(
                      width: Get.width*0.05,
                    ),
                    Expanded(child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                      Get.back();
                    }, backgroundClr: clrBlacke, child: Text("No",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),),


                  ]
              ),
                SizedBox(
                height: Get.height*.014,
              ),
            ],
          ),
        ),
      ));
    });
  }
  alertCancelRequestConfirmation() {
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
                height: Get.height*.014,
              ),
              Center(child: Text("Canceling within 24 hours of the activity will incur a €3 fee. Are you sure you want to proceed?",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),


                SizedBox(
                height: Get.height*.024,
              ),
              Row(
                  children: [
                    Expanded(child: SizedBox(
                      height: Res.h_btn,
                      child: CustoFilterBtn(borderClr: clrBlacke,lable: Text("Yes",style: TextStyle(color: clrBlacke,fontSize: 16,fontWeight: FontWeight.w700),), ontap: (){
                        controller.changeReqSent(1);
                        Get.back();
                      }, backgroundClr: Get.theme.scaffoldBackgroundColor),
                    )),
                    SizedBox(
                      width: Get.width*0.05,
                    ),
                    Expanded(child: SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
                      Get.back();
                    }, backgroundClr: clrBlacke, child: Text("No",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),),
                  ]
              ),
                SizedBox(
                height: Get.height*.014,
              ),
            ],
          ),
        ),
      ));
    });
  }
}
