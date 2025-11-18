import 'dart:convert';

UpdateMobileNumberModel updateMobileNumberModelFromJson(String str) =>
    UpdateMobileNumberModel.fromJson(json.decode(str));

String updateMobileNumberModelToJson(UpdateMobileNumberModel data) =>
    json.encode(data.toJson());

class UpdateMobileNumberModel {
  bool? status;
  String? message;
  Data? data;

  UpdateMobileNumberModel({
    this.status,
    this.message,
    this.data,
  });

  factory UpdateMobileNumberModel.fromJson(Map<String, dynamic> json) =>
      UpdateMobileNumberModel(
          status: json["status"],
          message: json["message"],
          data: json["data"] == null ? null : Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Vendordata? vendordata;

  Data({
    this.vendordata,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        vendordata: json["vendordata"] == null
            ? null
            : Vendordata.fromJson(json["vendordata"]),
      );

  Map<String, dynamic> toJson() => {
        "vendordata": vendordata?.toJson(),
      };
}

class Vendordata {
  dynamic deletedAt;
  String? id;
  String? name;
  int? phone;
  String? email;
  String? avatar;
  String? status;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Vendordata({
    this.deletedAt,
    this.id,
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Vendordata.fromJson(Map<String, dynamic> json) => Vendordata(
        deletedAt: json["deleted_at"],
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        avatar: json["avatar"],
        status: json["status"],
        role: json["role"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "deleted_at": deletedAt,
        "_id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "avatar": avatar,
        "status": status,
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
