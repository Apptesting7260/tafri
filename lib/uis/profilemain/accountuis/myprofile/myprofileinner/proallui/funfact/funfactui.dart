import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/components/custotextfield.dart';
import 'package:plusone/uis/profilemain/accountuis/myprofile/myprofileinner/controller/myprofileinn_controller.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';

import '../../../../../../../utils/colors.dart';
import '../../../../../../components/custodropdownbtn.dart';

class FunFactUi extends GetWidget<MyprofileInnController> {
  const FunFactUi({super.key});

  @override
  Widget build(BuildContext context) {
    var h = Get.height;
    var w = Get.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus,
      child: Scaffold(body: SafeArea(
        child: Obx(() {
          if(controller.isLoadingFunFactQuest.value){
            return Center(
              child: CommonUi.scaffoldLoading(color: clrYellow),
            );
          }
          return Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonUi.appBar(),
                    const Text(
                      "Fun facts about me",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: w * .04,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Res.Defalt_side_margin),
                      child: const Text(
                          "Answer 1-3 fun fact questions to show your personality and help others get to know you"),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                   Obx(() =>  ListView.builder(
                       itemCount: controller.funFactListDeta.length,
                       physics: const NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (context, index) {
                         if (controller.funFactListDeta.length <= index) {
                           controller.funFactListDeta.add({'id': null, 'answer': ''});
                           print('--- ${controller.funFactListDeta}');
                         }
                         print('--- ${controller.funFactListDeta[index]['id']}');
                         print('--- ${controller.funFactListDeta}');
                         return Column(
                           children: [
                             SizedBox(
                               height: Get.height * 0.02,
                             ),
                             Stack(
                               clipBehavior: Clip.none,
                               children: [
                                 Container(
                                   margin: EdgeInsets.symmetric(
                                       horizontal: Res.Defalt_side_margin),
                                   padding: const EdgeInsets.symmetric(
                                       horizontal: 10, vertical: 15),
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(15),
                                       color: clrGreyLight),
                                   child: Column(
                                     children: [
                                       CustoDropDownBtn(
                                         onchange: (val) {
                                           final selectedId = int.parse(val.toString());
                                           controller.existingItemIndex.value = controller.funFactListDeta.indexWhere(
                                                 (item) => item['id'] == selectedId,
                                           );

                                           // if (!controller.existingItemIndexList
                                           //     .any((map) => map.containsKey(selectedId))) {
                                           //   controller.existingItemIndexList
                                           //       .add({selectedId: controller.existingItemIndex.value});
                                           //   print('---- ${controller.existingItemIndexList}');
                                           // }

                                           print(controller.existingItemIndex.value);
                                           if(controller.existingItemIndex.value != -1){
                                             showTostMsg('Question already selected.',gravity: ToastGravity.CENTER);
                                             // controller.funFactListDeta[index]['question'] = '';
                                             // controller.funFactListDeta[index]['id'] = '';
                                           }else{
                                             final selectedQuestion = controller.idToQuestionMap[selectedId] ?? '';
                                             controller.funFactListDeta[index]['question'] = selectedQuestion;
                                             controller.funFactListDeta[index]['id'] = val;
                                             print(controller.funFactListDeta[index]['question']);
                                           }
                                         },
                                         itemList: controller.questionList,
                                         hindtext: "Select Question",
                                         suffix: Image.asset('assets/images/arrow down.png',scale: 4,),
                                         val: controller.funFactListDeta[index]['id'] ?? '',
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 10),
                                         child: Divider(
                                           color: clrGrey.withOpacity(0.4),
                                         ),
                                       ),
                                       CustoTextFormField(
                                         hintText: "Enter your answer",
                                         maxLines: 3,
                                         onChanged: (value) {
                                           controller.funFactListDeta[index]['answer'] = value.toString();
                                           controller.textEditingList[index].text = value.toString();
                                         },
                                         controll: controller.textEditingList[index],
                                       )
                                     ],
                                   ),
                                 ),
                                 controller.funFactListDeta.length > 1 ? Positioned(
                                   right: 15,
                                   top: -5,
                                   child: InkWell(
                                     onTap: () {
                                       log("gk-==$index");
                                       controller.removeFunFactDeta(index);
                                     },
                                     child: Container(
                                         padding: const EdgeInsets.all(2),
                                         decoration: BoxDecoration(
                                             color: clrBlacke,
                                             borderRadius:
                                             BorderRadius.circular(100)),
                                         child: Icon(
                                           Icons.close,
                                           color: clrWhite,
                                           size: 19,
                                         )),
                                   ),
                                 ) : SizedBox(),
                               ],
                             ),
                           ],
                         );
                       }),),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Res.Defalt_side_margin),
                      child: InkWell(
                        onTap: () {
                          if(controller.funFactListDeta.length < 3){
                            controller.addFunFactDeta('', '', null);
                          }else {
                            showTostMsg('You can add upto 3 funfacts');
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: clrYellow,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Icons.add,
                                  color: clrWhite,
                                  size: 18,
                                )),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text("Add new question")
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * .02,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Obx(() => Opacity(
                  opacity: controller.funfactLoading.value ? .5 : 1,
                  child: SizedBox(
                      height: Res.h_btn,
                      width: double.maxFinite,
                      child: CustomElevatedButton(
                          onTap: () async{
                            FocusScope.of(context).unfocus();
                            await controller.funfactUpdate();
                          },
                          backgroundClr: clrBlacke,
                          child:  controller.funfactLoading.value ? CommonUi.buttonLoading() : Text(
                            "Save",
                            style: TextStyle(
                                color: clrWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ))),
                ),)
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }),
      )),
    );
  }
}
