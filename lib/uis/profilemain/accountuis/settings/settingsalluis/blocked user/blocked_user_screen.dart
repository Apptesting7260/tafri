import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/blocked%20user/blocked_user_controller.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/error_widget.dart';
import 'package:plusone/utils/size.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class BlockedUserScreen extends StatelessWidget {
  BlockedUserScreen({super.key});

  final BlockedUserController controller = Get.find<BlockedUserController>();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonUi.appBar(),
                const Text(
                  "Blocked users",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                ),
                SizedBox(
                  width: h * .025,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Obx(
              () => controller.loading.value &&
                      controller.blockedUserData.value.result == null
                  ? Center(child: CommonUi.scaffoldLoading(color: clrYellow))
                  : SmartRefresher(
                      controller: controller.refreshController,
                      header: CommonUi.refreshHeader(),
                      onRefresh: () async {
                        await controller.getBlockedUser();
                        controller.refreshController.refreshCompleted();
                      },
                      child: controller.error.value.isNotEmpty
                          ? const Center(child: ErrorScreen())
                          : controller.blockedUserData.value.result!.isNotEmpty ? ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data = controller
                                    .blockedUserData.value.result?[index];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: CachedNetworkImage(
                                            height: 40,
                                            width: 40,
                                            memCacheWidth: 500,
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                '${data?.profilePhoto.toString()}',
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              height: 40,
                                              width: 40,
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: clrGreyLight,
                                                  shape: BoxShape.circle),
                                              child: Image.asset(
                                                "assets/icons/manicon.png",
                                                color: clrGrey,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: grey300,
                                              highlightColor: grey100,
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: grey300,
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        Text(
                                          '${data?.firstName}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap:(){
                                        controller.alertUnBlock(data!.id.toString());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: clrBlacke,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: Center(
                                          child: Text('Unblock',style: TextStyle(
                                            color: clrWhite,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14
                                          ),),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount: controller
                                      .blockedUserData.value.result?.length ??
                                  0) : const Center(
                        child: Text('No user found!',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                        ),
                      ),
                    ),
            ))
          ],
        ),
      )),
    );
  }
}
