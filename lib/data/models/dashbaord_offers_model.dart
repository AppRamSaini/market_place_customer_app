
  import 'dart:convert';

  DashboardOffersModel dashboardOffersModelFromJson(String str) => DashboardOffersModel.fromJson(json.decode(str));

  String dashboardOffersModelToJson(DashboardOffersModel data) => json.encode(data.toJson());

  class DashboardOffersModel {
  bool? status;
  String? message;
  Data? data;

  DashboardOffersModel({
  this.status,
  this.message,
  this.data,
  });

  factory DashboardOffersModel.fromJson(Map<String, dynamic> json) => DashboardOffersModel(
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
    List<PopularVendorElement>? popularvendor;
    List<NearbyvendorElement>? nearbyvendor;
    List<VendorsCategory>? category;

  Data({
  this.popularvendor,
  this.nearbyvendor,
  this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  popularvendor: json["popularvendor"] == null ? [] : List<PopularVendorElement>.from(json["popularvendor"]!.map((x) => PopularVendorElement.fromJson(x))),
  nearbyvendor: json["nearbyvendor"] == null ? [] : List<NearbyvendorElement>.from(json["nearbyvendor"]!.map((x) => NearbyvendorElement.fromJson(x))),
  category: json["category"] == null ? [] : List<VendorsCategory>.from(json["category"]!.map((x) => VendorsCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
  "popularvendor": popularvendor == null ? [] : List<dynamic>.from(popularvendor!.map((x) => x.toJson())),
  "nearbyvendor": nearbyvendor == null ? [] : List<dynamic>.from(nearbyvendor!.map((x) => x.toJson())),
  "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x.toJson())),
  };
  }

  class VendorsCategory {
  String? id;
  String? name;
  int? categoryId;
  String? image;

  VendorsCategory({
  this.id,
  this.name,
  this.categoryId,
  this.image,
  });

  factory VendorsCategory.fromJson(Map<String, dynamic> json) => VendorsCategory(
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

  class NearbyvendorElement {
  NearbyvendorVendor? vendor;
  MaxOffer? maxOffer;
  int? activeOffersCount;

  NearbyvendorElement({
  this.vendor,
  this.maxOffer,
  this.activeOffersCount,
  });

  factory NearbyvendorElement.fromJson(Map<String, dynamic> json) => NearbyvendorElement(
  vendor: json["vendor"] == null ? null : NearbyvendorVendor.fromJson(json["vendor"]),
  maxOffer: json["maxOffer"] == null ? null : MaxOffer.fromJson(json["maxOffer"]),
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

  class NearbyvendorVendor {
  String? id;
  String? state;
  String? businessName;
  String? city;
  String? area;
  VendorsCategory? category;
  Subcategory? subcategory;
  String? address;
  double? lat;
  double? long;
  String? businessLogo;
  PurpleUser? user;
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

  factory NearbyvendorVendor.fromJson(Map<String, dynamic> json) => NearbyvendorVendor(
  id: json["_id"],
  state: json["state"],
  businessName: json["business_name"],
  city: json["city"],
  area: json["area"],
  category: json["category"] == null ? null : VendorsCategory.fromJson(json["category"]),
  subcategory: json["subcategory"] == null ? null : Subcategory.fromJson(json["subcategory"]),
  address: json["address"],
  lat: json["lat"]?.toDouble(),
  long: json["long"]?.toDouble(),
  businessLogo: json["business_logo"],
  user: json["user"] == null ? null : PurpleUser.fromJson(json["user"]),
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

  class PurpleUser {
  String? id;
  String? name;
  int? phone;
  String? email;
  String? avatar;

  PurpleUser({
  this.id,
  this.name,
  this.phone,
  this.email,
  this.avatar,
  });

  factory PurpleUser.fromJson(Map<String, dynamic> json) => PurpleUser(
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

  class PopularVendorElement {
  PopularvendorVendor? vendor;
  MaxOffer? maxOffer;
  int? activeOffersCount;
  double? distance;

  PopularVendorElement({
  this.vendor,
  this.maxOffer,
  this.activeOffersCount,
  this.distance,
  });

  factory PopularVendorElement.fromJson(Map<String, dynamic> json) => PopularVendorElement(
  vendor: json["vendor"] == null ? null : PopularvendorVendor.fromJson(json["vendor"]),
  maxOffer: json["maxOffer"] == null ? null : MaxOffer.fromJson(json["maxOffer"]),
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

  class PopularvendorVendor {
  String? id;
  String? state;
  String? businessName;
  String? city;
  String? area;
  VendorsCategory? category;
  Subcategory? subcategory;
  String? address;
  double? lat;
  double? long;
  String? businessLogo;
  FluffyUser? user;

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

  factory PopularvendorVendor.fromJson(Map<String, dynamic> json) => PopularvendorVendor(
  id: json["_id"],
  state: json["state"],
  businessName: json["business_name"],
  city: json["city"],
  area: json["area"],
  category: json["category"] == null ? null : VendorsCategory.fromJson(json["category"]),
  subcategory: json["subcategory"] == null ? null : Subcategory.fromJson(json["subcategory"]),
  address: json["address"],
  lat: json["lat"]?.toDouble(),
  long: json["long"]?.toDouble(),
  businessLogo: json["business_logo"],
  user: json["user"] == null ? null : FluffyUser.fromJson(json["user"]),
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

  class FluffyUser {
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

  FluffyUser({
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

  factory FluffyUser.fromJson(Map<String, dynamic> json) => FluffyUser(
  id: json["_id"],
  name: json["name"],
  phone: json["phone"],
  email: json["email"],
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
  "email": email,
  "avatar": avatar,
  "status": status,
  "role": role,
  "createdAt": createdAt?.toIso8601String(),
  "updatedAt": updatedAt?.toIso8601String(),
  "__v": v,
  };
  }
