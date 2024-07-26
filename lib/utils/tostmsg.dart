import 'package:fluttertoast/fluttertoast.dart';
import 'package:plusone/utils/colors.dart';

showTostMsg(msg){
  Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:clrBlacke,
      fontSize: 16.0
  );
}