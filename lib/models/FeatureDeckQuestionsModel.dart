// To parse this JSON data, do
//
//     final featureDeckQuestionsModel = featureDeckQuestionsModelFromJson(jsonString);

import 'dart:convert';

FeatureDeckQuestionsModel featureDeckQuestionsModelFromJson(String str) => FeatureDeckQuestionsModel.fromJson(json.decode(str));

String featureDeckQuestionsModelToJson(FeatureDeckQuestionsModel data) => json.encode(data.toJson());

class FeatureDeckQuestionsModel {
  bool? status;
  String? message;
  Deck? deck;
  Pagination? pagination;
  List<FeatureDatum>? data;

  FeatureDeckQuestionsModel({
    this.status,
    this.message,
    this.deck,
    this.pagination,
    this.data,
  });

  factory FeatureDeckQuestionsModel.fromJson(Map<String, dynamic> json) => FeatureDeckQuestionsModel(
    status: json["status"],
    message: json["message"],
    deck: json["deck"] == null ? null : Deck.fromJson(json["deck"]),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? [] : List<FeatureDatum>.from(json["data"]!.map((x) => FeatureDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "deck": deck?.toJson(),
    "pagination": pagination?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FeatureDatum {
  String? id;
  String? question;
  String? answer;
  dynamic explanation;
  int? displayOrder;

  FeatureDatum({
    this.id,
    this.question,
    this.answer,
    this.explanation,
    this.displayOrder,
  });

  factory FeatureDatum.fromJson(Map<String, dynamic> json) => FeatureDatum(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    explanation: json["explanation"],
    displayOrder: json["displayOrder"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "explanation": explanation,
    "displayOrder": displayOrder,
  };
}

class Deck {
  String? id;
  String? name;
  dynamic description;

  Deck({
    this.id,
    this.name,
    this.description,
  });

  factory Deck.fromJson(Map<String, dynamic> json) => Deck(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  Pagination({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}
