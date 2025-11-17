import 'dart:convert';

UpdateBillAmountModel updateBillAmountModelFromJson(String str) =>
    UpdateBillAmountModel.fromJson(json.decode(str));

String updateBillAmountModelToJson(UpdateBillAmountModel data) =>
    json.encode(data.toJson());

class UpdateBillAmountModel {
  bool? status;
  String? message;
  Data? data;

  UpdateBillAmountModel({
    this.status,
    this.message,
    this.data,
  });

  factory UpdateBillAmountModel.fromJson(Map<String, dynamic> json) =>
      UpdateBillAmountModel(
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
  String? user;
  Offer? offer;
  String? vendor;
  String? paymentId;
  int? discount;
  int? totalAmount;
  int? finalAmount;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? vendorBillStatus;
  dynamic bill;
  dynamic usedTime;

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
    this.bill,
    this.usedTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        user: json["user"],
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        vendor: json["vendor"],
        paymentId: json["payment_id"],
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
        bill: json["bill"],
        usedTime: json["used_time"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "offer": offer?.toJson(),
        "vendor": vendor,
        "payment_id": paymentId,
        "discount": discount,
        "total_amount": totalAmount,
        "final_amount": finalAmount,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "vendor_bill_status": vendorBillStatus,
        "bill": bill,
        "used_time": usedTime,
      };
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
        "percentage": percentage!.toJson(),
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
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
        offerImage: json["offer_image"],
        amount: json["amount"],
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
        "expiryDate": expiryDate?.toIso8601String(),
        "offer_image": offerImage,
        "amount": amount,
        "isExpired": isExpired,
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
  DateTime? expiryDate;
  String? offerImage;
  int? amount;
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
    this.expiryDate,
    this.offerImage,
    this.amount,
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
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
        offerImage: json["offer_image"],
        amount: json["amount"],
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
        "expiryDate": expiryDate?.toIso8601String(),
        "offer_image": offerImage,
        "amount": amount,
        "isExpired": isExpired,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
