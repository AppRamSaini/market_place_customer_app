import 'dart:convert';

PurchasedOffersHistoryModel purchasedOffersHistoryModelFromJson(String str) =>
    PurchasedOffersHistoryModel.fromJson(json.decode(str));

String purchasedOffersHistoryModelToJson(PurchasedOffersHistoryModel data) =>
    json.encode(data.toJson());

class PurchasedOffersHistoryModel {
  bool? status;
  String? message;
  Data? data;

  PurchasedOffersHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory PurchasedOffersHistoryModel.fromJson(Map<String, dynamic> json) =>
      PurchasedOffersHistoryModel(
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
  List<PurchasedCustomer>? purchasedCustomers;
  int? totalRecords;
  int? currentPage;
  int? perPage;
  int? totalPages;
  dynamic nextPage;
  dynamic previousPage;

  Data({
    this.purchasedCustomers,
    this.totalRecords,
    this.currentPage,
    this.perPage,
    this.totalPages,
    this.nextPage,
    this.previousPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        purchasedCustomers: json["purchased_customers"] == null
            ? []
            : List<PurchasedCustomer>.from(json["purchased_customers"]!
                .map((x) => PurchasedCustomer.fromJson(x))),
        totalRecords: json["total_records"],
        currentPage: json["current_page"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
      );

  Map<String, dynamic> toJson() => {
        "purchased_customers": purchasedCustomers == null
            ? []
            : List<dynamic>.from(purchasedCustomers!.map((x) => x.toJson())),
        "total_records": totalRecords,
        "current_page": currentPage,
        "per_page": perPage,
        "total_pages": totalPages,
        "nextPage": nextPage,
        "previousPage": previousPage,
      };
}

class PurchasedCustomer {
  String? id;
  UserClass? user;
  Offer? offer;
  UserClass? vendor;
  PaymentId? paymentId;
  int? discount;
  int? totalAmount;
  int? finalAmount;
  String? status;
  bool? vendorBillStatus;
  DateTime? usedTime;
  String? bill;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PurchasedCustomer({
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
    this.usedTime,
    this.bill,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PurchasedCustomer.fromJson(Map<String, dynamic> json) =>
      PurchasedCustomer(
        id: json["_id"],
        user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        vendor:
            json["vendor"] == null ? null : UserClass.fromJson(json["vendor"]),
        paymentId: json["payment_id"] == null
            ? null
            : PaymentId.fromJson(json["payment_id"]),
        discount: json["discount"],
        totalAmount: json["total_amount"],
        finalAmount: json["final_amount"],
        status: json["status"],
        vendorBillStatus: json["vendor_bill_status"],
        usedTime: json["used_time"] == null
            ? null
            : DateTime.parse(json["used_time"]),
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
        "discount": discount,
        "total_amount": totalAmount,
        "final_amount": finalAmount,
        "status": status,
        "vendor_bill_status": vendorBillStatus,
        "used_time": usedTime?.toIso8601String(),
        "bill": bill,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Offer {
  String? id;
  String? vendor;
  Flat? flat;
  Flat? percentage;
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
            : Flat.fromJson(json["percentage"]),
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

class PaymentId {
  String? id;
  String? paymentId;
  int? amount;
  String? currency;
  String? paymentStatus;
  String? paymentMethod;
  String? offerId;
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
    this.offerId,
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
        offerId: json["offer_id"],
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
        "offer_id": offerId,
        "user": user,
        "vendor_id": vendorId,
        "payment_date": paymentDate?.toIso8601String(),
        "__v": v,
      };
}

class UserClass {
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

  UserClass({
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

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
