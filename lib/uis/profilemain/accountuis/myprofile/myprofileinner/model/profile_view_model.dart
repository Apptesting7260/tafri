  class ProfileViewModel {
  bool? status;
  Result? result;

  ProfileViewModel({
    this.status,
    this.result,
  });

  factory ProfileViewModel.fromJson(Map<String, dynamic> json) => ProfileViewModel(
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
  String? timeZone;
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
  String? upcommingActivityStatus;
  String? previousActivityStatus;
  String? pushNotificaions;
  String? emailNotifications;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? age;
  String? attendanceRate;
  int? activitiesJoined;
  int? activitiesHosted;
  Profile? profile;
  List<Activity>? upcomingActivities;
  List<Activity>? previousActivities;
  String? planType;
  String? subscriptionId;
  String? cancelDate;
  String? startDate;
  String? endDate;
  String? trailDate;
  String? referalApplied;
  String? cancelStatus;
  bool? membershipStatus;
  SwitchPlan? switchPlan;
  CardDetail? cardDetail;
  String? referCode;
  int? myReferDays;
  ReferralSetting? referralSetting;
  ReStartPlan? restartPlan;

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
    this.restartPlan,
    this.timeZone,
    this.userType,
    this.subscriptionStatus,
    this.currentStep,
    this.upcommingActivityStatus,
    this.previousActivityStatus,
    this.pushNotificaions,
    this.emailNotifications,
    this.createdAt,
    this.updatedAt,
    this.age,
    this.referalApplied,
    this.attendanceRate,
    this.activitiesJoined,
    this.activitiesHosted,
    this.profile,
    this.upcomingActivities,
    this.previousActivities,
    this.planType,
    this.membershipStatus,
    this.subscriptionId,
    this.cancelDate,
    this.startDate,
    this.endDate,
    this.trailDate,
    this.cancelStatus,
    this.switchPlan,
    this.cardDetail,
    this.referCode,
    this.myReferDays,
    this.referralSetting
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    gender: json["gender"],
    referalApplied: json['used_by_referral_code'],
    location: json["location"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    googleId: json["google_id"],
    appleId: json["apple_id"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    status: json["status"],
    isBlocked: json["is_blocked"],
    userType: json["user_type"],
    timeZone: json['time_zone'],
    subscriptionStatus: json["subscription_status"],
    currentStep: json["current_step"],
    upcommingActivityStatus: json["upcomming_activity_status"],
    previousActivityStatus: json["previous_activity_status"],
    pushNotificaions: json["push_notifications"],
    emailNotifications: json["email_notifications"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    age: json["age"],
    attendanceRate: json["attendance_rate"],
    activitiesJoined: json["activities_joined"],
    activitiesHosted: json["activities_hosted"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    upcomingActivities: json["upcoming_activities"] == null ? [] : List<Activity>.from(json["upcoming_activities"]!.map((x) => Activity.fromJson(x))),
    previousActivities: json["previous_activities"] == null ? [] : List<Activity>.from(json["previous_activities"]!.map((x) => Activity.fromJson(x))),
    planType: json['plan_type'],
    membershipStatus: json['membership_status'],
    subscriptionId: json['subscription_id'],
    cancelDate: json['canceled_date'],
    cancelStatus: json['subscription_status'],
    startDate: json['start_date'],
    endDate: json['end_date'],
    trailDate: json['trail_end_at'],
    switchPlan: json["switch_plan"] == null ? null : SwitchPlan.fromJson(json["switch_plan"]),
    cardDetail: json['card_active'] == null ? null : CardDetail.fromJson(json['card_active']),
    referCode: json['referral_code'],
    myReferDays: json['extra_days'],
    referralSetting: json['referral_setting'] == null ? null : ReferralSetting.fromJson(json['referral_setting']),
    restartPlan: json['restart_plan'] == null ? null : ReStartPlan.fromJson(json['restart_plan'])
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
    "upcomming_activity_status": upcommingActivityStatus,
    "previous_activity_status": previousActivityStatus,
    "push_notificaions": pushNotificaions,
    "email_notifications": emailNotifications,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "age": age,
    "attendance_rate": attendanceRate,
    "activities_joined": activitiesJoined,
    "activities_hosted": activitiesHosted,
    "profile": profile?.toJson(),
    "upcoming_activities": upcomingActivities == null ? [] : List<dynamic>.from(upcomingActivities!.map((x) => x.toJson())),
    "previous_activities": previousActivities == null ? [] : List<dynamic>.from(previousActivities!.map((x) => x.toJson())),
  };
}

  class ReStartPlan{
  String? planType;
  String? subId;
  String? cancelDate;

  ReStartPlan({
    this.planType,
    this.subId,
    this.cancelDate
  });

  factory ReStartPlan.fromJson(Map<String, dynamic> json) => ReStartPlan(
    planType: json['plan_type'],
    subId: json['subscription_id'],
    cancelDate: json['canceled_date']
  );

  }


  class ReferralSetting{
  int? referralDays;

  ReferralSetting({
    this.referralDays
  });

  factory ReferralSetting.fromJson(Map<String, dynamic> json) => ReferralSetting(
    referralDays: json['referral_days']
  );

  }

  class CardDetail{
    String? customerId;
    String? mandateId;
    String? cardToken;
    bool? cardSave;

    CardDetail({
      this.cardSave,
      this.customerId,
      this.mandateId,
      this.cardToken,
  });

    factory CardDetail.fromJson(Map<String, dynamic> json) => CardDetail(
      cardSave: json['isAuthCardActive'],
      customerId: json['customerId'],
      mandateId: json['merchantId'],
      cardToken: json['cartToken'],
    );

  }

  class SwitchPlan {
    dynamic planId;
    dynamic subscriptionId;
    dynamic cancelDate;

    SwitchPlan({
      this.planId,
      this.subscriptionId,
      this.cancelDate
    });

    factory SwitchPlan.fromJson(Map<String, dynamic> json) => SwitchPlan(
      planId: json["plan_type"],
      subscriptionId: json["subscription_id"],
      cancelDate: json['canceled_date']
    );

    Map<String, dynamic> toJson() => {
      "plan_type ": planId,
      "subscription_id": subscriptionId,
    };
  }

class Activity {
  DateTime? date;
  String? formattedDate;
  List<ActivityElement>? activities;

  Activity({
    this.date,
    this.formattedDate,
    this.activities,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    formattedDate: json["formatted_date"],
    activities: json["activities"] == null ? [] : List<ActivityElement>.from(json["activities"]!.map((x) => ActivityElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "formatted_date": formattedDate,
    "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x.toJson())),
  };
}

class ActivityElement {
  int? id;
  List<String>? banners;
  String? pickPhotoForMe;
  int? categoryId;
  int? subcategoryId;
  int? hostId;
  String? name;
  String? description;
  String? location;
  DateTime? date;
  String? startAt;
  String? endAt;
  int? maxPeople;
  String? gender;
  String? repeatStatus;
  String? joinInstantly;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? formattedDate;

  ActivityElement({
    this.id,
    this.banners,
    this.pickPhotoForMe,
    this.categoryId,
    this.subcategoryId,
    this.hostId,
    this.name,
    this.description,
    this.location,
    this.date,
    this.startAt,
    this.endAt,
    this.maxPeople,
    this.gender,
    this.repeatStatus,
    this.joinInstantly,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.formattedDate,
  });

  factory ActivityElement.fromJson(Map<String, dynamic> json) => ActivityElement(
    id: json["id"],
    banners: json["banners"] == null ? [] : List<String>.from(json["banners"]!.map((x) => x)),
    pickPhotoForMe: json["pick_photo_for_me"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    hostId: json["host_id"],
    name: json["name"],
    description: json["description"],
    location: json["location"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    startAt: json["start_at"],
    endAt: json["end_at"],
    maxPeople: json["max_people"],
    gender: json["gender"],
    repeatStatus: json["repeat_status"],
    joinInstantly: json["join_instantly"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    formattedDate: json["formatted_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x)),
    "pick_photo_for_me": pickPhotoForMe,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "host_id": hostId,
    "name": name,
    "description": description,
    "location": location,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "start_at": startAt,
    "end_at": endAt,
    "max_people": maxPeople,
    "gender": gender,
    "repeat_status": repeatStatus,
    "join_instantly": joinInstantly,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "formatted_date": formattedDate,
  };
}

class Profile {
  int? id;
  int? userId;
  String? bio;
  String? occupation;
  String? organisationName;
  List<String>? languageId;
  ActivityInterests? activityInterests;
  List<FunFactsAboutMe>? funFactsAboutMe;
  dynamic verifyInstagram;
  dynamic verifyLinkedin;
  String? instaId;
  String? instaName;
  String? linkedinID;
  String? linkedinName;
  String? linkedinMail;
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
    this.instaId,
    this.instaName,
    this.linkedinName,
    this.linkedinID,
    this.linkedinMail,
    this.profilePhoto,
    this.createdAt,
    this.updatedAt,
    this.languageNames,
    this.activityTitles,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    userId: json["user_id"],
    bio: json["bio"] ?? '',
    occupation: json["occupation"],
    organisationName: json["organisation_name"],
    languageId: json["language_id"] == null ? [] : List<String>.from(json["language_id"]!.map((x) => x)),
    activityInterests: json["activity_interests"] == null ? null : ActivityInterests.fromJson(json["activity_interests"]),
    funFactsAboutMe: json["fun_facts_about_me"] == null ? [] : List<FunFactsAboutMe>.from(json["fun_facts_about_me"]!.map((x) => FunFactsAboutMe.fromJson(x))),
    verifyInstagram: json["verify_instagram"],
    verifyLinkedin: json["verify_linkedin"],
    instaId: json['instagram_id'],
    instaName: json['instagram_name'],
    linkedinID: json['linkedin_id'],
    linkedinName: json['linkedin_name'],
    linkedinMail: json['linkedin_email'],
    profilePhoto: json["profile_photo"] == 'https://api.plusonesapp.com/admin/assets/dist/img/default-profile.png' ? null : json['profile_photo'],
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
    "activity_interests": activityInterests?.toJson(),
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

class ActivityInterests {
  List<String>? the1;

  ActivityInterests({
    this.the1,
  });

  factory ActivityInterests.fromJson(Map<String, dynamic> json) => ActivityInterests(
    the1: json["1"] == null ? [] : List<String>.from(json["1"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "1": the1 == null ? [] : List<dynamic>.from(the1!.map((x) => x)),
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
