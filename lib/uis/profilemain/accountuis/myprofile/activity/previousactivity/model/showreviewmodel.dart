class ShowReviewModel {
  bool? status;
  List<Result>? result;
  String? message;

  ShowReviewModel({
    this.status,
    this.result,
    this.message,
  });

  factory ShowReviewModel.fromJson(Map<String, dynamic> json) => ShowReviewModel(
    status: json["status"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
  };
}

class Result {
  int? id;
  int? activityId;
  int? userId;
  String? firstName;
  String? lastName;
  String? profilePhoto;
  String? rating;
  String? review;
  DateTime? createdAt;

  Result({
    this.id,
    this.activityId,
    this.userId,
    this.firstName,
    this.lastName,
    this.profilePhoto,
    this.rating,
    this.review,
    this.createdAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    activityId: json["activity_id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profilePhoto: json["profile_photo"],
    rating: json["rating"],
    review: json["review"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "activity_id": activityId,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "profile_photo": profilePhoto,
    "rating": rating,
    "review": review,
    "created_at": createdAt?.toIso8601String(),
  };
}
