class GenderAddModel {
  bool? status;
  String? message;
  int? currentStep;

  GenderAddModel({
    this.status,
    this.message,
    this.currentStep,
  });

  factory GenderAddModel.fromJson(Map<String, dynamic> json) => GenderAddModel(
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
