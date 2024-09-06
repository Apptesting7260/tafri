import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FilteractivityModel {
  bool? status;
  Data? result;

  FilteractivityModel({
    this.status,
    this.result,
  });

  factory FilteractivityModel.fromJson(Map<String, dynamic> json) => FilteractivityModel(
    status: json["status"],
    result: json["result"] == null ? null : Data.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result?.toJson(),
  };
}

class Data {
  List<Activity>? activities;
  bool? profileComplete;
  bool? membershipStatus;

  Data({
    this.activities,
    this.profileComplete,
    this.membershipStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    activities: json["activities"] == null ? [] : List<Activity>.from(json["activities"]!.map((x) => Activity.fromJson(x))),
    profileComplete: json["profile_complete"],
    membershipStatus: json["membership_status"],
  );

  Map<String, dynamic> toJson() => {
    "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
    "profile_complete": profileComplete,
    "membership_status": membershipStatus,
  };
}

class Activity {
  int? id;
  List<String>? banners;
  String? featureImg;
  String? pickPhotoForMe;
  int? categoryId;
  int? subcategoryId;
  int? hostId;
  String? name;
  String? description;
  String? location;
  DateTime? date;
  String? startAt;
  String? endAt;
  int? maxPeople;
  String? gender;
  String? repeatStatus;
  String? joinInstantly;
  String? status;
  String? upcommingActivityStatus;
  String? previousActivityStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryTitle;
  String? subcategoryTitle;
  String? hostName;
  dynamic profilePhoto;
  String? formattedDate;
  bool? isFav;
  int? spotPeople;
  int? spotLeft;
  RxInt? circleIndex;

  Activity({
    this.id,
    this.banners,
    this.featureImg,
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
    this.upcommingActivityStatus,
    this.previousActivityStatus,
    this.createdAt,
    this.updatedAt,
    this.categoryTitle,
    this.subcategoryTitle,
    this.hostName,
    this.profilePhoto,
    this.formattedDate,
    this.isFav,
    this.spotPeople,
    this.spotLeft,
    RxInt? circleIndex,
  }) : circleIndex = circleIndex ?? 0.obs;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json["id"],
    banners: json["banners"] == null ? [] : List<String>.from(json["banners"]!.map((x) => x)),
    featureImg: json["feature_img"],
    pickPhotoForMe: json["pick_photo_for_me"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    hostId: json["host_id"],
    name: json["name"],
    description: json["description"],
    location: json["location"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    startAt: json["start_at"],
    endAt: json["end_at"],
    maxPeople: json["max_people"],
    gender: json["gender"],
    repeatStatus: json["repeat_status"],
    joinInstantly: json["join_instantly"],
    status: json["status"],
    upcommingActivityStatus: json["upcomming_activity_status"],
    previousActivityStatus: json["previous_activity_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    categoryTitle: json["category_title"],
    subcategoryTitle: json["subcategory_title"],
    hostName: json["host_name"],
    profilePhoto: json["profile_photo"],
    formattedDate: json["formatted_date"],
    isFav: json["isFav"],
    spotPeople: json["spot_people"],
    spotLeft: json["spot_left"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x)),
    "feature_img": featureImg,
    "pick_photo_for_me": pickPhotoForMe,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "host_id": hostId,
    "name": name,
    "description": description,
    "location": location,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "start_at": startAt,
    "end_at": endAt,
    "max_people": maxPeople,
    "gender": gender,
    "repeat_status": repeatStatus,
    "join_instantly": joinInstantly,
    "status": status,
    "upcomming_activity_status": upcommingActivityStatus,
    "previous_activity_status": previousActivityStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "category_title": categoryTitle,
    "subcategory_title": subcategoryTitle,
    "host_name": hostName,
    "profile_photo": profilePhoto,
    "formatted_date": formattedDate,
    "isFav": isFav,
    "spot_people": spotPeople,
    "spot_left": spotLeft,
  };
}
