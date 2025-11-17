// To parse this JSON data, do
//
//     final flashcardsQuestionsCompletionModel = flashcardsQuestionsCompletionModelFromJson(jsonString);

import 'dart:convert';

FlashcardsQuestionsCompletionModel flashcardsQuestionsCompletionModelFromJson(String str) => FlashcardsQuestionsCompletionModel.fromJson(json.decode(str));

String flashcardsQuestionsCompletionModelToJson(FlashcardsQuestionsCompletionModel data) => json.encode(data.toJson());

class FlashcardsQuestionsCompletionModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  FlashcardsQuestionsCompletionModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory FlashcardsQuestionsCompletionModel.fromJson(Map<String, dynamic> json) => FlashcardsQuestionsCompletionModel(
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
  String? topicId;
  String? topicName;
  int? totalFlashcards;
  int? quizQuestionsCount;
  int? totalQuizzes;
  int? completedFlashcards;
  int? progressPercentage;
  int? score;
  Statistics? statistics;

  Data({
    this.topicId,
    this.topicName,
    this.totalFlashcards,
    this.totalQuizzes,
    this.quizQuestionsCount,
    this.completedFlashcards,
    this.progressPercentage,
    this.score,
    this.statistics,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    topicId: json["topicId"],
    topicName: json["topicName"],
    quizQuestionsCount: json["quizQuestionsCount"],
    totalQuizzes: json["totalQuizzes"],
    totalFlashcards: json["totalFlashcards"],
    completedFlashcards: json["completedFlashcards"],
    progressPercentage: json["progressPercentage"],
    score: json["score"],
    statistics: json["statistics"] == null ? null : Statistics.fromJson(json["statistics"]),
  );

  Map<String, dynamic> toJson() => {
    "topicId": topicId,
    "topicName": topicName,
    "quizQuestionsCount": quizQuestionsCount,
    "totalQuizzes": totalQuizzes,
    "totalFlashcards": totalFlashcards,
    "completedFlashcards": completedFlashcards,
    "progressPercentage": progressPercentage,
    "score": score,
    "statistics": statistics?.toJson(),
  };
}

class Statistics {
  int? unknownCards;
  int? knownCards;
  int? highestStreak;

  Statistics({
    this.unknownCards,
    this.knownCards,
    this.highestStreak,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    unknownCards: json["unknownCards"],
    knownCards: json["knownCards"],
    highestStreak: json["highestStreak"],
  );

  Map<String, dynamic> toJson() => {
    "unknownCards": unknownCards,
    "knownCards": knownCards,
    "highestStreak": highestStreak,
  };
}
