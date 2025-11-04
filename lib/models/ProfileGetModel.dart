// To parse this JSON data, do
//
//     final profileGetModel = profileGetModelFromJson(jsonString);

import 'dart:convert';

ProfileGetModel profileGetModelFromJson(String str) => ProfileGetModel.fromJson(json.decode(str));

String profileGetModelToJson(ProfileGetModel data) => json.encode(data.toJson());

class ProfileGetModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  ProfileGetModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ProfileGetModel.fromJson(Map<String, dynamic> json) => ProfileGetModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? dataClass;
  String? state;
  String? city;
  dynamic profilePicture;
  String? role;
  bool? isProfileComplete;
  DateTime? createdAt;

  Data({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.dataClass,
    this.state,
    this.city,
    this.profilePicture,
    this.role,
    this.isProfileComplete,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    dataClass: json["class"],
    state: json["state"],
    city: json["city"],
    profilePicture: json["profilePicture"],
    role: json["role"],
    isProfileComplete: json["isProfileComplete"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "phoneNumber": phoneNumber,
    "class": dataClass,
    "state": state,
    "city": city,
    "profilePicture": profilePicture,
    "role": role,
    "isProfileComplete": isProfileComplete,
    "createdAt": createdAt?.toIso8601String(),
  };
}
