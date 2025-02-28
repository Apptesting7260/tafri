import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/creativity/createcreativityui.dart';
import 'package:plusone/uis/explore/explorelist/controller/explorelist_controller.dart';
import 'package:plusone/uis/explore/explorelist/exploreui.dart';
import 'package:plusone/uis/explore/filter/controller/filterexp_controller.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
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
     MessageListUi(),
     MyActivitiesListUi(),
     ProfileUi()
  ];
  // List<IconData> iconList=[IconData()];
  NavBarController navcontroller = Get.put(NavBarController());
  ExploreListController exploreListController=Get.put(ExploreListController());
  // SocketController chatController = Get.find<SocketController>();
  SocketController chatController = Get.put(SocketController());
  MyactiController activityController =  Get.put(MyactiController());
  MessagelistController notController = Get.put(MessagelistController());
  FilterExpController filterController = Get.put(FilterExpController());

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
      // extendBody: true,
      // backgroundColor: Colors.transparent,
      body: Obx(() {
        return classes[navcontroller.navIndex.value ?? 0];
      }),
      floatingActionButton:
      // Obx((){
      //   print('fab == ${exploreListController.calculateBottomBarOffset(from: 'FAB')}');
      //   return Transform.translate(
      //     offset: Offset(0, exploreListController.calculateBottomBarOffset(from: 'FAB')),
      //     child: Visibility(
      //       visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      //       child:
        FloatingActionButton(
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
                  // Get.toNamed(Routes.createActivityUi);
                }),
          // ),
        // );
      // }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GetBuilder<NavBarController>(builder: (controller) {
        return
          // Obx(() {
          // double dynamicHeight = ((exploreListController.bottomBarOffset.value > 0.0 ? 1 : 0) + exploreListController.bottomBarOffset.value) * 30;
          // print('bool == ${exploreListController.bottomBarOffset.value > 0.0}');
          // print('off == ${exploreListController.bottomBarOffset.value}');
          // print('height == ${dynamicHeight}');
          // return Transform.translate(
          //   offset: Offset(0, exploreListController.calculateBottomBarOffset()),
          //   child:
            AnimatedBottomNavigationBar.builder(
              // backgroundGradient: LinearGradient(colors: [clrYellow,clrWhite]),
              //   height:dynamicHeight,
              height: 60,
                itemCount: iconList.length,
                tabBuilder: (int index, bool isActive) {
                  final color =
                  controller.navIndex.value == index ? clrYellow : clrGrey;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
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
                                  ? "My activities"
                                  : index == 3
                                  ? "Profile"
                                  : '',
                              maxLines: 1,
                              style: TextStyle(color: color, fontSize: 10),
                            ),
                          )
                        ],
                      ),
                      if(index == 1)
                        Obx(() {
                          int totalUnread = chatController.unReadMsg.value + notController.unReadNot.value;

                          return totalUnread > 0
                              ? Padding(
                            padding: EdgeInsets.only(right: Get.width * 0.05, top: 3),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 9,
                                backgroundColor: clrWhite,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: clrRed,
                                  child: Center(
                                    child: Text(
                                      totalUnread > 99 ? '99+' : '$totalUnread',
                                      style: TextStyle(
                                        color: clrWhite,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                              : SizedBox();
                        })

                      // Obx(() => chatController.unReadMsg.value > 0 || notController.unReadNot.value > 0 ? Padding(
                      //     padding: EdgeInsets.only(right: Get.width*0.05,top: 3),
                      //     child: Align(
                      //       alignment: Alignment.topRight,
                      //       child: CircleAvatar(
                      //       radius: 10,
                      //       backgroundColor: clrWhite,
                      //       child: CircleAvatar(
                      //         radius: 9,
                      //         backgroundColor: clrRed,
                      //         child: Center(
                      //           child: Text('${chatController.unReadMsg.value > 99 ? '99+' : chatController.unReadMsg.value}',style: TextStyle(
                      //               color: clrWhite,
                      //               fontSize: 8
                      //           ),),
                      //         ),
                      //       ),
                      //                             ),
                      //     ),
                      //   ) : SizedBox(),)
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
                  notController.getNotification();
                  if(index == 3) {
                    Get.put(ProfilemainController());
                    if(Get.isRegistered<ProfilemainController>()){
                      final ProfilemainController pc = ProfilemainController();
                      pc.viewProfile();
                    }
                  }
                  controller.changeNavIndex(index);
                  if(index == 1){
                    chatController.searchController.clear();
                    chatController.fetchGroup();
                  }else if(index == 2){
                    activityController.attendingActivity();
                    activityController.hostingActivity();
                  }else if(index == 0){
                    exploreListController.homePageApi();
                  }
                }
            );
          // );
        // },);
      }),
    );
  }
}
