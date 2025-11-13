import 'dart:convert';

FetchVendorsModel fetchVendorsModelFromJson(String str) =>
    FetchVendorsModel.fromJson(json.decode(str));

String fetchVendorsModelToJson(FetchVendorsModel data) =>
    json.encode(data.toJson());

class FetchVendorsModel {
  bool? status;
  String? message;
  List<VendorDataList>? data;

  FetchVendorsModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchVendorsModel.fromJson(Map<String, dynamic> json) =>
      FetchVendorsModel(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        data: json["data"] == null
            ? []
            : List<VendorDataList>.from((json["data"] as List)
                .map((x) => VendorDataList.fromJson(x ?? {}))),
      );

  Map<String, dynamic> toJson() => {
        "status": status ?? false,
        "message": message ?? '',
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VendorDataList {
  Vendor? vendor;
  MaxOffer? maxOffer;
  int? activeOffersCount;

  VendorDataList({
    this.vendor,
    this.maxOffer,
    this.activeOffersCount,
  });

  factory VendorDataList.fromJson(Map<String, dynamic> json) => VendorDataList(
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
        maxOffer: json["maxOffer"] == null
            ? null
            : MaxOffer.fromJson(json["maxOffer"]),
        activeOffersCount: json["activeOffersCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "vendor": vendor?.toJson(),
        "maxOffer": maxOffer?.toJson(),
        "activeOffersCount": activeOffersCount ?? 0,
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
        amount: json["amount"] ?? 0,
        type: json["type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "amount": amount ?? 0,
        "type": type ?? '',
      };
}

class Vendor {
  OpeningHours? openingHours;
  String? id;
  String? state;
  String? businessName;
  String? city;
  String? area;
  int? pincode;
  Category? category;
  Subcategory? subcategory;
  String? businessRegister;
  String? address;
  double? lat;
  double? long;
  String? aadhaarFront;
  String? aadhaarBack;
  String? aadhaarVerify;
  String? panCardImage;
  String? panCardVerify;
  String? gstCertificate;
  String? gstCertificateVerify;
  String? gstNumber;
  List<String>? businessImage;
  String? businessLogo;
  DateTime? weeklyOffDay;
  User? user;
  dynamic addedBy;
  String? status;
  String? verifyStatus;
  String? country;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Vendor({
    this.openingHours,
    this.id,
    this.state,
    this.businessName,
    this.city,
    this.area,
    this.pincode,
    this.category,
    this.subcategory,
    this.businessRegister,
    this.address,
    this.lat,
    this.long,
    this.aadhaarFront,
    this.aadhaarBack,
    this.aadhaarVerify,
    this.panCardImage,
    this.panCardVerify,
    this.gstCertificate,
    this.gstCertificateVerify,
    this.gstNumber,
    this.businessImage,
    this.businessLogo,
    this.weeklyOffDay,
    this.user,
    this.addedBy,
    this.status,
    this.verifyStatus,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        id: json["_id"] ?? '',
        state: json["state"] ?? '',
        businessName: json["business_name"] ?? '',
        city: json["city"] ?? '',
        area: json["area"] ?? '',
        pincode: json["pincode"] ?? 0,
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Subcategory.fromJson(json["subcategory"]),
        businessRegister: json["business_register"] ?? '',
        address: json["address"] ?? '',
        lat: (json["lat"] is num) ? json["lat"].toDouble() : 0.0,
        long: (json["long"] is num) ? json["long"].toDouble() : 0.0,
        aadhaarFront: json["aadhaar_front"] ?? '',
        aadhaarBack: json["aadhaar_back"] ?? '',
        aadhaarVerify: json["aadhaar_verify"] ?? '',
        panCardImage: json["pan_card_image"] ?? '',
        panCardVerify: json["pan_card_verify"] ?? '',
        gstCertificate: json["gst_certificate"] ?? '',
        gstCertificateVerify: json["gst_certificate_verify"] ?? '',
        gstNumber: json["gst_number"] ?? '',
        businessImage: json["business_image"] == null
            ? []
            : List<String>.from(json["business_image"]!.map((x) => x)),
        businessLogo: json["business_logo"] ?? '',
        weeklyOffDay: json["weekly_off_day"] == null
            ? null
            : DateTime.tryParse(json["weekly_off_day"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        addedBy: json["added_by"],
        status: json["status"] ?? '',
        verifyStatus: json["Verify_status"] ?? '',
        country: json["country"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "opening_hours": openingHours?.toJson(),
        "_id": id ?? '',
        "state": state ?? '',
        "business_name": businessName ?? '',
        "city": city ?? '',
        "area": area ?? '',
        "pincode": pincode ?? 0,
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
        "business_register": businessRegister ?? '',
        "address": address ?? '',
        "lat": lat ?? 0.0,
        "long": long ?? 0.0,
        "aadhaar_front": aadhaarFront ?? '',
        "aadhaar_back": aadhaarBack ?? '',
        "aadhaar_verify": aadhaarVerify ?? '',
        "pan_card_image": panCardImage ?? '',
        "pan_card_verify": panCardVerify ?? '',
        "gst_certificate": gstCertificate ?? '',
        "gst_certificate_verify": gstCertificateVerify ?? '',
        "gst_number": gstNumber ?? '',
        "business_image": businessImage == null
            ? []
            : List<dynamic>.from(businessImage!.map((x) => x)),
        "business_logo": businessLogo ?? '',
        "weekly_off_day": weeklyOffDay?.toIso8601String(),
        "user": user?.toJson(),
        "added_by": addedBy,
        "status": status ?? '',
        "Verify_status": verifyStatus ?? '',
        "country": country ?? '',
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v ?? 0,
      };
}

class BusinessImage {
  String? url;

  BusinessImage({
    this.url,
  });

  factory BusinessImage.fromJson(Map<String, dynamic> json) => BusinessImage(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Category {
  String? id;
  String? name;
  int? categoryId;

  Category({
    this.id,
    this.name,
    this.categoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        categoryId: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "name": name ?? '',
        "id": categoryId ?? 0,
      };
}

class OpeningHours {
  Fri? mon;
  Fri? tue;
  Fri? wed;
  Fri? thu;
  Fri? fri;
  Fri? sat;
  Fri? sun;

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
        mon: json["Mon"] == null ? null : Fri.fromJson(json["Mon"]),
        tue: json["Tue"] == null ? null : Fri.fromJson(json["Tue"]),
        wed: json["Wed"] == null ? null : Fri.fromJson(json["Wed"]),
        thu: json["Thu"] == null ? null : Fri.fromJson(json["Thu"]),
        fri: json["Fri"] == null ? null : Fri.fromJson(json["Fri"]),
        sat: json["Sat"] == null ? null : Fri.fromJson(json["Sat"]),
        sun: json["Sun"] == null ? null : Fri.fromJson(json["Sun"]),
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

class Fri {
  String? open;
  String? close;
  bool? active;

  Fri({
    this.open,
    this.close,
    this.active,
  });

  factory Fri.fromJson(Map<String, dynamic> json) => Fri(
        open: json["open"] ?? '',
        close: json["close"] ?? '',
        active: json["active"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "open": open ?? '',
        "close": close ?? '',
        "active": active ?? false,
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
        id: json["_id"] ?? '',
        subcategoryId: json["subcategory_id"] ?? 0,
        name: json["name"] ?? '',
        categoryId: json["category_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "subcategory_id": subcategoryId ?? 0,
        "name": name ?? '',
        "category_id": categoryId ?? 0,
      };
}

class User {
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
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        phone: json["phone"] ?? 0,
        email: json["email"] ?? '',
        avatar: json["avatar"] ?? '',
        status: json["status"] ?? '',
        role: json["role"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.tryParse(json["updatedAt"]),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id ?? '',
        "name": name ?? '',
        "phone": phone ?? 0,
        "email": email ?? '',
        "avatar": avatar ?? '',
        "status": status ?? '',
        "role": role ?? '',
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v ?? 0,
      };
}
