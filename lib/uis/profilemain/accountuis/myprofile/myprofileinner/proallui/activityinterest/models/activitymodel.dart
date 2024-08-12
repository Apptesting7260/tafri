import 'package:get/get.dart';

class ActivityModel {
  bool? status;
  List<Result>? result;

  ActivityModel({this.status, this.result});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? id;
  String? title;
  String? icon;
  String? slug;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Subcategories>? subcategories;

  Result(
      {this.id,
        this.title,
        this.icon,
        this.slug,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.subcategories});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    slug = json['slug'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['icon'] = icon;
    data['slug'] = slug;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subcategories != null) {
      data['subcategories'] =
          subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  int? id;
  int? categoryId;
  String? title;
  bool? isSelected;
  String? icon;
  String? slug;
  String? status;
  String? createdAt;
  String? updatedAt;

  Subcategories(
      {this.id,
        this.categoryId,
        this.isSelected,
        this.title,
        this.icon,
        this.slug,
        this.status,
        this.createdAt,
        this.updatedAt});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    isSelected = json['isSelected'];
    title = json['title'];
    icon = json['icon'];
    slug = json['slug'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['icon'] = icon;
    data['slug'] = slug;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
