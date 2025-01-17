import 'package:get/get.dart';

class ApiServices extends GetConnect{

  @override
  void $configureLifeCycle() {
    super.$configureLifeCycle();
    timeout = Duration(seconds: 60);
  }

  void tt() {
    print(" TIMEOUT ${timeout}");
  }

}