// models/important_topic_model.dart
import 'dart:convert';

ImportantTopicListModel importantTopicListModelFromJson(String str) => ImportantTopicListModel.fromJson(json.decode(str));

class ImportantTopicListModel {
  ImportantTopicListModel({
    required this.status,
    required this.code,
    required this.pagination,
    required this.data,
  });

  bool status;
  int code;
  Pagination pagination;
  List<ImportantTopicSeeAll> data;

  factory ImportantTopicListModel.fromJson(Map<String, dynamic> json) => ImportantTopicListModel(
    status: json["status"],
    code: json["code"],
    pagination: Pagination.fromJson(json["pagination"]),
    data: List<ImportantTopicSeeAll>.from(json["data"].map((x) => ImportantTopicSeeAll.fromJson(x))),
  );
}

class Pagination {
  Pagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  int total;
  int page;
  int limit;
  int totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
  );
}

class ImportantTopicSeeAll {
  ImportantTopicSeeAll({
    required this.id,
    required this.name,
    this.description, // nullable
    required this.chapter,
    required this.subject,
    required this.classInfo,
    required this.totalFlashcards,
    required this.totalQuestions,
    required this.displayOrder,
  });

  String id;
  String name;
  String? description; // nullable
  Chapter chapter;
  Subject subject;
  ClassInfo classInfo;
  int totalFlashcards;
  int totalQuestions;
  int displayOrder;

  factory ImportantTopicSeeAll.fromJson(Map<String, dynamic> json) => ImportantTopicSeeAll(
    id: json["id"],
    name: json["name"],
    description: json["description"], // can be null
    chapter: Chapter.fromJson(json["chapter"]),
    subject: Subject.fromJson(json["subject"]),
    classInfo: ClassInfo.fromJson(json["class"]),
    totalFlashcards: json["totalFlashcards"],
    totalQuestions: json["totalQuestions"],
    displayOrder: json["displayOrder"],
  );
}

class Subject {
  Subject({required this.id, required this.name, this.colorCode}); // nullable
  String id;
  String name;
  String? colorCode;

  factory Subject.fromJson(Map<String, dynamic> json) =>
      Subject(id: json["id"], name: json["name"], colorCode: json["colorCode"]);
}


class Chapter {
  Chapter({required this.id, required this.name});
  String id;
  String name;
  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(id: json["id"], name: json["name"]);
}


class ClassInfo {
  ClassInfo({required this.id, required this.code, required this.name});
  String id;
  String code;
  String name;
  factory ClassInfo.fromJson(Map<String, dynamic> json) =>
      ClassInfo(id: json["id"], code: json["code"], name: json["name"]);
}
