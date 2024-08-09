import 'package:get/get.dart';

class HomePageModal {
  bool? status;
  Result? result;

  HomePageModal({
    this.status,
    this.result,
  });

  factory HomePageModal.fromJson(Map<String, dynamic> json) => HomePageModal(
    status: json["status"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result?.toJson(),
  };
}

class Result {
  List<Category>? categories;
  List<Activity>? activities;
  bool? profileComplete;
  bool? membershipStatus;

  Result({
    this.categories,
    this.activities,
    this.profileComplete,
    this.membershipStatus,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    activities: json["activities"] == null ? [] : List<Activity>.from(json["activities"]!.map((x) => Activity.fromJson(x))),
    profileComplete: json["profile_complete"],
    membershipStatus: json["membership_status"],
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
    "profile_complete": profileComplete,
    "membership_status": membershipStatus,
  };
}

class Activity {
  int? id;
  List<String>? banners;
  String? pickPhotoForMe;
  int? categoryId;
  int? subcategoryId;
  int? hostId;
  String? name;
  String? description;
  String? location;
  String? date;
  String? startAt;
  String? endAt;
  int? maxPeople;
  String? gender;
  int? repeatStatus;
  String? joinInstantly;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isSelected;
  String? categoryTitle;
  String? subcategoryTitle;
  String? hostName;
  String? profilePhoto;
  bool? isFav;
  RxInt? circleIndex;

  Activity({
    this.id,
    this.banners,
    this.pickPhotoForMe,
    this.categoryId,
    this.subcategoryId,
    this.hostId,
    this.name,
    this.description,
    this.location,
    this.date,
    this.startAt,
    this.endAt,
    this.maxPeople,
    this.gender,
    this.repeatStatus,
    this.joinInstantly,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isSelected,
    this.categoryTitle,
    this.subcategoryTitle,
    this.hostName,
    this.profilePhoto,
    this.isFav,
  RxInt? circleIndex,
  }) : circleIndex = circleIndex ?? 0.obs;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json["id"],
    banners: json["banners"] == null ? [] : List<String>.from(json["banners"]!.map((x) => x)),
    pickPhotoForMe: json["pick_photo_for_me"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    hostId: json["host_id"],
    name: json["name"],
    description: json["description"],
    location: json["location"],
    date: json["date"] == null ? null : json["date"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    maxPeople: json["max_people"],
    gender: json["gender"],
    repeatStatus: json["repeat_status"],
    joinInstantly: json["join_instantly"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isSelected: json["isSelected"],
    categoryTitle: json["category_title"],
    subcategoryTitle: json["subcategory_title"],
    hostName: json["host_name"],
    profilePhoto: json["profile_photo"],
    isFav: json["isFav"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x)),
    "pick_photo_for_me": pickPhotoForMe,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "host_id": hostId,
    "name": name,
    "description": description,
    "location": location,
    // "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "start_at": startAt,
    "end_at": endAt,
    "max_people": maxPeople,
    "gender": gender,
    "repeat_status": repeatStatus,
    "join_instantly": joinInstantly,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "isSelected": isSelected,
    "category_title": categoryTitle,
    "subcategory_title": subcategoryTitle,
    "host_name": hostName,
    "profile_photo": profilePhoto,
    "isFav": isFav,
  };
}

class Category {
  int? id;
  String? title;
  String? icon;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  RxBool? loading;

  Category({
    this.id,
    this.title,
    this.icon,
    this.status,
    this.createdAt,
    this.updatedAt,
    RxBool? loading,
  }) : loading = loading ?? false.obs;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    icon: json["icon"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "icon": icon,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
