class CategoryModel {
  bool? status;
  List<CatResult>? result;

  CategoryModel({
    this.status,
    this.result,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    status: json["status"],
    result: json["result"] == null ? [] : List<CatResult>.from(json["result"]!.map((x) => CatResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class CatResult {
  int? id;
  String? title;
  String? icon;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Subcategory>? subcategories;
  bool isSelected;

  CatResult({
    this.id,
    this.title,
    this.icon,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.subcategories,
    this.isSelected = false
  });

  factory CatResult.fromJson(Map<String, dynamic> json) => CatResult(
    id: json["id"],
    title: json["title"],
    icon: json["icon"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "icon": icon,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
  };
}

class Subcategory {
  int? id;
  int? categoryId;
  String? title;
  String? icon;
  String? slug;
  String? image;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isSelected;

  Subcategory({
    this.id,
    this.categoryId,
    this.title,
    this.icon,
    this.slug,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isSelected,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    icon: json["icon"],
    slug: json["slug"],
    image: json["image"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isSelected: json["isSelected"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "icon": icon,
    "slug": slug,
    "image": image,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "isSelected": isSelected,
  };
}
