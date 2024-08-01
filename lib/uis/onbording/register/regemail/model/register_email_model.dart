class RegisterEmailModel {
  String? accessToken;
  bool? status;
  String? message;
  int? currentStep;
  int? userID;

  RegisterEmailModel({
    this.accessToken,
    this.status,
    this.message,
    this.currentStep,
    this.userID
  });

  factory RegisterEmailModel.fromJson(Map<String, dynamic> json) => RegisterEmailModel(
    accessToken: json["access_token"],
    status: json["status"],
    message: json["message"],
    currentStep: json["current_step"],
    userID: json['user_id']
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "status": status,
    "message": message,
    "current_step": currentStep,
    'user_id': userID
  };
}
