// To parse this JSON data, do
//
//     final testReviewAnswerModel = testReviewAnswerModelFromJson(jsonString);

import 'dart:convert';

TestReviewAnswerModel testReviewAnswerModelFromJson(String str) => TestReviewAnswerModel.fromJson(json.decode(str));

String testReviewAnswerModelToJson(TestReviewAnswerModel data) => json.encode(data.toJson());

class TestReviewAnswerModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  TestReviewAnswerModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory TestReviewAnswerModel.fromJson(Map<String, dynamic> json) => TestReviewAnswerModel(
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
  AttemptMeta? attemptMeta;
  List<Review>? review;

  Data({
    this.attemptMeta,
    this.review,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attemptMeta: json["attemptMeta"] == null ? null : AttemptMeta.fromJson(json["attemptMeta"]),
    review: json["review"] == null ? [] : List<Review>.from(json["review"]!.map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attemptMeta": attemptMeta?.toJson(),
    "review": review == null ? [] : List<dynamic>.from(review!.map((x) => x.toJson())),
  };
}

class AttemptMeta {
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
  Answers? answers;
  dynamic rank;
  Test? test;

  AttemptMeta({
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
    this.test,
  });

  factory AttemptMeta.fromJson(Map<String, dynamic> json) => AttemptMeta(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"],
    testId: json["testId"],
    startedAt: json["startedAt"] == null ? null : DateTime.parse(json["startedAt"]),
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
    answers: json["answers"] == null ? null : Answers.fromJson(json["answers"]),
    rank: json["rank"],
    test: json["test"] == null ? null : Test.fromJson(json["test"]),
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
    "answers": answers?.toJson(),
    "rank": rank,
    "test": test?.toJson(),
  };
}

class Answers {
  Cmhzidgx? cmhzidgx10Yelnz01T5E6Yvjp;
  Cmhzidgx? cmhzidgxm0Yernz014Trzkke8;
  Cmi92Var? cmi92Var5110Pox01Uiy4Pn3C;
  Cmi92Var? cmi92Vark110Vox01W3Zka29L;
  Cmi92Var? cmi92Varz1111Ox01B4Q59Rl3;

  Answers({
    this.cmhzidgx10Yelnz01T5E6Yvjp,
    this.cmhzidgxm0Yernz014Trzkke8,
    this.cmi92Var5110Pox01Uiy4Pn3C,
    this.cmi92Vark110Vox01W3Zka29L,
    this.cmi92Varz1111Ox01B4Q59Rl3,
  });

  factory Answers.fromJson(Map<String, dynamic> json) => Answers(
    cmhzidgx10Yelnz01T5E6Yvjp: json["cmhzidgx10yelnz01t5e6yvjp"] == null ? null : Cmhzidgx.fromJson(json["cmhzidgx10yelnz01t5e6yvjp"]),
    cmhzidgxm0Yernz014Trzkke8: json["cmhzidgxm0yernz014trzkke8"] == null ? null : Cmhzidgx.fromJson(json["cmhzidgxm0yernz014trzkke8"]),
    cmi92Var5110Pox01Uiy4Pn3C: json["cmi92var5110pox01uiy4pn3c"] == null ? null : Cmi92Var.fromJson(json["cmi92var5110pox01uiy4pn3c"]),
    cmi92Vark110Vox01W3Zka29L: json["cmi92vark110vox01w3zka29l"] == null ? null : Cmi92Var.fromJson(json["cmi92vark110vox01w3zka29l"]),
    cmi92Varz1111Ox01B4Q59Rl3: json["cmi92varz1111ox01b4q59rl3"] == null ? null : Cmi92Var.fromJson(json["cmi92varz1111ox01b4q59rl3"]),
  );

  Map<String, dynamic> toJson() => {
    "cmhzidgx10yelnz01t5e6yvjp": cmhzidgx10Yelnz01T5E6Yvjp?.toJson(),
    "cmhzidgxm0yernz014trzkke8": cmhzidgxm0Yernz014Trzkke8?.toJson(),
    "cmi92var5110pox01uiy4pn3c": cmi92Var5110Pox01Uiy4Pn3C?.toJson(),
    "cmi92vark110vox01w3zka29l": cmi92Vark110Vox01W3Zka29L?.toJson(),
    "cmi92varz1111ox01b4q59rl3": cmi92Varz1111Ox01B4Q59Rl3?.toJson(),
  };
}

class Cmhzidgx {
  bool? isCorrect;
  int? timeTaken;
  bool? isBookmarked;
  dynamic selectedAnswer;

  Cmhzidgx({
    this.isCorrect,
    this.timeTaken,
    this.isBookmarked,
    this.selectedAnswer,
  });

  factory Cmhzidgx.fromJson(Map<String, dynamic> json) => Cmhzidgx(
    isCorrect: json["isCorrect"],
    timeTaken: json["timeTaken"],
    isBookmarked: json["isBookmarked"],
    selectedAnswer: json["selectedAnswer"],
  );

  Map<String, dynamic> toJson() => {
    "isCorrect": isCorrect,
    "timeTaken": timeTaken,
    "isBookmarked": isBookmarked,
    "selectedAnswer": selectedAnswer,
  };
}

class Cmi92Var {
  bool? skip;
  bool? visited;
  bool? isCorrect;
  int? timeTaken;
  bool? isBookmarked;
  String? selectedAnswer;

  Cmi92Var({
    this.skip,
    this.visited,
    this.isCorrect,
    this.timeTaken,
    this.isBookmarked,
    this.selectedAnswer,
  });

  factory Cmi92Var.fromJson(Map<String, dynamic> json) => Cmi92Var(
    skip: json["skip"],
    visited: json["visited"],
    isCorrect: json["isCorrect"],
    timeTaken: json["timeTaken"],
    isBookmarked: json["isBookmarked"],
    selectedAnswer: json["selectedAnswer"],
  );

  Map<String, dynamic> toJson() => {
    "skip": skip,
    "visited": visited,
    "isCorrect": isCorrect,
    "timeTaken": timeTaken,
    "isBookmarked": isBookmarked,
    "selectedAnswer": selectedAnswer,
  };
}

class Test {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? title;
  String? description;
  String? instructions;
  String? type;
  String? status;
  dynamic classId;
  dynamic subjectId;
  int? totalMarks;
  int? totalQuestions;
  int? duration;
  DateTime? startDate;
  dynamic endDate;
  bool? isPublished;
  bool? isFeatured;
  bool? isPremium;
  int? attemptCount;
  dynamic averageScore;
  dynamic thumbnailImage;
  dynamic icon;
  List<TestQuestion>? testQuestions;

  Test({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.instructions,
    this.type,
    this.status,
    this.classId,
    this.subjectId,
    this.totalMarks,
    this.totalQuestions,
    this.duration,
    this.startDate,
    this.endDate,
    this.isPublished,
    this.isFeatured,
    this.isPremium,
    this.attemptCount,
    this.averageScore,
    this.thumbnailImage,
    this.icon,
    this.testQuestions,
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    title: json["title"],
    description: json["description"],
    instructions: json["instructions"],
    type: json["type"],
    status: json["status"],
    classId: json["classId"],
    subjectId: json["subjectId"],
    totalMarks: json["totalMarks"],
    totalQuestions: json["totalQuestions"],
    duration: json["duration"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"],
    isPublished: json["isPublished"],
    isFeatured: json["isFeatured"],
    isPremium: json["isPremium"],
    attemptCount: json["attemptCount"],
    averageScore: json["averageScore"],
    thumbnailImage: json["thumbnailImage"],
    icon: json["icon"],
    testQuestions: json["testQuestions"] == null ? [] : List<TestQuestion>.from(json["testQuestions"]!.map((x) => TestQuestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "title": title,
    "description": description,
    "instructions": instructions,
    "type": type,
    "status": status,
    "classId": classId,
    "subjectId": subjectId,
    "totalMarks": totalMarks,
    "totalQuestions": totalQuestions,
    "duration": duration,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate,
    "isPublished": isPublished,
    "isFeatured": isFeatured,
    "isPremium": isPremium,
    "attemptCount": attemptCount,
    "averageScore": averageScore,
    "thumbnailImage": thumbnailImage,
    "icon": icon,
    "testQuestions": testQuestions == null ? [] : List<dynamic>.from(testQuestions!.map((x) => x.toJson())),
  };
}

class TestQuestion {
  String? id;
  String? testId;
  String? questionId;
  int? displayOrder;
  dynamic marks;
  Question? question;

  TestQuestion({
    this.id,
    this.testId,
    this.questionId,
    this.displayOrder,
    this.marks,
    this.question,
  });

  factory TestQuestion.fromJson(Map<String, dynamic> json) => TestQuestion(
    id: json["id"],
    testId: json["testId"],
    questionId: json["questionId"],
    displayOrder: json["displayOrder"],
    marks: json["marks"],
    question: json["question"] == null ? null : Question.fromJson(json["question"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "testId": testId,
    "questionId": questionId,
    "displayOrder": displayOrder,
    "marks": marks,
    "question": question?.toJson(),
  };
}

class Question {
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
  List<QuestionOption>? options;
  QuestionTopic? topic;

  Question({
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

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    isPreviousYear: json["isPreviousYear"],
    examYear: json["examYear"],
    examName: json["examName"],
    icon: json["icon"],
    options: json["options"] == null ? [] : List<QuestionOption>.from(json["options"]!.map((x) => QuestionOption.fromJson(x))),
    topic: json["topic"] == null ? null : QuestionTopic.fromJson(json["topic"]),
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
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "isPreviousYear": isPreviousYear,
    "examYear": examYear,
    "examName": examName,
    "icon": icon,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    "topic": topic?.toJson(),
  };
}

class QuestionOption {
  String? id;
  String? optionText;
  dynamic optionImage;
  String? optionLabel;
  bool? isCorrect;
  int? displayOrder;
  String? questionId;

  QuestionOption({
    this.id,
    this.optionText,
    this.optionImage,
    this.optionLabel,
    this.isCorrect,
    this.displayOrder,
    this.questionId,
  });

  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
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

class QuestionTopic {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? icon;
  dynamic description;
  int? displayOrder;
  bool? isActive;
  bool? isImportant;
  String? chapterId;

  QuestionTopic({
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

  factory QuestionTopic.fromJson(Map<String, dynamic> json) => QuestionTopic(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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

class Review {
  String? questionId;
  String? questionText;
  List<ReviewOption>? options;
  String? selected;
  bool? isCorrect;
  String? explanation;
  ReviewTopic? topic;

  Review({
    this.questionId,
    this.questionText,
    this.options,
    this.selected,
    this.isCorrect,
    this.explanation,
    this.topic,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    questionId: json["questionId"],
    questionText: json["questionText"],
    options: json["options"] == null ? [] : List<ReviewOption>.from(json["options"]!.map((x) => ReviewOption.fromJson(x))),
    selected: json["selected"],
    isCorrect: json["isCorrect"],
    explanation: json["explanation"],
    topic: json["topic"] == null ? null : ReviewTopic.fromJson(json["topic"]),
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "questionText": questionText,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    "selected": selected,
    "isCorrect": isCorrect,
    "explanation": explanation,
    "topic": topic?.toJson(),
  };
}

class ReviewOption {
  String? id;
  String? text;
  bool? isCorrect;

  ReviewOption({
    this.id,
    this.text,
    this.isCorrect,
  });

  factory ReviewOption.fromJson(Map<String, dynamic> json) => ReviewOption(
    id: json["id"],
    text: json["text"],
    isCorrect: json["isCorrect"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "isCorrect": isCorrect,
  };
}

class ReviewTopic {
  String? id;
  String? name;

  ReviewTopic({
    this.id,
    this.name,
  });

  factory ReviewTopic.fromJson(Map<String, dynamic> json) => ReviewTopic(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
