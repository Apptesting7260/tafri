import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/profilemain/controller/profilemain_controller.dart';
import 'package:plusone/utils/local_storage.dart';
import 'package:plusone/utils/tostmsg.dart';

class ReStartMembershipController extends GetxController{

  final ProfilemainController profileController =
  Get.find<ProfilemainController>();

  var choosePlan = (-1).obs;
  var price = ''.obs;
  var freeDays = ''.obs;
  var selectedPlan = ''.obs;
  var planID = ''.obs;

  void updatePlan(int value,String planPrice,String freeDay,String plan,String id){
    choosePlan.value = value;
    price.value = planPrice;
    freeDays.value = freeDay;
    selectedPlan.value = plan;
    planID.value = id;
    print('price = ${price.value}  selectedplan = ${selectedPlan.value}  plan id  = ${planID.value}');
  }

  final api = ApiServices();

  var loading = false.obs;
  Future<void> restartPlan({required String customerID}) async{

    loading.value = true;
    var body = {
      'plan_id': planID.value,
      'amount': price.value,
      'customer_id': customerID,
    };

    var header = {
      'Authorization': 'Bearer ${LocalStorage.getToken()}'
    };

    try{
      final response = await api.post(EndPoints.restartPlan, body,headers: header);
      print('restart response == ${response.statusCode}  ${response.body}');
      if(response.statusCode == 200){
        profileController.viewProfile();
        Get.back();
      }else{
        showTostMsg('msg');
      }
    }catch(e){
      showTostMsg('Something went wrong. Please try again.');
      print('restart error == ${e.toString()}');
    }
    loading.value = false;

  }


}