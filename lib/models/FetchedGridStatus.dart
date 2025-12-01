// To parse this JSON data, do
//
//     final fetchedGridStatus = fetchedGridStatusFromJson(jsonString);

import 'dart:convert';

FetchedGridStatus fetchedGridStatusFromJson(String str) => FetchedGridStatus.fromJson(json.decode(str));

String fetchedGridStatusToJson(FetchedGridStatus data) => json.encode(data.toJson());

class FetchedGridStatus {
  bool? status;
  int? code;
  String? message;
  FetchedGridData? data;

  FetchedGridStatus({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory FetchedGridStatus.fromJson(Map<String, dynamic> json) => FetchedGridStatus(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : FetchedGridData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class FetchedGridData {
  String? attemptId;
  int? totalQuestions;
  List<Grid>? grid;

  FetchedGridData({
    this.attemptId,
    this.totalQuestions,
    this.grid,
  });

  factory FetchedGridData.fromJson(Map<String, dynamic> json) => FetchedGridData(
    attemptId: json["attemptId"],
    totalQuestions: json["totalQuestions"],
    grid: json["grid"] == null ? [] : List<Grid>.from(json["grid"]!.map((x) => Grid.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attemptId": attemptId,
    "totalQuestions": totalQuestions,
    "grid": grid == null ? [] : List<dynamic>.from(grid!.map((x) => x.toJson())),
  };
}

class Grid {
  String? questionId;
  int? number;
  String? selectedAnswer;
  bool? isBookmarked;
  bool? isCorrect;
  bool? visited;
  bool? skip;
  String? status;

  Grid({
    this.questionId,
    this.number,
    this.selectedAnswer,
    this.isBookmarked,
    this.isCorrect,
    this.visited,
    this.skip,
    this.status,
  });

  factory Grid.fromJson(Map<String, dynamic> json) => Grid(
    questionId: json["questionId"],
    number: json["number"],
    selectedAnswer: json["selectedAnswer"],
    isBookmarked: json["isBookmarked"],
    isCorrect: json["isCorrect"],
    visited: json["visited"],
    skip: json["skip"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "number": number,
    "selectedAnswer": selectedAnswer,
    "isBookmarked": isBookmarked,
    "isCorrect": isCorrect,
    "visited": visited,
    "skip": skip,
    "status": status,
  };
}
