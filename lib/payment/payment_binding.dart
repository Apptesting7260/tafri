import 'package:get/get.dart';
import 'package:plusone/payment/payment_controller.dart';

class PaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController(),);
  }

}