// To parse this JSON data, do
//
//     final flashcardTopicsModel = flashcardTopicsModelFromJson(jsonString);

import 'dart:convert';

FlashcardTopicsModel flashcardTopicsModelFromJson(String str) => FlashcardTopicsModel.fromJson(json.decode(str));

String flashcardTopicsModelToJson(FlashcardTopicsModel data) => json.encode(data.toJson());

class FlashcardTopicsModel {
  bool? status;
  int? code;
  String? message;
  List<Datum>? data;

  FlashcardTopicsModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory FlashcardTopicsModel.fromJson(Map<String, dynamic> json) => FlashcardTopicsModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? name;
  dynamic icon;
  String? description;
  int? displayOrder;
  int? totalFlashcards;
  int? totalQuizQuestions;
  int? totalQuizzes;
  int? totalQuestions;
  bool? isFree;
  bool? isLocked;

  Datum({
    this.id,
    this.name,
    this.isFree,
    this.isLocked,
    this.icon,
    this.description,
    this.displayOrder,
    this.totalQuizzes,
    this.totalQuizQuestions,
    this.totalFlashcards,
    this.totalQuestions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    isFree: json["isFree"],
    isLocked: json["isLocked"],
    totalQuizQuestions: json["totalQuizQuestions"],
    totalQuizzes: json["totalQuizzes"],
    icon: json["icon"],
    description: json["description"],
    displayOrder: json["displayOrder"],
    totalFlashcards: json["totalFlashcards"],
    totalQuestions: json["totalQuestions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "isLocked": isLocked,
    "isFree": isFree,
    "totalQuizzes": totalQuizzes,
    "totalQuizQuestions": totalQuizQuestions,
    "icon": icon,
    "description": description,
    "displayOrder": displayOrder,
    "totalFlashcards": totalFlashcards,
    "totalQuestions": totalQuestions,
  };
}
