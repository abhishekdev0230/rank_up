// To parse this JSON data, do
//
//     final testResumeBottomStartTestNextQueModel = testResumeBottomStartTestNextQueModelFromJson(jsonString);

import 'dart:convert';

TestResumeBottomStartTestNextQueModel testResumeBottomStartTestNextQueModelFromJson(String str) => TestResumeBottomStartTestNextQueModel.fromJson(json.decode(str));

String testResumeBottomStartTestNextQueModelToJson(TestResumeBottomStartTestNextQueModel data) => json.encode(data.toJson());

class TestResumeBottomStartTestNextQueModel {
  bool? status;
  int? code;
  String? message;
  NextQueData? data;

  TestResumeBottomStartTestNextQueModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory TestResumeBottomStartTestNextQueModel.fromJson(Map<String, dynamic> json) => TestResumeBottomStartTestNextQueModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : NextQueData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class NextQueData {
  String? attemptId;
  int? questionNumber;
  int? totalQuestions;
  Question? question;
  String? selectedAnswer;
  bool? isBookmarked;
  int? timeTaken;
  Navigation? navigation;

  NextQueData({
    this.attemptId,
    this.questionNumber,
    this.totalQuestions,
    this.question,
    this.selectedAnswer,
    this.isBookmarked,
    this.timeTaken,
    this.navigation,
  });

  factory NextQueData.fromJson(Map<String, dynamic> json) => NextQueData(
    attemptId: json["attemptId"],
    questionNumber: json["questionNumber"],
    totalQuestions: json["totalQuestions"],
    question: json["question"] == null ? null : Question.fromJson(json["question"]),
    selectedAnswer: json["selectedAnswer"],
    isBookmarked: json["isBookmarked"],
    timeTaken: json["timeTaken"],
    navigation: json["navigation"] == null ? null : Navigation.fromJson(json["navigation"]),
  );

  Map<String, dynamic> toJson() => {
    "attemptId": attemptId,
    "questionNumber": questionNumber,
    "totalQuestions": totalQuestions,
    "question": question?.toJson(),
    "selectedAnswer": selectedAnswer,
    "isBookmarked": isBookmarked,
    "timeTaken": timeTaken,
    "navigation": navigation?.toJson(),
  };
}

class Navigation {
  bool? hasPrev;
  bool? hasNext;

  Navigation({
    this.hasPrev,
    this.hasNext,
  });

  factory Navigation.fromJson(Map<String, dynamic> json) => Navigation(
    hasPrev: json["hasPrev"],
    hasNext: json["hasNext"],
  );

  Map<String, dynamic> toJson() => {
    "hasPrev": hasPrev,
    "hasNext": hasNext,
  };
}

class Question {
  String? id;
  String? text;
  String? image;
  String? explanation;
  Topic? topic;
  List<Option>? options;

  Question({
    this.id,
    this.text,
    this.image,
    this.explanation,
    this.topic,
    this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    text: json["text"],
    image: json["image"],
    explanation: json["explanation"],
    topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "image": image,
    "explanation": explanation,
    "topic": topic?.toJson(),
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

class Option {
  String? id;
  String? text;
  dynamic image;
  String? label;

  Option({
    this.id,
    this.text,
    this.image,
    this.label,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    text: json["text"],
    image: json["image"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "image": image,
    "label": label,
  };
}

class Topic {
  String? id;
  String? name;

  Topic({
    this.id,
    this.name,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
