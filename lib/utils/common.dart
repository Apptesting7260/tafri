import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plusone/utils/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommonUi{

  static Widget buttonLoading(){
   return LoadingAnimationWidget.fourRotatingDots(color: clrWhite, size: 45);
  }

  static Widget loadingIndicator({Color? color}){
    return CupertinoActivityIndicator(
      color: color ?? clrGreyDark,
      radius: 20,
    );
  }

  static Widget scaffoldLoading({Color? color}){
    return LoadingAnimationWidget.discreteCircle(color: color ?? clrGreyDark, size: 40);
  }

  static Widget fallingDot(){
    return LoadingAnimationWidget.fallingDot(color: clrWhite, size: 25);
  }

  static Widget emptySizeBox(){
    return const SizedBox();
  }

  static Widget appBar({void Function()? onTap}){
    return GestureDetector(
      onTap: onTap ?? () {
        Get.back();
      },
      child: Image.asset('assets/images/appbar icon.png',height: 40,width: 40,),
    );
  }

  static Widget refreshHeader(){
    return WaterDropHeader(
      waterDropColor: Colors.transparent,
      idleIcon: Icon(Icons.refresh,color: clrWhite,size: 18,),
    );
  }

}