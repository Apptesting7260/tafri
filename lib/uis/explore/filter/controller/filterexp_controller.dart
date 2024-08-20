import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

class FilterExpController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  var currentPage = 0.obs;
  var focusedDay = DateTime.now().obs;
  var daysInMonth = <int>[].obs;

  void updatePage(int index) {
    currentPage.value = index;
    final year = (index ~/ 12);
    final month = (index % 12) + 1;
    focusedDay.value = DateTime(year, month);
    _updateDaysInMonth(focusedDay.value);
  }

  void _updateDaysInMonth(DateTime date) {
    int daysInMonthCount = DateUtils.getDaysInMonth(date.year, date.month);
    daysInMonth.value = List.generate(daysInMonthCount, (index) => index + 1);
  }

}