// To parse this JSON data, do
//
//     final flashcardSubjectModel = flashcardSubjectModelFromJson(jsonString);

import 'dart:convert';

FlashcardSubjectModel flashcardSubjectModelFromJson(String str) => FlashcardSubjectModel.fromJson(json.decode(str));

String flashcardSubjectModelToJson(FlashcardSubjectModel data) => json.encode(data.toJson());

class FlashcardSubjectModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  FlashcardSubjectModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory FlashcardSubjectModel.fromJson(Map<String, dynamic> json) => FlashcardSubjectModel(
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
  List<Subject>? subjects;
  List<RecentlyViewed>? recentlyViewed;

  Data({
    this.subjects,
    this.recentlyViewed,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
    recentlyViewed: json["recentlyViewed"] == null ? [] : List<RecentlyViewed>.from(json["recentlyViewed"]!.map((x) => RecentlyViewed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
    "recentlyViewed": recentlyViewed == null ? [] : List<dynamic>.from(recentlyViewed!.map((x) => x.toJson())),
  };
}

class RecentlyViewed {
  String? topicId;
  String? topicName;
  String? chapterId;
  String? chapterName;
  int? totalFlashcards;
  int? totalQuestions;
  int? totalQuizzes;
  int? totalQuizQuestions;
  String? subjectId;
  String? subjectName;
  DateTime? lastViewedAt;
  int? viewCount;

  RecentlyViewed({
    this.topicId,
    this.topicName,
    this.chapterId,
    this.totalFlashcards,
    this.totalQuestions,
    this.totalQuizQuestions,
    this.totalQuizzes,
    this.chapterName,
    this.subjectId,
    this.subjectName,
    this.lastViewedAt,
    this.viewCount,
  });

  factory RecentlyViewed.fromJson(Map<String, dynamic> json) => RecentlyViewed(
    topicId: json["topicId"],
    topicName: json["topicName"],
    totalQuizzes: json["totalQuizzes"],
    totalQuizQuestions: json["totalQuizQuestions"],
    totalQuestions: json["totalQuestions"],
    totalFlashcards: json["totalFlashcards"],
    chapterId: json["chapterId"],
    chapterName: json["chapterName"],
    subjectId: json["subjectId"],
    subjectName: json["subjectName"],
    lastViewedAt: json["lastViewedAt"] == null ? null : DateTime.parse(json["lastViewedAt"]),
    viewCount: json["viewCount"],
  );

  Map<String, dynamic> toJson() => {
    "topicId": topicId,
    "topicName": topicName,
    "chapterId": chapterId,
    "chapterName": chapterName,
    "totalFlashcards": totalFlashcards,
    "totalQuestions": totalQuestions,
    "totalQuizQuestions": totalQuizQuestions,
    "totalQuizzes": totalQuizzes,
    "subjectId": subjectId,
    "subjectName": subjectName,
    "lastViewedAt": lastViewedAt?.toIso8601String(),
    "viewCount": viewCount,
  };
}

class Subject {
  String? id;
  String? name;
  String? description;
  String? icon;

  Subject({
    this.id,
    this.name,
    this.description,
    this.icon,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "icon": icon,
  };
}
