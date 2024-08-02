import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import '../../../utils/colors.dart';

class HostProfileUi extends GetWidget{
  const HostProfileUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: clrGreyLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(child: Icon(Icons.arrow_back_ios)),
                      ),
                    ),
                    const Text(
                      "Host profile",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      child: PopupMenuButton(
                        elevation: 5,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Center(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: const DecorationImage(
                                    image: AssetImage("assets/images/proimg.png"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Kayla",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16),
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
                              "25 years old | She/Her",
                              style: TextStyle(color: clrGreyTextLight, fontSize: 13),
                            )),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: clrGreyLight),
                                child: Column(
                                  children: [
                                    Text(
                                      "100%",
                                      style: TextStyle(
                                          color: clrYellowText.withOpacity(0.8),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const Text("Attendance Rate",
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: clrGreyLight),
                                child: Column(
                                  children: [
                                    Text(
                                      "20",
                                      style: TextStyle(
                                          color: clrYellowText.withOpacity(0.8),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const Text(
                                      "Activities Joined",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: clrGreyLight),
                                child: Column(
                                  children: [
                                    Text(
                                      "25",
                                      style: TextStyle(
                                          color: clrYellowText.withOpacity(0.8),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const Text("Activities Hosted",
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
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
                              Text(
                                  "Hi, I’m Kayla! I love exploring local cafes and meeting new people in the neighborhood. Whether it’s chatting over coffee, discovering new places, or planning community events, I’m always up for a good conversation. Looking forward to connecting with you! ☕️👋",
                                  style: TextStyle(color: clrGreyTextLight)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
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
                              Text("Amsterdam, Netherlands",
                                  style: TextStyle(color: clrGreyTextLight)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
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
                              Text("Creative Strategist at YouTube",
                                  style: TextStyle(color: clrGreyTextLight)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
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
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrWhite),
                                    child: const Text("English"),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrWhite),
                                    child: const Text("Spanish"),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
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
                              const SizedBox(
                                height: 5,
                              ),
                              const Text("Sports and fitness",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w800)),
                              const SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrWhite),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/icons/cycleicon.png",
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Text("Cycling"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text("Social",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w800)),
                              const SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrWhite),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/icons/dinner.png",
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Text("Dining out"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Learning",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: clrWhite),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/icons/languagetrn.png",
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Text("Language exchange"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
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
                              const Text(
                                "Fun facts about Emma",
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                              const Text(
                                "Are you a morning person or night owl?",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                  "I'm both! Whether it's sunrise or midnight, I'm always ready to roll.",
                                  style: TextStyle(color: clrGreyTextLight)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        const Text(
                          "Upcoming activities",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        ListView.builder(
                            itemCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: clrGreyLight),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "25 May",
                                      style: TextStyle(color: clrGreyDark),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.003,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          clipBehavior: Clip.hardEdge,
                                          height: 57,
                                          width: 57,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Image.asset(
                                            "assets/images/parkimage.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                                color: clrWhite,
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "10KM Vondelpark run",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                Text(
                                                    "Padel next, 1055 AH, Amsterdam ",
                                                    style: TextStyle(
                                                        color: clrGreyDark,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        const Text(
                          "Previous activities",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        ListView.builder(
                            itemCount: 1,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: clrGreyLight),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "20 May",
                                      style: TextStyle(color: clrGreyDark),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.003,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              clipBehavior: Clip.hardEdge,
                                              height: 57,
                                              width: 57,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Image.asset(
                                                "assets/images/parkimage.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.02,
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: clrWhite,
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Salsa night at Tulp",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                    Text("Confirm attendance",
                                                        style: TextStyle(
                                                            color: clrYellowText,
                                                            fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              clipBehavior: Clip.hardEdge,
                                              height: 57,
                                              width: 57,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Image.asset(
                                                "assets/images/cofee.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.02,
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: clrWhite,
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Sunday morning coffee",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                    Text("Cancelled",
                                                        style: TextStyle(
                                                            color: clrGreyTextLight,
                                                            fontSize: 12)),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
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
              ],
            ),
          )),
    );
  }

  alertReport() {
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
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),
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
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(height: 30,child: Radio(splashRadius: 0,value: 1, groupValue: 2, onChanged: (val) {})),
                const Text("Fake profile or spam")
              ],
            ),
            Divider(
              color: clrGreyLight,
            ),
            Row(
              children: [
                SizedBox(height: 30,child: Radio(value: 2, groupValue: 2, onChanged: (val) {})),
                const Text("Inappropriate or offensive behaviour")
              ],
            ),
            Divider(
              color: clrGreyLight,
            ),
            Row(
              children: [
                SizedBox(height: 30,child: Radio(value: 3, groupValue: 2, onChanged: (val) {})),
                const Text("Harrassment or abuse")
              ],
            ),
            Divider(
              color: clrGreyLight,
            ),
            Row(
              children: [
                SizedBox(height: 30,child: Radio(value: 4, groupValue: 2, onChanged: (val) {})),
                const Text("Other")
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const CustoTextFormField(hintText: "Please provide more details about what happened. We will review your report and take appropriate action.",maxLines: 5,),
            const SizedBox(
              height: 20,
            ),
            SizedBox(width: double.maxFinite,height: 45,child: CustomElevatedButton(child: Text("Submit",style: TextStyle(color: clrWhite),), onTap: (){
              Get.back();
            }, backgroundClr: clrBlacke)),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
