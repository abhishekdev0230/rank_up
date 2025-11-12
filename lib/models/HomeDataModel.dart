// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  bool? status;
  int? code;
  Data? data;

  HomeDataModel({
    this.status,
    this.code,
    this.data,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
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
  User? user;
  ModuleProgress? moduleProgress;
  DailyQuestion? dailyQuestion;
  List<FeaturedDeck>? featuredDecks;
  LiveTest? liveTest;
  PausedModule? pausedModule;
  SolveNext? solveNext;
  List<ImportantTopic>? importantTopics;

  Data({
    this.user,
    this.moduleProgress,
    this.dailyQuestion,
    this.featuredDecks,
    this.liveTest,
    this.pausedModule,
    this.solveNext,
    this.importantTopics,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    moduleProgress: json["moduleProgress"] == null ? null : ModuleProgress.fromJson(json["moduleProgress"]),
    dailyQuestion: json["dailyQuestion"] == null ? null : DailyQuestion.fromJson(json["dailyQuestion"]),
    featuredDecks: json["featuredDecks"] == null ? [] : List<FeaturedDeck>.from(json["featuredDecks"]!.map((x) => FeaturedDeck.fromJson(x))),
    liveTest: json["liveTest"] == null ? null : LiveTest.fromJson(json["liveTest"]),
    pausedModule: json["pausedModule"] == null ? null : PausedModule.fromJson(json["pausedModule"]),
    solveNext: json["solveNext"] == null ? null : SolveNext.fromJson(json["solveNext"]),
    importantTopics: json["importantTopics"] == null ? [] : List<ImportantTopic>.from(json["importantTopics"]!.map((x) => ImportantTopic.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "moduleProgress": moduleProgress?.toJson(),
    "dailyQuestion": dailyQuestion?.toJson(),
    "featuredDecks": featuredDecks == null ? [] : List<dynamic>.from(featuredDecks!.map((x) => x.toJson())),
    "liveTest": liveTest?.toJson(),
    "pausedModule": pausedModule?.toJson(),
    "solveNext": solveNext?.toJson(),
    "importantTopics": importantTopics == null ? [] : List<dynamic>.from(importantTopics!.map((x) => x.toJson())),
  };
}

class DailyQuestion {
  String? id;
  String? questionText;
  dynamic questionImage;
  DailyQuestionSubject? subject;
  Chapter? chapter;
  Chapter? topic;

  DailyQuestion({
    this.id,
    this.questionText,
    this.questionImage,
    this.subject,
    this.chapter,
    this.topic,
  });

  factory DailyQuestion.fromJson(Map<String, dynamic> json) => DailyQuestion(
    id: json["id"],
    questionText: json["questionText"],
    questionImage: json["questionImage"],
    subject: json["subject"] == null ? null : DailyQuestionSubject.fromJson(json["subject"]),
    chapter: json["chapter"] == null ? null : Chapter.fromJson(json["chapter"]),
    topic: json["topic"] == null ? null : Chapter.fromJson(json["topic"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionText": questionText,
    "questionImage": questionImage,
    "subject": subject?.toJson(),
    "chapter": chapter?.toJson(),
    "topic": topic?.toJson(),
  };
}

class Chapter {
  String? id;
  String? name;

  Chapter({
    this.id,
    this.name,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class DailyQuestionSubject {
  String? id;
  String? name;
  String? colorCode;

  DailyQuestionSubject({
    this.id,
    this.name,
    this.colorCode,
  });

  factory DailyQuestionSubject.fromJson(Map<String, dynamic> json) => DailyQuestionSubject(
    id: json["id"],
    name: json["name"],
    colorCode: json["colorCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "colorCode": colorCode,
  };
}

class FeaturedDeck {
  String? id;
  String? name;
  List<Flashcard>? flashcards;

  FeaturedDeck({
    this.id,
    this.name,
    this.flashcards,
  });

  factory FeaturedDeck.fromJson(Map<String, dynamic> json) => FeaturedDeck(
    id: json["id"],
    name: json["name"],
    flashcards: json["flashcards"] == null ? [] : List<Flashcard>.from(json["flashcards"]!.map((x) => Flashcard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "flashcards": flashcards == null ? [] : List<dynamic>.from(flashcards!.map((x) => x.toJson())),
  };
}

class Flashcard {
  String? id;
  String? subjectId;
  String? chapterId;
  String? topicId;
  FlashcardSubject? subject;

  Flashcard({
    this.id,
    this.subjectId,
    this.chapterId,
    this.topicId,
    this.subject,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) => Flashcard(
    id: json["id"],
    subjectId: json["subjectId"],
    chapterId: json["chapterId"],
    topicId: json["topicId"],
    subject: json["subject"] == null ? null : FlashcardSubject.fromJson(json["subject"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subjectId": subjectId,
    "chapterId": chapterId,
    "topicId": topicId,
    "subject": subject?.toJson(),
  };
}

class FlashcardSubject {
  String? name;

  FlashcardSubject({
    this.name,
  });

  factory FlashcardSubject.fromJson(Map<String, dynamic> json) => FlashcardSubject(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class ImportantTopic {
  String? id;
  String? name;
  String? description;
  Chapter? chapter;
  DailyQuestionSubject? subject;
  int? totalFlashcards;
  int? totalQuestions;
  int? displayOrder;

  ImportantTopic({
    this.id,
    this.name,
    this.description,
    this.chapter,
    this.subject,
    this.totalFlashcards,
    this.totalQuestions,
    this.displayOrder,
  });

  factory ImportantTopic.fromJson(Map<String, dynamic> json) => ImportantTopic(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    chapter: json["chapter"] == null ? null : Chapter.fromJson(json["chapter"]),
    subject: json["subject"] == null ? null : DailyQuestionSubject.fromJson(json["subject"]),
    totalFlashcards: json["totalFlashcards"],
    totalQuestions: json["totalQuestions"],
    displayOrder: json["displayOrder"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "chapter": chapter?.toJson(),
    "subject": subject?.toJson(),
    "totalFlashcards": totalFlashcards,
    "totalQuestions": totalQuestions,
    "displayOrder": displayOrder,
  };
}

class LiveTest {
  String? id;
  String? title;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  int? duration;
  int? totalQuestions;
  int? totalMarks;
  String? thumbnailImage;
  DailyQuestionSubject? subject;
  bool? isLive;
  int? timeRemaining;

  LiveTest({
    this.id,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.duration,
    this.totalQuestions,
    this.totalMarks,
    this.thumbnailImage,
    this.subject,
    this.isLive,
    this.timeRemaining,
  });

  factory LiveTest.fromJson(Map<String, dynamic> json) => LiveTest(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
    endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
    duration: json["duration"],
    totalQuestions: json["totalQuestions"],
    totalMarks: json["totalMarks"],
    thumbnailImage: json["thumbnailImage"],
    subject: json["subject"] == null ? null : DailyQuestionSubject.fromJson(json["subject"]),
    isLive: json["isLive"],
    timeRemaining: json["timeRemaining"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "startTime": startTime?.toIso8601String(),
    "endTime": endTime?.toIso8601String(),
    "duration": duration,
    "totalQuestions": totalQuestions,
    "totalMarks": totalMarks,
    "thumbnailImage": thumbnailImage,
    "subject": subject?.toJson(),
    "isLive": isLive,
    "timeRemaining": timeRemaining,
  };
}

class ModuleProgress {
  int? totalModules;
  int? completedModules;
  int? progressPercentage;

  ModuleProgress({
    this.totalModules,
    this.completedModules,
    this.progressPercentage,
  });

  factory ModuleProgress.fromJson(Map<String, dynamic> json) => ModuleProgress(
    totalModules: json["totalModules"],
    completedModules: json["completedModules"],
    progressPercentage: json["progressPercentage"],
  );

  Map<String, dynamic> toJson() => {
    "totalModules": totalModules,
    "completedModules": completedModules,
    "progressPercentage": progressPercentage,
  };
}

class PausedModule {
  String? id;
  String? topicId;
  String? topicName;
  String? chapterName;
  int? flashcardsCompleted;
  int? totalFlashcards;
  int? progressPercentage;
  DateTime? lastAccessedAt;

  PausedModule({
    this.id,
    this.topicId,
    this.topicName,
    this.chapterName,
    this.flashcardsCompleted,
    this.totalFlashcards,
    this.progressPercentage,
    this.lastAccessedAt,
  });

  factory PausedModule.fromJson(Map<String, dynamic> json) => PausedModule(
    id: json["id"],
    topicId: json["topicId"],
    topicName: json["topicName"],
    chapterName: json["chapterName"],
    flashcardsCompleted: json["flashcardsCompleted"],
    totalFlashcards: json["totalFlashcards"],
    progressPercentage: json["progressPercentage"],
    lastAccessedAt: json["lastAccessedAt"] == null ? null : DateTime.parse(json["lastAccessedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topicId": topicId,
    "topicName": topicName,
    "chapterName": chapterName,
    "flashcardsCompleted": flashcardsCompleted,
    "totalFlashcards": totalFlashcards,
    "progressPercentage": progressPercentage,
    "lastAccessedAt": lastAccessedAt?.toIso8601String(),
  };
}

class SolveNext {
  String? id;
  String? topicId;
  String? topicName;
  String? chapterName;
  int? quizzesCompleted;
  int? totalQuizzes;
  int? progressPercentage;

  SolveNext({
    this.id,
    this.topicId,
    this.topicName,
    this.chapterName,
    this.quizzesCompleted,
    this.totalQuizzes,
    this.progressPercentage,
  });

  factory SolveNext.fromJson(Map<String, dynamic> json) => SolveNext(
    id: json["id"],
    topicId: json["topicId"],
    topicName: json["topicName"],
    chapterName: json["chapterName"],
    quizzesCompleted: json["quizzesCompleted"],
    totalQuizzes: json["totalQuizzes"],
    progressPercentage: json["progressPercentage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topicId": topicId,
    "topicName": topicName,
    "chapterName": chapterName,
    "quizzesCompleted": quizzesCompleted,
    "totalQuizzes": totalQuizzes,
    "progressPercentage": progressPercentage,
  };
}

class User {
  String? id;
  String? name;
  String? profilePicture;

  User({
    this.id,
    this.name,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    profilePicture: json["profilePicture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profilePicture": profilePicture,
  };
}
