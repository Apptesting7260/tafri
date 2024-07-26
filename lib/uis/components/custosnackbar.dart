import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plusone/utils/colors.dart';

custoSnackbar(title,message){
  return Get.snackbar(title, message,backgroundColor: clrWhite);
}