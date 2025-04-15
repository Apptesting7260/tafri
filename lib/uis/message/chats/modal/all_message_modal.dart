// class AllMessageModal {
//   List<Data>? data;
//   int? currentPage;
//   int? totalPages;
//   int? totalMessages;
//   bool? status;
//   int? members;
//   String? gpName;
//   String? gpImg;
//
//   AllMessageModal({
//     this.data,
//     this.currentPage,
//     this.totalPages,
//     this.totalMessages,
//     this.status,
//     this.members,
//     this.gpName,
//     this.gpImg
//   });
//
//   factory AllMessageModal.fromJson(Map<String, dynamic> json) => AllMessageModal(
//     data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
//     currentPage: json["currentPage"],
//     totalPages: json["totalPages"],
//     totalMessages: json["totalMessages"],
//     status: json["status"],
//     members: json['members'],
//     gpName: json['groupName'],
//     gpImg: json['groupImage'],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     "currentPage": currentPage,
//     "totalPages": totalPages,
//     "totalMessages": totalMessages,
//     "status": status,
//   };
// }
//
// class Data {
//   Message? message;
//   PollMessage? pollMessage;
//   ReplayMessage? replayMessage;
//   String? id;
//   int? senderId;
//   String? chatGroupId;
//   bool? replayMessageStatus;
//   String? messageForward;
//   bool? isgroup;
//   bool? pollStatus;
//   bool? pinStatus;
//   String? messageStatus;
//   List<dynamic>? messageRection;
//   List<SeenUserMessage>? seenUserMessage;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//   String? fullName;
//   String? username;
//   dynamic proImg;
//   bool? loading;
//
//   Data({
//     this.message,
//     this.pollMessage,
//     this.replayMessage,
//     this.id,
//     this.senderId,
//     this.chatGroupId,
//     this.replayMessageStatus,
//     this.messageForward,
//     this.isgroup,
//     this.pollStatus,
//     this.pinStatus,
//     this.messageStatus,
//     this.messageRection,
//     this.seenUserMessage,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.fullName,
//     this.username,
//     this.proImg,
//     this.loading
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     message: json["message"] == null ? null : Message.fromJson(json["message"]),
//     pollMessage: json["poll_message"] == null ? null : PollMessage.fromJson(json["poll_message"]),
//     replayMessage: json["replay_message"] == null ? null : ReplayMessage.fromJson(json["replay_message"]),
//     id: json["_id"],
//     senderId: json["sender_id"],
//     chatGroupId: json["chatGroupId"],
//     replayMessageStatus: json["replay_message_status"],
//     messageForward: json["message_forward"],
//     isgroup: json["isgroup"],
//     pollStatus: json["poll_status"],
//     pinStatus: json["pin_status"],
//     messageStatus: json["messageType"],
//     messageRection: json["message_rection"] == null ? [] : List<dynamic>.from(json["message_rection"]!.map((x) => x)),
//     seenUserMessage: json["seen_user_message"] == null ? [] : List<SeenUserMessage>.from(json["seen_user_message"]!.map((x) => SeenUserMessage.fromJson(x))),
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//     fullName: json["full_name"],
//     username: json["username"],
//     proImg: json["pro_img"],
//     loading: false
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message?.toJson(),
//     "poll_message": pollMessage?.toJson(),
//     "replay_message": replayMessage?.toJson(),
//     "_id": id,
//     "sender_id": senderId,
//     "chatGroupId": chatGroupId,
//     "replay_message_status": replayMessageStatus,
//     "message_forward": messageForward,
//     "isgroup": isgroup,
//     "poll_status": pollStatus,
//     "pin_status": pinStatus,
//     "message_status": messageStatus,
//     "message_rection": messageRection == null ? [] : List<dynamic>.from(messageRection!.map((x) => x)),
//     "seen_user_message": seenUserMessage == null ? [] : List<dynamic>.from(seenUserMessage!.map((x) => x.toJson())),
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//     "full_name": fullName,
//     "username": username,
//     "pro_img": proImg,
//   };
// }
//
// class Message {
//   String? textmessage;
//   String? file;
//
//   Message({
//     this.textmessage,
//     this.file,
//   });
//
//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//     textmessage: json["textmessage"],
//     file: json["file"] is List && json["file"].isNotEmpty ? json["file"].first : null,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "textmessage": textmessage,
//     "file": file,
//   };
// }
//
// class PollMessage {
//   List<dynamic>? options;
//
//   PollMessage({
//     this.options,
//   });
//
//   factory PollMessage.fromJson(Map<String, dynamic> json) => PollMessage(
//     options: json["options"] == null ? [] : List<dynamic>.from(json["options"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
//   };
// }
//
// class ReplayMessage {
//   List<dynamic>? file;
//
//   ReplayMessage({
//     this.file,
//   });
//
//   factory ReplayMessage.fromJson(Map<String, dynamic> json) => ReplayMessage(
//     file: json["file"] == null ? [] : List<dynamic>.from(json["file"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "file": file == null ? [] : List<dynamic>.from(file!.map((x) => x)),
//   };
// }
//
// class SeenUserMessage {
//   int? seenUserMessageId;
//   String? fullName;
//   String? username;
//   String? proImg;
//   String? id;
//
//   SeenUserMessage({
//     this.seenUserMessageId,
//     this.fullName,
//     this.username,
//     this.proImg,
//     this.id,
//   });
//
//   factory SeenUserMessage.fromJson(Map<String, dynamic> json) => SeenUserMessage(
//     seenUserMessageId: json["id"],
//     fullName: json["full_name"],
//     username: json["username"],
//     proImg: json["pro_img"],
//     id: json["_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": seenUserMessageId,
//     "full_name": fullName,
//     "username": username,
//     "pro_img": proImg,
//     "_id": id,
//   };
// }



