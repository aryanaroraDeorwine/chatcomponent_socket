import 'dart:convert';

import '../message_model/message_model.dart';

class ChatRoomModel {
  String? chatRoomId;
  UserDetails? userFirst;
  UserDetails? userSecond;
  String? userFirstId;
  String? userSecondId;
  Message? recentMessage;
  List<dynamic>? chatMembers;

  ChatRoomModel({
    this.chatRoomId,
    this.userFirst,
    this.userSecond,
    this.userFirstId,
    this.userSecondId,
    this.recentMessage,
    this.chatMembers,
  });


  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
    chatRoomId: json["chatroom_id"],
    userFirst: UserDetails.fromJson(json["user_first"]),
    userSecond: UserDetails.fromJson(json["user_second"]),
    userFirstId: json["user_first_id"],
    userSecondId: json["user_second_id"],
    chatMembers: json["chat_members"],
    recentMessage: Message.fromJson(json["recent_message"]??{}),
  );

  Map<String, dynamic> toJson() => {
    "chatroom_id": chatRoomId,
    "user_first": userFirst?.toJson(),
    "user_second": userSecond?.toJson(),
    "user_first_id": userFirstId,
    "user_second_id": userSecondId,
    "chat_members": chatMembers,
    "recent_message": recentMessage?.toJson(),
  };
}

class UserDetails {
  String? userId;
  String? userName;
  String? userProfile;
  String? userEmail;
  String? userToken;
  String? userSignType;
  bool? userActiveStatus;
  bool? userTypingStatus;

  UserDetails({
    this.userId,
    this.userName,
    this.userProfile,
    this.userEmail,
    this.userToken,
    this.userSignType,
    this.userActiveStatus,
    this.userTypingStatus,
  });


  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    userId: json["Id"],
    userName: json["Name"],
    userProfile: json["Profile"],
    userEmail: json["Email"],
    userToken: json["Token"],
    userSignType: json["SignType"],
    userActiveStatus: json["active_status"],
    userTypingStatus: json["typing_status"],
  );

  Map<String, dynamic> toJson() => {
    "Id": userId,
    "Name": userName,
    "Profile": userProfile,
    "Email": userEmail,
    "Token": userToken,
    "SignType": userSignType,
    "active_status": userActiveStatus,
    "typing_status": userTypingStatus,
  };
}


FileUploadModel fileUploadModelFromJson(String str) => FileUploadModel.fromJson(json.decode(str));

String fileUploadModelToJson(FileUploadModel data) => json.encode(data.toJson());

class FileUploadModel {
  String? detail;
  String? fileName;
  String? fileWithPath;

  FileUploadModel({
    this.detail,
    this.fileName,
    this.fileWithPath,
  });

  factory FileUploadModel.fromJson(Map<String, dynamic> json) => FileUploadModel(
    detail: json["detail"],
    fileName: json["file_name"],
    fileWithPath: json["file_with_path"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
    "file_name": fileName,
    "file_with_path": fileWithPath,
  };
}

