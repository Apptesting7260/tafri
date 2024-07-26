import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custodropdownbtn.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import 'package:plusone/uis/creativity/creativity_controller/creativityController.dart';
import '../../utils/colors.dart';
import '../../utils/size.dart';
import '../components/custotextfield.dart';

class CreateActivityUi extends GetWidget<Creativitycontroller>{
  const CreateActivityUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:Res.Defalt_side_margin),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: h*.05,
                      height: h*.05,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: clrGreyLight,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(child: Icon(Icons.arrow_back_ios)),
                    ),
                  ),
                  const Text(
                    "Create activity",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                    SizedBox(
                    width:h*.024,
                  )
                ],
              ),
              SizedBox(
                height:h * 0.03,
              ),
              TabBar(
                indicatorColor: clrYellow,
                dividerHeight: 0,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: clrBlacke,
                labelColor: clrYellow,
                labelStyle:
                const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                tabs: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Edit",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text("Preview"),
                  )
                ],
                controller: controller.tabController,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                child: TabBarView(controller: controller.tabController, children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          alertRepeatSchedule();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 1),
                                          child: DottedBorder(
                                              color: clrGrey,
                                              dashPattern: const [6,3],
                                              borderType: BorderType.RRect,
                                              strokeWidth: 2,
                                              radius: const Radius.circular(12),
                                              child: Container(
                                                clipBehavior: Clip.hardEdge,
                                                padding:
                                                  const EdgeInsets.symmetric(vertical: 40,),
                                                decoration: BoxDecoration(
                                                    color: clrGreyLight,
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                                child: Center(
                                                    child: Image.asset(
                                                      "assets/icons/imgicon.png",
                                                      height: 30,
                                                      color: clrGreyDark.withOpacity(0.8),
                                                    )),
                                              )),
                                        ),
                                      )),
                                    SizedBox(
                                    width:h*.013,
                                  ),
                                  Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 1),
                                        child: DottedBorder(
                                            color: clrGrey,
                                            dashPattern: const [6],
                                            borderType: BorderType.RRect,
                                            strokeWidth: 2,
                                            radius: const Radius.circular(12),
                                            child: Container(
                                              clipBehavior: Clip.hardEdge,
                                              padding:
                                                const EdgeInsets.symmetric(vertical: 30,),
                                              decoration: BoxDecoration(
                                                  color: clrGreyLight,
                                                  borderRadius:
                                                  BorderRadius.circular(15)),
                                              child: Center(
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 30,
                                                        color: clrGreyDark.withOpacity(0.8),
                                                      ),
                                                      Text(
                                                        "Add more",
                                                        style: TextStyle(
                                                            color: clrGreyDark
                                                                .withOpacity(0.8)),
                                                      )
                                                    ],
                                                  )),
                                            )),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Checkbox(value: true, onChanged: (val) {}),
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  const Text("Chose a photo for me")
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              SizedBox(
                                height: Res.h_btn,
                                child: const CustoDropDownBtn(itemList: [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text("Coffee"),
                                  )
                                ], hindtext: "Select Category"),
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                                SizedBox(
                                height: Res.h_btn,
                                child: const CustoTextFormField(
                                  hintText: "Activity name (title)",
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                                const SizedBox(
                                // height: Res.h_btn,
                                child: CustoTextFormField(
                                  hintText:
                                  "Write a description (min. 30 characters)",
                                  maxLines: 4,
                                  maxLength: 500,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              SizedBox(
                                height: Res.h_btn,
                                child: CustoTextFormField(
                                  hintText: "Location",
                                  sufixIcon: SizedBox(
                                      height:h*.013,
                                      width:h*.013,
                                      child: Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: Image.asset(
                                            "assets/icons/locationicon.png",
                                            height: 10,
                                            width: 10),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.015,
                              ),
                              InkWell(
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2025));
                                },
                                child: Container(
                                    height: Res.h_btn,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 13),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: clrGreyLight),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/calendericon.png",
                                          height: 23,
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "DD/MM/YYYY",
                                          style: TextStyle(color: clrGreyTextLight),
                                        )
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              SizedBox(
                                height: Res.h_btn,
                                child: CustoDropDownBtn(
                                  itemList: const [
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text("10:00 AM"),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text("11:00 AM"),
                                    ),
                                    DropdownMenuItem(
                                        value: 3,
                                        child: Text("12:00 PM")
                                    ),
                                  ],
                                  hindtext: "Start At",
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset("assets/icons/timericon.png"),
                                  ),
                                ),
                              ),
                        
                              SizedBox(
                                height: h * 0.015,
                              ),
                              SizedBox(
                                height: Res.h_btn,
                                child: CustoDropDownBtn(
                                  itemList: const [
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text("1:00 PM"),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text("2:00 PM"),
                                    ),
                                    DropdownMenuItem(
                                        value: 3,
                                        child: Text("3:00 PM")
                                    ),
                                  ],
                                  hindtext: "Ends At",
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset("assets/icons/timericon.png"),
                                  ),
                                ),
                              ),
                        
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              Container(
                                  height:Res.h_btn,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 13),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: clrGreyLight),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/manicon.png",
                                              height: 23,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Flexible(
                                                child: Text(
                                                  "Max 6 people (incl. you)",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: clrGreyTextLight),
                                                ))
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            controller.decGroupSize();
                                          }, child: const Icon(Icons.remove)),
                                        Obx((){
                                         return Text("${controller.groupSize}");
                                        }),
                                      InkWell(onTap: () {
                                        controller.incGroupSize();
                                      }, child: const Icon(Icons.add))
                                    ],
                                  )),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              SizedBox(
                                height: Res.h_btn,
                                child: Obx((){
                                  return CustoDropDownBtn(
                                    val: controller.gender.value==0?null:controller.gender.value,
                                    onchange: (val){
                                      controller.changeGenderFilter(val);
                                    },
                                    itemList: const [
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text("Same gender as me"),
                                      ),
                                      DropdownMenuItem(
                                        value:2,
                                        child: Text("All"),
                                      )
                                    ],
                                    hindtext: "Gender preference (optional)",
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Image.asset("assets/icons/gendericon.png"),
                                    ),
                                  ) ;
                                }),
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              SizedBox(
                                height:Res.h_btn,
                                child: Obx((){
                                  var value=controller.gender.value;
                                  return CustoDropDownBtn(
                                    val:controller.repeat?.value ,
                                    onchange: (val){
                                      return controller.changeRepeatVal(val);
                                    },
                                    backClr: clrWhite,
                                    borderClr: clrGrey.withOpacity(0.6),
                                    itemList: const [
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text("Doesn’t repeat"),
                                      ),
                                      DropdownMenuItem(
                                        value:2,
                                        child: Text("Should have repeat schedule "),
                                      ),
                                    ],
                                    hindtext: "Doesn’t repeat ",
                                  );
                                }),
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Join instantly without approval",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                 Obx((){
                                   return  SizedBox(
                                       height:h*.04,
                                       // width: 40,
                                       child: FittedBox(
                                           fit: BoxFit.fill,
                                           child: Switch(
                                             activeTrackColor: clrYellow,
                                             value: controller.joinInstant.value,
                                             onChanged: (val) {
                                               controller.changejoinInstant();
                                             },
                                             activeColor: clrWhite,
                                             focusColor: clrWhite,
                                             inactiveThumbColor: clrWhite,
                                             trackOutlineColor:
                                             WidgetStateProperty.all(
                                                 clrTransparent),
                                           )));
                                 })
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                        
                            ]),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                          height:Res.h_btn,
                          child: CustoElevatedBtn(
                              onTap: () {},
                              backgroundClr: clrBlacke,
                              child: Text(
                                "Post Activity",
                                style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),
                              ))),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                    ],
                  ),