import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class AllMessageModal {
  List<MessageElement>? message;
  int? currentPage;
  int? totalPages;
  int? totalMessages;
  bool? status;
  int? members;
  String? gpImg;
  String? gpName;

  AllMessageModal({
    this.message,
    this.currentPage,
    this.totalPages,
    this.totalMessages,
    this.status,
    this.members,
    this.gpImg,
    this.gpName,
  });

  factory AllMessageModal.fromJson(Map<String, dynamic> json) => AllMessageModal(
    message: json["message"] == null ? [] : List<MessageElement>.from(json["message"]!.map((x) => MessageElement.fromJson(x))),
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    totalMessages: json["totalMessages"],
    status: json["status"],
    members: json["members"],
    gpImg: json["groupImage"],
    gpName: json["groupName"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    "currentPage": currentPage,
    "totalPages": totalPages,
    "totalMessages": totalMessages,
    "status": status,
    "members": members,
    "groupImage": gpImg,
    "groupName": gpName,
  };
}

class MessageElement {
  String? name;
  List<Data>? data;

  MessageElement({
    this.name,
    this.data,
  });

  factory MessageElement.fromJson(Map<String, dynamic> json) => MessageElement(
    name: json["name"],
    data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Data {
  Message? message;
  PollMessage? pollMessage;
  ReplayMessage? replayMessage;
  String? id;
  int? senderId;
  String? chatGroupId;
  bool? replayMessageStatus;
  String? messageForward;
  bool? isgroup;
  bool? pollStatus;
  bool? pinStatus;
  String? messageStatus;
  List<dynamic>? messageRection;
  List<SeenUserMessage>? seenUserMessage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? fullName;
  String? username;
  String? proImg;
  bool? loading;

  Data({
    this.message,
    this.pollMessage,
    this.replayMessage,
    this.id,
    this.senderId,
    this.chatGroupId,
    this.replayMessageStatus,
    this.messageForward,
    this.isgroup,
    this.pollStatus,
    this.pinStatus,
    this.messageStatus,
    this.messageRection,
    this.seenUserMessage,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.fullName,
    this.username,
    this.proImg,
    this.loading
  });

  static String convertTime({String? messageTime}){

    try{
      tz.initializeTimeZones();

      String targetTimeZone = Get.find<SocketController>().profileController.profileData.value.result?.timeZone == 'Asia/Calcutta' ? 'Asia/Kolkata' : Get.find<SocketController>().profileController.profileData.value.result?.timeZone ?? 'Europe/Amsterdam';
      print('user time zone == ${Get.find<SocketController>().profileController.profileData.value.result?.timeZone}');
      DateTime dateTime = DateTime.parse(messageTime!);
      final targetTZ = tz.getLocation(targetTimeZone);

      final targetTime = tz.TZDateTime.from(dateTime, targetTZ);

      final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      print('Converted time: ${formatter.format(targetTime)}');
      return formatter.format(targetTime).toString();
    }catch(e){
      print('time zone error == ${e.toString()}');
      return messageTime!;
    }

  }

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    pollMessage: json["poll_message"] == null ? null : PollMessage.fromJson(json["poll_message"]),
    replayMessage: json["replay_message"] == null ? null : ReplayMessage.fromJson(json["replay_message"]),
    id: json["_id"],
    senderId: json["sender_id"],
    chatGroupId: json["chatGroupId"],
    replayMessageStatus: json["replay_message_status"],
    messageForward: json["message_forward"],
    isgroup: json["isgroup"],
    pollStatus: json["poll_status"],
    pinStatus: json["pin_status"],
    messageStatus: json["messageType"],
    messageRection: json["message_rection"] == null ? [] : List<dynamic>.from(json["message_rection"]!.map((x) => x)),
    seenUserMessage: json["seen_user_message"] == null ? [] : List<SeenUserMessage>.from(json["seen_user_message"]!.map((x) => SeenUserMessage.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(convertTime(messageTime: json["createdAt"].toString())),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    fullName: json["full_name"],
    username: json["username"],
    proImg: json["pro_img"],
    loading: false,
  );

  Map<String, dynamic> toJson() => {
    "message": message?.toJson(),
    "poll_message": pollMessage?.toJson(),
    "replay_message": replayMessage?.toJson(),
    "_id": id,
    "sender_id": senderId,
    "chatGroupId": chatGroupId,
    "replay_message_status": replayMessageStatus,
    "message_forward": messageForward,
    "isgroup": isgroup,
    "poll_status": pollStatus,
    "pin_status": pinStatus,
    "message_status": messageStatus,
    "message_rection": messageRection == null ? [] : List<dynamic>.from(messageRection!.map((x) => x)),
    "seen_user_message": seenUserMessage == null ? [] : List<dynamic>.from(seenUserMessage!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "full_name": fullName,
    "username": username,
    "pro_img": proImg,
  };
}



class Message {
  String? textmessage;
  String? file;

  Message({
    this.textmessage,
    this.file,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    textmessage: json["textmessage"],
    file: json["file"] is List && json["file"].isNotEmpty ? json["file"].first : null,
  );

  Map<String, dynamic> toJson() => {
    "textmessage": textmessage,
    "file": file,
  };
}



class PollMessage {
  List<dynamic>? options;

  PollMessage({
    this.options,
  });

  factory PollMessage.fromJson(Map<String, dynamic> json) => PollMessage(
    options: json["options"] == null ? [] : List<dynamic>.from(json["options"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
  };
}


class ReplayMessage {
  List<dynamic>? file;

  ReplayMessage({
    this.file,
  });

  factory ReplayMessage.fromJson(Map<String, dynamic> json) => ReplayMessage(
    file: json["file"] == null ? [] : List<dynamic>.from(json["file"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "file": file == null ? [] : List<dynamic>.from(file!.map((x) => x)),
  };
}

class SeenUserMessage {
  int? seenUserMessageId;
  String? fullName;
  String? username;
  String? proImg;
  String? id;

  SeenUserMessage({
    this.seenUserMessageId,
    this.fullName,
    this.username,
    this.proImg,
    this.id,
  });

  factory SeenUserMessage.fromJson(Map<String, dynamic> json) => SeenUserMessage(
    seenUserMessageId: json["id"],
    fullName: json["full_name"],
    username: json["username"],
    proImg: json["pro_img"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": seenUserMessageId,
    "full_name": fullName,
    "username": username,
    "pro_img": proImg,
    "_id": id,
  };
}
