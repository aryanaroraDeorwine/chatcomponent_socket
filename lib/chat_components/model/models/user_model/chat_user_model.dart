import 'dart:convert';

List<ChatUserModal> chatUserModalFromJson(String str) => List<ChatUserModal>.from(json.decode(str).map((x) => ChatUserModal.fromJson(x)));

String chatUserModalToJson(List<ChatUserModal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatUserModal {
  int? id;
  dynamic offerId;
  LastMessage? lastMessage;
  String? loadId;
  bool? isActive;
  bool? chatMute;
  WizardWidget? widget;
  Load? load;
  Carrier? shipper;
  Carrier? carrier;
  Carrier? chatUser;

  ChatUserModal({
    this.id,
    this.offerId,
    this.lastMessage,
    this.loadId,
    this.isActive,
    this.chatMute,
    this.widget,
    this.load,
    this.shipper,
    this.carrier,
    this.chatUser,
  });

  factory ChatUserModal.fromJson(Map<String, dynamic> json) => ChatUserModal(
    id: json["id"],
    offerId: json["offer_id"],
    lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
    loadId: json["load_id"],
    isActive: json["is_active"],
    chatMute: json["chat_mute"],
    widget: json["widget"] == null ? null : WizardWidget.fromJson(json["widget"]),
    load: json["load"] == null ? null : Load.fromJson(json["load"]),
    shipper: json["shipper"] == null ? null : Carrier.fromJson(json["shipper"]),
    carrier: json["carrier"] == null ? null : Carrier.fromJson(json["carrier"]),
    chatUser: json["chat_user"] == null ? null : Carrier.fromJson(json["chat_user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "offer_id": offerId,
    "last_message": lastMessage?.toJson(),
    "load_id": loadId,
    "is_active": isActive,
    "chat_mute": chatMute,
    "widget": widget?.toJson(),
    "load": load?.toJson(),
    "shipper": shipper?.toJson(),
    "carrier": carrier?.toJson(),
    "chat_user": chatUser?.toJson(),
  };
}

class Carrier {
  String? id;
  String? companyName;
  String? imageWithPath;

  Carrier({
    this.id,
    this.companyName,
    this.imageWithPath,
  });

  factory Carrier.fromJson(Map<String, dynamic> json) => Carrier(
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

class LastMessage {
  String? type;
  String? text;
  dynamic file;
  dynamic imageType;

  LastMessage({
    this.type,
    this.text,
    this.file,
    this.imageType,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    type: json["type"],
    text: json["text"],
    file: json["file"],
    imageType: json["image_type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "text": text,
    "file": file,
    "image_type": imageType,
  };
}

class Load {
  dynamic orderRefNo;

  Load({
    this.orderRefNo,
  });

  factory Load.fromJson(Map<String, dynamic> json) => Load(
    orderRefNo: json["order_ref_no"],
  );

  Map<String, dynamic> toJson() => {
    "order_ref_no": orderRefNo,
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
