
import 'dart:convert';

MerchantProfileModel merchantProfileModelFromJson(String str) => MerchantProfileModel.fromJson(json.decode(str));

String merchantProfileModelToJson(MerchantProfileModel data) => json.encode(data.toJson());

class MerchantProfileModel {
  bool? status;
  String? message;
  Data? data;

  MerchantProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory MerchantProfileModel.fromJson(Map<String, dynamic> json) => MerchantProfileModel(
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
  String? businessName;
  String? city;
  String? area;
  int? pincode;
  String? category;
  String? subcategory;
  bool? panCard;
  dynamic gstNo;
  String? address;
  double? lat;
  double? long;
  dynamic landmark;
  dynamic adharFront;
  dynamic adharBack;
  dynamic panCardImage;
  dynamic gstCertificate;
  dynamic shopLicense;
  dynamic businessLogo;
  dynamic openingHours;
  dynamic weeklyOffDay;
  Vendor? vendor;
  String? status;
  String? verifyStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.businessName,
    this.city,
    this.area,
    this.pincode,
    this.category,
    this.subcategory,
    this.panCard,
    this.gstNo,
    this.address,
    this.lat,
    this.long,
    this.landmark,
    this.adharFront,
    this.adharBack,
    this.panCardImage,
    this.gstCertificate,
    this.shopLicense,
    this.businessLogo,
    this.openingHours,
    this.weeklyOffDay,
    this.vendor,
    this.status,
    this.verifyStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    businessName: json["business_name"],
    city: json["city"],
    area: json["area"],
    pincode: json["pincode"],
    category: json["category"],
    subcategory: json["subcategory"],
    panCard: json["pan_card"],
    gstNo: json["GST_no"],
    address: json["address"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    landmark: json["landmark"],
    adharFront: json["adhar_front"],
    adharBack: json["adhar_back"],
    panCardImage: json["pan_card_image"],
    gstCertificate: json["gst_certificate"],
    shopLicense: json["shop_license"],
    businessLogo: json["business_logo"],
    openingHours: json["opening_hours"],
    weeklyOffDay: json["weekly_off_day"],
    vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    status: json["status"],
    verifyStatus: json["Verify_status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "business_name": businessName,
    "city": city,
    "area": area,
    "pincode": pincode,
    "category": category,
    "subcategory": subcategory,
    "pan_card": panCard,
    "GST_no": gstNo,
    "address": address,
    "lat": lat,
    "long": long,
    "landmark": landmark,
    "adhar_front": adharFront,
    "adhar_back": adharBack,
    "pan_card_image": panCardImage,
    "gst_certificate": gstCertificate,
    "shop_license": shopLicense,
    "business_logo": businessLogo,
    "opening_hours": openingHours,
    "weekly_off_day": weeklyOffDay,
    "vendor": vendor?.toJson(),
    "status": status,
    "Verify_status": verifyStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Vendor {
  String? id;
  String? name;
  int? phone;
  String? avatar;
  String? status;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Vendor({
    this.id,
    this.name,
    this.phone,
    this.avatar,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    avatar: json["avatar"],
    status: json["status"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "avatar": avatar,
    "status": status,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
