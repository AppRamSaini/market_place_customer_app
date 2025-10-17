import 'dart:convert';

GetNotificationModel getNotificationModelFromJson(String str) =>
    GetNotificationModel.fromJson(json.decode(str));

String getNotificationModelToJson(GetNotificationModel data) =>
    json.encode(data.toJson());

class GetNotificationModel {
  bool? status;
  String? message;
  GetNotificationModelData? data;

  GetNotificationModel({this.status, this.message, this.data});

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) =>
      GetNotificationModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : GetNotificationModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class GetNotificationModelData {
  int? count;
  int? unread;
  int? read;
  List<NotificationElement>? notification;

  GetNotificationModelData({this.count, this.unread, this.read, this.notification});

  factory GetNotificationModelData.fromJson(Map<String, dynamic> json) =>
      GetNotificationModelData(
        count: json["count"],
        unread: json["unread"],
        read: json["read"],
        notification: json["notification"] == null
            ? []
            : List<NotificationElement>.from(json["notification"]!
            .map((x) => NotificationElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "count": count,
    "unread": unread,
    "read": read,
    "notification": notification == null
        ? []
        : List<dynamic>.from(notification!.map((x) => x.toJson())),
  };
}

class NotificationElement {
  int? id;
  String? uuid;
  String? type;
  int? userId;
  int? fromId;
  String? sourceType;
  int? sourceId;
  String? title;
  String? content;
  dynamic firebase; // raw JSON string or parsed map
  dynamic extra;    // raw JSON string or parsed map
  DateTime? readAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  NotificationElement({
    this.id,
    this.uuid,
    this.type,
    this.userId,
    this.fromId,
    this.sourceType,
    this.sourceId,
    this.title,
    this.content,
    this.firebase,
    this.extra,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory NotificationElement.fromJson(Map<String, dynamic> json) =>
      NotificationElement(
        id: json["id"],
        uuid: json["uuid"],
        type: json["type"],
        userId: json["user_id"],
        fromId: json["from_id"],
        sourceType: json["source_type"],
        sourceId: json["source_id"],
        title: json["title"],
        content: json["content"],
        firebase: json["firebase"],
        extra: json["extra"],
        readAt:
        json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "type": type,
    "user_id": userId,
    "from_id": fromId,
    "source_type": sourceType,
    "source_id": sourceId,
    "title": title,
    "content": content,
    "firebase": firebase,
    "extra": extra,
    "read_at": readAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
