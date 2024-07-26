import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custofilterbtn.dart';
import '../../../../../../../utils/colors.dart';
import '../../../../../../../utils/size.dart';

class ActivityInterestUi extends GetWidget{
  const ActivityInterestUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h=Get.height;
    var w=Get.width;
    return Scaffold(
      backgroundColor: clrWhite,
      body: SafeArea(child: Padding(
        padding:   EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        child: Column(
          children: [
            SizedBox(
              height:h*.012,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width:h*.05,
                    height: h*.05,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: clrGreyLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Icon(Icons.arrow_back_ios)),
                  ),
                ),
                const Text(
                  "Activity interests",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                  SizedBox(
                  width: h*.024,
                ),
              ],
            ),
            SizedBox(
              height: Get.height*0.02,
            ),
            Expanded(
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add 3 to 10 activities you are interested in partnering with others",style: TextStyle(fontSize: 15),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Text("Sports & fitness",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/cycleicon.png",height: 16,),SizedBox(width: 3,),Text("Cycling",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/pdelicon.png",height: 16,),SizedBox(width: 3,),Text("Padel",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/tennisicon.png",height: 16,),SizedBox(width: 3,),Text("Tennis",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/climbicon.png",height: 16,),SizedBox(width: 3,),Text("Climbing",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/bouldringicon.png",height: 16,),SizedBox(width: 3,),Text("Bouldering",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),

                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/basketballicon.png",height: 16,),SizedBox(width: 3,),Text("Basketball",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/soccericon.png",height: 16,),SizedBox(width: 3,),Text("Soccer",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/yogaicon.png",height: 16,),SizedBox(width: 3,),Text("Yoga",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/windsuffering.png",height: 16,),SizedBox(width: 3,),Text("Windsurfing",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/kitesuffering.png",height: 16,),SizedBox(width: 3,),Text("Kitesurfing",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/kayaking.png",height: 16,),SizedBox(width: 3,),Text("Kayaking",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/Running.png",height: 16,),SizedBox(width: 3,),Text("Running",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Text("Other",style: TextStyle(color: clrBlacke),), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),

                    ],
                  ),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Text("Workshops & learning",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/dance.png",height: 16,),SizedBox(width: 3,),Text("Dance class",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/pottery.png",height: 16,),SizedBox(width: 3,),Text("Pottery class",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/cooking.png",height: 16,),SizedBox(width: 3,),Text("Cooking class",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/languagetrn.png",height: 16,),SizedBox(width: 3,),Text("Language exchange",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/careernetworking.png",height: 16,),SizedBox(width: 3,),Text("Career networking",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                    ],
                  ),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Text("Food & drinks",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/picnick.png",height: 16,),SizedBox(width: 3,),Text("Picnic",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/cafe.png",height: 16,),SizedBox(width: 3,),Text("Cafe",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/wine.png",height: 16,),SizedBox(width: 3,),Text("Wine",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/beer.png",height: 16,),SizedBox(width: 3,),Text("Beer",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/dinner.png",height: 16,),SizedBox(width: 3,),Text("Dining",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Text("Other",style: TextStyle(color: clrBlacke),), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                    ],
                  ),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Text("Entertainment & performances",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/consert.png",height: 16,),SizedBox(width: 3,),Text("Concert",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/musicfest.png",height: 16,),SizedBox(width: 3,),Text("Music festival",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/livehouse.png",height: 16,),SizedBox(width: 3,),Text("Livehouse",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/standup.png",height: 16,),SizedBox(width: 3,),Text("Standup comedy",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/movie.png",height: 16,),SizedBox(width: 3,),Text("Movies",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Text("Other",style: TextStyle(color: clrBlacke),), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                    ],
                  ),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Text("Arts & Community",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/musium.png",height: 16,),SizedBox(width: 3,),Text("Museum",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/exebition.png",height: 16,),SizedBox(width: 3,),Text("Exhibition",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/localmarcket.png",height: 16,),SizedBox(width: 3,),Text("Local markets",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/communityservice.png",height: 16,),SizedBox(width: 3,),Text("Community service",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),

                      SizedBox(height: 36,child: CustoFilterBtn(lable: Text("Other",style: TextStyle(color: clrBlacke),), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                    ],
                  ),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Text("Hobbies & Creativity",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                  SizedBox(
                    height: Get.height*0.015,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/camerahoby.png",height: 16,),SizedBox(width: 3,),Text("Photography",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/drawing.png",height: 16,),SizedBox(width: 3,),Text("Drawing",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/crafting.png",height: 16,),SizedBox(width: 3,),Text("Crafting",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/writing.png",height: 16,),SizedBox(width: 3,),Text("Writing",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/reading.png",height: 16,),SizedBox(width: 3,),Text("Reading",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Row(mainAxisSize: MainAxisSize.min,children: [Image.asset("assets/icons/chess.png",height: 16,),SizedBox(width: 3,),Text("Chess",style: TextStyle(color: clrBlacke),)],), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                      SizedBox(height: 36,child: CustoFilterBtn(lable: Text("Other",style: TextStyle(color: clrBlacke),), ontap: (){}, backgroundClr: clrWhite,borderClr: clrBlacke.withOpacity(0.2),)),
                    ],
                  ),
                  SizedBox(
                    height: Get.height*0.03,
                  ),
                ],
              ),
            ),
            SizedBox(height:Res.h_btn ,width: double.maxFinite,child: CustoElevatedBtn(onTap: (){} ,backgroundClr:clrBlacke, child: Text("Save",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
            SizedBox(
              height: Get.height*0.01,
            ),
          ],
        ),
      )),
    );
  }
}
