
import 'dart:convert';

import 'package:market_place_customer/data/models/offers_detail_model.dart';

FetchOffersListModel fetchOffersListModelFromJson(String str) => FetchOffersListModel.fromJson(json.decode(str));

String fetchOffersListModelToJson(FetchOffersListModel data) => json.encode(data.toJson());

class FetchOffersListModel {
  bool? status;
  String? message;
  List<OffersList>? data;

  FetchOffersListModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchOffersListModel.fromJson(Map<String, dynamic> json) => FetchOffersListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<OffersList>.from(json["data"]!.map((x) => OffersList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OffersList {
  String? id;
  String? vendor;
  Flat? flat;
  Flat? percentage;
  String? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  OffersList({
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

  factory OffersList.fromJson(Map<String, dynamic> json) => OffersList(
    id: json["_id"],
    vendor: json["vendor"],
    flat: json["flat"] == null ? null : Flat.fromJson(json["flat"]),
    percentage: json["percentage"] == null ? null : Flat.fromJson(json["percentage"]),
    type: json["type"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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

// class Flat {
//   String? id;
//   String? title;
//   String? description;
//   int? discountPercentage;
//   int? maxDiscountCap;
//   int? minBillAmount;
//   DateTime? expiryDate;
//   String? offerImage;
//   int? amount;
//   bool? isExpired;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//
//   Flat({
//     this.id,
//     this.title,
//     this.description,
//     this.discountPercentage,
//     this.maxDiscountCap,
//     this.minBillAmount,
//     this.expiryDate,
//     this.offerImage,
//     this.amount,
//     this.isExpired,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory Flat.fromJson(Map<String, dynamic> json) => Flat(
//     id: json["_id"],
//     title: json["title"],
//     description: json["description"],
//     discountPercentage: json["discountPercentage"],
//     maxDiscountCap: json["maxDiscountCap"],
//     minBillAmount: json["minBillAmount"],
//     expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
//     offerImage: json["offer_image"],
//     amount: json["amount"],
//     isExpired: json["isExpired"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "title": title,
//     "description": description,
//     "discountPercentage": discountPercentage,
//     "maxDiscountCap": maxDiscountCap,
//     "minBillAmount": minBillAmount,
//     "expiryDate": expiryDate?.toIso8601String(),
//     "offer_image": offerImage,
//     "amount": amount,
//     "isExpired": isExpired,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//   };
// }
