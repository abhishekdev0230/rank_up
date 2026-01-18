class SubscriptionPlansResponse {
  final bool? status;
  final int? code;
  final String? message;
  final SubscriptionData? data;

  SubscriptionPlansResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SubscriptionPlansResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlansResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: json['data'] != null
          ? SubscriptionData.fromJson(json['data'])
          : null,
    );
  }
}
class SubscriptionData {
  final UserModel? user;
  final List<SubscriptionPlan> plans;

  SubscriptionData({
    this.user,
    required this.plans,
  });

  factory SubscriptionData.fromJson(Map<String, dynamic> json) {
    return SubscriptionData(
      user:
      json['user'] != null ? UserModel.fromJson(json['user']) : null,
      plans: (json['plans'] as List<dynamic>? ?? [])
          .map((e) => SubscriptionPlan.fromJson(e))
          .toList(),
    );
  }
}
class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final bool? isPremium;
  final DateTime? premiumExpiry;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.isPremium,
    this.premiumExpiry,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      isPremium: json['isPremium'],
      premiumExpiry: json['premiumExpiry'] != null
          ? DateTime.parse(json['premiumExpiry'])
          : null,
    );
  }
}
class SubscriptionPlan {
  final String? id;
  final String? name;
  final int? price;
  final String? type;
  final int? duration;
  final bool? isActive;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> features;

  SubscriptionPlan({
    this.id,
    this.name,
    this.price,
    this.type,
    this.duration,
    this.isActive,
    this.description,
    this.createdAt,
    this.updatedAt,
    required this.features,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      type: json['type'],
      duration: json['duration'],
      isActive: json['isActive'],
      description: json['description'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      features: (json['features'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
