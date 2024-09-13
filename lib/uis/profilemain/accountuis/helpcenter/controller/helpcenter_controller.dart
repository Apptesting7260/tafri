import 'package:get/get.dart';
import 'package:plusone/networking/apiservices.dart';
import 'package:plusone/networking/endpoints.dart';
import 'package:plusone/uis/profilemain/accountuis/helpcenter/model/helpcenter_model.dart';
import 'package:plusone/utils/local_storage.dart';

class HelpcenterController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    helpCenter('');
    super.onInit();
  }


  final api = ApiServices();
  var activityLoading = false.obs;
  var helpData = HelpCenterModel().obs;
  var attError = ''.obs;
  var filteredHelpData = <Result>[].obs;
  var searchQuery = ''.obs;

  Future<void> helpCenter(String? name) async{

    Map body = {
      if(name!.isNotEmpty)'name': name
    };

    print(body);

    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    activityLoading.value = true;

    try{
      final response = await api.post(EndPoints.helpcenter, body, headers: header);
      if(response.statusCode == 200){
        attError.value = '';
        print('home data == ${response.body}');
        helpData.value = HelpCenterModel.fromJson(response.body);
        filteredHelpData.value = helpData.value.result!;
        filterHelpData();
      }else{
        print('error == ${response.body}');
        attError.value = 'ERROR';
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      attError.value = e.toString();
    }

    activityLoading.value = false;

  }

  void filterHelpData() {
    if (searchQuery.value.isEmpty) {
      filteredHelpData.value = helpData.value.result!;
    } else {
      filteredHelpData.value = helpData.value.result!.where((item) {
        return item.name!.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }


}