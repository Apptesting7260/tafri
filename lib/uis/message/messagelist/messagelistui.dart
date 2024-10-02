import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/message/messagelist/controller/messagelist_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/size.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;


class MessageListUi extends GetWidget<MessagelistController> {
  const MessageListUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,left: 4,right: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GetX<MessagelistController>(builder: (controller){
              // return
              TabBar(
                tabAlignment: TabAlignment.start,
                indicatorColor: darkYellow,
                dividerHeight: 0,
                isScrollable: true,
                unselectedLabelColor: clrBlacke,
                labelColor: darkYellow,
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                tabs: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "Chats",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text("Notifications"),
                  )
                ],
                controller: controller.tabController,
              ),
              // }),
              SizedBox(
                height: Get.height * 0.025,
              ),
              Expanded(
                child:
                    TabBarView(controller: controller.tabController, children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height*.07,
                          child: const CustoTextFormField(
                            hintText: "Search",
                            sufixIcon: Icon(Icons.search),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.poSupportChat);
                          },
                          child: Row(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                height: h * 0.055,
                                width: h * 0.055,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "PlusOnes Support",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text("Hey Zoe, welcome to PlusOnes... ",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: clrGrey868380,
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        // Container(
                                        //   padding: EdgeInsets.all(7),
                                        //   decoration: BoxDecoration(
                                        //     borderRadius: BorderRadius.circular(100),
                                        //     color: clrBlacke
                                        //   ),
                                        //   child: Text("1",style: TextStyle(color: clrWhite),),
                                        // ),
                                        CircleAvatar(
                                          backgroundColor: clrBlacke,
                                          maxRadius: 10,
                                          child: Text(
                                            "1",
                                            style: TextStyle(
                                                color: clrWhite,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Text(
                                          "Just now",
                                          style: TextStyle(
                                              color: clrGreyDark, fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        const Divider(thickness: 0.5),
                        Text(
                          "Group chats with other members appear below. ",
                          style: TextStyle(color: clrGrey868380, fontSize: 12),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        const Text(
                          "Chats",
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        ListView.builder(
                            itemCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 3),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes.chatUi);
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            clipBehavior: Clip.hardEdge,
                                            height: h * .055,
                                            width: h * .055,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        "Early morning coffee break",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600),
                                                      ),
                                                      Text(
                                                          "Hey Zoe, welcome to PlusOnes... ",
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              color: clrGrey868380,
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    // Container(
                                                    //   padding: EdgeInsets.all(7),
                                                    //   decoration: BoxDecoration(
                                                    //     borderRadius: BorderRadius.circular(100),
                                                    //     color: clrBlacke
                                                    //   ),
                                                    //   child: Text("1",style: TextStyle(color: clrWhite),),
                                                    // ),
                                                    CircleAvatar(
                                                      backgroundColor: clrBlacke,
                                                      maxRadius: 10,
                                                      child: Text(
                                                        "1",
                                                        style: TextStyle(
                                                            color: clrWhite,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w700),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Just now",
                                                      style: TextStyle(
                                                          color: clrGreyDark,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Divider(
                                      color: clrGrey,
                                      thickness: 0.5,
                                    )
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                  //notification ui
                      Obx(() => controller.notLoading.value ? Center(child: CommonUi.scaffoldLoading(color: clrYellow)) : controller.notError.value.isNotEmpty ? Center(child: ErrorScreen()) : Padding(
                        padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                        child: Column(
                          children: [
                            Expanded(
                              child: SmartRefresher(
                                controller: controller.refreshController,
                                onRefresh: () async{
                                  await controller.getNotification();
                                  controller.refreshController.refreshCompleted();
                                },
                                header: CommonUi.refreshHeader(),
                                child: ListView.builder(
                                    itemCount: controller.notData.value.notifications?.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(Routes.viewNotifiUi,arguments: controller.notData.value.notifications?[index].message.toString());
                                        },
                                        child: Slidable(
                                          key: const ValueKey(0),
                                          endActionPane: ActionPane(
                                            motion: const ScrollMotion(),
                                            dismissible:
                                            DismissiblePane(
                                                onDismissed: () {
                                              controller.deleteNot(controller.notData.value.notifications![index].id.toString());
                                            }),
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.deleteNot(controller.notData.value.notifications![index].id.toString());
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: h * 0.008),
                                                    decoration: BoxDecoration(
                                                      color: clrYellow,
                                                      borderRadius: BorderRadius.only(
                                                          bottomRight: Radius.circular(15),
                                                          topRight: Radius.circular(15)
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height: double.maxFinite,
                                                          decoration: BoxDecoration(
                                                              color: clrYellow),
                                                          child: Container(
                                                            height: h * 0.045,
                                                            width: 30,
                                                            decoration: const BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        "assets/icons/deleteIcon.png"),
                                                                    fit: BoxFit.contain)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 20),
                                            margin:
                                            const EdgeInsets.symmetric(vertical: 8),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: clrGreyLight),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  clipBehavior: Clip.hardEdge,
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(100),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: '${controller.notData.value.notifications?[index].profile}',fit: BoxFit.cover,
                                                    errorWidget: (context, url, error) => Container(
                                                      height: 35,
                                                      width: 35,
                                                      color: clrWhite,
                                                      child: Image.asset(
                                                        'assets/icons/manicon.png',
                                                        color: clrGrey,
                                                        scale: 1.8,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "${controller.notData.value.notifications?[index].message}",
                                                              style:
                                                              TextStyle(fontSize: 13),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                            Text(
                                                              "${timeago.format(controller.notData.value.notifications![index].createdAt!,)}",
                                                              style: TextStyle(
                                                                  color: clrGreyDark,
                                                                  fontSize: 12),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Icon(Icons.more_vert,color: Color.fromRGBO(85, 92, 105, 1),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),)
                ]),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
