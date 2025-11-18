import 'dart:convert';

FetchAllVendorsModel fetchAllVendorsModelFromJson(String str) =>
    FetchAllVendorsModel.fromJson(json.decode(str));

String fetchAllVendorsModelToJson(FetchAllVendorsModel data) =>
    json.encode(data.toJson());

class FetchAllVendorsModel {
  bool? status;
  String? message;
  Data? data;

  FetchAllVendorsModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchAllVendorsModel.fromJson(Map<String, dynamic> json) =>
      FetchAllVendorsModel(
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
  List<VendorDataList>? data;
  int? total;
  var page;
  int? limit;
  int? totalPages;

  Data({
    this.data,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? []
            : List<VendorDataList>.from(
                json["data"]!.map((x) => VendorDataList.fromJson(x))),
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
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
      maxOffer:
          json["maxOffer"] == null ? null : MaxOffer.fromJson(json["maxOffer"]),
      activeOffersCount: json["activeOffersCount"]);

  Map<String, dynamic> toJson() => {
        "vendor": vendor?.toJson(),
        "maxOffer": maxOffer?.toJson(),
        "activeOffersCount": activeOffersCount,
      };
}

class MaxOffer {
  int? amount;
  String? type;

  MaxOffer({this.amount, this.type});

  factory MaxOffer.fromJson(Map<String, dynamic> json) =>
      MaxOffer(amount: json["amount"], type: json["type"]);

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "type": type,
      };
}

class Vendor {
  OpeningHours? openingHours;
  dynamic aadhaarReasons;
  dynamic panCardReasons;
  dynamic gstCertificateReasons;
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
  String? addedBy;
  String? assignStaff;
  String? status;
  String? verifyStatus;
  String? country;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Vendor({
    this.openingHours,
    this.aadhaarReasons,
    this.panCardReasons,
    this.gstCertificateReasons,
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
    this.assignStaff,
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
        aadhaarReasons: json["aadhaar_reasons"],
        panCardReasons: json["pan_card_reasons"],
        gstCertificateReasons: json["gst_certificate_reasons"],
        id: json["_id"],
        state: json["state"],
        businessName: json["business_name"],
        city: json["city"],
        area: json["area"],
        pincode: json["pincode"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Subcategory.fromJson(json["subcategory"]),
        businessRegister: json["business_register"],
        address: json["address"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        aadhaarFront: json["aadhaar_front"],
        aadhaarBack: json["aadhaar_back"],
        aadhaarVerify: json["aadhaar_verify"],
        panCardImage: json["pan_card_image"],
        panCardVerify: json["pan_card_verify"],
        gstCertificate: json["gst_certificate"],
        gstCertificateVerify: json["gst_certificate_verify"],
        gstNumber: json["gst_number"],
        businessImage: json["business_image"] == null
            ? []
            : List<String>.from(json["business_image"]!.map((x) => x)),
        businessLogo: json["business_logo"],
        weeklyOffDay: json["weekly_off_day"] == null
            ? null
            : DateTime.parse(json["weekly_off_day"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        addedBy: json["added_by"],
        assignStaff: json["assign_staff"],
        status: json["status"],
        verifyStatus: json["Verify_status"],
        country: json["country"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "opening_hours": openingHours?.toJson(),
        "aadhaar_reasons": aadhaarReasons,
        "pan_card_reasons": panCardReasons,
        "gst_certificate_reasons": gstCertificateReasons,
        "_id": id,
        "state": state,
        "business_name": businessName,
        "city": city,
        "area": area,
        "pincode": pincode,
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
        "business_register": businessRegister,
        "address": address,
        "lat": lat,
        "long": long,
        "aadhaar_front": aadhaarFront,
        "aadhaar_back": aadhaarBack,
        "aadhaar_verify": aadhaarVerify,
        "pan_card_image": panCardImage,
        "pan_card_verify": panCardVerify,
        "gst_certificate": gstCertificate,
        "gst_certificate_verify": gstCertificateVerify,
        "gst_number": gstNumber,
        "business_image": businessImage == null
            ? []
            : List<dynamic>.from(businessImage!.map((x) => x)),
        "business_logo": businessLogo,
        "weekly_off_day": weeklyOffDay?.toIso8601String(),
        "user": user?.toJson(),
        "added_by": addedBy,
        "assign_staff": assignStaff,
        "status": status,
        "Verify_status": verifyStatus,
        "country": country,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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

class User {
  dynamic deletedAt;
  String? id;
  String? name;
  int? phone;
  String? email;
  dynamic avatar;
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
