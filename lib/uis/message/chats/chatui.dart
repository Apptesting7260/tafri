import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import '../../../utils/colors.dart';

class ChatUi extends GetWidget {
  ChatUi({super.key});

  ScrollController scrollController = ScrollController();
  List<Map> msgList = [
    {"msg": "hello", "sentby": "1"},
    {"msg": "hello gk", "sentby": "2"},
    {"msg": "how are you", "sentby": "2"},
    {"msg": "i m ok ", "sentby": "1"}
  ];

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
            padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonUi.appBar(),
                Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      height: h * .08,
                      width: h * .08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.asset(
                        "assets/images/cofee.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      "Early morning coffee break",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.5),
                    ),
                    Text("4 members",
                        style: TextStyle(color: clrGrey, fontSize: 12))
                  ],
                ),
                const Icon(Icons.more_vert)
              ],
            ),
          ),
          const Divider(
            thickness: 0.5,
          ),
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
                    Center(
                        child: Text("Today",
                            style:
                                TextStyle(color: clrGreyDark, fontSize: 12))),
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
                                      ? Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                clipBehavior: Clip.hardEdge,
                                                height: h * .04,
                                                width: h * .04,
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
                                                              "Jessica",
                                                              style: TextStyle(
                                                                  color:
                                                                      clrBlacke,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            RichText(
                                                                softWrap: true,
                                                                text: TextSpan(
                                                                    children: [
                                                                      WidgetSpan(
                                                                          child:
                                                                              Text(
                                                                        "${msgDeta['msg']}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                clrBlacke),
                                                                      )),
                                                                      const WidgetSpan(
                                                                          child:
                                                                              SizedBox(
                                                                        width: 5,
                                                                      )),
                                                                      WidgetSpan(
                                                                          child:
                                                                              Text(
                                                                        "9:34",
                                                                        style: TextStyle(
                                                                            color:
                                                                                clrGrey,
                                                                            fontSize:
                                                                                12),
                                                                      ))
                                                                    ])),
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
                                            child: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: msgDeta['msg'],
                                                  style:
                                                      TextStyle(color: clrWhite)),
                                              WidgetSpan(
                                                child: SizedBox(
                                                  width: w * 0.01,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: Get.width * 0.74,
                    height: Res.h_btn,
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
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: clrYellow),
                  child: Center(
                      child: Image.asset(
                    "assets/icons/sendmsgicon.png",
                    height: 22,
                  )),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
