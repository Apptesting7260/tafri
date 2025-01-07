import 'dart:developer';

import 'package:get/get.dart';
import 'package:plusone/routes/routes.dart';
import 'package:plusone/utils/tostmsg.dart';

import '../../../../../networking/apiservices.dart';
import '../../../../../networking/endpoints.dart';
import '../../../../../utils/local_storage.dart';
import '../Modal/MyfavouriteModal.dart';

class MyfavouriteController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    myfavouriteapi();
    super.onInit();
  }


  final api = ApiServices();
  var myfavouriteLoading = false.obs;
  var favData = MyfavouriteModal().obs;
  var favError = ''.obs;


  Future<void> myfavouriteapi() async{
    
    Map<String,String> header = {
      'Authorization' : 'Bearer ${LocalStorage.getToken()}'
    };

    myfavouriteLoading.value = true;

    try{
      final response = await api.get('${EndPoints.favurl}${LocalStorage.getUid()}', headers: header);
      if(response.statusCode == 200){
        favError.value = '';
        print('fav data == ${response.body}');
        favData.value = MyfavouriteModal.fromJson(response.body);
      }else if(response.statusCode == 401){
        LocalStorage.removeToken();
        Get.offAllNamed(Routes.initialPage);
        showTostMsg('Session expired. Please login again.');
      }else{
        print('error == ${response.body}');
        favError.value = 'ERROR';
        favData.value = MyfavouriteModal();
      }
    }catch(e){
      print('home api error == ${e.toString()}');
      favError.value = e.toString();
      favData.value = MyfavouriteModal();
    }

    myfavouriteLoading.value = false;

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
        await myfavouriteapi();
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

  changeIndicator(index, currentIndex) {
    favData.value.result?[index].circleIndex?.value = currentIndex;
  }


}