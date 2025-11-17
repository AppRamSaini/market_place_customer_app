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
  List<PopularvendorElement>? popularvendor;
  List<Nearbyvendor>? nearbyvendor;
  List<CategoryElement>? category;

  Data({
    this.popularvendor,
    this.nearbyvendor,
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        popularvendor: json["popularvendor"] == null
            ? []
            : List<PopularvendorElement>.from(json["popularvendor"]!
                .map((x) => PopularvendorElement.fromJson(x))),
        nearbyvendor: json["nearbyvendor"] == null
            ? []
            : List<Nearbyvendor>.from(
                json["nearbyvendor"]!.map((x) => Nearbyvendor.fromJson(x))),
        category: json["category"] == null
            ? []
            : List<CategoryElement>.from(
                json["category"]!.map((x) => CategoryElement.fromJson(x))),
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

class PopularvendorVendor {
  String? id;
  String? state;
  String? businessName;
  String? city;
  String? area;
  CategoryElement? category;
  PurpleSubcategory? subcategory;
  String? address;
  double? lat;
  double? long;
  String? businessLogo;
  PurpleUser? user;

  PopularvendorVendor({
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
    this.businessLogo,
    this.user,
  });

  factory PopularvendorVendor.fromJson(Map<String, dynamic> json) =>
      PopularvendorVendor(
        id: json["_id"],
        state: json["state"],
        businessName: json["business_name"],
        city: json["city"],
        area: json["area"],
        category: json["category"] == null
            ? null
            : CategoryElement.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : PurpleSubcategory.fromJson(json["subcategory"]),
        address: json["address"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        businessLogo: json["business_logo"],
        user: json["user"] == null ? null : PurpleUser.fromJson(json["user"]),
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
        "business_logo": businessLogo,
        "user": user?.toJson(),
      };
}

class PopularvendorElement {
  PopularvendorVendor? vendor;
  MaxOffer? maxOffer;
  int? activeOffersCount;
  double? distance;

  PopularvendorElement({
    this.vendor,
    this.maxOffer,
    this.activeOffersCount,
    this.distance,
  });

  factory PopularvendorElement.fromJson(Map<String, dynamic> json) =>
      PopularvendorElement(
        vendor: json["vendor"] == null
            ? null
            : PopularvendorVendor.fromJson(json["vendor"]),
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

class CategoryElement {
  dynamic deletedAt;
  String? id;
  String? name;
  int? categoryId;
  String? image;
  List<PopularvendorElement>? vendors;

  CategoryElement({
    this.deletedAt,
    this.id,
    this.name,
    this.categoryId,
    this.image,
    this.vendors,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        deletedAt: json["deleted_at"],
        id: json["_id"],
        name: json["name"],
        categoryId: json["id"],
        image: json["image"],
        vendors: json["vendors"] == null
            ? []
            : List<PopularvendorElement>.from(
                json["vendors"]!.map((x) => PopularvendorElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "deleted_at": deletedAt,
        "_id": id,
        "name": name,
        "id": categoryId,
        "image": image,
        "vendors": vendors == null
            ? []
            : List<dynamic>.from(vendors!.map((x) => x.toJson())),
      };
}

class PurpleSubcategory {
  String? id;
  String? name;
  String? categoryId;
  dynamic deletedAt;
  int? v;

  PurpleSubcategory({
    this.id,
    this.name,
    this.categoryId,
    this.deletedAt,
    this.v,
  });

  factory PurpleSubcategory.fromJson(Map<String, dynamic> json) =>
      PurpleSubcategory(
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

class PurpleUser {
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

  PurpleUser({
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

  factory PurpleUser.fromJson(Map<String, dynamic> json) => PurpleUser(
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

class Nearbyvendor {
  NearbyvendorVendor? vendor;
  MaxOffer? maxOffer;
  int? activeOffersCount;

  Nearbyvendor({
    this.vendor,
    this.maxOffer,
    this.activeOffersCount,
  });

  factory Nearbyvendor.fromJson(Map<String, dynamic> json) => Nearbyvendor(
        vendor: json["vendor"] == null
            ? null
            : NearbyvendorVendor.fromJson(json["vendor"]),
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

class NearbyvendorVendor {
  String? id;
  String? state;
  String? businessName;
  String? city;
  String? area;
  PurpleCategory? category;
  FluffySubcategory? subcategory;
  String? address;
  double? lat;
  double? long;
  String? businessLogo;
  FluffyUser? user;
  double? distance;

  NearbyvendorVendor({
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
    this.businessLogo,
    this.user,
    this.distance,
  });

  factory NearbyvendorVendor.fromJson(Map<String, dynamic> json) =>
      NearbyvendorVendor(
        id: json["_id"],
        state: json["state"],
        businessName: json["business_name"],
        city: json["city"],
        area: json["area"],
        category: json["category"] == null
            ? null
            : PurpleCategory.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : FluffySubcategory.fromJson(json["subcategory"]),
        address: json["address"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        businessLogo: json["business_logo"],
        user: json["user"] == null ? null : FluffyUser.fromJson(json["user"]),
        distance: json["distance"]?.toDouble(),
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
        "business_logo": businessLogo,
        "user": user?.toJson(),
        "distance": distance,
      };
}

class PurpleCategory {
  String? id;
  String? name;
  int? categoryId;

  PurpleCategory({
    this.id,
    this.name,
    this.categoryId,
  });

  factory PurpleCategory.fromJson(Map<String, dynamic> json) => PurpleCategory(
        id: json["_id"],
        name: json["name"],
        categoryId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "id": categoryId,
      };
}

class FluffySubcategory {
  String? id;
  String? name;
  String? categoryId;

  FluffySubcategory({this.id, this.name, this.categoryId});

  factory FluffySubcategory.fromJson(Map<String, dynamic> json) =>
      FluffySubcategory(
          id: json["_id"], name: json["name"], categoryId: json["category_id"]);

  Map<String, dynamic> toJson() =>
      {"_id": id, "name": name, "category_id": categoryId};
}

class FluffyUser {
  String? id;
  String? name;
  int? phone;
  String? email;
  dynamic avatar;

  FluffyUser({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.avatar,
  });

  factory FluffyUser.fromJson(Map<String, dynamic> json) => FluffyUser(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "avatar": avatar,
      };
}
