class SubscriptionPlansResponse {
  bool? status;
  int? code;
  String? message;
  SubscriptionData? data;

  SubscriptionPlansResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SubscriptionPlansResponse.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlansResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : SubscriptionData.fromJson(json["data"]),
      );
}

class SubscriptionData {
  UserModel? user;
  List<SubscriptionPlan>? plans;

  SubscriptionData({
    this.user,
    this.plans,
  });

  factory SubscriptionData.fromJson(Map<String, dynamic> json) =>
      SubscriptionData(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        plans: json["plans"] == null
            ? []
            : List<SubscriptionPlan>.from(
            json["plans"].map((x) => SubscriptionPlan.fromJson(x))),
      );
}

class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  bool? isPremium;
  String? premiumExpiry;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.isPremium,
    this.premiumExpiry,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    isPremium: json["isPremium"],
    premiumExpiry: json["premiumExpiry"],
  );
}

class SubscriptionPlan {
  String? id;
  String? name;
  int? price;
  String? type;
  int? duration;
  List<String>? features;

  SubscriptionPlan({
    this.id,
    this.name,
    this.price,
    this.type,
    this.duration,
    this.features,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlan(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        type: json["type"],
        duration: json["duration"],
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"].map((x) => x)),
      );
}
