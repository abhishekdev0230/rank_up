// To parse this JSON data, do
//
//     final quizCompleteModel = quizCompleteModelFromJson(jsonString);

import 'dart:convert';

QuizCompleteModel quizCompleteModelFromJson(String str) => QuizCompleteModel.fromJson(json.decode(str));

String quizCompleteModelToJson(QuizCompleteModel data) => json.encode(data.toJson());

class QuizCompleteModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  QuizCompleteModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory QuizCompleteModel.fromJson(Map<String, dynamic> json) => QuizCompleteModel(
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
  String? quizId;
  String? quizTitle;
  DateTime? startedAt;
  DateTime? completedAt;
  int? score;
  int? totalScore;
  double? percentage;
  int? timeTaken;
  int? totalQuestions;
  int? attemptedQuestions;
  int? correctAnswers;
  int? incorrectAnswers;
  int? skippedQuestions;
  bool? isPassed;
  Answers? answers;

  Data({
    this.id,
    this.quizId,
    this.quizTitle,
    this.startedAt,
    this.completedAt,
    this.score,
    this.totalScore,
    this.percentage,
    this.timeTaken,
    this.totalQuestions,
    this.attemptedQuestions,
    this.correctAnswers,
    this.incorrectAnswers,
    this.skippedQuestions,
    this.isPassed,
    this.answers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    quizId: json["quizId"],
    quizTitle: json["quizTitle"],
    startedAt: json["startedAt"] == null ? null : DateTime.parse(json["startedAt"]),
    completedAt: json["completedAt"] == null ? null : DateTime.parse(json["completedAt"]),
    score: json["score"],
    totalScore: json["totalScore"],
    percentage: json["percentage"]?.toDouble(),
    timeTaken: json["timeTaken"],
    totalQuestions: json["totalQuestions"],
    attemptedQuestions: json["attemptedQuestions"],
    correctAnswers: json["correctAnswers"],
    incorrectAnswers: json["incorrectAnswers"],
    skippedQuestions: json["skippedQuestions"],
    isPassed: json["isPassed"],
    answers: json["answers"] == null ? null : Answers.fromJson(json["answers"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quizId": quizId,
    "quizTitle": quizTitle,
    "startedAt": startedAt?.toIso8601String(),
    "completedAt": completedAt?.toIso8601String(),
    "score": score,
    "totalScore": totalScore,
    "percentage": percentage,
    "timeTaken": timeTaken,
    "totalQuestions": totalQuestions,
    "attemptedQuestions": attemptedQuestions,
    "correctAnswers": correctAnswers,
    "incorrectAnswers": incorrectAnswers,
    "skippedQuestions": skippedQuestions,
    "isPassed": isPassed,
    "answers": answers?.toJson(),
  };
}

class Answers {
  Cmhwnvh180005Q701Xa8Zxzmo? cmhwnvh180005Q701Xa8Zxzmo;

  Answers({
    this.cmhwnvh180005Q701Xa8Zxzmo,
  });

  factory Answers.fromJson(Map<String, dynamic> json) => Answers(
    cmhwnvh180005Q701Xa8Zxzmo: json["cmhwnvh180005q701xa8zxzmo"] == null ? null : Cmhwnvh180005Q701Xa8Zxzmo.fromJson(json["cmhwnvh180005q701xa8zxzmo"]),
  );

  Map<String, dynamic> toJson() => {
    "cmhwnvh180005q701xa8zxzmo": cmhwnvh180005Q701Xa8Zxzmo?.toJson(),
  };
}

class Cmhwnvh180005Q701Xa8Zxzmo {
  bool? isCorrect;
  int? timeTaken;
  bool? isBookmarked;
  String? selectedAnswer;

  Cmhwnvh180005Q701Xa8Zxzmo({
    this.isCorrect,
    this.timeTaken,
    this.isBookmarked,
    this.selectedAnswer,
  });

  factory Cmhwnvh180005Q701Xa8Zxzmo.fromJson(Map<String, dynamic> json) => Cmhwnvh180005Q701Xa8Zxzmo(
    isCorrect: json["isCorrect"],
    timeTaken: json["timeTaken"],
    isBookmarked: json["isBookmarked"],
    selectedAnswer: json["selectedAnswer"],
  );

  Map<String, dynamic> toJson() => {
    "isCorrect": isCorrect,
    "timeTaken": timeTaken,
    "isBookmarked": isBookmarked,
    "selectedAnswer": selectedAnswer,
  };
}
