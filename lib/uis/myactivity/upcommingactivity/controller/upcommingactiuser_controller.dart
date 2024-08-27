import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plusone/utils/size.dart';
import '../../../../networking/apiservices.dart';
import '../../../../networking/endpoints.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/local_storage.dart';
import '../../../components/custoelevatedbtn.dart';
import '../../../explore/exploreview/model/exploreviewui_model.dart';

class UpCommingActiUserController extends GetxController{
  @override
  void onInit() {
    // alertRequestAccepted();
    String id = Get.arguments;
    upactapi(id);
    super.onInit();
  }

  final api = ApiServices();
  var activityLoading = false.obs;
  var actData = ActDataModal().obs;
  var actError = ''.obs;


  Future<void> upactapi(String? id) async{


    Map body = {
      'id': id,
      'user_id': LocalStorage.getUid()
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    activityLoading.value = true;

    try{
      final response = await api.post(EndPoints.activitypage, body, headers: header);
      if(response.statusCode == 200){
        actError.value = '';
        print('home data == ${response.body}');
        actData.value = ActDataModal.fromJson(response.body);
        if(actData.value.activity?.requestStatus == 'reject'){
          alertRequestNotAccepted();
        }
      }else{
        print('error == ${response.body}');
        actError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      actError.value = e.toString();
    }

    activityLoading.value = false;

  }

  alertRequestAccepted() {
    return Future.delayed(Duration.zero,(){
      return  Get.dialog(AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(child: Image.asset("assets/icons/congratesicon.png",height: 65,)),
              ),
              const Center(
                child:  Text(
                  "Request Accepted!",
                  style: TextStyle(fontSize: 19
                      , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
                ),
              ),

               SizedBox(
                height: Get.height*.012,
              ),
              Center(child: Text("Congratulations! Your activity request is accepted by the host.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),
               SizedBox(
                height: Get.height*.024,
              ),
              SizedBox(width: double.maxFinite,height:Res.h_btn,child: CustomElevatedButton(onTap: (){
                Get.back();
              }, backgroundClr: clrBlacke, child: Text("Go to activity",style: TextStyle(color: clrWhite,fontSize: 16,fontWeight: FontWeight.w700),))),
               SizedBox(
                height: Get.height*.012,
              ),
            ],
          ),
        ),
      )).then((val){
        return alertRequestNotAccepted();
      });
    });
  }

  alertRequestNotAccepted() {
    Get.dialog(AlertDialog(
      scrollable: true,
      insetPadding: const EdgeInsets.symmetric(horizontal: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
              SizedBox(
              height: Get.height*.007,
            ),
            InkWell(onTap: (){Get.back();},child: Icon(Icons.close)),
            Center(child: Image.asset("assets/icons/iicon.png",height: 65,)),
              SizedBox(
              height: Get.height*.02,
            ),
            const Center(
              child:  Text(
                "Request not accepted",
                style: TextStyle(fontSize: 19
                    , fontWeight: FontWeight.w800),textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Center(child: Text("The host couldn't accept your request this time. Check other activities available.",style: TextStyle(color: clrGreyTextLight),textAlign: TextAlign.center,)),
              SizedBox(
              height:Get.height*.025,
            ),
            SizedBox(width: double.maxFinite,height: Res.h_btn,child: CustomElevatedButton(onTap: (){
              Get.back();
            }, backgroundClr: clrBlacke, child: Text("Explore more",style: TextStyle(color: clrWhite,fontWeight: FontWeight.w700,fontSize: 16),))),
              SizedBox(
              height: Get.height*.012,
            ),
          ],
        ),
      ),
    ));
  }
}