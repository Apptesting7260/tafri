class AttendanceConfirmModel {
  bool? status;
  String? message;

  AttendanceConfirmModel({
    this.status,
    this.message,
  });

  factory AttendanceConfirmModel.fromJson(Map<String, dynamic> json) => AttendanceConfirmModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
