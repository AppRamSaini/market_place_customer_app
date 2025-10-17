import 'dart:convert';

DashboardOffersModel dashboardOffersModelFromJson(String str) =>
    DashboardOffersModel.fromJson(json.decode(str));

String dashboardOffersModelToJson(DashboardOffersModel data) =>
    json.encode(data.toJson());

class DashboardOffersModel {
  bool? status;
  String? message;
  Data? data;

  DashboardOffersModel({
    this.status,
    this.message,
    this.data,
  });

  factory DashboardOffersModel.fromJson(Map<String, dynamic> json) =>
      DashboardOffersModel(
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
  List<NearbyvendorElement>? popularvendor;
  List<NearbyvendorElement>? nearbyvendor;
  List<VendorsCategory>? category;

  Data({
    this.popularvendor,
    this.nearbyvendor,
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        popularvendor: json["popularvendor"] == null
            ? []
            : List<NearbyvendorElement>.from(json["popularvendor"]!
                .map((x) => NearbyvendorElement.fromJson(x))),
        nearbyvendor: json["nearbyvendor"] == null
            ? []
            : List<NearbyvendorElement>.from(json["nearbyvendor"]!
                .map((x) => NearbyvendorElement.fromJson(x))),
        category: json["category"] == null
            ? []
            : List<VendorsCategory>.from(
                json["category"]!.map((x) => VendorsCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "popularvendor": popularvendor == null
            ? []
            : List<dynamic>.from(popularvendor!.map((x) => x.toJson())),
        "nearbyvendor": nearbyvendor == null
            ? []
            : List<dynamic>.from(nearbyvendor!.map((x) => x.toJson())),
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class VendorsCategory {
  String? id;
  String? name;
  int? categoryId;

  VendorsCategory({this.id, this.name, this.categoryId});

  factory VendorsCategory.fromJson(Map<String, dynamic> json) =>
      VendorsCategory(
          id: json["_id"], name: json["name"], categoryId: json["id"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "id": categoryId};
}

class NearbyvendorElement {
  VendorClass? vendor;
  MaxOffer? maxOffer;
  int? activeOffersCount;

  NearbyvendorElement({
    this.vendor,
    this.maxOffer,
    this.activeOffersCount,
  });

  factory NearbyvendorElement.fromJson(Map<String, dynamic> json) =>
      NearbyvendorElement(
        vendor: json["vendor"] == null
            ? null
            : VendorClass.fromJson(json["vendor"]),
        maxOffer: json["maxOffer"] == null
            ? null
            : MaxOffer.fromJson(json["maxOffer"]),
        activeOffersCount: json["activeOffersCount"],
      );

  Map<String, dynamic> toJson() => {
        "vendor": vendor?.toJson(),
        "maxOffer": maxOffer?.toJson(),
        "activeOffersCount": activeOffersCount,
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

class VendorClass {
  String? id;
  String? businessName;
  VendorsCategory? category;
  Subcategory? subcategory;
  String? address;
  String? businessLogo;
  User? user;

  VendorClass({
    this.id,
    this.businessName,
    this.category,
    this.subcategory,
    this.address,
    this.businessLogo,
    this.user,
  });

  factory VendorClass.fromJson(Map<String, dynamic> json) => VendorClass(
        id: json["_id"],
        businessName: json["business_name"],
        category: json["category"] == null
            ? null
            : VendorsCategory.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Subcategory.fromJson(json["subcategory"]),
        address: json["address"],
        businessLogo: json["business_logo"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "business_name": businessName,
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
        "address": address,
        "business_logo": businessLogo,
        "user": user?.toJson(),
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
