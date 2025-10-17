
import 'dart:convert';

CustomerSignupModel customerSignupModelFromJson(String str) => CustomerSignupModel.fromJson(json.decode(str));

String customerSignupModelToJson(CustomerSignupModel data) => json.encode(data.toJson());

class CustomerSignupModel {
  bool? status;
  String? message;
  Data? data;

  CustomerSignupModel({
    this.status,
    this.message,
    this.data,
  });

  factory CustomerSignupModel.fromJson(Map<String, dynamic> json) => CustomerSignupModel(
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
  String? name;
  int? phone;
  String? email;
  String? avatar;
  String? status;
  String? role;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.status,
    this.role,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    avatar: json["avatar"],
    status: json["status"],
    role: json["role"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "email": email,
    "avatar": avatar,
    "status": status,
    "role": role,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
