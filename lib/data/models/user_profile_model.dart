import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  bool? status;
  int? code;
  Data? data;
  String? message;

  UserProfileModel({this.status, this.code, this.data, this.message});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        status: json["status"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  String? mobileNumber;
  String? otp;
  DateTime? otpExpiredTime;
  String? role;
  String? roles;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;
  UserDetail? userDetail;

  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.mobileNumber,
    this.otp,
    this.otpExpiredTime,
    this.role,
    this.roles,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.uuid,
    this.userDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        mobileNumber: json["mobile_number"],
        otp: json["otp"],
        otpExpiredTime: json["otp_expired_time"] == null
            ? null
            : DateTime.parse(json["otp_expired_time"]),
        role: json["role"],
        roles: json["roles"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        uuid: json["uuid"],
        userDetail: json["user_detail"] == null
            ? null
            : UserDetail.fromJson(json["user_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "mobile_number": mobileNumber,
        "otp": otp,
        "otp_expired_time": otpExpiredTime?.toIso8601String(),
        "role": role,
        "roles": roles,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "uuid": uuid,
        "user_detail": userDetail?.toJson(),
      };
}

class UserDetail {
  int? id;
  int? userId;
  String? address;
  String? drivingLicenseNumber;
  String? drivingLicenseDoc;
  String? vehicleType;
  String? vehicleNumber;
  String? vehiclePhoto;
  String? aadharDoc;
  String? emergencyContact;
  String? profilePicture;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? uuid;
  String? profilePhotoUrl;
  String? drivingLicenseDocUrl;
  String? vehiclePhotoUrl;
  String? aadharDocUrl;

  UserDetail({
    this.id,
    this.userId,
    this.address,
    this.drivingLicenseNumber,
    this.drivingLicenseDoc,
    this.vehicleType,
    this.vehicleNumber,
    this.vehiclePhoto,
    this.aadharDoc,
    this.emergencyContact,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.uuid,
    this.profilePhotoUrl,
    this.drivingLicenseDocUrl,
    this.vehiclePhotoUrl,
    this.aadharDocUrl,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        userId: json["user_id"],
        address: json["address"],
        drivingLicenseNumber: json["driving_license_number"],
        drivingLicenseDoc: json["driving_license_doc"],
        vehicleType: json["vehicle_type"],
        vehicleNumber: json["vehicle_number"],
        vehiclePhoto: json["vehicle_photo"],
        aadharDoc: json["aadhar_doc"],
        emergencyContact: json["emergency_contact"],
        profilePicture: json["profile_picture"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        uuid: json["uuid"],
        profilePhotoUrl: json["profile_photo_url"],
        drivingLicenseDocUrl: json["driving_license_doc_url"],
        vehiclePhotoUrl: json["vehicle_photo_url"],
        aadharDocUrl: json["aadhar_doc_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "address": address,
        "driving_license_number": drivingLicenseNumber,
        "driving_license_doc": drivingLicenseDoc,
        "vehicle_type": vehicleType,
        "vehicle_number": vehicleNumber,
        "vehicle_photo": vehiclePhoto,
        "aadhar_doc": aadharDoc,
        "emergency_contact": emergencyContact,
        "profile_picture": profilePicture,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "uuid": uuid,
        "profile_photo_url": profilePhotoUrl,
        "driving_license_doc_url": drivingLicenseDocUrl,
        "vehicle_photo_url": vehiclePhotoUrl,
        "aadhar_doc_url": aadharDocUrl,
      };
}
