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
  UserClass? vendor;
  List<Offer>? offers;
  List<Similar>? similar;
  dynamic sales;
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
        vendor:
            json["vendor"] == null ? null : UserClass.fromJson(json["vendor"]),
        offers: json["offers"] == null
            ? []
            : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
        similar: json["similar"] == null
            ? []
            : List<Similar>.from(
                json["similar"]!.map((x) => Similar.fromJson(x))),
        sales: json["sales"],
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
        "sales": sales,
        "status": status,
        "Verify_status": verifyStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "percentages": percentages?.toJson(),
      };
}

class BusinessDetails {
  String? businessName;
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
  String? id;
  String? name;
  int? categoryId;
  String? image;

  Category({
    this.id,
    this.name,
    this.categoryId,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        categoryId: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "id": categoryId,
        "image": image,
      };
}

class Subcategory {
  String? id;
  int? subcategoryId;
  String? name;
  int? categoryId;

  Subcategory({
    this.id,
    this.subcategoryId,
    this.name,
    this.categoryId,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["_id"],
        subcategoryId: json["subcategory_id"],
        name: json["name"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subcategory_id": subcategoryId,
        "name": name,
        "category_id": categoryId,
      };
}

class Offer {
  String? id;
  String? vendor;
  Flat? flat;
  Flat? percentage;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? status;
  bool? purchaseStatus;

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
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        status: json["status"],
        purchaseStatus: json["purchase_status"],
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
  String? status;
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
    this.status,
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
        status: json["status"],
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
        "status": status,
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

class Similar {
  SimilarVendor? vendor;
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
        vendor: json["vendor"] == null
            ? null
            : SimilarVendor.fromJson(json["vendor"]),
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

class SimilarVendor {
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
  UserClass? user;

  SimilarVendor({
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

  factory SimilarVendor.fromJson(Map<String, dynamic> json) => SimilarVendor(
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
        user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
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

class UserClass {
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

class Timing {
  OpeningHours? openingHours;
  DateTime? weeklyOffDay;

  Timing({
    this.openingHours,
    this.weeklyOffDay,
  });

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        weeklyOffDay: json["weekly_off_day"] == null
            ? null
            : DateTime.parse(json["weekly_off_day"]),
      );

  Map<String, dynamic> toJson() => {
        "opening_hours": openingHours?.toJson(),
        "weekly_off_day": weeklyOffDay?.toIso8601String(),
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
        mon: _parse(json["Mon"]),
        tue: _parse(json["Tue"]),
        wed: _parse(json["Wed"]),
        thu: _parse(json["Thu"]),
        fri: _parse(json["Fri"]),
        sat: _parse(json["Sat"]),
        sun: _parse(json["Sun"]),
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

  /// SAFE PARSER (FINAL)
  static DayHour? _parse(dynamic data) {
    if (data == null) return null;

    // If backend gives: "Instance of OpeningHour"
    if (data.toString().contains("Instance of")) {
      return null; // invalid → ignore safely
    }

    if (data is Map<String, dynamic>) {
      return DayHour.fromJson(data);
    }

    return null;
  }
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
        open: json["open"]?.toString(),
        close: json["close"]?.toString(),
        active: json["active"] == true,
      );

  Map<String, dynamic> toJson() => {
        "open": open,
        "close": close,
        "active": active,
      };
}
