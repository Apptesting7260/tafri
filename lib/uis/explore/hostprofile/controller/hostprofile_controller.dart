import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/explore/hostprofile/model/hostprofile_model.dart';
import 'package:plusone/utils/local_storage.dart';

class HostProfileController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    var id = Get.arguments;
    hostapi(id);
    super.onInit();
  }


  final api = ApiServices();
  var hostLoading = false.obs;
  var hostData = HostprofileModel().obs;
  var hostError = ''.obs;


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