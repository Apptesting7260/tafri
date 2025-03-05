import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:plusone/uis/message/messagelist/controller/messagelist_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;


class MessageListUi extends GetWidget<MessagelistController> {
  MessageListUi({super.key});

  final SocketController chatController = Get.put(SocketController());

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
                tabs: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "Chats",
                        ),
                      ),
                      Obx(() => chatController.unReadMsg.value > 0 ? Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: clrRed,
                        ),
                      ) : const SizedBox(),)
                    ],
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text("Notifications"),
                      ),
                      Obx(() => controller.unReadNot.value > 0 ? Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: clrRed,
                        ),
                      ) : const SizedBox()),
                    ],
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
                    child: Obx(() => chatController.allGroup.value.friend == null ? Center(child: CommonUi.scaffoldLoading(color: clrYellow)) : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height*.07,
                          child: CustoTextFormField(
                            hintText: "Search",
                            focusNode: chatController.focusNode,
                            sufixIcon: const Icon(Icons.search),
                            controll: chatController.searchController,
                            onChanged: (val) {
                              log('search value == ${val}');
                              chatController.filterGroups(search: val);
                            },
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Expanded(
                          child: SmartRefresher(
                            controller: chatController.chatRefreshController,
                            header: CommonUi.refreshHeader(),
                            onRefresh: () {
                              chatController.fetchGroup();
                              chatController.chatRefreshController.refreshCompleted();
                            },
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.poSupportChat,arguments: chatController.allGroup.value.support != null ? chatController.allGroup.value.support!.frientConvarsationId : '')?.then((value) {
                                      chatController.fetchGroup();
                                      chatController.searchController.clear();
                                    },);
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
                                          "assets/images/plusones.png",
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
                                                  Obx(() => chatController.allGroup.value.friend!.isEmpty && chatController.gpLoading.value ? const Text('') : chatController.allGroup.value.support == null ? const Text('Hey, welcome to PlusOnes!'): Text(
                                                      (chatController.allGroup.value.support!.lastMsg!.textmessage == 'null' && chatController.allGroup.value.support!.lastMsg!.file!.isNotEmpty) ? 'Media' : chatController.allGroup.value.support!.lastMsg!.textmessage!.isNotEmpty ? '${chatController.allGroup.value.support!.lastMsg!.textmessage}' : "Hey, welcome to PlusOnes...",
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: clrGrey868380,
                                                          fontSize: 12)),)
                                                ],
                                              ),
                                            ),
                                            Obx(() => chatController.gpLoading.value && chatController.allGroup.value.friend!.isEmpty ? const SizedBox() : chatController.allGroup.value.support == null ? const SizedBox() : chatController.allGroup.value.support!.friendUnSeenMessage! > 0 ? Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: clrBlacke,
                                                  maxRadius: 10,
                                                  child: Text(
                                                    "${chatController.allGroup.value.support!.friendUnSeenMessage}",
                                                    style: TextStyle(
                                                        color: clrWhite,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                                Text(
                                                  timeago.format(chatController.allGroup.value.support!.updatedAt!),
                                                  style: TextStyle(
                                                      color: clrGreyDark, fontSize: 12),
                                                )
                                              ],
                                            ) : const SizedBox(),)
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
                                chatController.allGroup.value.friend!.isNotEmpty ? const Text(
                                  "Chats",
                                  style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                ) : const SizedBox(),
                                chatController.allGroup.value.friend!.isNotEmpty ? SizedBox(
                                  height: Get.height * 0.01,
                                ) : const SizedBox(),
                                chatController.allGroup.value.friend!.isEmpty
                                    ? Center(
                                  child: chatController.gpLoading.value
                                      ? CommonUi.scaffoldLoading(color: clrYellow)
                                      : const Text('No group yet!', style: TextStyle(fontSize: 16)),
                                )
                                    : chatController.filteredGroups.isNotEmpty
                                    ? ListView.builder(
                                    itemCount: chatController.filteredGroups.length ?? 0,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var data = chatController.filteredGroups[index];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(vertical: 3),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                chatController.focusNode.unfocus();
                                                Get.toNamed(Routes.chatUi,arguments: {
                                                  'gpID': data.groupId,
                                                  'activityId': data.activityId.toString(),
                                                  'hostId': data.createdBy.toString()
                                                })?.then((value) {
                                                  chatController.fetchGroup();
                                                  chatController.searchController.clear();
                                                },);
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
                                                          color: clrGreyLight
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: '${data?.groupImg}',
                                                        memCacheWidth: 400,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context, url) => Shimmer.fromColors(
                                                            baseColor: grey300,
                                                            highlightColor: grey100,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(100),
                                                              child: Container(
                                                                height: h * .055,
                                                                width: h * .055,
                                                                color: clrGrey,
                                                              ),
                                                            )
                                                        ),
                                                        errorWidget: (context, url, error) => Icon(Icons.group,color: clrGreyDark,),
                                                      )
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${data?.groupName}",
                                                                style: const TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight:
                                                                    FontWeight.w600),
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(
                                                                  (data!.lastMsg!.textmessage == 'null' && data.lastMsg!.file!.isNotEmpty) ? 'Media' : data.lastMsg!.textmessage!.isNotEmpty ? '${data.lastMsg!.textmessage}' : "No messages yet",
                                                                  maxLines: 1,
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: clrGrey868380,
                                                                      fontSize: 12)),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
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
                                                                data!.groupUnSennMessage! > 0 ? CircleAvatar(
                                                                  backgroundColor: clrBlacke,
                                                                  maxRadius: 10,
                                                                  child: Text(
                                                                    "${data.groupUnSennMessage}",
                                                                    style: TextStyle(
                                                                        color: clrWhite,
                                                                        fontSize: 10,
                                                                        fontWeight:
                                                                        FontWeight.w700),
                                                                  ),
                                                                ) : const SizedBox(),
                                                                data.groupUnSennMessage! > 0 ? Text(
                                                                  timeago.format(data.updatedAt!),
                                                                  style: TextStyle(
                                                                      color: clrGreyDark,
                                                                      fontSize: 12),
                                                                ) : const SizedBox()
                                                              ],
                                                            ),
                                                            data.startDate != null ? const SizedBox(width: 8,) : const SizedBox(),
                                                            data.startDate != null ? Text('${DateFormat('d MMM').format(DateTime.parse(data.startDate.toString()))}',style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w600,
                                                                color: clrGreyTextLight
                                                            ),) : const SizedBox()
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
                                    }) : const Center(
                                  child: Text('No group find',style: TextStyle(
                                      fontSize: 16
                                  ),),
                                ),
                                const SizedBox(height: 20,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),),
                  ),
                  //notification ui
                      Obx(() => controller.notLoading.value ? Center(child: CommonUi.scaffoldLoading(color: clrYellow)) : controller.notError.value.isNotEmpty ? const Center(child: ErrorScreen()) : Padding(
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
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.viewNotifiUi,arguments: {
                                                        'msg':controller
                                                            .notData
                                                            .value
                                                            .notifications?[
                                                                index]
                                                            .message
                                                            .toString(),
                                            // 'hostid': controller
                                            //     .notData
                                            //     .value
                                            //     .notifications?[
                                            // index].userId.toString(),
                                            'userid': controller
                                                .notData
                                                .value
                                                .notifications?[
                                            index].senderId.toString(),
                                            'userimg': controller.notData.value.notifications?[index].profile.toString(),
                                            'activity_id': controller.notData.value.notifications?[index].actId.toString(),
                                            'activity_img': controller.notData.value.notifications?[index].actImg.toString(),
                                            'activity_title': controller.notData.value.notifications?[index].actName.toString(),
                                            'waitlist_msg': controller.notData.value.notifications?[index].waitListMsg
                                                      });
                                          if(controller.notData.value.notifications?[index].isRead == '0') {
                                            controller.readNotification(
                                                controller.notData.value
                                                    .notifications![index].id
                                                    .toString());
                                          }
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
                                                      borderRadius: const BorderRadius.only(
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
                                                    memCacheWidth: 500,
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
                                                              const TextStyle(fontSize: 13),
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
                                                controller.notData.value.notifications?[index].isRead == '0' ? CircleAvatar(
                                                  radius: 4,
                                                  backgroundColor: clrYellow,
                                                ) : const SizedBox()
                                                // Icon(Icons.more_vert,color: Color.fromRGBO(85, 92, 105, 1),)
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
