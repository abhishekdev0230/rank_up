// To parse this JSON data, do
//
//     final quizAnsModel = quizAnsModelFromJson(jsonString);

import 'dart:convert';

QuizAnsModel quizAnsModelFromJson(String str) => QuizAnsModel.fromJson(json.decode(str));

String quizAnsModelToJson(QuizAnsModel data) => json.encode(data.toJson());

class QuizAnsModel {
  bool? status;
  int? code;
  Data? data;

  QuizAnsModel({
    this.status,
    this.code,
    this.data,
  });

  factory QuizAnsModel.fromJson(Map<String, dynamic> json) => QuizAnsModel(
    status: json["status"],
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data?.toJson(),
  };
}

class Data {
  String? questionId;
  String? selectedAnswer;
  String? correctAnswer;
  String? explanation;
  bool? isCorrect;

  Data({
    this.questionId,
    this.selectedAnswer,
    this.correctAnswer,
    this.explanation,
    this.isCorrect,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    questionId: json["questionId"],
    selectedAnswer: json["selectedAnswer"],
    correctAnswer: json["correctAnswer"],
    explanation: json["explanation"],
    isCorrect: json["isCorrect"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "selectedAnswer": selectedAnswer,
    "correctAnswer": correctAnswer,
    "explanation": explanation,
    "isCorrect": isCorrect,
  };
}
