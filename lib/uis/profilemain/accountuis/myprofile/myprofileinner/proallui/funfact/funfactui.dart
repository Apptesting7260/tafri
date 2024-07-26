import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/utils/size.dart';

import '../../../../../../../utils/colors.dart';
import '../../../../../../components/custodropdownbtn.dart';

class FunFactUi extends GetWidget {
  const FunFactUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: h * .05,
                    height: h * .05,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Icon(Icons.arrow_back_ios)),
                  ),
                ),
                const Text(
                  "Fun facts about me",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: w * .04,
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  child: Text(
                      "Answer 1-3 fun fact questions to show your personality and help others get to know you"),
                ),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: clrGreyLight),
                    child: Column(
                      children: [
                        const Text(
                          "One interesting skill you’d love to learn and why?",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: h * .013,
                        ),
                        Divider(
                          color: clrGrey,
                        ),
                        Text(
                          "I'd love to talk to animals. Imagine getting advice from an owl, gossip from your dog, or having a heart-to-heart with a dolphin. ",
                          style:
                              TextStyle(color: clrGreyTextLight, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 13),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: clrGreyLight),
                      child: Column(
                        children: [
                          // Text(
                          //   ,style: TextStyle(),),
                          SizedBox(
                            height: 25,
                            child: CustoDropDownBtn(
                                onchange: (val) {},
                                itemList: const [
                                  DropdownMenuItem(
                                    value: 1,
                                    child:
                                        Text("What’s your go-to karaoke song?"),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child:
                                    Text("Are you a morning person or night owl?"),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child:
                                    Text("What's your hidden skill or talent?"),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child:
                                    Text("What recent book, movie, or show did you enjoy?"),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child:
                                    Text("What type of music do you love?"),
                                  ),
                                  DropdownMenuItem(
                                    value: 6,
                                    child:
                                    Text("What's your quirky talent or party trick?"),
                                  ),
                                  DropdownMenuItem(
                                    value: 7,
                                    child:
                                    Text("What's your go-to karaoke song?"),
                                  ),
                                  DropdownMenuItem(
                                    value: 8,
                                    child:
                                    Text("If you could be an expert in anything, what would it be?"),
                                  ),
                                  DropdownMenuItem(
                                    value: 9,
                                    child:
                                    Text("What's on your bucket list?"),
                                  ),
                                  DropdownMenuItem(
                                    value: 10,
                                    child:
                                    Text("What's your favorite book, movie, or TV show?"),
                                  ),
                                  DropdownMenuItem(
                                    value: 11,
                                    child:
                                    Text("What's your favorite place you’ve traveled to?"),
                                  ), 
                                ],
                                hindtext: "Select Question"),
                          ),
                          SizedBox(
                            height: h * .012,
                          ),
                          Divider(
                            color: clrGrey,
                          ),
                          const CustoTextFormField(
                            hintText: "Enter your answer",
                            maxLines: 3,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: -5,
                      child: InkWell(
                        onTap: () {
                          debugPrint("clicked gk tested");
                        },
                        child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: clrBlacke,
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.close,
                              color: clrWhite,
                              size: 19,
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: clrYellow,
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.add,
                              color: clrWhite,
                              size: 18,
                            )),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text("Add new question")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: h * .02,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: SizedBox(
                height: Res.h_btn,
                width: double.maxFinite,
                child: CustoElevatedBtn(
                    onTap: () {},
                    backgroundClr: clrBlacke,
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: clrWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ))),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
        ],
      )),
    );
  }
}
