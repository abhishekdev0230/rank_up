// To parse this JSON data:
//
//     final testResumeBottomStartTestModel = testResumeBottomStartTestModelFromJson(jsonMap);

import 'dart:convert';

// JSON Map से model बनाने वाला function
TestResumeBottomStartTestModel testResumeBottomStartTestModelFromJson(
    Map<String, dynamic> jsonMap) =>
    TestResumeBottomStartTestModel.fromJson(jsonMap);

String testResumeBottomStartTestModelToJson(
    TestResumeBottomStartTestModel data) =>
    json.encode(data.toJson());

class TestResumeBottomStartTestModel {
  bool? status;
  int? code;
  String? message;
  TestData? data;

  TestResumeBottomStartTestModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory TestResumeBottomStartTestModel.fromJson(
      Map<String, dynamic> json) =>
      TestResumeBottomStartTestModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : TestData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class TestData {
  Attempt? attempt;
  TestInfo? test;
  FirstQuestion? firstQuestion;
  int? totalQuestions;
  bool? resumed;

  TestData({
    this.attempt,
    this.test,
    this.firstQuestion,
    this.totalQuestions,
    this.resumed,
  });

  factory TestData.fromJson(Map<String, dynamic> json) => TestData(
    attempt:
    json["attempt"] == null ? null : Attempt.fromJson(json["attempt"]),
    test: json["test"] == null ? null : TestInfo.fromJson(json["test"]),
    firstQuestion: json["firstQuestion"] == null
        ? null
        : FirstQuestion.fromJson(json["firstQuestion"]),
    totalQuestions: json["totalQuestions"],
    resumed: json["resumed"],
  );

  Map<String, dynamic> toJson() => {
    "attempt": attempt?.toJson(),
    "test": test?.toJson(),
    "firstQuestion": firstQuestion?.toJson(),
    "totalQuestions": totalQuestions,
    "resumed": resumed,
  };
}

class Attempt {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  String? testId;
  DateTime? startedAt;
  dynamic completedAt;
  int? score;
  int? totalScore;
  int? percentage;
  dynamic timeTaken;
  int? totalQuestions;
  int? attemptedQuestions;
  int? correctAnswers;
  int? incorrectAnswers;
  int? skippedQuestions;
  Map<String, dynamic>? answers;
  dynamic rank;

  Attempt({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.testId,
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
    this.answers,
    this.rank,
  });

