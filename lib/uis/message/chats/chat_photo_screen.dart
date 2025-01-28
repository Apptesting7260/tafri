import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';

class ChatPhotoScreen extends StatefulWidget {
  const ChatPhotoScreen({super.key});

  @override
  State<ChatPhotoScreen> createState() => _ChatPhotoScreenState();
}

class _ChatPhotoScreenState extends State<ChatPhotoScreen> {

  var imageUrl = ''.obs;

  @override
  void initState() {
    super.initState();
    imageUrl.value = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: Res.Defalt_side_margin),
              child: CommonUi.appBar(),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: CachedNetworkImage(
                imageUrl: imageUrl.value,
                placeholder: (context, url) => Center(
                  child: CommonUi.scaffoldLoading(
                    color: clrYellow
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
