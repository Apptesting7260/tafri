import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/message/messagelist/controller/messagelist_controller.dart';
import 'package:plusone/uis/myactivity/myactivitylist/controller/myacti_controller.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import '../../../../utils/colors.dart';
import 'package:plusone/uis/navbar/controller/navbar_controller.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex; // Current index for active tab

  CustomBottomNavbar({Key? key, required this.currentIndex}) : super(key: key);

  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];

  NavBarController navcontroller = Get.find<NavBarController>();


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Bottom Navigation Bar
        AnimatedBottomNavigationBar.builder(
          height: 60,
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = navcontroller.navIndex.value == index ? clrYellow : clrGrey;

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                index == 0
                    ? Icon(Icons.home, color: color)
                    : index == 1
                    ? Image.asset(
                  "assets/icons/msgicon.png",
                  height: 23,
                  color: color,
                )
                    : index == 2
                    ? Image.asset(
                  "assets/icons/calendericon.png",
                  height: 23,
                  color: color,
                )
                    : Image.asset(
                  "assets/icons/manicon.png",
                  height: 23,
                  color: color,
                ),
                const SizedBox(height: 4),
                Text(
                  index == 0
                      ? "Explore"
                      : index == 1
                      ? 'Messages'
                      : index == 2
                      ? "My Activities"
                      : 'Profile',
                  maxLines: 1,
                  style: TextStyle(color: color, fontSize: 10),
                ),
              ],
            );
          },
          backgroundColor: clrWhite,
          activeIndex: currentIndex,
          notchSmoothness: NotchSmoothness.sharpEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 20,
          rightCornerRadius: 20,
          onTap: (index) {
            // Add navigation logic here based on the index
            if (index == 0) {
              // Get.toNamed(Routes.exploreUi);
              Get.back();
            } else if (index == 1) {
              navcontroller.changeNavIndex(1);
              Get.put(MessagelistController());
              Get.back();
              // Get.toNamed(Routes.messageListUi);
            } else if (index == 2) {
              navcontroller.changeNavIndex(2);
              Get.put(MyactiController());
              Get.back();
            } else if (index == 3) {
              navcontroller.changeNavIndex(3);
              Get.put(ProfilemainController());
              Get.back();
            }
          },
        ),
        // Floating Action Button in the Center
        Positioned(
          bottom: 30, // Adjust this value based on the height of your bottom bar
          child: FloatingActionButton(
            backgroundColor: clrYellow,
            shape: CircleBorder(),
            onPressed: () {
              Get.toNamed(Routes.createActivityUi); // Example route
            },
            child: Icon(Icons.add, size: 35, color: clrWhite),
          ),
        ),
      ],
    );
  }
}
