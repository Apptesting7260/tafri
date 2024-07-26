class LocAndDobAddModel {
  bool? status;
  String? message;
  int? currentStep;

  LocAndDobAddModel({
    this.status,
    this.message,
    this.currentStep,
  });

  factory LocAndDobAddModel.fromJson(Map<String, dynamic> json) => LocAndDobAddModel(
    status: json["status"],
    message: json["message"],
    currentStep: json["current_step"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "current_step": currentStep,
  };
}
