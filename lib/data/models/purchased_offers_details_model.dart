import 'dart:convert';

PurchasedOffersDetailModel purchasedOffersDetailModelFromJson(String str) =>
    PurchasedOffersDetailModel.fromJson(json.decode(str));

String purchasedOffersDetailModelToJson(PurchasedOffersDetailModel data) =>
    json.encode(data.toJson());

class PurchasedOffersDetailModel {
  bool? status;
  String? message;
  Data? data;

  PurchasedOffersDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory PurchasedOffersDetailModel.fromJson(Map<String, dynamic> json) =>
      PurchasedOffersDetailModel(
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
  String? id;
  User? user;
  Offer? offer;
  User? vendor;
  PaymentId? paymentId;
  var discount;
  var totalAmount;
  var finalAmount;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? vendorBillStatus;

  Data({
    this.id,
    this.user,
    this.offer,
    this.vendor,
    this.paymentId,
    this.discount,
    this.totalAmount,
    this.finalAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.vendorBillStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        vendor: json["vendor"] == null ? null : User.fromJson(json["vendor"]),
        paymentId: json["payment_id"] == null
            ? null
            : PaymentId.fromJson(json["payment_id"]),
        discount: json["discount"],
        totalAmount: json["total_amount"],
        finalAmount: json["final_amount"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        vendorBillStatus: json["vendor_bill_status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "offer": offer?.toJson(),
        "vendor": vendor?.toJson(),
        "payment_id": paymentId?.toJson(),
        "discount": discount,
        "total_amount": totalAmount,
        "final_amount": finalAmount,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "vendor_bill_status": vendorBillStatus,
      };
}

class Offer {
  String? id;
  String? vendor;
  Flat? flat;
  Percentage? percentage;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? status;

  Offer({
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

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["_id"],
        vendor: json["vendor"],
        flat: json["flat"] == null ? null : Flat.fromJson(json["flat"]),
        percentage: json["percentage"] == null
            ? null
            : Percentage.fromJson(json["percentage"]),
        type: json["type"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vendor": vendor,
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
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
        offerImage: json["offer_image"],
        status: json["status"],
        isExpired: json["isExpired"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
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
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
        offerImage: json["offer_image"],
        status: json["status"],
        isExpired: json["isExpired"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
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

class PaymentId {
  String? id;
  String? paymentId;
  int? amount;
  String? currency;
  String? paymentStatus;
  String? paymentMethod;
  String? user;
  String? vendorId;
  DateTime? paymentDate;
  int? v;

  PaymentId({
    this.id,
    this.paymentId,
    this.amount,
    this.currency,
    this.paymentStatus,
    this.paymentMethod,
    this.user,
    this.vendorId,
    this.paymentDate,
    this.v,
  });

  factory PaymentId.fromJson(Map<String, dynamic> json) => PaymentId(
        id: json["_id"],
        paymentId: json["payment_id"],
        amount: json["amount"],
        currency: json["currency"],
        paymentStatus: json["payment_status"],
        paymentMethod: json["payment_method"],
        user: json["user"],
        vendorId: json["vendor_id"],
        paymentDate: json["payment_date"] == null
            ? null
            : DateTime.parse(json["payment_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "payment_id": paymentId,
        "amount": amount,
        "currency": currency,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "user": user,
        "vendor_id": vendorId,
        "payment_date": paymentDate?.toIso8601String(),
        "__v": v,
      };
}

class User {
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
