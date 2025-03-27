import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/components/custoelevatedbtn.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/blocked%20user/blocked_user_modal.dart';
import 'package:plusone/utils/colors.dart';
import 'package:plusone/utils/common.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/size.dart';
import 'package:plusone/utils/tostmsg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BlockedUserController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    getBlockedUser();
  }

  final api = ApiServices();
  var blockedUserData = BlockedUserModal().obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);


  var loading = false.obs;
  var error = ''.obs;
  Future<void> getBlockedUser() async{
    loading.value = true;
    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}'
    };
    try{
      final response = await api.get(EndPoints.blockedUserUrl,headers: header);
      print('blocked user response == ${response.statusCode}   ${response.body}');
      blockedUserData.value = BlockedUserModal.fromJson(response.body);
      if(response.statusCode == 200){
        error.value = '';
      }
    }catch(e){
      error.value = e.toString();
      print('blocked user error == ${e.toString()}');
    }
    loading.value = false;
  }


  var blockLoading = false.obs;
  Future<void> unblockUser({required String id}) async{

    // blockedUserData.value.result?[index].loading?.value = true;
    blockLoading.value = true;
    Map body = {
      'blocked_user_id': id,
    };

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    try{
      final response = await api.post(EndPoints.unBlockUrl, body, headers: header);
      print('unblock response == ${response.body}');
      if(response.statusCode == 200){
        blockedUserData.value.result?.removeWhere((e) => e.id.toString() == id,);
        blockedUserData.refresh();
        showTostMsg('User has been successfully unblocked.');
        Get.back();
      }else{
        showTostMsg(response.body['message']);
      }
    }catch(e){
      showTostMsg('Failed to unblock user. Please try again.');
      print('unblock user error == ${e.toString()}');
    }
    // blockedUserData.value.result?[index].loading?.value = false;
    blockLoading.value = false;

  }

  alertUnBlock(String id){
    Get.dialog(AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Res.Defalt_side_margin),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Do you want to unblock this user?",style: TextStyle(
            fontSize: 18,
            fontFamily: 'Nunito',
          ),),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Flexible(
                child: SizedBox(
                  height: Get.height * .07,
                  child: CustomElevatedButton(
                    backgroundClr: clrWhite,
                    borderClr: clrBlacke,
                    onTap: () {
                      Get.back();
                    },
                    child: Center(
                      child: Text('Cancel', style: TextStyle(
                          color: clrBlacke,
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700),),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Flexible(
                child: SizedBox(
                  height: Get.height * .07,
                  child: CustomElevatedButton(
                    backgroundClr: clrBlacke,
                    onTap: () {
                      unblockUser(id: id);
                    },
                    child: Center(
                      child: Obx(() => blockLoading.value ? CommonUi.buttonLoading() : Text('Unblock', style: TextStyle(
                          color: clrWhite,
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700),),),
                    ),
                  ),
                ),
              ),

            ],
          )
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(onTap: () {
            Get.back();
          },child: const Icon(Icons.close,size: 25,)),
          const Text('Unblock user',
            style: TextStyle(fontSize: 20, fontFamily: 'Nunito',fontWeight: FontWeight.w700),
          ),
          const SizedBox(),
        ],
      ),
    ));
  }


}