import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

import '../../../../networking/apiservices.dart';
import '../../../../networking/endpoints.dart';
import '../../../../utils/local_storage.dart';
import '../../../creativity/model/category_model.dart';

class FilterExpController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    getCategory();
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


  String uid = LocalStorage.getUid().toString();
  String token = LocalStorage.getToken().toString();

  final api = ApiServices();
  var catData = CategoryModel().obs;


  var catLoading = false.obs;
  var catError = ''.obs;


  Future<void> getCategory() async{
    categryList.clear();
    catLoading.value = true;
    var header = {
      'Authorization': 'Bearer $token'
    };
    try{
      final response = await api.get("${EndPoints.getCategoryApiUrl}$uid",headers: header);
      if(response.statusCode == 200){
        catError.value = '';
        catData.value = CategoryModel.fromJson(response.body);
        if (catData.value.result != null) {
          categryList.addAll(catData.value.result!);
          log('cat => ${categryList}');
        }
        // catData.value.result?.forEach((e) {
        //   categoryList.add(DropdownMenuItem(
        //     value: e.id,
        //     child: Text(e.title.toString()),
        //   ));
        // });
      }else{
        catError.value = 'Error';
      }
    }catch(e){
      catError.value = e.toString();
      print('error == ${e.toString()}');
    }
    catLoading.value = false;
  }

  RxList<Result> categryList = <Result>[].obs;

  selectCategory(int id) {
    for (var category in categryList) {
      if (category.id == id) {
        category.isSelected = true;
        print('object == ${category.isSelected}');
      } else {
        category.isSelected = false;
        print('object 2 == ${category.isSelected}');
      }
    }
    categryList.refresh();  // Trigger a UI update
    print(categryList.runtimeType);
  }


}