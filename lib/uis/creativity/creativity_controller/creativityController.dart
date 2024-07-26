import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';

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
  RxString sTime="".obs;
  changeStime(TimeOfDay stime){
    sTime.value="${stime.hour}:${stime.minute}";
  }
  RxString eTime="".obs;
  changeEtime(TimeOfDay etime){
    eTime.value="${etime.hour}:${etime.minute}";
  }
  Rx<bool> choosePhotoCheck=false.obs;
  changeChoosePhotoVal(){
    choosePhotoCheck.value=!choosePhotoCheck.value;
  }

}