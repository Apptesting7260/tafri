import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plusone/utils/colors.dart';

class CommonUi{

  static fourDotLoading(){
   return LoadingAnimationWidget.fourRotatingDots(color: clrWhite, size: 45);
  }

  static emptySizeBox(){
    return const SizedBox();
  }

}