import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ActDataModal {
  bool? status;
  Activity? activity;
  List<Going>? going;
  List<Request>? requests;
  bool? markAttendance;
  bool? cardSave;
  ActivitySettings? activitySettings;
  PaymentSettings? paymentSettings;

  ActDataModal({
    this.status,
    this.activity,
    this.going,
    this.requests,
    this.markAttendance,
    this.cardSave,
    this.activitySettings,
    this.paymentSettings
  });

  factory ActDataModal.fromJson(Map<String, dynamic> json) => ActDataModal(
    status: json["status"],
    activity: json["activity"] == null ? null : Activity.fromJson(json["activity"]),
    going: json["going"] == null ? [] : List<Going>.from(json["going"]!.map((x) => Going.fromJson(x))),
    requests: json["requests"] == null ? [] : List<Request>.from(json["requests"]!.map((x) => Request.fromJson(x))),
    markAttendance: json["mark_attendance"],
    cardSave: json['isAuthCardActive'],
    activitySettings: json["activity_settings"] == null ? null : ActivitySettings.fromJson(json["activity_settings"]),
    paymentSettings: json['payment_settings'] == null ? null : PaymentSettings.fromJson(json['payment_settings'])
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "activity": activity?.toJson(),
    "going": going == null ? [] : List<dynamic>.from(going!.map((x) => x.toJson())),
    "requests": requests == null ? [] : List<dynamic>.from(requests!.map((x) => x.toJson())),
    "mark_attendance": markAttendance,
  };
}

class ActivitySettings {
  String? shareText;

  ActivitySettings({
    this.shareText,
  });

  factory ActivitySettings.fromJson(Map<String, dynamic> json) => ActivitySettings(
    shareText: json["share_text"],
  );

  Map<String, dynamic> toJson() => {
    "share_text": shareText,
  };
}

class PaymentSettings {
  String? deductAmount;
  String? attendeeNoShowFee;
  String? attendeeCancellationFee;
  String? attendeeCancellationHour;
  String? hostCancellationHour;
  String? hostCancellationFee;

  PaymentSettings({
    this.deductAmount,
    this.attendeeNoShowFee,
    this.attendeeCancellationFee,
    this.attendeeCancellationHour,
    this.hostCancellationHour,
    this.hostCancellationFee,
  });

  factory PaymentSettings.fromJson(Map<String, dynamic> json) =>
      PaymentSettings(
        deductAmount: json["deduct_amount"],
        attendeeNoShowFee: json["attendee_no_show_fee"],
        attendeeCancellationFee: json["attendee_cancellation_fee"],
        attendeeCancellationHour: json["attendee_cancellation_hour"],
        hostCancellationHour: json["host_cancellation_hour"],
        hostCancellationFee: json["host_cancellation_fee"],
      );

  Map<String, dynamic> toJson() =>
      {
        "deduct_amount": deductAmount,
        "attendee_no_show_fee": attendeeNoShowFee,
        "attendee_cancellation_fee": attendeeCancellationFee,
        "attendee_cancellation_hour": attendeeCancellationHour,
        "host_cancellation_hour": hostCancellationHour,
        "host_cancellation_fee": hostCancellationFee,
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
  String? latitude;
  String? longitude;
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
  dynamic profilePhoto;
  String? formattedDate;
  bool? isFav;
  RxInt? circleIndex;
  dynamic requestStatus;
  int? spotLeft;
  int? spotPeople;
  String? groupId;

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
    this.categoryTitle,
    this.subcategoryTitle,
    this.hostName,
    this.profilePhoto,
    this.formattedDate,
    this.isFav,
    this.requestStatus,
    this.spotLeft,
    this.spotPeople,
    this.groupId,
    RxInt? circleIndex,
  }): circleIndex = circleIndex ?? 0.obs;

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
    latitude: json["latitude"],
    longitude: json["longitude"],
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
    formattedDate: json["formatted_date"],
    isFav: json["isFav"],
    requestStatus: json["request_status"],
    spotLeft: json["spot_left"],
    spotPeople: json["spot_people"],
    groupId: json['groupid']
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
    "date": date,
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
    "formatted_date": formattedDate,
    "isFav": isFav,
    "request_status": requestStatus,
    "spot_left": spotLeft,
    "up_to_people": spotPeople,
  };
}


class Going {
  int? userId;
  String? profilePhoto;
  String? firstName;
  String? lastName;
  bool? userAttendance;

  Going({
    this.userId,
    this.profilePhoto,
    this.firstName,
    this.lastName,
    this.userAttendance,
  });

  factory Going.fromJson(Map<String, dynamic> json) => Going(
    userId: json["user_id"],
    profilePhoto: json["profile_photo"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userAttendance: json["user_attendance"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "profile_photo": profilePhoto,
    "first_name": firstName,
    "last_name": lastName,
    "user_attendance": userAttendance,
  };
}

class Request {
  int? userId;
  String? profilePhoto;
  String? firstName;
  String? lastName;

  Request({
    this.userId,
    this.profilePhoto,
    this.firstName,
    this.lastName,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    userId: json["user_id"],
    profilePhoto: json["profile_photo"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "profile_photo": profilePhoto,
    "first_name": firstName,
    "last_name": lastName,
  };
}