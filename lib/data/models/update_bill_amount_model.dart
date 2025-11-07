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
  String? offer;
  String? vendor;
  String? paymentId;
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
        user: json["user"],
        offer: json["offer"],
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
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "offer": offer,
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
      };
}
