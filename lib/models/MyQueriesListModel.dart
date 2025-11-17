// To parse this JSON data, do
//
//     final myQueriesListModel = myQueriesListModelFromJson(jsonString);

import 'dart:convert';

MyQueriesListModel myQueriesListModelFromJson(String str) => MyQueriesListModel.fromJson(json.decode(str));

String myQueriesListModelToJson(MyQueriesListModel data) => json.encode(data.toJson());

class MyQueriesListModel {
  bool? status;
  int? code;
  String? message;
  List<Datum>? data;

  MyQueriesListModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory MyQueriesListModel.fromJson(Map<String, dynamic> json) => MyQueriesListModel(
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  String? ticketNumber;
  String? category;
  String? subject;
  String? description;
  String? status;
  String? priority;
  List<String>? attachments;
  dynamic assignedTo;
  dynamic resolvedAt;
  dynamic closedAt;
  dynamic lastReplyAt;
  User? user;
  List<dynamic>? replies;
  Count? count;

  Datum({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.ticketNumber,
    this.category,
    this.subject,
    this.description,
    this.status,
    this.priority,
    this.attachments,
    this.assignedTo,
    this.resolvedAt,
    this.closedAt,
    this.lastReplyAt,
    this.user,
    this.replies,
    this.count,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"],
    ticketNumber: json["ticketNumber"],
    category: json["category"],
    subject: json["subject"],
    description: json["description"],
    status: json["status"],
    priority: json["priority"],
    attachments: json["attachments"] == null ? [] : List<String>.from(json["attachments"]!.map((x) => x)),
    assignedTo: json["assignedTo"],
    resolvedAt: json["resolvedAt"],
    closedAt: json["closedAt"],
    lastReplyAt: json["lastReplyAt"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    replies: json["replies"] == null ? [] : List<dynamic>.from(json["replies"]!.map((x) => x)),
    count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userId": userId,
    "ticketNumber": ticketNumber,
    "category": category,
    "subject": subject,
    "description": description,
    "status": status,
    "priority": priority,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x)),
    "assignedTo": assignedTo,
    "resolvedAt": resolvedAt,
    "closedAt": closedAt,
    "lastReplyAt": lastReplyAt,
    "user": user?.toJson(),
    "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x)),
    "_count": count?.toJson(),
  };
}

class Count {
  int? replies;

  Count({
    this.replies,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    replies: json["replies"],
  );

  Map<String, dynamic> toJson() => {
    "replies": replies,
  };
}

class User {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;

  User({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}
