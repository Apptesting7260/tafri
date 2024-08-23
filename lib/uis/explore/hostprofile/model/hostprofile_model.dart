class HostprofileModel {
  bool? status;
  Result? result;

  HostprofileModel({
    this.status,
    this.result,
  });

  factory HostprofileModel.fromJson(Map<String, dynamic> json) => HostprofileModel(
    status: json["status"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result?.toJson(),
  };
}

class Result {
  int? id;
  String? firstName;
  String? lastName;
  String? countryCode;
  String? mobile;
  String? gender;
  String? location;
  DateTime? dob;
  dynamic googleId;
  dynamic appleId;
  String? email;
  dynamic emailVerifiedAt;
  String? status;
  String? isBlocked;
  String? userType;
  String? subscriptionStatus;
  String? currentStep;
  dynamic otp;
  String? otpVerifyStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? age;
  String? attendanceRate;
  String? activitiesJoined;
  String? activitiesHosted;
  Profile? profile;

  Result({
    this.id,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.mobile,
    this.gender,
    this.location,
    this.dob,
    this.googleId,
    this.appleId,
    this.email,
    this.emailVerifiedAt,
    this.status,
    this.isBlocked,
    this.userType,
    this.subscriptionStatus,
    this.currentStep,
    this.otp,
    this.otpVerifyStatus,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.age,
    this.attendanceRate,
    this.activitiesJoined,
    this.activitiesHosted,
    this.profile,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    gender: json["gender"],
    location: json["location"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    googleId: json["google_id"],
    appleId: json["apple_id"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    status: json["status"],
    isBlocked: json["is_blocked"],
    userType: json["user_type"],
    subscriptionStatus: json["subscription_status"],
    currentStep: json["current_step"],
    otp: json["otp"],
    otpVerifyStatus: json["otp_verify_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    age: json["age"],
    attendanceRate: json["attendance_rate"],
    activitiesJoined: json["activities_joined"],
    activitiesHosted: json["activities_hosted"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "country_code": countryCode,
    "mobile": mobile,
    "gender": gender,
    "location": location,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "google_id": googleId,
    "apple_id": appleId,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "status": status,
    "is_blocked": isBlocked,
    "user_type": userType,
    "subscription_status": subscriptionStatus,
    "current_step": currentStep,
    "otp": otp,
    "otp_verify_status": otpVerifyStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "age": age,
    "attendance_rate": attendanceRate,
    "activities_joined": activitiesJoined,
    "activities_hosted": activitiesHosted,
    "profile": profile?.toJson(),
  };
}

class Profile {
  int? id;
  int? userId;
  String? bio;
  String? occupation;
  String? organisationName;
  List<String>? languageId;
  Map<String, List<String>>? activityInterests;
  List<FunFactsAboutMe>? funFactsAboutMe;
  String? verifyInstagram;
  String? verifyLinkedin;
  String? profilePhoto;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? languageNames;
  List<ActivityTitle>? activityTitles;

  Profile({
    this.id,
    this.userId,
    this.bio,
    this.occupation,
    this.organisationName,
    this.languageId,
    this.activityInterests,
    this.funFactsAboutMe,
    this.verifyInstagram,
    this.verifyLinkedin,
    this.profilePhoto,
    this.createdAt,
    this.updatedAt,
    this.languageNames,
    this.activityTitles,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    userId: json["user_id"],
    bio: json["bio"],
    occupation: json["occupation"],
    organisationName: json["organisation_name"],
    languageId: json["language_id"] == null ? [] : List<String>.from(json["language_id"]!.map((x) => x)),
    activityInterests: Map.from(json["activity_interests"]!).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
    funFactsAboutMe: json["fun_facts_about_me"] == null ? [] : List<FunFactsAboutMe>.from(json["fun_facts_about_me"]!.map((x) => FunFactsAboutMe.fromJson(x))),
    verifyInstagram: json["verify_instagram"],
    verifyLinkedin: json["verify_linkedin"],
    profilePhoto: json["profile_photo"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    languageNames: json["language_names"] == null ? [] : List<String>.from(json["language_names"]!.map((x) => x)),
    activityTitles: json["activity_titles"] == null ? [] : List<ActivityTitle>.from(json["activity_titles"]!.map((x) => ActivityTitle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "bio": bio,
    "occupation": occupation,
    "organisation_name": organisationName,
    "language_id": languageId == null ? [] : List<dynamic>.from(languageId!.map((x) => x)),
    "activity_interests": Map.from(activityInterests!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    "fun_facts_about_me": funFactsAboutMe == null ? [] : List<dynamic>.from(funFactsAboutMe!.map((x) => x.toJson())),
    "verify_instagram": verifyInstagram,
    "verify_linkedin": verifyLinkedin,
    "profile_photo": profilePhoto,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "language_names": languageNames == null ? [] : List<dynamic>.from(languageNames!.map((x) => x)),
    "activity_titles": activityTitles == null ? [] : List<dynamic>.from(activityTitles!.map((x) => x.toJson())),
  };
}

class ActivityTitle {
  String? category;
  List<Subcategory>? subcategories;

  ActivityTitle({
    this.category,
    this.subcategories,
  });

  factory ActivityTitle.fromJson(Map<String, dynamic> json) => ActivityTitle(
    category: json["category"],
    subcategories: json["subcategories"] == null ? [] : List<Subcategory>.from(json["subcategories"]!.map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
  };
}

class Subcategory {
  String? title;
  String? icon;

  Subcategory({
    this.title,
    this.icon,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    title: json["title"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "icon": icon,
  };
}

class FunFactsAboutMe {
  String? question;
  String? answer;

  FunFactsAboutMe({
    this.question,
    this.answer,
  });

  factory FunFactsAboutMe.fromJson(Map<String, dynamic> json) => FunFactsAboutMe(
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
  };
}
