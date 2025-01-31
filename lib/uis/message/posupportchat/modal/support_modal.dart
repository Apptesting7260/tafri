import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plusone/uis/message/chats/controller/socket_controller.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SupportMessage {
  List<MessageElement>? message;
  int? currentPage;
  int? totalPages;
  int? totalMessages;
  bool? status;

  SupportMessage({
    this.message,
    this.currentPage,
    this.totalPages,
    this.totalMessages,
    this.status,
  });

  factory SupportMessage.fromJson(Map<String, dynamic> json) => SupportMessage(
    message: json["message"] == null ? [] : List<MessageElement>.from(json["message"]!.map((x) => MessageElement.fromJson(x))),
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    totalMessages: json["totalMessages"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    "currentPage": currentPage,
    "totalPages": totalPages,
    "totalMessages": totalMessages,
    "status": status,
  };
}

class MessageElement {
  String? name;
  List<Message>? data;

  MessageElement({
    this.name,
    this.data,
  });

  factory MessageElement.fromJson(Map<String, dynamic> json) => MessageElement(
    name: json["name"],
    data: json["data"] == null ? [] : List<Message>.from(json["data"]!.map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Message {
  MessageData? message;
  String? id;
  String? friendsAndConversationId;
  int? senderId;
  int? recieverId;
  bool? replayMessageStatus;
  String? messageForward;
  bool? isgroup;
  bool? pollStatus;
  bool? pinStatus;
  String? messageStatus;
  List<dynamic>? messageRection;
  List<dynamic>? seenUserMessage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? fullName;
  String? username;
  String? proImg;
  String? messageType;
  bool? loading;

  Message({
    this.message,
    this.id,
    this.friendsAndConversationId,
    this.senderId,
    this.recieverId,
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
    this.messageType,
    this.loading
  });

  static String convertTime({String? messageTime}){

    try{
      tz.initializeTimeZones();

      String targetTimeZone = Get.find<SocketController>().profileController.profileData.value.result?.timeZone == 'Asia/Calcutta' ? 'Asia/Kolkata' : Get.find<SocketController>().profileController.profileData.value.result?.timeZone ?? '';
// String targetTimeZone = 'Asia/Calcutta';
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

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    message: json["message"] == null ? null : MessageData.fromJson(json["message"]),
    id: json["_id"],
    friendsAndConversationId: json["friendsAndConversationId"],
    senderId: json["sender_id"],
    recieverId: json["reciever_id"],
    replayMessageStatus: json["replay_message_status"],
    messageForward: json["message_forward"],
    isgroup: json["isgroup"],
    pollStatus: json["poll_status"],
    pinStatus: json["pin_status"],
    messageStatus: json["message_status"],
    messageRection: json["message_rection"] == null ? [] : List<dynamic>.from(json["message_rection"]!.map((x) => x)),
    seenUserMessage: json["seen_user_message"] == null ? [] : List<dynamic>.from(json["seen_user_message"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(convertTime(messageTime: json["createdAt"].toString())),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    fullName: json["full_name"],
    username: json["username"],
    proImg: json["pro_img"],
    messageType: json["messageType"],
    loading: false
  );

  Map<String, dynamic> toJson() => {
    "message": message?.toJson(),
    "_id": id,
    "friendsAndConversationId": friendsAndConversationId,
    "sender_id": senderId,
    "reciever_id": recieverId,
    "replay_message_status": replayMessageStatus,
    "message_forward": messageForward,
    "isgroup": isgroup,
    "poll_status": pollStatus,
    "pin_status": pinStatus,
    "message_status": messageStatus,
    "message_rection": messageRection == null ? [] : List<dynamic>.from(messageRection!.map((x) => x)),
    "seen_user_message": seenUserMessage == null ? [] : List<dynamic>.from(seenUserMessage!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "full_name": fullName,
    "username": username,
    "pro_img": proImg,
    "messageType": messageType,
  };
}

class MessageData {
  String? textmessage;
  String? file;

  MessageData({
    this.textmessage,
    this.file,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
    textmessage: json["textmessage"],
    file: json["file"] is List && json["file"].isNotEmpty ? json["file"].first : null,
  );

  Map<String, dynamic> toJson() => {
    "textmessage": textmessage,
    "file": file,
  };
}


