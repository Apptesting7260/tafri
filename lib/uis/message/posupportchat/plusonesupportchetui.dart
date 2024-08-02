import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../utils/colors.dart';

class PlusOneSupportChetUi extends GetWidget {
  PlusOneSupportChetUi({super.key});

  List<Map> msgList = [
    {
      "msg":
          "Hey [User_Name],\nWe're thrilled to have you join the PlusOnes community!\nWhether you're looking to meet new friends for your activities or searching for a plus one for your next event, we've got you covered.\nIf you have any questions or need assistance, our support team is here to help. We're dedicated to making sure you have an amazing experience with PlusOnes.\nEnjoy your adventures with PlusOnes!\nCheers, The PlusOnes Support Team",
      "sentby": "2"
    },
    // {"msg": "Hey [User_Name],\nWe're thrilled to have you join the PlusOnes community!\nWhether you're looking to meet new friends for your activities or searching for a plus one for your next event, we've got you covered.\nIf you have any questions or need assistance, our support team is here to help. We're dedicated to making sure you have an amazing experience with PlusOnes.\nEnjoy your adventures with PlusOnes!\nCheers, The PlusOnes Support Team", "sentby": "1"},
    // {"msg": "Hey", "sentby": "1"},
    // {"msg": "Hey", "sentby": "2"},
  ];
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonUi.appBar(),
                Column(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/plusone.png"),
                    ),
                    SizedBox(
                      height: Get.width * 0.02,
                    ),
                    const Text(
                      "Plus Ones Support",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  width: Get.width * 0.09,
                )
              ],
            ),
          ),
          const SizedBox(height: 5,),
          const Divider(
            thickness: 0.5,
          ),
          const SizedBox(height: 5,),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    // Center(
                    //     child: Text("Today",
                    //         style: TextStyle(color: clrGrey, fontSize: 12))),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    ListView.builder(
                        itemCount: msgList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Map msgDeta = msgList[index];
                          return Align(
                            alignment: msgDeta['sentby'] == "1"
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: SizedBox(
                              width: Get.width * 0.72,
                              child: Column(
                                crossAxisAlignment: msgDeta['sentby'] == "1"
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  msgDeta['sentby'] != "1"
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 20),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          decoration: BoxDecoration(
                                              color: clrGreyLight,
                                              borderRadius:
                                                   BorderRadius.circular(15)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: RichText(
                                                    softWrap: true,
                                                    text: TextSpan(children: [
                                                      WidgetSpan(
                                                          child: Text(
                                                        "${msgDeta['msg']}",
                                                        style: TextStyle(
                                                            color: clrBlacke),
                                                      )),
                                                    ])),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          decoration: BoxDecoration(
                                            color: clrBlacke,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8)),
                                          ),
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: msgDeta['msg'],
                                                style:
                                                    TextStyle(color: clrWhite)),
                                            const WidgetSpan(
                                              child: SizedBox(
                                                width: 5,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("9:30",
                                                    style: TextStyle(
                                                        color: clrWhite
                                                            .withOpacity(0.8),
                                                        fontSize: 12)),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(Icons.done_all,
                                                    color: clrWhite
                                                        .withOpacity(0.8),
                                                    size: 16)
                                              ],
                                            ))
                                          ])),
                                        ),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: Get.width * 0.74,
                    height: 50,
                    child: CustoTextFormField(
                      hintText: "Type your message",
                      sufixIcon: InkWell(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? photo = await picker.pickImage(
                                source: ImageSource.camera);
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: clrGrey,
                          )),
                    )),
                // SizedBox(
                //   width: Get.width * 0.005,
                // ),
                Container(
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: clrYellow),
                  child: Image.asset(
                    "assets/icons/sendmsgicon.png",
                    height: 22,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
