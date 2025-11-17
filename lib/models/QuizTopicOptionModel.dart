// To parse this JSON data, do
//
//     final quizTopicOptionModel = quizTopicOptionModelFromJson(jsonString);

import 'dart:convert';

QuizTopicOptionModel quizTopicOptionModelFromJson(String str) => QuizTopicOptionModel.fromJson(json.decode(str));

String quizTopicOptionModelToJson(QuizTopicOptionModel data) => json.encode(data.toJson());

class QuizTopicOptionModel {
  bool? status;
  int? code;
  String? message;
  List<QuizTopicOptionDatum>? data;

  QuizTopicOptionModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory QuizTopicOptionModel.fromJson(Map<String, dynamic> json) => QuizTopicOptionModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? [] : List<QuizTopicOptionDatum>.from(json["data"]!.map((x) => QuizTopicOptionDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class QuizTopicOptionDatum {
  String? id;
  String? title;
  String? description;
  int? duration;
  int? totalQuestions;
  int? totalMarks;
  int? passingMarks;
  int? displayOrder;
  bool? isPremium;
  int? attemptCount;
  dynamic bestScore;
  dynamic lastAttemptDate;

  QuizTopicOptionDatum({
    this.id,
    this.title,
    this.description,
    this.duration,
    this.totalQuestions,
    this.totalMarks,
    this.passingMarks,
    this.displayOrder,
    this.isPremium,
    this.attemptCount,
    this.bestScore,
    this.lastAttemptDate,
  });

  factory QuizTopicOptionDatum.fromJson(Map<String, dynamic> json) => QuizTopicOptionDatum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    duration: json["duration"],
    totalQuestions: json["totalQuestions"],
    totalMarks: json["totalMarks"],
    passingMarks: json["passingMarks"],
    displayOrder: json["displayOrder"],
    isPremium: json["isPremium"],
    attemptCount: json["attemptCount"],
    bestScore: json["bestScore"],
    lastAttemptDate: json["lastAttemptDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "duration": duration,
    "totalQuestions": totalQuestions,
    "totalMarks": totalMarks,
    "passingMarks": passingMarks,
    "displayOrder": displayOrder,
    "isPremium": isPremium,
    "attemptCount": attemptCount,
    "bestScore": bestScore,
    "lastAttemptDate": lastAttemptDate,
  };
}
