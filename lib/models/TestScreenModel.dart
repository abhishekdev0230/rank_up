// To parse this JSON data, do
//
//     final testScreenModel = testScreenModelFromJson(jsonString);

import 'dart:convert';

TestScreenModel testScreenModelFromJson(String str) => TestScreenModel.fromJson(json.decode(str));

String testScreenModelToJson(TestScreenModel data) => json.encode(data.toJson());

class TestScreenModel {
  bool? status;
  int? code;
  String? message;
  TestScreenData? data;

  TestScreenModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory TestScreenModel.fromJson(Map<String, dynamic> json) => TestScreenModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : TestScreenData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class TestScreenData {
  User? user;
  FeaturedTest? featuredTest;
  DailyPractice? dailyPractice;
  UpcomingTests? upcomingTests;
  Leaderboard? leaderboard;
  Streak? streak;
  List<dynamic>? achievements;
  Subscription? subscription;

  TestScreenData({
    this.user,
    this.featuredTest,
    this.dailyPractice,
    this.upcomingTests,
    this.leaderboard,
    this.streak,
    this.achievements,
    this.subscription,
  });

  factory TestScreenData.fromJson(Map<String, dynamic> json) => TestScreenData(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    featuredTest: json["featuredTest"] == null ? null : FeaturedTest.fromJson(json["featuredTest"]),
    dailyPractice: json["dailyPractice"] == null ? null : DailyPractice.fromJson(json["dailyPractice"]),
    upcomingTests: json["upcomingTests"] == null ? null : UpcomingTests.fromJson(json["upcomingTests"]),
    leaderboard: json["leaderboard"] == null ? null : Leaderboard.fromJson(json["leaderboard"]),
    streak: json["streak"] == null ? null : Streak.fromJson(json["streak"]),
    achievements: json["achievements"] == null ? [] : List<dynamic>.from(json["achievements"]!.map((x) => x)),
    subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "featuredTest": featuredTest?.toJson(),
    "dailyPractice": dailyPractice?.toJson(),
    "upcomingTests": upcomingTests?.toJson(),
    "leaderboard": leaderboard?.toJson(),
    "streak": streak?.toJson(),
    "achievements": achievements == null ? [] : List<dynamic>.from(achievements!.map((x) => x)),
    "subscription": subscription?.toJson(),
  };
}

class DailyPractice {
  bool? isCompleted;
  bool? startAvailable;
  int? questionsToday;

  DailyPractice({
    this.isCompleted,
    this.startAvailable,
    this.questionsToday,
  });

  factory DailyPractice.fromJson(Map<String, dynamic> json) => DailyPractice(
    isCompleted: json["isCompleted"],
    startAvailable: json["startAvailable"],
    questionsToday: json["questionsToday"],
  );

  Map<String, dynamic> toJson() => {
    "isCompleted": isCompleted,
    "startAvailable": startAvailable,
    "questionsToday": questionsToday,
  };
}

class FeaturedTest {
  String? id;
  String? title;
  String? description;
  DateTime? startDate;
  String? type;
  bool? isPremium;

  FeaturedTest({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.type,
    this.isPremium,
  });

  factory FeaturedTest.fromJson(Map<String, dynamic> json) => FeaturedTest(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    type: json["type"],
    isPremium: json["isPremium"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "startDate": startDate?.toIso8601String(),
    "type": type,
    "isPremium": isPremium,
  };
}

class Leaderboard {
  int? averageScore;
  int? solved;
  int? total;

  Leaderboard({
    this.averageScore,
    this.solved,
    this.total,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
    averageScore: json["averageScore"],
    solved: json["solved"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "averageScore": averageScore,
    "solved": solved,
    "total": total,
  };
}

class Streak {
  int? current;
  int? longest;

  Streak({
    this.current,
    this.longest,
  });

  factory Streak.fromJson(Map<String, dynamic> json) => Streak(
    current: json["current"],
    longest: json["longest"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "longest": longest,
  };
}

class Subscription {
  String? plan;
  dynamic expiresAt;

  Subscription({
    this.plan,
    this.expiresAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    plan: json["plan"],
    expiresAt: json["expiresAt"],
  );

  Map<String, dynamic> toJson() => {
    "plan": plan,
    "expiresAt": expiresAt,
  };
}

class UpcomingTests {
  List<Major>? minor;
  List<Major>? major;

  UpcomingTests({
    this.minor,
    this.major,
  });

  factory UpcomingTests.fromJson(Map<String, dynamic> json) => UpcomingTests(
    minor: json["minor"] == null ? [] : List<Major>.from(json["minor"]!.map((x) => Major.fromJson(x))),
    major: json["major"] == null ? [] : List<Major>.from(json["major"]!.map((x) => Major.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "minor": minor == null ? [] : List<dynamic>.from(minor!.map((x) => x.toJson())),
    "major": major == null ? [] : List<dynamic>.from(major!.map((x) => x.toJson())),
  };
}

class Major {
  String? id;
  String? title;
  int? totalQuestions;
  int? duration;
  String? type;
  bool? isPremium;

  Major({
    this.id,
    this.title,
    this.totalQuestions,
    this.duration,
    this.type,
    this.isPremium,
  });

  factory Major.fromJson(Map<String, dynamic> json) => Major(
    id: json["id"],
    title: json["title"],
    totalQuestions: json["totalQuestions"],
    duration: json["duration"],
    type: json["type"],
    isPremium: json["isPremium"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "totalQuestions": totalQuestions,
    "duration": duration,
    "type": type,
    "isPremium": isPremium,
  };
}

class User {
  String? id;
  String? fullName;
  String? profilePicture;

  User({
    this.id,
    this.fullName,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    profilePicture: json["profilePicture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "profilePicture": profilePicture,
  };
}
