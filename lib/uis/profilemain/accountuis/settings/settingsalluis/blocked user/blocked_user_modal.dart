import 'package:get/get.dart';

class BlockedUserModal {
  final bool? status;
  final List<Result>? result;

  BlockedUserModal({
    this.status,
    this.result,
  });

  factory BlockedUserModal.fromJson(Map<String, dynamic> json) => BlockedUserModal(
    status: json["status"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

}

class Result {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? profilePhoto;
  RxBool? loading;

  Result({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePhoto,
    RxBool? loading,
  }): loading = loading ?? false.obs;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profilePhoto: json["profile_photo"],
  );

}
