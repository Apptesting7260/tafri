class SignUpStepOneModel {
  bool? status;
  String? message;

  SignUpStepOneModel({
    this.status,
    this.message,
  });


  factory SignUpStepOneModel.fromJson(Map<String, dynamic> json) => SignUpStepOneModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
