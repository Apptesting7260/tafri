class AllGroupModal {
  bool? status;
  String? msg;
  List<Friend>? friend;
  Support? support;

  AllGroupModal({
    this.status,
    this.msg,
    this.friend,
    this.support
  });

  factory AllGroupModal.fromJson(Map<String, dynamic> json) => AllGroupModal(
    status: json["status"],
    msg: json["msg"],
    friend: json["friend"] == null ? [] : List<Friend>.from(json["friend"]!.map((x) => Friend.fromJson(x))),
    support: json["support"] == null ? null : Support.fromJson(json["support"]),
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
  int? allMember;
  String? startDate;
  int? activityId;
  int? createdBy;

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
    this.allMember,
    this.startDate,
    this.activityId,
    this.createdBy,
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
    startDate: json['activityStartDate'],
    allMember: json['allMembers'],
    activityId: json['activityId'],
    createdBy: json['createdBy']
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


class Support {
  String? frientConvarsationId;
  LastMsg? lastMsg;
  String? discription;
  bool? isgroup;
  String? messageStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? friendUnSeenMessage;
  int? allMembers;

  Support({
    this.frientConvarsationId,
    this.lastMsg,
    this.discription,
    this.isgroup,
    this.messageStatus,
    this.createdAt,
    this.updatedAt,
    this.friendUnSeenMessage,
    this.allMembers,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
    frientConvarsationId: json["frient_convarsation_id"],
    lastMsg: json["last_msg"] == null ? null : LastMsg.fromJson(json["last_msg"]),
    discription: json["discription"],
    isgroup: json["isgroup"],
    messageStatus: json["message_status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    friendUnSeenMessage: json["friendUnSeenMessage"],
    allMembers: json["allMembers"],
  );

  Map<String, dynamic> toJson() => {
    "frient_convarsation_id": frientConvarsationId,
    "last_msg": lastMsg?.toJson(),
    "discription": discription,
    "isgroup": isgroup,
    "message_status": messageStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "friendUnSeenMessage": friendUnSeenMessage,
    "allMembers": allMembers,
  };
}


class Premium {
  Premium();

  factory Premium.fromJson(Map<String, dynamic> json) => Premium(
  );

  Map<String, dynamic> toJson() => {
  };
}
