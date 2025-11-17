// To parse this JSON data, do
//
//     final reviewAnswerModel = reviewAnswerModelFromJson(jsonString);

import 'dart:convert';

ReviewAnswerModel reviewAnswerModelFromJson(String str) => ReviewAnswerModel.fromJson(json.decode(str));

String reviewAnswerModelToJson(ReviewAnswerModel data) => json.encode(data.toJson());

class ReviewAnswerModel {
  bool? status;
  int? code;
  String? message;
  List<Datum>? data;

  ReviewAnswerModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ReviewAnswerModel.fromJson(Map<String, dynamic> json) => ReviewAnswerModel(
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
  String? questionText;
  dynamic questionImage;
  String? type;
  String? difficulty;
  int? marks;
  int? negativeMarks;
  int? displayOrder;
  String? correctAnswer;
  String? selectedAnswer;
  bool? isCorrect;
  String? explanation;
  dynamic explanationImage;
  bool? isBookmarked;
  int? timeTaken;
  Subject? subject;
  Subject? topic;
  List<Option>? options;

  Datum({
    this.id,
    this.questionText,
    this.questionImage,
    this.type,
    this.difficulty,
    this.marks,
    this.negativeMarks,
    this.displayOrder,
    this.correctAnswer,
    this.selectedAnswer,
    this.isCorrect,
    this.explanation,
    this.explanationImage,
    this.isBookmarked,
    this.timeTaken,
    this.subject,
    this.topic,
    this.options,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    questionText: json["questionText"],
    questionImage: json["questionImage"],
    type: json["type"],
    difficulty: json["difficulty"],
    marks: json["marks"],
    negativeMarks: json["negativeMarks"],
    displayOrder: json["displayOrder"],
    correctAnswer: json["correctAnswer"],
    selectedAnswer: json["selectedAnswer"],
    isCorrect: json["isCorrect"],
    explanation: json["explanation"],
    explanationImage: json["explanationImage"],
    isBookmarked: json["isBookmarked"],
    timeTaken: json["timeTaken"],
    subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
    topic: json["topic"] == null ? null : Subject.fromJson(json["topic"]),
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionText": questionText,
    "questionImage": questionImage,
    "type": type,
    "difficulty": difficulty,
    "marks": marks,
    "negativeMarks": negativeMarks,
    "displayOrder": displayOrder,
    "correctAnswer": correctAnswer,
    "selectedAnswer": selectedAnswer,
    "isCorrect": isCorrect,
    "explanation": explanation,
    "explanationImage": explanationImage,
    "isBookmarked": isBookmarked,
    "timeTaken": timeTaken,
    "subject": subject?.toJson(),
    "topic": topic?.toJson(),
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

class Subject {
  String? id;
  String? name;

  Subject({
    this.id,
    this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
