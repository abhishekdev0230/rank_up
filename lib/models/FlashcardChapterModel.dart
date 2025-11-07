// To parse this JSON data, do
//
//     final flashcardChapterModel = flashcardChapterModelFromJson(jsonString);

import 'dart:convert';

FlashcardChapterModel flashcardChapterModelFromJson(String str) => FlashcardChapterModel.fromJson(json.decode(str));

String flashcardChapterModelToJson(FlashcardChapterModel data) => json.encode(data.toJson());

class FlashcardChapterModel {
  bool? status;
  int? code;
  String? message;
  List<Datum>? data;

  FlashcardChapterModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory FlashcardChapterModel.fromJson(Map<String, dynamic> json) => FlashcardChapterModel(
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
  int? totalQuestions;
  int? totalFlashcards;

  Datum({
    this.id,
    this.name,
    this.icon,
    this.description,
    this.totalQuestions,
    this.totalFlashcards,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    description: json["description"],
    totalQuestions: json["totalQuestions"],
    totalFlashcards: json["totalFlashcards"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "description": description,
    "totalQuestions": totalQuestions,
    "totalFlashcards": totalFlashcards,
  };
}