////////////////////////////////////////////////////preview ui
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            SizedBox(
                              height: h*.25,
                              child: Stack(
                                // clipBehavior: Clip.none,
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                        height: h*.25, viewportFraction: 1),
                                    items: [1, 2, 3].map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                              clipBehavior: Clip.hardEdge,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: double.maxFinite,
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(18)),
                                              child: Image.asset(
                                                "assets/images/cofee.png",
                                                fit: BoxFit.cover,
                                                height: h*.25,
                                                width: double.maxFinite,
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
                                          child: const Text("Coffee",style: TextStyle(fontWeight: FontWeight.w600),),
                                        ),
                                        const SizedBox()
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 7),
                                      height: 16,
                                      child: ListView.builder(
                                          itemCount: 3,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 1.5),
                                              child: Icon(
                                                Icons.circle,
                                                color:index==0?clrYellow: clrWhite,
                                                size: 8,
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Picnic in the park",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.005,
                                      ),
                                      Text(
                                        "Vondelpark",
                                        style: TextStyle(
                                            color: clrGreyDark),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.005,
                                      ),
                                      Text(
                                        "13 March 2024 | 2:30 PM - 6:00PM",
                                        style: TextStyle(
                                            color: clrGreyDark),
                                      ),
                                      SizedBox(
                                        height:Get.height * 0.005,
                                      ),
                                      Text(
                                        "Up to 3 people | 1 spot left",
                                        style: TextStyle(
                                            color: clrYellowText, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                        height: h*.05,
                                        width: h*.05,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(100)),
                                        child: Image.asset(
                                          "assets/images/girldp.png",
                                          fit: BoxFit.cover,
                                        )),
                                    const Text("Jenny",style: TextStyle(fontWeight: FontWeight.w700),)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text( "Hey guys! Looking for 2 others who would like to join me for a picnic in the park today ,we all do games and dinner",
                              style: TextStyle(
                                  fontSize: 14, color: clrGreyTextLight),),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
  alertRepeatSchedule() {
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
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(onTap: (){Get.back();},child: const Icon(Icons.close)),
                const Text("Set repeat schedule",
                  style: TextStyle(fontSize: 17
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,),
                const SizedBox(
                  width: 1,
                )
              ],
            ),
            Divider(
              color: clrGreyLight,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Repeat every",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal:20,vertical:7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: clrGreyLight
                  ),
                  child: const Text("1"),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: const Icon(Icons.arrow_drop_up),
                    ),

                    InkWell(
                      onTap: (){},
                      child: const Icon(Icons.arrow_drop_down_outlined),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal:20,vertical: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: clrGreyLight
                  ),
                  child: const Text("week"),
                ),

              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Repeat every",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(150)
                    ),
                    child: const Text("M"),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(150)
                    ),
                    child: const Text("T"),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(150)
                    ),
                    child: const Text("W"),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(150)
                    ),
                    child: const Text("T"),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(150)
                    ),
                    child: const Text("F"),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(150)
                    ),
                    child: const Text("S"),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(150)
                    ),
                    child: const Text("S"),
                  ),
                ),
              ],
            ),
            Text("Repeat every",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,),
            Row(
              children: [
                Radio(activeColor: clrYellow,value: 1, groupValue: 2, onChanged: (val){}),
                Text("Never",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,),
              ],
            ),Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Radio(activeColor: clrYellow,value: 2, groupValue: 2, onChanged: (val){}),
                      Text("On",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal:15,vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: clrGreyLight
                  ),
                  child: Text("18 Sep 2024",style: TextStyle(color: clrGreyTextLight),),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Radio(activeColor: clrYellow,value: 3, groupValue: 2, onChanged: (val){}),
                      Text("After",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,),
                    ],
                  ),
                ),

                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: clrGreyLight
                    ),
                    child: Text("3 occurrences",style: TextStyle(color: clrGreyTextLight),),
                  ),
                ),
                SizedBox(
                  width: Get.width*0.05,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: const Icon(Icons.arrow_drop_up),
                    ),

                    InkWell(
                      onTap: (){},
                      child: const Icon(Icons.arrow_drop_down_outlined),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CustoFilterBtn(lable:  Text("Cancel",style: TextStyle(color: clrBlacke),), ontap: (){
                    Get.back();
                  }, backgroundClr: Get.theme.scaffoldBackgroundColor
                ),
                ),
                SizedBox(
                  width: Get.width*0.05,
                ),
                Expanded(child: CustoElevatedBtn(child: Text("Done",style: TextStyle(color: clrWhite),), onTap: (){
                  Get.back();
                }, backgroundClr: clrBlacke)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
