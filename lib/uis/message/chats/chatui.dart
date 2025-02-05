import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/message/chats/controller/group_chat_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/colors.dart';

class ChatUi extends GetWidget<GroupChatController> {
  ChatUi({super.key});


  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: clrWhite,
        child: SafeArea(
          top: false,
          child: Scaffold(
            bottomSheet: Padding(
              padding: EdgeInsets.only(left: Res.Defalt_side_margin,bottom: 5,top: 5,right: Res.Defalt_side_margin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => controller.selectedImages.isEmpty ? SizedBox() : Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        controller.selectedImages.clear();
                      },
                      child: Chip(
                        avatar: Icon(Icons.delete,color: clrYellow,),
                        backgroundColor: clrWhite,
                        label: const Text("File attached"),
                        // color: WidgetStatePropertyAll(AppColor.primaryButtonColor),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(50),
                          side: BorderSide(color: clrBlacke)
                        ),
                      ),
                    ),
                  ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: SizedBox(
                            width: double.maxFinite,
                            // height: Res.h_btn,
                            child: CustoTextFormField(
                              hintText: "Type your message",
                              controll: controller.msgController,
                              focusNode: controller.focusNode,
                              maxLines: 8,
                              minLines: 1,
                              borderRadius: 50,
                              sufixIcon: GestureDetector(
                                  onTap: () async {
                                    controller.imagePopUp(context);
                                    // controller.openGallery();
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: clrGrey,
                                  )),
                            )),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                          onTap: () {
                            if(controller.selectedImages.isNotEmpty && controller.msgController.text.trim().isNotEmpty){
                              log('send image and msg');
                              controller.sendImage(file: controller
                                  .selectedImages.last,message: controller.msgController.value.text.trim());
                            } else if(controller.selectedImages.isNotEmpty){
                              log('send image');
                              controller.sendImage(file: controller
                                  .selectedImages.last);
                            } else if (controller.msgController.text.trim().isNotEmpty) {
                              log('send msg');
                              controller.sendMsg(
                                  message:
                                  controller.msgController.value.text.trim());
                            }
                          },
                          child: Image.asset(
                            'assets/images/send.png',
                            scale: 4,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            appBar: PreferredSize(preferredSize: const Size.fromHeight(130), child: Padding(
              padding: EdgeInsets.only(left: Res.Defalt_side_margin,right: Res.Defalt_side_margin,top: 15),
              child: AppBar(
                backgroundColor: clrWhite,
                surfaceTintColor: clrWhite,
                elevation: 0,
                toolbarHeight: 130,
                centerTitle: true,
                leading: Align(alignment: Alignment.topLeft,child: CommonUi.appBar()),
                leadingWidth: 40,
                title: Column(
                  children: [
                    Obx(() => controller.msgLoading.value ? Shimmer.fromColors(
                        baseColor: grey300,
                        highlightColor: grey100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: h * .08,
                            width: h * .08,
                            color: clrGrey,
                          ),
                        )) : GestureDetector(
                      onTap: () {
                        if(controller.actStatus.value.isEmpty){

                        }else if(controller.actStatus.value == 'completed'){
                          Get.toNamed(Routes.previousActivityUi, arguments: {
                            "isHost": LocalStorage.getUid() == controller.hostId.value ? true : false,
                            "id": controller.actId.value
                          });
                        }else if(controller.actStatus.value == 'approved'){
                          if(LocalStorage.getUid() == controller.hostId.value){
                            Get.toNamed(Routes.hostUpcommingActiview, arguments: controller.actId.value);
                          }else{
                            Get.toNamed(Routes.exploreView, arguments: controller.actId.value);
                          }
                        }else if(controller.actStatus.value == 'pending'){
                          if(LocalStorage.getUid() == controller.hostId.value){
                            Get.toNamed(Routes.hostUpcommingActiview, arguments: controller.actId.value);
                          }else{
                            Get.toNamed(Routes.exploreView, arguments: controller.actId.value);
                          }
                        }else if(controller.actStatus.value == 'not_approved'){
                          if(LocalStorage.getUid() == controller.hostId.value){
                            Get.toNamed(Routes.hostUpcommingActiview, arguments: controller.actId.value);
                          }else{
                            Get.toNamed(Routes.exploreView, arguments: controller.actId.value);
                          }
                        }
                      },
                          child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: h * .08,
                          width: h * .08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: clrGreyLight
                          ),
                          child: CachedNetworkImage(
                            imageUrl: controller.allMessage.value.gpImg ?? '',
                            fit: BoxFit.cover,
                            memCacheWidth: 500,
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
                                )),
                            errorWidget: (context, url, error) => Icon(Icons.group,color: clrGreyDark,),
                          )),
                        ),),
                    const SizedBox(
                      height: 7,
                    ),
                    Obx(() => controller.msgLoading.value ? Shimmer.fromColors(
                        baseColor: grey300,
                        highlightColor: grey100,
                        child: ClipRRect(
                          child: Container(
                            height: h * .01,
                            width: h * .08,
                            color: clrGrey,
                          ),
                        )) : Text(
                      controller.allMessage.value.gpName ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.5),
                    ),),
                    Obx(() => controller.msgLoading.value ? Shimmer.fromColors(
                        baseColor: grey300,
                        highlightColor: grey100,
                        child: ClipRRect(
                          child: Container(
                            height: h * .01,
                            width: h * .08,
                            color: clrGrey,
                          ),
                        )) : controller.allMessage.value.members != null ? Text('${controller.allMessage.value.members ?? '0'} ${controller.allMessage.value.members! > 1 ? 'members' : 'member'}',style: TextStyle(color: clrGrey, fontSize: 12)) : SizedBox())
                  ],
                ),
                // actions: const [Align(alignment: Alignment.topLeft,child: Icon(Icons.more_vert))],
              ),
            ),),
            body: Obx(() => controller.msgLoading.value ? Center(
              child: CommonUi.scaffoldLoading(color: clrYellow),
            ) : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Res.Defalt_side_margin),
              child: Obx(() => ListView.builder(
                  itemCount: controller.allMessage.value.message?.length ?? 0,
                  controller: controller.scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  reverse: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: controller.selectedImages.isEmpty ? 70 : 120),
                  itemBuilder: (context, index) {
                    var message = controller.allMessage.value.message?[index];
                    return Column(
                      children: [
                        const SizedBox(height: 15,),
                        Text('${message?.name}',style: TextStyle(
                          fontSize: 13,
                          color: clrGreyTextLight
                        ),),
                        // const SizedBox(height: 15,),
                        ListView.builder(
                          itemCount: message?.data?.length ?? 0,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, ind) {
                            var msg = message?.data?[ind];
                            var time = DateTime.parse(msg!.createdAt.toString());
                          return Align(
                            alignment: msg.senderId == int.parse(controller.userID)
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: SizedBox(
                              width: Get.width * 0.72,
                              child: Column(
                                crossAxisAlignment: msg.senderId == int.parse(controller.userID)
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  msg.senderId != int.parse(controller.userID)
                                      ? Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            Get.toNamed(Routes.userProfileui,arguments: msg.senderId.toString());
                                          },
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            height: h * .04,
                                            width: h * .04,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: '${msg.proImg}',
                                              memCacheWidth: 500,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Shimmer.fromColors(
                                                  baseColor: grey300,
                                                  highlightColor: grey100,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child: Container(
                                                      height: h * .04,
                                                      width: h * .04,
                                                      color: clrGrey,
                                                    ),
                                                  )
                                              ),
                                              errorWidget: (context, url, error) => Image.asset('assets/icons/manicon.png',color: clrGrey),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: w * 0.01,
                                        ),
                                        Flexible(
                                          child: Container(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 10),
                                            // margin:
                                            //     const EdgeInsets.symmetric(
                                            //         vertical: 10),
                                            decoration: BoxDecoration(
                                                color: clrGreyLight,
                                                borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                    Radius.circular(
                                                        8),
                                                    bottomRight:
                                                    Radius.circular(
                                                        8),
                                                    topRight:
                                                    Radius.circular(
                                                        8))),
                                            child: Row(
                                              mainAxisSize:
                                              MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Column(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        "${msg.username}",
                                                        style: TextStyle(
                                                            color:
                                                            clrBlacke,
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                      msg.message?.textmessage == null || msg.message?.textmessage == "null" ? SizedBox(
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Flexible(child:
                                                            msg.message?.file?.split('.').last.toLowerCase() == 'mp4' ? InkWell(
                                                              onTap: () {
                                                                Get.toNamed(Routes.videoPlayScreen,arguments: '${msg.message?.file}');
                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.grey.withOpacity(0.5),
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                height: 60,
                                                                width: 60,
                                                                child: const Center(
                                                                  child: Icon(
                                                                    Icons.play_arrow,
                                                                    color: Colors.white, // Icon color
                                                                    size: 40, // Icon size
                                                                  ),
                                                                ),
                                                              ),
                                                            ) : GestureDetector(
                                                              onTap: () {
                                                                Get.toNamed(Routes.chatPhotoScreen,arguments: '${msg.message?.file}');
                                                              },
                                                              child: CachedNetworkImage(
                                                                imageUrl: '${msg.message?.file}',
                                                                memCacheWidth: 500,
                                                                placeholder: (context, url) => Icon(Icons.image_outlined,size: 35,color: clrBlackeChat,),
                                                                errorWidget: (context, url, error) => Text("Couldn't load image",style:TextStyle(
                                                                  color:
                                                                  clrBlacke,fontSize: 12)),),
                                                            )),
                                                            const SizedBox(width: 5,),
                                                            Flexible(
                                                              child: Text(DateFormat('h:mm').format(time),
                                                                  style: TextStyle(
                                                                      color:
                                                                      clrGrey,
                                                                      fontSize:
                                                                      12)),
                                                            ),
                                                          ],
                                                        ),
                                                      ) : msg.message?.file == null || msg.message?.file == 'null' ?
                                                          SelectableText.rich(
                                                              TextSpan(
                                                              children: [
                                                                WidgetSpan(
                                                                    child:
                                                                    Linkify(text: "${msg.message?.textmessage}",style: TextStyle(
                                                                        color:
                                                                        clrBlacke),linkStyle: const TextStyle(
                                                                      decoration: TextDecoration.none
                                                                    ),onOpen: (link) async{
                                                                      await launchUrl(Uri.parse(link.url));
                                                                    },)
                                                                    // Text(
                                                                    //   "${msg.message?.textmessage}",
                                                                    //   style: TextStyle(
                                                                    //       color:
                                                                    //       clrBlacke),
                                                                    // )
                                                                ),
                                                                const WidgetSpan(
                                                                    child:
                                                                    SizedBox(
                                                                      width: 5,
                                                                    )),
                                                                WidgetSpan(
                                                                    child:
                                                                    Text(
                                                                      DateFormat('h:mm').format(time),
                                                                      style: TextStyle(
                                                                          color:
                                                                          clrGrey,
                                                                          fontSize:
                                                                          12),
                                                                    ))
                                                              ]))
                                                      // RichText(
                                                      //     softWrap: true,
                                                      //     text: TextSpan(
                                                      //         children: [
                                                      //           WidgetSpan(
                                                      //               child:
                                                      //               Text(
                                                      //                 "${msg.message?.textmessage}",
                                                      //                 style: TextStyle(
                                                      //                     color:
                                                      //                     clrBlacke),
                                                      //               )),
                                                      //           const WidgetSpan(
                                                      //               child:
                                                      //               SizedBox(
                                                      //                 width: 5,
                                                      //               )),
                                                      //           WidgetSpan(
                                                      //               child:
                                                      //               Text(
                                                      //                 DateFormat('h:mm').format(time),
                                                      //                 style: TextStyle(
                                                      //                     color:
                                                      //                     clrGrey,
                                                      //                     fontSize:
                                                      //                     12),
                                                      //               ))
                                                      //         ]))
                                                          : msg.message!.textmessage!.isNotEmpty && msg.message?.textmessage != null && msg.message?.textmessage != 'null' && msg.message!.file != null ? SizedBox(
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Flexible(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  const SizedBox(height: 5,),
                                                                  msg.message?.file?.split('.').last.toLowerCase() == 'mp4' ? InkWell(
                                                                    onTap: () {
                                                                      Get.toNamed(Routes.videoPlayScreen,arguments: '${msg.message?.file}');
                                                                    },
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.grey.withOpacity(0.5),
                                                                        borderRadius: BorderRadius.circular(10),
                                                                      ),
                                                                      height: 60,
                                                                      width: 60,
                                                                      child: const Center(
                                                                        child: Icon(
                                                                          Icons.play_arrow,
                                                                          color: Colors.white, // Icon color
                                                                          size: 40, // Icon size
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ) : GestureDetector(
                                                                    onTap: () {
                                                                      Get.toNamed(Routes.chatPhotoScreen,arguments: '${msg.message?.file}');
                                                                    },
                                                                    child: CachedNetworkImage(
                                                                      imageUrl: '${msg.message?.file}',
                                                                      memCacheWidth: 500,
                                                                      placeholder: (context, url) => Icon(Icons.image_outlined,size: 35,color: clrBlackeChat,),
                                                                      errorWidget: (context, url, error) =>  Text("Couldn't load image",style: TextStyle(
                                                                        color:
                                                                        clrBlacke,fontSize: 12)),),
                                                                  ),
                                                                  const SizedBox(height: 5,),
                                                                  Linkify(text: "${msg.message?.textmessage}",linkStyle: const TextStyle(
                                                                      decoration: TextDecoration.none
                                                                  ),onOpen: (link) async{
                                                                    await launchUrl(Uri.parse(link.url));
                                                                  },)
                                                                  // SelectableText('${msg.message?.textmessage}')
                                                                  // Text('${msg.message?.textmessage}')
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(width: 5,),
                                                            Text(
                                                              DateFormat('h:mm').format(time),
                                                              style: TextStyle(
                                                                  color:
                                                                  clrGrey,
                                                                  fontSize:
                                                                  12),
                                                            )
                                                          ],
                                                        ),
                                                      ) : const SizedBox() ,
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: GestureDetector(
                                      onLongPress: () {
                                        controller.focusNode.unfocus();
                                        controller.deletePopUp(context,msg.id.toString());
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 10),
                                              // margin: const EdgeInsets.symmetric(
                                              //     vertical: 5),
                                              decoration: BoxDecoration(
                                                color: clrBlackeChat,
                                                borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                    Radius.circular(8),
                                                    topRight:
                                                    Radius.circular(8)),
                                              ),
                                              child: msg.message?.textmessage == null || msg.message?.textmessage == "null" ? SizedBox(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    msg.message?.file?.split('.').last.toLowerCase() == 'mp4' ? InkWell(
                                                      onTap: () {
                                                        Get.toNamed(Routes.videoPlayScreen,arguments: '${msg.message?.file}');
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey.withOpacity(0.5),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        height: 60,
                                                        width: 60,
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.white, // Icon color
                                                            size: 40, // Icon size
                                                          ),
                                                        ),
                                                      ),
                                                    ) : Flexible(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(Routes.chatPhotoScreen,arguments: '${msg.message?.file}');
                                                          },
                                                          child: CachedNetworkImage(
                                                            imageUrl: '${msg.message?.file}',
                                                            memCacheWidth: 500,
                                                            placeholder: (context, url) => Icon(Icons.image_outlined,size: 35,color: clrWhite,),
                                                            errorWidget: (context, url, error) => Text(msg.loading == true ? 'Sending...' : "Couldn't load image",style: TextStyle(color: clrWhite
                                                                .withOpacity(0.8),
                                                                fontSize: 12)),
                                                          ),
                                                        )
                                                    ),
                                                    const SizedBox(width: 5,),
                                                    msg.loading == false ? Flexible(
                                                      child: Text(DateFormat('h:mm').format(time),
                                                          style: TextStyle(
                                                              color: clrWhite
                                                                  .withOpacity(0.8),
                                                              fontSize: 12)),
                                                    ) : SizedBox(),
                                                    const SizedBox(width: 5,),
                                                    msg.messageStatus == 'seen' ? Icon(Icons.done_all,
                                                        color: clrWhite
                                                            .withOpacity(0.8),
                                                        size: 16) : msg.messageStatus == 'unseen' ? Icon(Icons.done,color: clrWhite
                                                        .withOpacity(0.8),
                                                        size: 16) : Icon(CupertinoIcons.clock,color: clrWhite.withOpacity(0.8),size: 15,)
                                                  ],
                                                ),
                                              ) : msg.message?.file == null || msg.message?.file == 'null' ? SelectableText.rich(
                                                TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Linkify(
                                                          text: "${msg.message?.textmessage}",style: TextStyle(
                                                        color: clrWhite
                                                      ),linkStyle: TextStyle(
                                                        decoration: TextDecoration.none
                                                      ),onOpen: (link) async{
                                                        await launchUrl(Uri.parse(link.url));
                                                      },),),
                                                  // TextSpan(
                                                  //     text: "${msg.message?.textmessage}",
                                                  //     style:
                                                  //     TextStyle(color: clrWhite)),
                                                  WidgetSpan(
                                                    child: SizedBox(
                                                      width: w * 0.01,
                                                    ),
                                                  ),
                                                  WidgetSpan(
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          msg.loading == false ? Text(DateFormat('h:mm').format(time),
                                                              style: TextStyle(
                                                                  color: clrWhite
                                                                      .withOpacity(0.8),
                                                                  fontSize: 12)):SizedBox(),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          msg.messageStatus == 'seen' ? Icon(Icons.done_all,
                                                              color: clrWhite
                                                                  .withOpacity(0.8),
                                                              size: 16) : msg.messageStatus == 'unseen' ? Icon(Icons.done,color: clrWhite
                                                              .withOpacity(0.8),
                                                              size: 16) : Icon(CupertinoIcons.clock,color: clrWhite.withOpacity(0.8),size: 15,)
                                                        ],
                                                      ))
                                                ]),
                                              ) : msg.message!.textmessage!.isNotEmpty && msg.message?.textmessage != null && msg.message?.textmessage != 'null' && msg.message!.file != null ? SizedBox(
                                                child:  Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(height: 5,),
                                                          msg.message?.file?.split('.').last.toLowerCase() == 'mp4' ? InkWell(
                                                            onTap: () {
                                                              Get.toNamed(Routes.videoPlayScreen,arguments: '${msg.message?.file}');
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color: Colors.grey.withOpacity(0.5),
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                              height: 60,
                                                              width: 60,
                                                              // padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                              child: const Center(
                                                                child: Icon(
                                                                  Icons.play_arrow,
                                                                  color: Colors.white, // Icon color
                                                                  size: 40, // Icon size
                                                                ),
                                                              ),
                                                            ),
                                                          ) : GestureDetector(
                                                            onTap: () {
                                                              Get.toNamed(Routes.chatPhotoScreen,arguments: '${msg.message?.file}');
                                                            },
                                                            child: CachedNetworkImage(
                                                              imageUrl: '${msg.message?.file}',
                                                              memCacheWidth: 500,
                                                              placeholder: (context, url) => Icon(Icons.image_outlined,size: 35,color: clrWhite,),
                                                              errorWidget: (context, url, error) =>  Text(msg.loading == true ? 'Sending...' : "Couldn't load image",style: TextStyle(
                                                                color:
                                                                clrWhite,fontSize: 12)),),
                                                          ),
                                                          const SizedBox(height: 5,),
                                                          Linkify(text: '${msg.message?.textmessage}',style: TextStyle(
                                                              color: clrWhite
                                                          ),linkStyle: TextStyle(
                                                        decoration: TextDecoration.none
                                                      ),onOpen: (link) async{
                                                        await launchUrl(Uri.parse(link.url));
                                                      },),
                                                          // SelectableText('${msg.message?.textmessage}',style: TextStyle(
                                                          //   color: clrWhite
                                                          // ),),
                                                          // Text('${msg.message?.textmessage}',style:
                                                          // TextStyle(color: clrWhite))
                                                        ],
                                                      ),
                                                    ),
                                                    msg.loading == false ?Text(
                                                      DateFormat('h:mm').format(time),
                                                      style: TextStyle(
                                                          color: clrWhite
                                                              .withOpacity(0.8),
                                                          fontSize: 12),
                                                    ):SizedBox(),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    msg.messageStatus == 'seen' ? Icon(Icons.done_all,
                                                        color: clrWhite
                                                            .withOpacity(0.8),
                                                        size: 16) : msg.messageStatus == 'unseen' ? Icon(Icons.done,color: clrWhite
                                                        .withOpacity(0.8),
                                                        size: 16) : Icon(CupertinoIcons.clock,color: clrWhite.withOpacity(0.8),size: 15,)
                                                  ],
                                                ),
                                              ) : SizedBox(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: w * 0.01,
                                          ),
                                          Container(
                                            clipBehavior: Clip.hardEdge,
                                            height: h * .04,
                                            width: h * .04,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: '${msg.proImg}',
                                              fit: BoxFit.cover,
                                              memCacheWidth: 500,
                                              placeholder: (context, url) => Shimmer.fromColors(
                                                  baseColor: grey300,
                                                  highlightColor: grey100,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child: Container(
                                                      height: h * .04,
                                                      width: h * .04,
                                                      color: clrGrey,
                                                    ),
                                                  )
                                              ),
                                              errorWidget: (context, url, error) => Image.asset('assets/icons/manicon.png',color: clrGrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },)
                      ],
                    );
                  }),),
            ),),
          ),
        ),
      ),
    );
  }
}
