import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plusone/uis/explore/search/model/searchact_model.dart';
import 'package:plusone/utils/tostmsg.dart';

import '../../../../networking/apiservices.dart';
import '../../../../networking/endpoints.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/local_storage.dart';
import '../../../../utils/size.dart';

class SearchActController extends GetxController{


  final api = ApiServices();
  var homePageLoading = false.obs;
  var homeData = SearchActModal().obs;
  var homeError = ''.obs;
  Rx<String?> categoryID = Rx<String?>(null);

  TextEditingController locController = TextEditingController();
  var selectedIndex = 0.obs;

  var allLoading = false.obs;

  Future<void> homePageApi() async{

    Map body = {
      'category_id': categoryID.value,
      'user_id': LocalStorage.getUid(),
      'location_or_subcategory_or_name': locController.value.text.trim()
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    homePageLoading.value = true;

    try{
      final response = await api.post(EndPoints.homePage, body,headers: header);
      if(response.statusCode == 200){
        homeError.value = '';
        print('home data == ${response.body}');
        homeData.value = SearchActModal.fromJson(response.body);
      }else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('Session expired. Please login again.');
      }else if(response.statusCode == 499){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        var data = response.body;
        showTostMsg('${data['message']}');
      }else{
        print('error == ${response.body}');
        homeError.value = 'ERROR';
        homeData.value = SearchActModal();
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      homeError.value = e.toString();
      homeData.value = SearchActModal();
    }

    homePageLoading.value = false;

  }

  changeIndicator(index, currentIndex) {
    homeData.value.result!.activities?[index].circleIndex?.value = currentIndex;
  }


  bool? isFavs = false;

  Future<bool?> changeFavApi(String? id) async{

    Map body = {
      'activity_id': id,
      'user_id': LocalStorage.getUid(),
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    try{
      final response = await api.post(EndPoints.changeFavurl, body,headers: header);
      if(response.statusCode == 200){
        isFavs = true;
        print('change data == ${response.body}');
        log(isFavs.toString());
        return isFavs;
      }else{
        print('error == ${response.body}');
        return false;
      }
    }catch(e){
      print('changeFav api error == ${e.toString()}');
      return false;
    }
  }

  showHomePop() async {
    Future.delayed(Duration.zero, () {
      return Get.dialog(AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
          contentPadding:
          const EdgeInsets.only(left: 18,right: 18, top: 20,bottom: 30),
          content: SizedBox(
            width: Get.width * 0.87,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 35,
                    )),
                Center(
                  child: Image.asset(
                    "assets/icons/hifyicon.png",
                    height: 49,
                    width: 90,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                const Center(
                    child: Text(
                      "Welcome! Let’s get started",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    )),
                SizedBox(
                  height: Get.height * 0.012,
                ),
                const Center(
                  child: Text(
                    "To join activities, please become a PlusOnes member and complete your profile.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Nunito'),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.planMemUi);
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 18,right: 10,top: 12,bottom: 12,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border:  homeData.value.result?.membershipStatus == true ? Border.all(
                            color: clrGreyLight
                        ) : null,
                        color:  homeData.value.result?.membershipStatus == true ? clrWhite :clrGreyLight),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/tajicon.png",
                          height: Get.height * 0.03,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  child: Text(
                                    "Become a member",
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                                  )),
                              homeData.value.result?.membershipStatus == true ? Image.asset('assets/images/check.png',height: 20) : Image.asset('assets/icons/arrow right.png',height: 14,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.myprofileInnUi);
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 18,right: 10,top: 12,bottom: 12,),
                    decoration: BoxDecoration(
                        border: homeData.value.result?.profileComplete == true ? Border.all(
                            color: clrGreyLight
                        ) : null,
                        borderRadius: BorderRadius.circular(50),
                        color: homeData.value.result?.profileComplete == true ? clrWhite : clrGreyLight),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/person.png",
                          height: Get.height * 0.03,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                  child: Text("Complete profile",
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400))),
                              homeData.value.result?.profileComplete == true ? Image.asset('assets/images/check.png',height: 20) : Image.asset('assets/icons/arrow right.png',height: 14)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )));
    });
  }


}