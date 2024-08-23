import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/explore/hostprofile/model/hostprofile_model.dart';
import 'package:plusone/utils/local_storage.dart';

class HostProfileController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    String id = Get.arguments;
    hostapi(id);
    super.onInit();
  }


  String getPronoun(String? gender) {
    if (gender == "female") {
      return "She/Her";
    } else if (gender == "male") {
      return "He/Him";
    } else {
      return "They/Them";
    }
  }


  final api = ApiServices();
  var hostLoading = false.obs;
  var hostData = HostprofileModel().obs;
  var hostError = ''.obs;
  List<Subcategory> interestList = [];


  Future<void> hostapi(String? id) async{


    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    hostLoading.value = true;

    try{
      final response = await api.get('${EndPoints.hostprofile}$id', headers: header);
      if(response.statusCode == 200){
        hostError.value = '';
        print('host data == ${response.body}');
        hostData.value = HostprofileModel.fromJson(response.body);
        interestList.clear();
        if(hostData.value.result?.profile?.activityTitles != null){
          for(var i in hostData.value.result!.profile!.activityTitles!){
            if (i.subcategories != null) {
              interestList.addAll(i.subcategories!);
            }
          }
        }

        for (var subcategory in interestList) {
          print('Title: ${subcategory.title}, Icon: ${subcategory.icon}');
        }
      }else{
        print('error == ${response.body}');
        hostError.value = 'ERROR';
      }
    }catch(e){
      print('host api error == ${e.toString()}');
      hostError.value = e.toString();
    }

    hostLoading.value = false;

  }



}