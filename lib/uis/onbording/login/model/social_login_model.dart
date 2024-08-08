class SocialLoginModel {
  bool? status;
  String? message;
  Data? data;

  SocialLoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory SocialLoginModel.fromJson(Map<String, dynamic> json) => SocialLoginModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? accessToken;
  int? userId;
  String? firstName;
  String? lastName;
  String? email;

  Data({
    this.accessToken,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["access_token"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
  };
}
