// To parse this JSON data, do
//
//     final offersDetailModel = offersDetailModelFromJson(jsonString);

import 'dart:convert';

OffersDetailModel offersDetailModelFromJson(String str) => OffersDetailModel.fromJson(json.decode(str));

String offersDetailModelToJson(OffersDetailModel data) => json.encode(data.toJson());

class OffersDetailModel {
  bool? status;
  String? message;
  Data? data;

  OffersDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory OffersDetailModel.fromJson(Map<String, dynamic> json) => OffersDetailModel(
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
  Record? record;
  bool? purchaseStatus;
  Stats? stats;
  List<dynamic>? offerBuys;

  Data({
    this.record,
    this.purchaseStatus,
    this.stats,
    this.offerBuys,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    record: json["record"] == null ? null : Record.fromJson(json["record"]),
    purchaseStatus: json["purchase_status"],
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
    offerBuys: json["offerBuys"] == null ? [] : List<dynamic>.from(json["offerBuys"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "record": record?.toJson(),
    "purchase_status": purchaseStatus,
    "stats": stats?.toJson(),
    "offerBuys": offerBuys == null ? [] : List<dynamic>.from(offerBuys!.map((x) => x)),
  };
}

class Record {
  String? id;
  Vendor? vendor;
  Flat? flat;
  Percentage? percentage;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? status;

  Record({
    this.id,
    this.vendor,
    this.flat,
    this.percentage,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.status,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["_id"],
    vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    flat:  json["flat"] == null ? null : Flat.fromJson(json["flat"]),
    percentage: json["percentage"] == null ? null : Percentage.fromJson(json["percentage"]),
    type: json["type"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "vendor": vendor?.toJson(),
    "flat": flat?.toJson(),
    "percentage": percentage?.toJson(),
    "type": type,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "status": status,
  };
}

class Percentage {
  String? id;
  String? title;
  String? description;
  int? discountPercentage;
  int? maxDiscountCap;
  int? minBillAmount;
  int? amount;
  DateTime? expiryDate;
  String? offerImage;
  String? status;
  bool? isExpired;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Percentage({
    this.id,
    this.title,
    this.description,
    this.discountPercentage,
    this.maxDiscountCap,
    this.minBillAmount,
    this.amount,
    this.expiryDate,
    this.offerImage,
    this.status,
    this.isExpired,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Percentage.fromJson(Map<String, dynamic> json) => Percentage(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    discountPercentage: json["discountPercentage"],
    maxDiscountCap: json["maxDiscountCap"],
    minBillAmount: json["minBillAmount"],
    amount: json["amount"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    offerImage: json["offer_image"],
    status: json["status"],
    isExpired: json["isExpired"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "discountPercentage": discountPercentage,
    "maxDiscountCap": maxDiscountCap,
    "minBillAmount": minBillAmount,
    "amount": amount,
    "expiryDate": expiryDate?.toIso8601String(),
    "offer_image": offerImage,
    "status": status,
    "isExpired": isExpired,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Flat {
  String? id;
  String? title;
  String? description;
  int? discountPercentage;
  int? maxDiscountCap;
  int? minBillAmount;
  int? amount;
  DateTime? expiryDate;
  String? offerImage;
  String? status;
  bool? isExpired;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Flat({
    this.id,
    this.title,
    this.description,
    this.discountPercentage,
    this.maxDiscountCap,
    this.minBillAmount,
    this.amount,
    this.expiryDate,
    this.offerImage,
    this.status,
    this.isExpired,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Flat.fromJson(Map<String, dynamic> json) => Flat(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    discountPercentage: json["discountPercentage"],
    maxDiscountCap: json["maxDiscountCap"],
    minBillAmount: json["minBillAmount"],
    amount: json["amount"],
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    offerImage: json["offer_image"],
    status: json["status"],
    isExpired: json["isExpired"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "discountPercentage": discountPercentage,
    "maxDiscountCap": maxDiscountCap,
    "minBillAmount": minBillAmount,
    "amount": amount,
    "expiryDate": expiryDate?.toIso8601String(),
    "offer_image": offerImage,
    "status": status,
    "isExpired": isExpired,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Vendor {
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

  Vendor({
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

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    avatar: json["avatar"],
    status: json["status"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
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

class Stats {
  int? total;
  int? redeemed;
  int? pending;
  int? expired;

  Stats({
    this.total,
    this.redeemed,
    this.pending,
    this.expired,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    total: json["total"],
    redeemed: json["redeemed"],
    pending: json["pending"],
    expired: json["expired"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "redeemed": redeemed,
    "pending": pending,
    "expired": expired,
  };
}
