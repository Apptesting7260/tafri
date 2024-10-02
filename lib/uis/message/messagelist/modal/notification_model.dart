class NotificationModal {
  bool? success;
  List<Notification>? notifications;

  NotificationModal({
    this.success,
    this.notifications,
  });


  factory NotificationModal.fromJson(Map<String, dynamic> json) => NotificationModal(
    success: json["success"],
    notifications: json["notifications"] == null ? [] : List<Notification>.from(json["notifications"]!.map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class Notification {
  int? id;
  int? userId;
  int? senderId;
  dynamic title;
  String? message;
  String? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? profile;

  Notification({
    this.id,
    this.userId,
    this.senderId,
    this.title,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    userId: json["user_id"],
    senderId: json["sender_id"],
    title: json["title"],
    message: json["message"],
    isRead: json["is_read"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "sender_id": senderId,
    "title": title,
    "message": message,
    "is_read": isRead,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "profile": profile,
  };
}
