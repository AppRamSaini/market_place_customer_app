import 'dart:convert';

MerchantCategoryModel merchantCategoryModelFromJson(String str) =>
    MerchantCategoryModel.fromJson(json.decode(str));

String merchantCategoryModelToJson(MerchantCategoryModel data) =>
    json.encode(data.toJson());

class MerchantCategoryModel {
  bool? status;
  String? message;
  List<MerchantCategory>? data;

  MerchantCategoryModel({this.status, this.message, this.data});

  factory MerchantCategoryModel.fromJson(Map<String, dynamic> json) =>
      MerchantCategoryModel(
          status: json["status"],
          message: json["message"],
          data: json["data"] == null
              ? []
              : List<MerchantCategory>.from(
                  json["data"]!.map((x) => MerchantCategory.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson()))
      };
}

class MerchantCategory {
  String? id;
  String? name;
  int? datumId;

  MerchantCategory({this.id, this.name, this.datumId});

  factory MerchantCategory.fromJson(Map<String, dynamic> json) =>
      MerchantCategory(
          id: json["_id"], name: json["name"], datumId: json["id"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "id": datumId};
}
