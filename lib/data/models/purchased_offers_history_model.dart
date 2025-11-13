import 'dart:convert';

PurchasedOffersHistoryModel purchasedOffersHistoryModelFromJson(String str) =>
    PurchasedOffersHistoryModel.fromJson(json.decode(str));

String purchasedOffersHistoryModelToJson(PurchasedOffersHistoryModel data) =>
    json.encode(data.toJson());

class PurchasedOffersHistoryModel {
  bool? status;
  String? message;
  List<PurchasedOffersHistoryList>? data;

  PurchasedOffersHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory PurchasedOffersHistoryModel.fromJson(Map<String, dynamic> json) =>
      PurchasedOffersHistoryModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<PurchasedOffersHistoryList>.from(json["data"]
                .map((x) => PurchasedOffersHistoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PurchasedOffersHistoryList {
  String? id;
  User? user;
  Offer? offer;
  User? vendor;
  PaymentId? paymentId;
  var discount;
  var totalAmount;
  var finalAmount;
  String? status;
  bool? vendorBillStatus;
  String? bill;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PurchasedOffersHistoryList({
    this.id,
    this.user,
    this.offer,
    this.vendor,
    this.paymentId,
    this.discount,
    this.totalAmount,
    this.finalAmount,
    this.status,
    this.vendorBillStatus,
    this.bill,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PurchasedOffersHistoryList.fromJson(Map<String, dynamic> json) =>
      PurchasedOffersHistoryList(
        id: json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        vendor: json["vendor"] == null ? null : User.fromJson(json["vendor"]),
        paymentId: json["payment_id"] == null
            ? null
            : PaymentId.fromJson(json["payment_id"]),
        discount: (json["discount"] ?? 0),
        totalAmount: (json["total_amount"] ?? 0),
        finalAmount: (json["final_amount"] ?? 0),
        status: json["status"],
        vendorBillStatus: json["vendor_bill_status"],
        bill: json["bill"],
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
        "user": user?.toJson(),
        "offer": offer?.toJson(),
        "vendor": vendor?.toJson(),
        "payment_id": paymentId?.toJson(),
        "discount": discount ?? 0.0,
        "total_amount": totalAmount ?? 0.0,
        "final_amount": finalAmount ?? 0.0,
        "status": status,
        "vendor_bill_status": vendorBillStatus,
        "bill": bill,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

extension NumParsing on num {
  double toDoubleSafely() => toDouble();
}

extension StringToDouble on String {
  double toDoubleSafely() => double.tryParse(this) ?? 0.0;
}

extension NullableToDouble on Object? {
  double toDoubleSafely() {
    if (this == null) return 0.0;
    if (this is num) return (this as num).toDouble();
    if (this is String) return double.tryParse(this as String) ?? 0.0;
    return 0.0;
  }
}

class Offer {
  String? id;
  String? vendor;
  Flat? flat;
  Percentage? percentage;
  String? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Offer({
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

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["_id"],
        vendor: json["vendor"],
        flat: json["flat"] == null ? null : Flat.fromJson(json["flat"]),
        percentage: json["percentage"] == null
            ? null
            : Percentage.fromJson(json["percentage"]),
        type: json["type"],
        status: json["status"],
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
        "vendor": vendor,
        "flat": flat?.toJson(),
        "percentage": percentage?.toJson(),
        "type": type,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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
        id: json["_id"]!,
        name: json["name"]!,
        phone: json["phone"],
        email: json["email"]!,
        avatar: json["avatar"],
        status: json["status"]!,
        role: json["role"]!,
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
