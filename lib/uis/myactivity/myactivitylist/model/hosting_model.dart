// class HostingActivityModel {
//   bool? status;
//   Result? result;
//
//   HostingActivityModel({
//     this.status,
//     this.result,
//   });
//
//   factory HostingActivityModel.fromJson(Map<String, dynamic> json) => HostingActivityModel(
//     status: json["status"],
//     result: json["result"] == null ? null : Result.fromJson(json["result"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "result": result?.toJson(),
//   };
// }
//
// class Result {
//   List<Activity>? upcomingActivities;
//   List<Activity>? previousActivities;
//
//   Result({
//     this.upcomingActivities,
//     this.previousActivities,
//   });
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     upcomingActivities: json["upcoming_activities"] == null ? [] : List<Activity>.from(json["upcoming_activities"]!.map((x) => Activity.fromJson(x))),
//     previousActivities: json["previous_activities"] == null ? [] : List<Activity>.from(json["previous_activities"]!.map((x) => Activity.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "upcoming_activities": upcomingActivities == null ? [] : List<dynamic>.from(upcomingActivities!.map((x) => x.toJson())),
//     "previous_activities": previousActivities == null ? [] : List<dynamic>.from(previousActivities!.map((x) => x.toJson())),
//   };
// }
//
// class Activity {
//   int? id;
//   List<String>? banners;
//   String? pickPhotoForMe;
//   int? categoryId;
//   int? subcategoryId;
//   int? hostId;
//   String? name;
//   String? description;
//   String? location;
//   DateTime? date;
//   String? startAt;
//   String? endAt;
//   int? maxPeople;
//   String? gender;
//   int? repeatStatus;
//   String? joinInstantly;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? formattedDate;
//
//   Activity({
//     this.id,
//     this.banners,
//     this.pickPhotoForMe,
//     this.categoryId,
//     this.subcategoryId,
//     this.hostId,
//     this.name,
//     this.description,
//     this.location,
//     this.date,
//     this.startAt,
//     this.endAt,
//     this.maxPeople,
//     this.gender,
//     this.repeatStatus,
//     this.joinInstantly,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.formattedDate,
//   });
//
//   factory Activity.fromJson(Map<String, dynamic> json) => Activity(
//     id: json["id"],
//     banners: json["banners"] == null ? [] : List<String>.from(json["banners"]!.map((x) => x)),
//     pickPhotoForMe: json["pick_photo_for_me"],
//     categoryId: json["category_id"],
//     subcategoryId: json["subcategory_id"],
//     hostId: json["host_id"],
//     name: json["name"],
//     description: json["description"],
//     location: json["location"],
//     date: json["date"] == null ? null : DateTime.parse(json["date"]),
//     startAt: json["start_at"],
//     endAt: json["end_at"],
//     maxPeople: json["max_people"],
//     gender: json["gender"],
//     repeatStatus: json["repeat_status"],
//     joinInstantly: json["join_instantly"],
//     status: json["status"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     formattedDate: json["formatted_date"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x)),
//     "pick_photo_for_me": pickPhotoForMe,
//     "category_id": categoryId,
//     "subcategory_id": subcategoryId,
//     "host_id": hostId,
//     "name": name,
//     "description": description,
//     "location": location,
//     "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
//     "start_at": startAt,
//     "end_at": endAt,
//     "max_people": maxPeople,
//     "gender": gender,
//     "repeat_status": repeatStatus,
//     "join_instantly": joinInstantly,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "formatted_date": formattedDate,
//   };
// }



class HostingActivityModel {
  bool? status;
  Result? result;

  HostingActivityModel({
    this.status,
    this.result,
  });

  factory HostingActivityModel.fromJson(Map<String, dynamic> json) => HostingActivityModel(
    status: json["status"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result?.toJson(),
  };
}

class Result {
  List<Activity>? upcomingActivities;
  List<Activity>? previousActivities;

  Result({
    this.upcomingActivities,
    this.previousActivities,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    upcomingActivities: json["upcoming_activities"] == null ? [] : List<Activity>.from(json["upcoming_activities"]!.map((x) => Activity.fromJson(x))),
    previousActivities: json["previous_activities"] == null ? [] : List<Activity>.from(json["previous_activities"]!.map((x) => Activity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "upcoming_activities": upcomingActivities == null ? [] : List<dynamic>.from(upcomingActivities!.map((x) => x.toJson())),
    "previous_activities": previousActivities == null ? [] : List<dynamic>.from(previousActivities!.map((x) => x.toJson())),
  };
}

class Activity {
  DateTime? date;
  String? formattedDate;
  List<ActivityElement>? activities;

  Activity({
    this.date,
    this.formattedDate,
    this.activities,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    formattedDate: json["formatted_date"],
    activities: json["activities"] == null ? [] : List<ActivityElement>.from(json["activities"]!.map((x) => ActivityElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "formatted_date": formattedDate,
    "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
  };
}

class ActivityElement {
  int? id;
  List<String>? banners;
  String? pickPhotoForMe;
  int? categoryId;
  int? subcategoryId;
  int? hostId;
  String? name;
  String? description;
  String? location;
  dynamic latitude;
  dynamic longitude;
  DateTime? date;
  String? startAt;
  String? endAt;
  int? maxPeople;
  String? gender;
  String? repeatStatus;
  String? joinInstantly;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? formattedDate;
  bool? markAttendance;
  Timezone? timezone;

  ActivityElement({
    this.id,
    this.banners,
    this.pickPhotoForMe,
    this.categoryId,
    this.subcategoryId,
    this.hostId,
    this.name,
    this.description,
    this.location,
    this.latitude,
    this.longitude,
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
    this.formattedDate,
    this.markAttendance,
    this.timezone
  });

  factory ActivityElement.fromJson(Map<String, dynamic> json) => ActivityElement(
    id: json["id"],
    banners: json["banners"] == null ? [] : List<String>.from(json["banners"]!.map((x) => x)),
    pickPhotoForMe: json["pick_photo_for_me"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    hostId: json["host_id"],
    name: json["name"],
    description: json["description"],
    location: json["location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    startAt: json["start_at"],
    endAt: json["end_at"],
    maxPeople: json["max_people"],
    gender: json["gender"],
    repeatStatus: json["repeat_status"],
    joinInstantly: json["join_instantly"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    formattedDate: json["formatted_date"],
    markAttendance: json['mark_attendance'],
    timezone: json["timezone"] == null ? null : Timezone.fromJson(json["timezone"]),
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
    "latitude": latitude,
    "longitude": longitude,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "start_at": startAt,
    "end_at": endAt,
    "max_people": maxPeople,
    "gender": gender,
    "repeat_status": repeatStatus,
    "join_instantly": joinInstantly,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "formatted_date": formattedDate,
  };
}



class Timezone {
  int? id;
  String? countryName;
  String? timeZone;
  String? gmtOffset;
  DateTime? createdAt;
  DateTime? updatedAt;

  Timezone({
    this.id,
    this.countryName,
    this.timeZone,
    this.gmtOffset,
    this.createdAt,
    this.updatedAt,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
    id: json["id"],
    countryName: json["country_name"],
    timeZone: json["time_zone"],
    gmtOffset: json["gmt_offset"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_name": countryName,
    "time_zone": timeZone,
    "gmt_offset": gmtOffset,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}