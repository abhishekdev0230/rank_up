// To parse this JSON data, do
//
//     final blogDetailModel = blogDetailModelFromJson(jsonString);

import 'dart:convert';

BlogDetailModel blogDetailModelFromJson(String str) => BlogDetailModel.fromJson(json.decode(str));

String blogDetailModelToJson(BlogDetailModel data) => json.encode(data.toJson());

class BlogDetailModel {
  bool? status;
  int? code;
  String? message;
  BlogDetailData? data;

  BlogDetailModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory BlogDetailModel.fromJson(Map<String, dynamic> json) => BlogDetailModel(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : BlogDetailData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class BlogDetailData {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? title;
  String? slug;
  String? excerpt;
  String? content;
  String? featuredImage;
  String? authorId;
  String? authorName;
  String? category;
  List<String>? tags;
  String? status;
  DateTime? publishedAt;
  int? viewCount;
  int? readTime;
  String? metaTitle;
  String? metaDesc;
  bool? isFeatured;

  BlogDetailData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.slug,
    this.excerpt,
    this.content,
    this.featuredImage,
    this.authorId,
    this.authorName,
    this.category,
    this.tags,
    this.status,
    this.publishedAt,
    this.viewCount,
    this.readTime,
    this.metaTitle,
    this.metaDesc,
    this.isFeatured,
  });

  factory BlogDetailData.fromJson(Map<String, dynamic> json) => BlogDetailData(
    id: json["id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    title: json["title"],
    slug: json["slug"],
    excerpt: json["excerpt"],
    content: json["content"],
    featuredImage: json["featuredImage"],
    authorId: json["authorId"],
    authorName: json["authorName"],
    category: json["category"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    status: json["status"],
    publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
    viewCount: json["viewCount"],
    readTime: json["readTime"],
    metaTitle: json["metaTitle"],
    metaDesc: json["metaDesc"],
    isFeatured: json["isFeatured"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "title": title,
    "slug": slug,
    "excerpt": excerpt,
    "content": content,
    "featuredImage": featuredImage,
    "authorId": authorId,
    "authorName": authorName,
    "category": category,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "status": status,
    "publishedAt": publishedAt?.toIso8601String(),
    "viewCount": viewCount,
    "readTime": readTime,
    "metaTitle": metaTitle,
    "metaDesc": metaDesc,
    "isFeatured": isFeatured,
  };
}
