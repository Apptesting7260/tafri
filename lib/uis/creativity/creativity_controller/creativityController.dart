import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Creativitycontroller extends GetxController with GetTickerProviderStateMixin{
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }
  RxInt groupSize=1.obs;
  incGroupSize(){
    if(groupSize.value<6){
      groupSize.value+=1;
    }
  }
  decGroupSize(){
    if( groupSize.value>1){
      groupSize.value-=1;
    }
  }
  RxInt gender=0.obs;
  changeGenderFilter(val){
    gender.value=val;
    debugPrint("gender=${gender.value}");
  }

  RxInt? repeat;
  changeRepeatVal(val){
    repeat?.value=val;
    debugPrint("repeat=${repeat?.value}==incomming=${val}");
  }
  RxBool joinInstant=false.obs;
  changejoinInstant(){
    joinInstant.value=!joinInstant.value;
  }


}