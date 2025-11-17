
// To parse this JSON data, do
//
//     final startQuizModel = startQuizModelFromJson(jsonString);

import 'dart:convert';

StartQuizModel startQuizModelFromJson(String str) => StartQuizModel.fromJson(json.decode(str));

String startQuizModelToJson(StartQuizModel data) => json.encode(data.toJson());

class StartQuizModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  StartQuizModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory StartQuizModel.fromJson(Map<String, dynamic> json) => StartQuizModel(
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
  String? attemptId;
  String? quizId;
  String? title;
  int? duration;
  int? totalQuestions;
  int? totalMarks;
  List<Question>? questions;

  Data({
    this.attemptId,
    this.quizId,
    this.title,
    this.duration,
    this.totalQuestions,
    this.totalMarks,
    this.questions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attemptId: json["attemptId"],
    quizId: json["quizId"],
    title: json["title"],
    duration: json["duration"],
    totalQuestions: json["totalQuestions"],
    totalMarks: json["totalMarks"],
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attemptId": attemptId,
    "quizId": quizId,
    "title": title,
    "duration": duration,
    "totalQuestions": totalQuestions,
    "totalMarks": totalMarks,
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  String? id;
  String? questionText;
  String? attemptId;
  dynamic questionImage;
  String? type;
  String? difficulty;
  int? marks;
  int? negativeMarks;
  int? displayOrder;
  List<Option>? options;

  Question({
    this.id,
    this.questionText,
    this.attemptId,
    this.questionImage,
    this.type,
    this.difficulty,
    this.marks,
    this.negativeMarks,
    this.displayOrder,
    this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    questionText: json["questionText"],
    attemptId: json["attemptId"],
    questionImage: json["questionImage"],
    type: json["type"],
    difficulty: json["difficulty"],
    marks: json["marks"],
    negativeMarks: json["negativeMarks"],
    displayOrder: json["displayOrder"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionText": questionText,
    "attemptId": attemptId,
    "questionImage": questionImage,
    "type": type,
    "difficulty": difficulty,
    "marks": marks,
    "negativeMarks": negativeMarks,
    "displayOrder": displayOrder,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

class Option {
  String? id;
  String? optionText;
  dynamic optionImage;
  String? optionLabel;
  int? displayOrder;

  Option({
    this.id,
    this.optionText,
    this.optionImage,
    this.optionLabel,
    this.displayOrder,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    optionText: json["optionText"],
    optionImage: json["optionImage"],
    optionLabel: json["optionLabel"],
    displayOrder: json["displayOrder"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "optionText": optionText,
    "optionImage": optionImage,
    "optionLabel": optionLabel,
    "displayOrder": displayOrder,
  };
}
