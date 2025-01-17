

class ApiMessageListModal {
  List<MessageModel>? data;
  int? pageNumber;
  int? pageSize;
  int? totalRecordCount;
  String? sortBy;
  String? sortOrder;

  ApiMessageListModal({
    this.data,
    this.pageNumber,
    this.pageSize,
    this.totalRecordCount,
    this.sortBy,
    this.sortOrder,
  });

  factory ApiMessageListModal.fromJson(Map<String, dynamic> json) => ApiMessageListModal(
    data: json["data"] == null ? [] : List<MessageModel>.from(json["data"]!.map((x) => MessageModel.fromJson(x))),
    pageNumber: json["page_number"],
    pageSize: json["page_size"],
    totalRecordCount: json["total_record_count"],
    sortBy: json["sort_by"],
    sortOrder: json["sort_order"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "page_number": pageNumber,
    "page_size": pageSize,
    "total_record_count": totalRecordCount,
    "sort_by": sortBy,
    "sort_order": sortOrder,
  };
}

class SocketReceiveModel {
  bool? status;
  MessageModel? data;

  SocketReceiveModel({
    this.status,
    this.data,
  });

  factory SocketReceiveModel.fromJson(Map<String, dynamic> json) => SocketReceiveModel(
    status: json["status"],
    data: json["data"] == null ? null : MessageModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class MessageModel {
  int? id;
  int? chatId;
  String? userId;
  WizardWidget? widget;
  String? createdAt;
  dynamic deletedAt;
  Message? message;
  List<Message> ?multiImages;
  String? userType;
  dynamic status;
  User? user;
  String? updatedAt;

  MessageModel({
    this.id,
    this.chatId,
    this.userId,
    this.widget,
    this.createdAt,
    this.deletedAt,
    this.message,
    this.multiImages,
    this.userType,
    this.status,
    this.updatedAt,
    this.user,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json["id"],
      chatId: json["chat_id"],
      userId: json["user_id"],
      widget: json["widget"] == null ? null : WizardWidget.fromJson(json["widget"]),
      createdAt: json["created_at"],
      deletedAt: json["deleted_at"],
      message: json["message"] == null ? null : Message.fromJson(json["message"]),
      multiImages: json["multi_images"] != null ? List<Message>.from(json["multi_images"].map((x) => Message.fromJson(x))) : [],
      userType: json["user_type"],
      status: json["status"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "chat_id": chatId,
      "user_id": userId,
      "widget": widget?.toJson(),
      "created_at": createdAt,
      "deleted_at": deletedAt,
      "message": message?.toJson(),
      "multi_images": multiImages != null ? List<dynamic>.from(multiImages!.map((x) => x.toJson())) : null,
      "user_type": userType,
      "status": status,
      "user": user?.toJson(),
      "updated_at": updatedAt,
    };
  }
}

class User {
  String? id;
  String? companyName;
  dynamic imageWithPath;

  User({
    this.id,
    this.companyName,
    this.imageWithPath,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    companyName: json["company_name"],
    imageWithPath: json["image_with_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
    "image_with_path": imageWithPath,
  };
}


class WizardWidget {
  String? widget;
  String? shipper;
  String? carrier;

  WizardWidget({
    this.widget,
    this.shipper,
    this.carrier,
  });

  factory WizardWidget.fromJson(Map<String, dynamic> json) => WizardWidget(
    widget: json["widget"],
    shipper: json["shipper"],
    carrier: json["carrier"],
  );

  Map<String, dynamic> toJson() => {
    "widget": widget,
    "shipper": shipper,
    "carrier": carrier,
  };
}

class Message {
  String? id;
  String? text;
  String? messageType;
  String? file;
  String? fileType;
  String? sender;
  String? time;
  String? imageType;
  int? reaction;
  bool? isSeen;
  bool? isAdding;

  Message({
    this.id,
    this.text,
    this.messageType,
    this.file,
    this.sender,
    this.fileType,
    this.time,
    this.isSeen,
    this.reaction,
    this.imageType,
    this.isAdding
  });


  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    text: json["text"],
    messageType: json["type"],
    file:json["file"],
    sender: json["sender"],
    time: json["time"],
    isSeen: json["isSeen"],
    reaction: json["reaction"],
    imageType: json["image_type"],
    fileType: json["file_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "type": messageType,
    "file": file,
    "sender": sender,
    "time": time,
    "isSeen": isSeen,
    "reaction": reaction,
    "image_type": imageType,
    "file_type": fileType,
  };
}
