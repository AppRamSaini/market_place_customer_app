// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  bool? status;
  String? message;
  Data? data;

  PaymentModel({
    this.status,
    this.message,
    this.data,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
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
  int? amount;
  int? amountDue;
  int? amountPaid;
  int? attempts;
  int? createdAt;
  String? currency;
  String? entity;
  String? id;
  Notes? notes;
  dynamic offerId;
  String? receipt;
  String? status;

  Data({
    this.amount,
    this.amountDue,
    this.amountPaid,
    this.attempts,
    this.createdAt,
    this.currency,
    this.entity,
    this.id,
    this.notes,
    this.offerId,
    this.receipt,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    amount: json["amount"],
    amountDue: json["amount_due"],
    amountPaid: json["amount_paid"],
    attempts: json["attempts"],
    createdAt: json["created_at"],
    currency: json["currency"],
    entity: json["entity"],
    id: json["id"],
    notes: json["notes"] == null ? null : Notes.fromJson(json["notes"]),
    offerId: json["offer_id"],
    receipt: json["receipt"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "amount_due": amountDue,
    "amount_paid": amountPaid,
    "attempts": attempts,
    "created_at": createdAt,
    "currency": currency,
    "entity": entity,
    "id": id,
    "notes": notes?.toJson(),
    "offer_id": offerId,
    "receipt": receipt,
    "status": status,
  };
}

class Notes {
  String? offerId;
  String? userid;
  String? vendorId;

  Notes({
    this.offerId,
    this.userid,
    this.vendorId,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    offerId: json["offer_id"],
    userid: json["userid"],
    vendorId: json["vendor_id"],
  );

  Map<String, dynamic> toJson() => {
    "offer_id": offerId,
    "userid": userid,
    "vendor_id": vendorId,
  };
}
