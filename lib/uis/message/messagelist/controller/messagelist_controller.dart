import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagelistController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    // TODO: implement onInit
    super.onInit();
  }
}