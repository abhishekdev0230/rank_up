// To parse this JSON data, do
//
//     final bookmarkedCardListModel = bookmarkedCardListModelFromJson(jsonString);

import 'dart:convert';

BookmarkedCardListModel bookmarkedCardListModelFromJson(String str) => BookmarkedCardListModel.fromJson(json.decode(str));

String bookmarkedCardListModelToJson(BookmarkedCardListModel data) => json.encode(data.toJson());

class BookmarkedCardListModel {
  bool? status;
  int? code;
  String? message;
  BookmarkedCardList? data;

  BookmarkedCardListModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory BookmarkedCardListModel.fromJson(Map<String, dynamic> json) => BookmarkedCardListModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : BookmarkedCardList.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class BookmarkedCardList {
  List<Card>? cards;
  List<AvailableClass>? availableClasses;
  List<AvailableSubject>? availableSubjects;
  Pagination? pagination;

  BookmarkedCardList({
    this.cards,
    this.availableClasses,
    this.availableSubjects,
    this.pagination,
  });

  factory BookmarkedCardList.fromJson(Map<String, dynamic> json) => BookmarkedCardList(
    cards: json["cards"] == null ? [] : List<Card>.from(json["cards"]!.map((x) => Card.fromJson(x))),
    availableClasses: json["availableClasses"] == null ? [] : List<AvailableClass>.from(json["availableClasses"]!.map((x) => AvailableClass.fromJson(x))),
    availableSubjects: json["availableSubjects"] == null ? [] : List<AvailableSubject>.from(json["availableSubjects"]!.map((x) => AvailableSubject.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "cards": cards == null ? [] : List<dynamic>.from(cards!.map((x) => x.toJson())),
    "availableClasses": availableClasses == null ? [] : List<dynamic>.from(availableClasses!.map((x) => x.toJson())),
    "availableSubjects": availableSubjects == null ? [] : List<dynamic>.from(availableSubjects!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class AvailableClass {
  String? classId;
  String? classCode;
  String? className;

  AvailableClass({
    this.classId,
    this.classCode,
    this.className,
  });

  factory AvailableClass.fromJson(Map<String, dynamic> json) => AvailableClass(
    classId: json["classId"],
    classCode: json["classCode"],
    className: json["className"],
  );

  Map<String, dynamic> toJson() => {
    "classId": classId,
    "classCode": classCode,
    "className": className,
  };
}

class AvailableSubject {
  String? subjectId;
  String? subjectName;
  String? subjectIcon;

  AvailableSubject({
    this.subjectId,
    this.subjectName,
    this.subjectIcon,
  });

  factory AvailableSubject.fromJson(Map<String, dynamic> json) => AvailableSubject(
    subjectId: json["subjectId"],
    subjectName: json["subjectName"],
    subjectIcon: json["subjectIcon"],
  );

  Map<String, dynamic> toJson() => {
    "subjectId": subjectId,
    "subjectName": subjectName,
    "subjectIcon": subjectIcon,
  };
}

class Card {
  String? id;
  String? flashcardId;
  String? question;
  String? answer;
  String? answerImage;
  String? classId;
  String? classCode;
  String? className;
  String? subjectId;
  String? subjectName;
  String? subjectIcon;
  String? topicId;
  String? topicName;
  String? chapterId;
  String? chapterName;
  DateTime? bookmarkedAt;

  Card({
    this.id,
    this.flashcardId,
    this.question,
    this.answer,
    this.answerImage,
    this.classId,
    this.classCode,
    this.className,
    this.subjectId,
    this.subjectName,
    this.subjectIcon,
    this.topicId,
    this.topicName,
    this.chapterId,
    this.chapterName,
    this.bookmarkedAt,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    id: json["id"],
    flashcardId: json["flashcardId"],
    question: json["question"],
    answer: json["answer"],
    answerImage: json["answerImage"],
    classId: json["classId"],
    classCode: json["classCode"],
    className: json["className"],
    subjectId: json["subjectId"],
    subjectName: json["subjectName"],
    subjectIcon: json["subjectIcon"],
    topicId: json["topicId"],
    topicName: json["topicName"],
    chapterId: json["chapterId"],
    chapterName: json["chapterName"],
    bookmarkedAt: json["bookmarkedAt"] == null ? null : DateTime.parse(json["bookmarkedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "flashcardId": flashcardId,
    "question": question,
    "answer": answer,
    "answerImage": answerImage,
    "classId": classId,
    "classCode": classCode,
    "className": className,
    "subjectId": subjectId,
    "subjectName": subjectName,
    "subjectIcon": subjectIcon,
    "topicId": topicId,
    "topicName": topicName,
    "chapterId": chapterId,
    "chapterName": chapterName,
    "bookmarkedAt": bookmarkedAt?.toIso8601String(),
  };
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
