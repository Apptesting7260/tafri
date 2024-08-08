import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plusone/utils/colors.dart';

class CommonUi{

  static fourDotLoading(){
   return LoadingAnimationWidget.fourRotatingDots(color: clrWhite, size: 45);
  }

  static loadingIndicator({Color? color}){
    return CupertinoActivityIndicator(
      color: color ?? clrGreyDark,
      radius: 20,
    );
  }

  static discreteCircleLoading({Color? color}){
    return LoadingAnimationWidget.discreteCircle(color: color ?? clrGreyDark, size: 45);
  }

  static emptySizeBox(){
    return const SizedBox();
  }

  static appBar(){
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Image.asset('assets/images/appbar icon.png',height: 40,width: 40,),
    );
  }

}