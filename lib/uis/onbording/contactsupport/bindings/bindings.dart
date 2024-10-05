import 'package:get/get.dart';
import 'package:plusone/uis/onbording/contactsupport/controller/controller.dart';


class ContactSupportBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ContactSupportController());
  }

}