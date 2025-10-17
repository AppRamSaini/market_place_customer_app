
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
  int? redeem;
  int? purchase;
  int? pending;

  Data({
    this.record,
    this.redeem,
    this.purchase,
    this.pending,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    record: json["record"] == null ? null : Record.fromJson(json["record"]),
    redeem: json["redeem"],
    purchase: json["purchase"],
    pending: json["pending"],
  );

  Map<String, dynamic> toJson() => {
    "record": record?.toJson(),
    "redeem": redeem,
    "purchase": purchase,
    "pending": pending,
  };
}

class Record {
  String? id;
  Vendor? vendor;
  Flat? flat;
  dynamic percentage;
  String? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Record({
    this.id,
    this.vendor,
    this.flat,
    this.percentage,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["_id"],
    vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    flat: json["flat"] == null ? null : Flat.fromJson(json["flat"]),
    percentage: json["percentage"],
    type: json["type"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "vendor": vendor?.toJson(),
    "flat": flat?.toJson(),
    "percentage": percentage,
    "type": type,
    "status": status,
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
  DateTime? expiryDate;
  String? offerImage;
  int? amount;
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
    this.expiryDate,
    this.offerImage,
    this.amount,
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
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    offerImage: json["offer_image"],
    amount: json["amount"],
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
    "expiryDate": expiryDate?.toIso8601String(),
    "offer_image": offerImage,
    "amount": amount,
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
  String? avatar;
  String? status;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? email;

  Vendor({
    this.id,
    this.name,
    this.phone,
    this.avatar,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.email,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    avatar: json["avatar"],
    status: json["status"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "avatar": avatar,
    "status": status,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "email": email,
  };
}
