class AttendancelistModel {
  bool? status;
  Result? result;

  AttendancelistModel({
    this.status,
    this.result,
  });

  factory AttendancelistModel.fromJson(Map<String, dynamic> json) => AttendancelistModel(
    status: json["status"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result?.toJson(),
  };
}

class Result {
  List<AttendanceList>? attendanceList;

  Result({
    this.attendanceList,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    attendanceList: json["attendance_list"] == null ? [] : List<AttendanceList>.from(json["attendance_list"]!.map((x) => AttendanceList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attendance_list": attendanceList == null ? [] : List<dynamic>.from(attendanceList!.map((x) => x.toJson())),
  };
}

class AttendanceList {
  int? userId;
  String? firstName;
  String? lastName;
  String? profilePhoto;
  String? userAttendance;

  AttendanceList({
    this.userId,
    this.firstName,
    this.lastName,
    this.profilePhoto,
    this.userAttendance,
  });

  factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profilePhoto: json["profile_photo"],
    userAttendance: json["user_attendance"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "profile_photo": profilePhoto,
    "user_attendance": userAttendance,
  };
}
