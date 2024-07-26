class PhoneNumberModel {
  bool? status;
  String? message;
  String? currentStep;

  PhoneNumberModel({
    this.status,
    this.message,
    this.currentStep
  });

  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) => PhoneNumberModel(
    status: json["status"],
    message: json["message"],
    currentStep: json['current_step']
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "current_step": currentStep
  };
}
