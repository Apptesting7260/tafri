import 'package:get/get.dart';

class MyfavouriteModal {
  bool? status;
  List<Result>? result;

  MyfavouriteModal({
    this.status,
    this.result,
  });

  factory MyfavouriteModal.fromJson(Map<String, dynamic> json) => MyfavouriteModal(
    status: json["status"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
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
  String? repeatStatus;
  String? joinInstantly;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? categoryTitle;
  String? subcategoryTitle;
  String? hostName;
  String? profilePhoto;
  int? spotLeft;
  int? spotPeople;
  RxInt? circleIndex;
  String? formattedDate;
  String? endDate;

  Result({
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
    this.categoryTitle,
    this.subcategoryTitle,
    this.hostName,
    this.profilePhoto,
    this.spotLeft,
    this.spotPeople,
    this.formattedDate,
    this.endDate,
    RxInt? circleIndex,
  }): circleIndex = circleIndex ?? 0.obs;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    banners: json["banners"] == null ? [] : List<String>.from(json["banners"]!.map((x) => x)),
    pickPhotoForMe: json["pick_photo_for_me"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    hostId: json["host_id"],
    name: json["name"],
    description: json["description"],
    location: json["location"],
    date: json["date"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    maxPeople: json["max_people"],
    gender: json["gender"],
    repeatStatus: json["repeat_status"],
    joinInstantly: json["join_instantly"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    categoryTitle: json["category_title"],
    subcategoryTitle: json["subcategory_title"],
    hostName: json["host_name"],
    profilePhoto: json["profile_photo"],
    spotLeft: json['spot_left'],
    spotPeople: json['spot_people'],
    formattedDate: json['formatted_date'],
    endDate: json['formatted_activity_end_date']
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
    "category_title": categoryTitle,
    "subcategory_title": subcategoryTitle,
    "host_name": hostName,
    "profile_photo": profilePhoto,
    'spot_people': spotPeople,
    'spot_left': spotLeft
  };
}
