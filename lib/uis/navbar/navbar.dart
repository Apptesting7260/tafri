import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/creativity/createcreativityui.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/uis/explore/explorelist/exploreui.dart';
import 'package:plusone/uis/message/messagelist/controller/messagelist_controller.dart';
import 'package:plusone/uis/message/messagelist/messagelistui.dart';
import 'package:plusone/uis/myactivity/myactivitylist/controller/myacti_controller.dart';
import 'package:plusone/uis/myactivity/myactivitylist/myactivitieslistui.dart';
import 'package:plusone/uis/navbar/controller/navbar_controller.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/uis/profilemain/profileui.dart';
import '../../utils/colors.dart';

class Navbar extends GetWidget {
  Navbar({super.key});
  List classes = [
     ExploreUi(),
    const MessageListUi(),
     MyActivitiesListUi(),
    const ProfileUi()
  ];
  // List<IconData> iconList=[IconData()];
  NavBarController navcontroller = Get.put(NavBarController());
  ExploreListController exploreListController=Get.put(ExploreListController());

  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];
  int classIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return classes[navcontroller.navIndex.value ?? 0];
      }),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton(
            backgroundColor: clrYellow,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.add,
              size: 35,
              color: clrWhite,
            ),
            onPressed: () {
              if( exploreListController.homeData.value.result?.membershipStatus == true && exploreListController.homeData.value.result?.profileComplete == true ) {
                Get.toNamed(Routes.createActivityUi);
              }else{
                exploreListController.showHomePop();
              }
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: GetBuilder<NavBarController>(builder: (controller) {
        return AnimatedBottomNavigationBar.builder(
            // backgroundGradient: LinearGradient(colors: [clrYellow,clrWhite]),
            height: 60,
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              final color =
                  controller.navIndex.value == index ? clrYellow : clrGrey;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  index == 0
                      ? Icon(
                          Icons.home,
                          color: controller.navIndex.value == 0
                              ? clrYellow
                              : clrGrey,
                        )
                      : index == 1
                          ? Image.asset(
                              "assets/icons/msgicon.png",
                              height: 23,
                              color: controller.navIndex.value == 1
                                  ? clrYellow
                                  : clrGrey,
                            )
                          : index == 2
                              ? Image.asset(
                                  "assets/icons/calendericon.png",
                                  height: 23,
                                  color: controller.navIndex.value == 2
                                      ? clrYellow
                                      : clrGrey,
                                )
                              : index == 3
                                  ? Image.asset(
                                      "assets/icons/manicon.png",
                                      height: 23,
                                      color: controller.navIndex.value == 3
                                          ? clrYellow
                                          : clrGrey,
                                    )
                                  : const Icon(Icons.home),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                      index == 0
                          ? "Explore"
                          : index == 1
                              ? 'Messages'
                              : index == 2
                                  ? "My Activities"
                                  : index == 3
                                      ? "Profile"
                                      : '',
                      maxLines: 1,
                      style: TextStyle(color: color, fontSize: 10),
                    ),
                  )
                ],
              );
            },
            backgroundColor: clrWhite,
            activeIndex: classIndex,
            notchSmoothness: NotchSmoothness.sharpEdge,
            gapLocation: GapLocation.center,
            leftCornerRadius: 20,
            rightCornerRadius: 20,
            onTap: (index) {
              index == 1
                      ? Get.put(MessagelistController())
                      : index == 2
                          ? Get.put(MyactiController())
                          : Get.put(ProfilemainController());
              controller.changeNavIndex(index);
            }
            );
      }),
    );
  }
}
