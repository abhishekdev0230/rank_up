// To parse this JSON data, do
//
//     final flashcardsQuestionsModel = flashcardsQuestionsModelFromJson(jsonString);

import 'dart:convert';

FlashcardsQuestionsModel flashcardsQuestionsModelFromJson(String str) => FlashcardsQuestionsModel.fromJson(json.decode(str));

String flashcardsQuestionsModelToJson(FlashcardsQuestionsModel data) => json.encode(data.toJson());

class FlashcardsQuestionsModel {
  bool? status;
  int? code;
  String? message;
  FlashcardsQuestionsData? data;

  FlashcardsQuestionsModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory FlashcardsQuestionsModel.fromJson(Map<String, dynamic> json) => FlashcardsQuestionsModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : FlashcardsQuestionsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class FlashcardsQuestionsData {
  String? topicId;
  String? topicName;
  int? totalFlashcards;
  int? completedFlashcards;
  int? progressPercentage;
  int? currentCardIndex;
  List<Flashcard>? flashcards;
  Pagination? pagination;

  FlashcardsQuestionsData({
    this.topicId,
    this.topicName,
    this.totalFlashcards,
    this.completedFlashcards,
    this.progressPercentage,
    this.currentCardIndex,
    this.flashcards,
    this.pagination,
  });

  factory FlashcardsQuestionsData.fromJson(Map<String, dynamic> json) => FlashcardsQuestionsData(
    topicId: json["topicId"],
    topicName: json["topicName"],
    totalFlashcards: json["totalFlashcards"],
    completedFlashcards: json["completedFlashcards"],
    progressPercentage: json["progressPercentage"],
    currentCardIndex: json["currentCardIndex"],
    flashcards: json["flashcards"] == null ? [] : List<Flashcard>.from(json["flashcards"]!.map((x) => Flashcard.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "topicId": topicId,
    "topicName": topicName,
    "totalFlashcards": totalFlashcards,
    "completedFlashcards": completedFlashcards,
    "progressPercentage": progressPercentage,
    "currentCardIndex": currentCardIndex,
    "flashcards": flashcards == null ? [] : List<dynamic>.from(flashcards!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Flashcard {
  String? id;
  String? question;
  String? answer;
  String? hint;
  String? explanation;
  String? difficulty;
  int? displayOrder;
  bool? isCompleted;
  bool? isBookmarked;
  int? confidence;
  int? reviewCount;

  Flashcard({
    this.id,
    this.question,
    this.answer,
    this.hint,
    this.explanation,
    this.difficulty,
    this.displayOrder,
    this.isCompleted,
    this.confidence,
    this.reviewCount,
    this.isBookmarked,
  });

  factory Flashcard.fromJson(Map<String, dynamic> json) => Flashcard(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    hint: json["hint"],
    explanation: json["explanation"],
    difficulty: json["difficulty"],
    displayOrder: json["displayOrder"],
    isCompleted: json["isCompleted"],
    confidence: json["confidence"],
    isBookmarked: json["isBookmarked"],
    reviewCount: json["reviewCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "isBookmarked": isBookmarked,
    "hint": hint,
    "explanation": explanation,
    "difficulty": difficulty,
    "displayOrder": displayOrder,
    "isCompleted": isCompleted,
    "confidence": confidence,
    "reviewCount": reviewCount,
  };

  // ✅ Add this copyWith method
  Flashcard copyWith({
    String? id,
    String? question,
    String? answer,
    String? hint,
    String? explanation,
    String? difficulty,
    int? displayOrder,
    bool? isCompleted,
    bool? isBookmarked,
    int? confidence,
    int? reviewCount,
  }) {
    return Flashcard(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      hint: hint ?? this.hint,
      explanation: explanation ?? this.explanation,
      difficulty: difficulty ?? this.difficulty,
      displayOrder: displayOrder ?? this.displayOrder,
      isCompleted: isCompleted ?? this.isCompleted,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      confidence: confidence ?? this.confidence,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }
}


class Pagination {
  int? currentPage;
  int? totalPages;
  int? totalItems;
  int? itemsPerPage;
  bool? hasNextPage;
  bool? hasPreviousPage;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.itemsPerPage,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
    totalItems: json["totalItems"],
    itemsPerPage: json["itemsPerPage"],
    hasNextPage: json["hasNextPage"],
    hasPreviousPage: json["hasPreviousPage"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "totalPages": totalPages,
    "totalItems": totalItems,
    "itemsPerPage": itemsPerPage,
    "hasNextPage": hasNextPage,
    "hasPreviousPage": hasPreviousPage,
  };
}
