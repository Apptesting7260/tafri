import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/checkconnection.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/onbording/introone/controller/intro_controller.dart';
import 'package:plusone/uis/onbording/register/nameadd/model/name_add_model.dart';
import 'package:plusone/utils/tostmsg.dart';

import '../../../../../routes/routes.dart';

class NameAddController extends GetxController{

  final api = ApiServices();

  final IntroController introController = Get.find<IntroController>();

  var loading = false.obs;

  TextEditingController fNameController=TextEditingController();
  TextEditingController lNameController=TextEditingController();

  Future<void> registerName() async{

    loading.value = true;

    Map data = {
      'first_name': fNameController.value.text.trim(),
      'last_name': lNameController.value.text.trim(),
      'mobile': introController.mobnoController.value.text.trim(),
      'country_code': introController.countryCode.value
    };
    print(data);

      try{
        final response = await api.post(EndPoints.signupStep1, data);
        var body = SignUpStepOneModel.fromJson(response.body);
        if(response.statusCode == 200){
          loading.value = false;
          if(body.status == true){
            Get.toNamed(Routes.genderaddUi);
          }
        }else{
          loading.value = false;
          showTostMsg(body.message);
        }
      }catch(e){
        loading.value = false;
        print('error == ${e.toString()}');
      }

  }

  // submitName(){
  //   GlobalData.regData['first_name']=fNameController.text.trim();
  //   GlobalData.regData['last_name']=lNameController.text.trim();
  //   debugPrint("gk================== f and l name===${ GlobalData.regData}");
  //   Get.toNamed(Routes.genderaddUi);
  // }

}