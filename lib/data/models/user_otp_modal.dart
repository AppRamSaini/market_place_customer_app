// To parse this JSON data, do
//
//     final userOtpModal = userOtpModalFromJson(jsonString);

import 'dart:convert';

UserOtpModal userOtpModalFromJson(String str) => UserOtpModal.fromJson(json.decode(str));

String userOtpModalToJson(UserOtpModal data) => json.encode(data.toJson());

class UserOtpModal {
  bool? status;
  String? message;
  Data? data;

  UserOtpModal({
    this.status,
    this.message,
    this.data,
  });

  factory UserOtpModal.fromJson(Map<String, dynamic> json) => UserOtpModal(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  User? user;
  String? token;
  String? role;

  Data({
    this.user,
    this.token,
    this.role,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
    "role": role,
  };
}

class User {
  String? status;
  String? id;
  String? name;
  int? phone;
  dynamic avatar;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.status,
    this.id,
    this.name,
    this.phone,
    this.avatar,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    status: json["status"],
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    avatar: json["avatar"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "name": name,
    "phone": phone,
    "avatar": avatar,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
