
import 'dart:convert';

HelpSupportModel helpSupportModelFromJson(String str) => HelpSupportModel.fromJson(json.decode(str));

String helpSupportModelToJson(HelpSupportModel data) => json.encode(data.toJson());

class HelpSupportModel {
  bool? status;
  String? message;
  String? phone;
  String? email;

  HelpSupportModel({
    this.status,
    this.message,
    this.phone,
    this.email,
  });

  factory HelpSupportModel.fromJson(Map<String, dynamic> json) => HelpSupportModel(
    status: json["status"],
    message: json["message"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "phone": phone,
    "email": email,
  };
}