  factory Attempt.fromJson(Map<String, dynamic> json) => Attempt(
    id: json["id"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    userId: json["userId"],
    testId: json["testId"],
    startedAt: json["startedAt"] == null
        ? null
        : DateTime.parse(json["startedAt"]),
    completedAt: json["completedAt"],
    score: json["score"],
    totalScore: json["totalScore"],
    percentage: json["percentage"],
    timeTaken: json["timeTaken"],
    totalQuestions: json["totalQuestions"],
    attemptedQuestions: json["attemptedQuestions"],
    correctAnswers: json["correctAnswers"],
    incorrectAnswers: json["incorrectAnswers"],
    skippedQuestions: json["skippedQuestions"],
    answers: json["answers"] ?? {},
    rank: json["rank"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userId": userId,
    "testId": testId,
    "startedAt": startedAt?.toIso8601String(),
    "completedAt": completedAt,
    "score": score,
    "totalScore": totalScore,
    "percentage": percentage,
    "timeTaken": timeTaken,
    "totalQuestions": totalQuestions,
    "attemptedQuestions": attemptedQuestions,
    "correctAnswers": correctAnswers,
    "incorrectAnswers": incorrectAnswers,
    "skippedQuestions": skippedQuestions,
    "answers": answers ?? {},
    "rank": rank,
  };
}

class TestInfo {
  String? id;
  String? title;
  int? duration;
  int? totalQuestions;

  TestInfo({
    this.id,
    this.title,
    this.duration,
    this.totalQuestions,
  });

  factory TestInfo.fromJson(Map<String, dynamic> json) => TestInfo(
    id: json["id"],
    title: json["title"],
    duration: json["duration"],
    totalQuestions: json["totalQuestions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "duration": duration,
    "totalQuestions": totalQuestions,
  };
}

class FirstQuestion {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? questionText;
  dynamic questionImage;
  String? type;
  String? difficulty;
  String? subjectId;
  String? chapterId;
  String? topicId;
  String? correctAnswer;
  String? explanation;
  dynamic explanationImage;
  int? marks;
  int? negativeMarks;
  int? timeLimit;
  String? status;
  bool? isVerified;
  bool? isActive;
  bool? isDailyQuestion;
  int? viewCount;
  int? attemptCount;
  int? correctAttemptCount;
  List<String>? tags;
  bool? isPreviousYear;
  String? examYear;
  String? examName;
  String? icon;
  List<TestOption>? options;
  Topic? topic;

  FirstQuestion({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.questionText,
    this.questionImage,
    this.type,
    this.difficulty,
    this.subjectId,
    this.chapterId,
    this.topicId,
    this.correctAnswer,
    this.explanation,
    this.explanationImage,
    this.marks,
    this.negativeMarks,
    this.timeLimit,
    this.status,
    this.isVerified,
    this.isActive,
    this.isDailyQuestion,
    this.viewCount,
    this.attemptCount,
    this.correctAttemptCount,
    this.tags,
    this.isPreviousYear,
    this.examYear,
    this.examName,
    this.icon,
    this.options,
    this.topic,
  });

  factory FirstQuestion.fromJson(Map<String, dynamic> json) => FirstQuestion(
    id: json["id"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    questionText: json["questionText"],
    questionImage: json["questionImage"],
    type: json["type"],
    difficulty: json["difficulty"],
    subjectId: json["subjectId"],
    chapterId: json["chapterId"],
    topicId: json["topicId"],
    correctAnswer: json["correctAnswer"],
    explanation: json["explanation"],
    explanationImage: json["explanationImage"],
    marks: json["marks"],
    negativeMarks: json["negativeMarks"],
    timeLimit: json["timeLimit"],
    status: json["status"],
    isVerified: json["isVerified"],
    isActive: json["isActive"],
    isDailyQuestion: json["isDailyQuestion"],
    viewCount: json["viewCount"],
    attemptCount: json["attemptCount"],
    correctAttemptCount: json["correctAttemptCount"],
    tags: json["tags"] == null
        ? []
        : List<String>.from(json["tags"].map((x) => x)),
    isPreviousYear: json["isPreviousYear"],
    examYear: json["examYear"],
    examName: json["examName"],
    icon: json["icon"],
    options: json["options"] == null
        ? []
        : List<TestOption>.from(
        json["options"].map((x) => TestOption.fromJson(x))),
    topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "questionText": questionText,
    "questionImage": questionImage,
    "type": type,
    "difficulty": difficulty,
    "subjectId": subjectId,
    "chapterId": chapterId,
    "topicId": topicId,
    "correctAnswer": correctAnswer,
    "explanation": explanation,
    "explanationImage": explanationImage,
    "marks": marks,
    "negativeMarks": negativeMarks,
    "timeLimit": timeLimit,
    "status": status,
    "isVerified": isVerified,
    "isActive": isActive,
    "isDailyQuestion": isDailyQuestion,
    "viewCount": viewCount,
    "attemptCount": attemptCount,
    "correctAttemptCount": correctAttemptCount,
    "tags": tags ?? [],
    "isPreviousYear": isPreviousYear,
    "examYear": examYear,
    "examName": examName,
    "icon": icon,
    "options": options?.map((x) => x.toJson()).toList(),
    "topic": topic?.toJson(),
  };
}

class TestOption {
  String? id;
  String? optionText;
  dynamic optionImage;
  String? optionLabel;
  bool? isCorrect;
  int? displayOrder;
  String? questionId;

  TestOption({
    this.id,
    this.optionText,
    this.optionImage,
    this.optionLabel,
    this.isCorrect,
    this.displayOrder,
    this.questionId,
  });

  factory TestOption.fromJson(Map<String, dynamic> json) => TestOption(
    id: json["id"],
    optionText: json["optionText"],
    optionImage: json["optionImage"],
    optionLabel: json["optionLabel"],
    isCorrect: json["isCorrect"],
    displayOrder: json["displayOrder"],
    questionId: json["questionId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "optionText": optionText,
    "optionImage": optionImage,
    "optionLabel": optionLabel,
    "isCorrect": isCorrect,
    "displayOrder": displayOrder,
    "questionId": questionId,
  };
}

class Topic {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  dynamic icon;
  dynamic description;
  int? displayOrder;
  bool? isActive;
  bool? isImportant;
  String? chapterId;

  Topic({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.icon,
    this.description,
    this.displayOrder,
    this.isActive,
    this.isImportant,
    this.chapterId,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    name: json["name"],
    icon: json["icon"],
    description: json["description"],
    displayOrder: json["displayOrder"],
    isActive: json["isActive"],
    isImportant: json["isImportant"],
    chapterId: json["chapterId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "name": name,
    "icon": icon,
    "description": description,
    "displayOrder": displayOrder,
    "isActive": isActive,
    "isImportant": isImportant,
    "chapterId": chapterId,
  };
}
