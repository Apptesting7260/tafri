import 'package:get/get.dart';
import 'package:plusone/uis/profilemain/accountuis/settings/settingsalluis/blocked%20user/blocked_user_controller.dart';

class BlockedUserBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BlockedUserController(),);
  }

}