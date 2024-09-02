import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/addactreview/controller/addactreview_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../utils/colors.dart';
import '../../../../explore/exploreview/model/exploreviewui_model.dart';

class AddActReviewUi extends StatefulWidget {
  AddActReviewUi({super.key});

  @override
  State<AddActReviewUi> createState() => _AddActReviewUiState();
}

class _AddActReviewUiState extends State<AddActReviewUi> {
  final AddactreviewController controller = Get.put(AddactreviewController());

  double rating = 0.0;
  late String? id;
  late String? hostImg;
  late List<Going>? goingImg;

  @override
  void initState() {
    super.initState();
    // Retrieve the arguments
    id = Get.arguments['id'];
    hostImg = Get.arguments['hostimg'];
    goingImg = List<Going>.from(Get.arguments['goingimg']);
  }

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              SizedBox(
              height: h*.012,
            ),
            Row(
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
                //         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  "Add a review",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ))),
                SizedBox(
                  width: Get.width*0.1,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "How would you rate this activity?",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      RatingBar(
                        allowHalfRating: true,
                        ratingWidget:RatingWidget(
                          full: Icon(
                            Icons.star,
                            color: clrYellow,
                            size: 50,
                          ),
                          half: Icon(
                            Icons.star_half,
                            color: clrYellow,
                            size: 50,
                          ),
                          empty: Icon(
                            Icons.star_border,
                            color: Colors.grey.shade400,
                            size: 50,
                          ),
                        ) ,
                        onRatingUpdate: (val) {
                          rating = val;
                          },
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      CustoTextFormField(
                        controll: controller.textController,
                        maxLines: 5,
                        hintText: "Host and other members would love to hear about your experience.",
                        borderRadius: 15
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      hostImg!.isEmpty  ? SizedBox() : Text("Hosted by",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      // Container(
                      //     height: h*.075,
                      //     width: h*.075,
                      //     decoration: BoxDecoration(
                      //         borderRadius:
                      //         BorderRadius.circular(100)
                      //     ),
                      //     child: hostImg != null
                      //         ? Image.network(
                      //       hostImg!,
                      //       fit: BoxFit.cover,
                      //     )
                      //         : Image.asset(
                      //       "assets/images/girldp.png",
                      //       fit: BoxFit.cover,
                      //     ),
                      // ),
                      hostImg!.isEmpty  ? SizedBox() : ClipRRect(
                        borderRadius:
                        BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          height: 52,
                          width: 52,
                          fit: BoxFit.cover,
                          imageUrl:
                          hostImg.toString(),
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
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      goingImg!.isEmpty ? SizedBox() : Text("Attendees",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      goingImg!.isEmpty ? SizedBox() : SizedBox(
                        height: 52,
                        child: ListView.separated(
                            itemCount: goingImg?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                              String? profilePhoto = goingImg?[index].profilePhoto;
                          //     return Container(
                          //       margin: const EdgeInsets.only(right: 5),
                          //       clipBehavior: Clip.hardEdge,
                          //       height: h*.075,
                          //       width: h*.075,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(100),
                          //       ),
                          //       child:profilePhoto != null
                          //           ? Image.network(
                          //         profilePhoto,
                          //         fit: BoxFit.cover,
                          //       )
                          //           : Image.asset(
                          //         "assets/images/cofee.png",
                          //         fit: BoxFit.cover,
                          //       ),
                          // );
                              return ClipRRect(
                                borderRadius:
                                BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  height: 52,
                                  width: 52,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                  profilePhoto.toString(),
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
                              );
                        }, separatorBuilder: (BuildContext context, int index) {return SizedBox(width: 10,); },),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Obx(() =>  Opacity(
                        opacity: controller.addreviewLoading.value ? .5 : 1,
                        child: SizedBox(
                          height: Res.h_btn,
                          width: double.maxFinite,
                          child: CustomElevatedButton(
                              onTap: (){
                                if (rating <= 0) {
                                  showTostMsg('Please provide a rating');
                                  return;
                                }

                                if (controller.textController.text.trim().isEmpty) {
                                  showTostMsg('Please enter a review description');
                                  return;
                                }

                                controller.addreviewapi(id,rating);
                              },
                              child: controller.addreviewLoading.value ? CommonUi.buttonLoading() : Text(
                                "Submit review",
                                style: TextStyle(
                                    color: clrWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              backgroundClr: clrBlacke
                          ),
                        ),
                      ),),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                    ],
                  ),
                )
            )],
            ),
          )
      ),
    );
  }
}
