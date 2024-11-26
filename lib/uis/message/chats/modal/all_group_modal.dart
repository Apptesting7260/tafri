class AllGroupModal {
  bool? status;
  String? msg;
  List<Friend>? friend;

  AllGroupModal({
    this.status,
    this.msg,
    this.friend,
  });

  factory AllGroupModal.fromJson(Map<String, dynamic> json) => AllGroupModal(
    status: json["status"],
    msg: json["msg"],
    friend: json["friend"] == null ? [] : List<Friend>.from(json["friend"]!.map((x) => Friend.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "friend": friend == null ? [] : List<dynamic>.from(friend!.map((x) => x.toJson())),
  };
}

class Friend {
  String? groupId;
  DateTime? createdAt;
  DateTime? updatedAt;
  LastMsg? lastMsg;
  String? groupImg;
  String? groupName;
  List<int>? members;
  String? discription;
  bool? isgroup;
  String? messageStatus;
  int? friendUnSeenMessage;
  int? groupUnSennMessage;
  bool? userBlock;
  bool? blockedBy;
  // Premium? premium;
  bool? userAcountDeleted;

  Friend({
    this.groupId,
    this.createdAt,
    this.updatedAt,
    this.lastMsg,
    this.groupImg,
    this.groupName,
    this.members,
    this.discription,
    this.isgroup,
    this.messageStatus,
    this.friendUnSeenMessage,
    this.groupUnSennMessage,
    this.userBlock,
    this.blockedBy,
    // this.premium,
    this.userAcountDeleted,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    groupId: json["Group_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    lastMsg: json["last_msg"] == null ? null : LastMsg.fromJson(json["last_msg"]),
    groupImg: json["group_img"],
    groupName: json["groupName"],
    members: json["members"] == null ? [] : List<int>.from(json["members"]!.map((x) => x)),
    discription: json["discription"],
    isgroup: json["isgroup"],
    messageStatus: json["message_status"],
    friendUnSeenMessage: json["friendUnSeenMessage"],
    groupUnSennMessage: json["groupUnSennMessage"],
    userBlock: json["userBlock"],
    blockedBy: json["blockedBy"],
    // premium: json["premium"] == null ? null : Premium.fromJson(json["premium"]),
    userAcountDeleted: json["userAcountDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "Group_id": groupId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "last_msg": lastMsg?.toJson(),
    "group_img": groupImg,
    "groupName": groupName,
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
    "discription": discription,
    "isgroup": isgroup,
    "message_status": messageStatus,
    "friendUnSeenMessage": friendUnSeenMessage,
    "groupUnSennMessage": groupUnSennMessage,
    "userBlock": userBlock,
    "blockedBy": blockedBy,
    // "premium": premium?.toJson(),
    "userAcountDeleted": userAcountDeleted,
  };
}

class LastMsg {
  String? textmessage;
  List<dynamic>? file;

  LastMsg({
    this.textmessage,
    this.file,
  });

  factory LastMsg.fromJson(Map<String, dynamic> json) => LastMsg(
    textmessage: json["textmessage"],
    file: json["file"] == null ? [] : List<dynamic>.from(json["file"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "textmessage": textmessage,
    "file": file == null ? [] : List<dynamic>.from(file!.map((x) => x)),
  };
}

class Premium {
  Premium();

  factory Premium.fromJson(Map<String, dynamic> json) => Premium(
  );

  Map<String, dynamic> toJson() => {
  };
}
