import 'package:fluttertoast/fluttertoast.dart';
import 'package:plusone/utils/colors.dart';

showTostMsg(msg,{ToastGravity? gravity}){
  Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:clrBlacke,
      fontSize: 16.0
  );
}