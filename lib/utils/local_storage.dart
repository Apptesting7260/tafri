import 'package:get_storage/get_storage.dart';

class LocalStorage {

  static final storage = GetStorage();

  static void saveToken(String token){
    storage.write('token', token);
  }

  static String getToken(){
    return storage.read('token');
  }

  static void removeToken(){
    storage.remove('token');
  }

}