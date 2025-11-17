// To parse this JSON data, do
//
//     final vendorsDetailsModel = vendorsDetailsModelFromJson(jsonString);

import 'dart:convert';

VendorsDetailsModel vendorsDetailsModelFromJson(String str) =>
    VendorsDetailsModel.fromJson(json.decode(str));

String vendorsDetailsModelToJson(VendorsDetailsModel data) =>
    json.encode(data.toJson());

class VendorsDetailsModel {
  bool? status;
  String? message;
  Data? data;

  VendorsDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory VendorsDetailsModel.fromJson(Map<String, dynamic> json) =>
      VendorsDetailsModel(
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
  BusinessDetails? businessDetails;
  Timing? timing;
  Sales? vendor;
  List<Offer>? offers;
  List<Similar>? similar;
  Sales? sales;
  String? status;
  String? verifyStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  Percentages? percentages;

  Data({
    this.id,
    this.businessDetails,
    this.timing,
    this.vendor,
    this.offers,
    this.similar,
    this.sales,
    this.status,
    this.verifyStatus,
    this.createdAt,
    this.updatedAt,
    this.percentages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        businessDetails: json["business_details"] == null
            ? null
            : BusinessDetails.fromJson(json["business_details"]),
        timing: json["timing"] == null ? null : Timing.fromJson(json["timing"]),
        vendor: json["vendor"] == null ? null : Sales.fromJson(json["vendor"]),
        offers: json["offers"] == null
            ? []
            : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
        similar: json["similar"] == null
            ? []
            : List<Similar>.from(
                json["similar"]!.map((x) => Similar.fromJson(x))),
        sales: json["sales"] == null ? null : Sales.fromJson(json["sales"]),
        status: json["status"],
        verifyStatus: json["Verify_status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        percentages: json["percentages"] == null
            ? null
            : Percentages.fromJson(json["percentages"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "business_details": businessDetails?.toJson(),
        "timing": timing?.toJson(),
        "vendor": vendor?.toJson(),
        "offers": offers == null
            ? []
            : List<dynamic>.from(offers!.map((x) => x.toJson())),
        "similar": similar == null
            ? []
            : List<dynamic>.from(similar!.map((x) => x.toJson())),
        "sales": sales?.toJson(),
        "status": status,
        "Verify_status": verifyStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "percentages": percentages?.toJson(),
      };
}

class BusinessDetails {
  String? businessName;
  String? businessLogo;
  Category? category;
  Subcategory? subcategory;
  String? businessRegister;
  String? gstNumber;
  String? address;
  String? city;
  String? area;
  int? pincode;
  double? lat;
  double? long;
  List<String>? businessImage;
  String? state;
  String? country;

  BusinessDetails({
    this.businessName,
    this.businessLogo,
    this.category,
    this.subcategory,
    this.businessRegister,
    this.gstNumber,
    this.address,
    this.city,
    this.area,
    this.pincode,
    this.lat,
    this.long,
    this.businessImage,
    this.state,
    this.country,
  });

  factory BusinessDetails.fromJson(Map<String, dynamic> json) =>
      BusinessDetails(
        businessName: json["business_name"],
        businessLogo: json["business_logo"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Subcategory.fromJson(json["subcategory"]),
        businessRegister: json["business_register"],
        gstNumber: json["gst_number"],
        address: json["address"],
        city: json["city"],
        area: json["area"],
        pincode: json["pincode"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        businessImage: json["business_image"] == null
            ? []
            : List<String>.from(json["business_image"]!.map((x) => x)),
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "business_name": businessName,
        "business_logo": businessLogo,
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
        "business_register": businessRegister,
        "gst_number": gstNumber,
        "address": address,
        "city": city,
        "area": area,
        "pincode": pincode,
        "lat": lat,
        "long": long,
        "business_image": businessImage == null
            ? []
            : List<dynamic>.from(businessImage!.map((x) => x)),
        "state": state,
        "country": country,
      };
}

class Category {
  dynamic deletedAt;
  String? id;
  String? name;
  int? categoryId;
  String? image;

  Category({
    this.deletedAt,
    this.id,
    this.name,
    this.categoryId,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        deletedAt: json["deleted_at"],
        id: json["_id"],
        name: json["name"],
        categoryId: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "deleted_at": deletedAt,
        "_id": id,
        "name": name,
        "id": categoryId,
        "image": image,
      };
}

class Subcategory {
  String? id;
  String? name;
  String? categoryId;
  dynamic deletedAt;
  int? v;

  Subcategory({
    this.id,
    this.name,
    this.categoryId,
    this.deletedAt,
    this.v,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["_id"],
        name: json["name"],
        categoryId: json["category_id"],
        deletedAt: json["deleted_at"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category_id": categoryId,
        "deleted_at": deletedAt,
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
  bool? purchaseStatus;

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
    this.purchaseStatus,
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
        purchaseStatus: json["purchase_status"],
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
        "purchase_status": purchaseStatus,
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

class Percentages {
  int? document;
  int? businessDetails;
  int? timing;
  int? vendorSales;

  Percentages({
    this.document,
    this.businessDetails,
    this.timing,
    this.vendorSales,
  });

  factory Percentages.fromJson(Map<String, dynamic> json) => Percentages(
        document: json["document"],
        businessDetails: json["business_details"],
        timing: json["timing"],
        vendorSales: json["vendor_sales"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
        "business_details": businessDetails,
        "timing": timing,
        "vendor_sales": vendorSales,
      };
}

class Sales {
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
  String? password;

  Sales({
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
    this.password,
  });

  factory Sales.fromJson(Map<String, dynamic> json) => Sales(
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
        password: json["password"],
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
        "password": password,
      };
}

class Similar {
  Vendor? vendor;
  MaxOffer? maxOffer;
  int? activeOffersCount;
  double? distance;

  Similar({
    this.vendor,
    this.maxOffer,
    this.activeOffersCount,
    this.distance,
  });

  factory Similar.fromJson(Map<String, dynamic> json) => Similar(
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
        maxOffer: json["maxOffer"] == null
            ? null
            : MaxOffer.fromJson(json["maxOffer"]),
        activeOffersCount: json["activeOffersCount"],
        distance: json["distance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "vendor": vendor?.toJson(),
        "maxOffer": maxOffer?.toJson(),
        "activeOffersCount": activeOffersCount,
        "distance": distance,
      };
}

class MaxOffer {
  int? amount;
  String? type;

  MaxOffer({
    this.amount,
    this.type,
  });

  factory MaxOffer.fromJson(Map<String, dynamic> json) => MaxOffer(
        amount: json["amount"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "type": type,
      };
}

class Vendor {
  String? id;
  String? state;
  String? businessName;
  String? city;
  String? area;
  Category? category;
  Subcategory? subcategory;
  String? address;
  double? lat;
  double? long;
  List<String>? businessImage;
  String? businessLogo;
  Sales? user;

  Vendor({
    this.id,
    this.state,
    this.businessName,
    this.city,
    this.area,
    this.category,
    this.subcategory,
    this.address,
    this.lat,
    this.long,
    this.businessImage,
    this.businessLogo,
    this.user,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        id: json["_id"],
        state: json["state"],
        businessName: json["business_name"],
        city: json["city"],
        area: json["area"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Subcategory.fromJson(json["subcategory"]),
        address: json["address"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        businessImage: json["business_image"] == null
            ? []
            : List<String>.from(json["business_image"]!.map((x) => x)),
        businessLogo: json["business_logo"],
        user: json["user"] == null ? null : Sales.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "state": state,
        "business_name": businessName,
        "city": city,
        "area": area,
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
        "address": address,
        "lat": lat,
        "long": long,
        "business_image": businessImage == null
            ? []
            : List<dynamic>.from(businessImage!.map((x) => x)),
        "business_logo": businessLogo,
        "user": user?.toJson(),
      };
}

class Timing {
  OpeningHours? openingHours;
  dynamic weeklyOffDay;

  Timing({
    this.openingHours,
    this.weeklyOffDay,
  });

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        weeklyOffDay: json["weekly_off_day"],
      );

  Map<String, dynamic> toJson() => {
        "opening_hours": openingHours?.toJson(),
        "weekly_off_day": weeklyOffDay,
      };
}

class OpeningHours {
  DayHour? mon;
  DayHour? tue;
  DayHour? wed;
  DayHour? thu;
  DayHour? fri;
  DayHour? sat;
  DayHour? sun;

  OpeningHours({
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
    this.sun,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        mon: json["Mon"] == null ? null : DayHour.fromJson(json["Mon"]),
        tue: json["Tue"] == null ? null : DayHour.fromJson(json["Tue"]),
        wed: json["Wed"] == null ? null : DayHour.fromJson(json["Wed"]),
        thu: json["Thu"] == null ? null : DayHour.fromJson(json["Thu"]),
        fri: json["Fri"] == null ? null : DayHour.fromJson(json["Fri"]),
        sat: json["Sat"] == null ? null : DayHour.fromJson(json["Sat"]),
        sun: json["Sun"] == null ? null : DayHour.fromJson(json["Sun"]),
      );

  Map<String, dynamic> toJson() => {
        "Mon": mon?.toJson(),
        "Tue": tue?.toJson(),
        "Wed": wed?.toJson(),
        "Thu": thu?.toJson(),
        "Fri": fri?.toJson(),
        "Sat": sat?.toJson(),
        "Sun": sun?.toJson(),
      };
}

class DayHour {
  String? open;
  String? close;
  bool? active;

  DayHour({
    this.open,
    this.close,
    this.active,
  });

  factory DayHour.fromJson(Map<String, dynamic> json) => DayHour(
        open: json["open"],
        close: json["close"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "open": open,
        "close": close,
        "active": active,
      };
}
