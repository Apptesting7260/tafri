import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/utils/size.dart';

import '../../../../utils/colors.dart';

class AddActReviewUi extends StatefulWidget {
  const AddActReviewUi({super.key});

  @override
  State<AddActReviewUi> createState() => _AddActReviewUiState();
}

class _AddActReviewUiState extends State<AddActReviewUi> {
  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            SizedBox(
            height: h*.012,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: h*.05,
                    height: h*.05,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Icon(Icons.arrow_back_ios)),
                  ),
                ),
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
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
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
                    ratingWidget:RatingWidget(full: Icon(
                    Icons.star,
                    color: clrYellow,
                    size: h*.075,
                  ), half: Icon(
                    Icons.star_half,
                    color: clrYellow,
                    size: h*.075,
                  ),
                    empty: Icon(
                    Icons.star_border,
                    color: clrYellow,
                    size: h*.075,
                  ),) , onRatingUpdate: (rating) {
                    print(rating);
                  },),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  CustoTextFormField(maxLines: 5,hintText: "Host and other members would love to hear about your experience.",),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text("Hosted by",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                      height: h*.075,
                      width: h*.075,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(100)),
                      child: Image.asset(
                        "assets/images/girldp.png",
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Text("Attendees",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  SizedBox(
                    height: h*.075,
                    child: ListView.builder(itemCount: 2,scrollDirection: Axis.horizontal,shrinkWrap: true,itemBuilder: (context,index){
                      return Container(
                        margin: const EdgeInsets.only(right: 5),
                        clipBehavior: Clip.hardEdge,
                        height: h*.075,
                        width: h*.075,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset("assets/images/cofee.png",fit: BoxFit.cover,),
                      ) ;
                    }),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  SizedBox(
                    height: Res.h_btn,
                    width: double.maxFinite,
                    child: CustoElevatedBtn(child: Text("Submit review",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),), onTap: (){}, backgroundClr: clrBlacke),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}
