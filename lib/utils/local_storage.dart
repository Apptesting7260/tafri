import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final storage = GetStorage();

  static void saveToken(String token) {
    storage.write('token', token);
  }

  static void saveUid(String uId) {
    storage.write('uid', uId);
  }

  static String? getToken() {
    return storage.read('token');
  }

  static String? getUid() {
    return storage.read('uid');
  }

  static void removeToken() {
    storage.remove('token');
    storage.remove('uid');
  }
}
