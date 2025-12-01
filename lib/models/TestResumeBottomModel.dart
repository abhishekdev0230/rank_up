// To parse this JSON data, do
//
//     final testResumeBottomModel = testResumeBottomModelFromJson(jsonString);

import 'dart:convert';

TestResumeBottomModel testResumeBottomModelFromJson(String str) => TestResumeBottomModel.fromJson(json.decode(str));

String testResumeBottomModelToJson(TestResumeBottomModel data) => json.encode(data.toJson());

class TestResumeBottomModel {
  bool? status;
  int? code;
  String? message;
  TestResumeBottom? data;

  TestResumeBottomModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory TestResumeBottomModel.fromJson(Map<String, dynamic> json) => TestResumeBottomModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : TestResumeBottom.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class TestResumeBottom {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? title;
  String? description;
  String? instructions;
  String? type;
  String? status;
  dynamic classId;
  dynamic subjectId;
  int? totalMarks;
  int? totalQuestions;
  int? duration;
  DateTime? startDate;
  dynamic endDate;
  bool? isPublished;
  bool? isFeatured;
  bool? isPremium;
  int? attemptCount;
  dynamic averageScore;
  dynamic thumbnailImage;
  dynamic icon;
  List<dynamic>? testQuestions;
  bool? isEnrolled;
  String? buttonState;

  TestResumeBottom({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.instructions,
    this.type,
    this.status,
    this.classId,
    this.subjectId,
    this.totalMarks,
    this.totalQuestions,
    this.duration,
    this.startDate,
    this.endDate,
    this.isPublished,
    this.isFeatured,
    this.isPremium,
    this.attemptCount,
    this.averageScore,
    this.thumbnailImage,
    this.icon,
    this.testQuestions,
    this.isEnrolled,
    this.buttonState,
  });

  factory TestResumeBottom.fromJson(Map<String, dynamic> json) => TestResumeBottom(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    title: json["title"],
    description: json["description"],
    instructions: json["instructions"],
    type: json["type"],
    status: json["status"],
    classId: json["classId"],
    subjectId: json["subjectId"],
    totalMarks: json["totalMarks"],
    totalQuestions: json["totalQuestions"],
    duration: json["duration"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"],
    isPublished: json["isPublished"],
    isFeatured: json["isFeatured"],
    isPremium: json["isPremium"],
    attemptCount: json["attemptCount"],
    averageScore: json["averageScore"],
    thumbnailImage: json["thumbnailImage"],
    icon: json["icon"],
    testQuestions: json["testQuestions"] == null ? [] : List<dynamic>.from(json["testQuestions"]!.map((x) => x)),
    isEnrolled: json["isEnrolled"],
    buttonState: json["buttonState"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "title": title,
    "description": description,
    "instructions": instructions,
    "type": type,
    "status": status,
    "classId": classId,
    "subjectId": subjectId,
    "totalMarks": totalMarks,
    "totalQuestions": totalQuestions,
    "duration": duration,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate,
    "isPublished": isPublished,
    "isFeatured": isFeatured,
    "isPremium": isPremium,
    "attemptCount": attemptCount,
    "averageScore": averageScore,
    "thumbnailImage": thumbnailImage,
    "icon": icon,
    "testQuestions": testQuestions == null ? [] : List<dynamic>.from(testQuestions!.map((x) => x)),
    "isEnrolled": isEnrolled,
    "buttonState": buttonState,
  };
}
