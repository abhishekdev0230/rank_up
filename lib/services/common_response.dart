import 'dart:convert';

CommonResponse commonResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  bool? status;
  String? message;
  dynamic data;
  int? statusCode;
  String? accessToken;
  String? refreshToken;
  bool? isNewUser;

  CommonResponse({
    this.status,
    this.message,
    this.data,
    this.statusCode,
    this.accessToken,
    this.refreshToken,
    this.isNewUser,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      status: json['status'] ?? false,
      statusCode: json['status_code'] ?? json['code'],
      message: json['message'] ?? json['messsage'] ?? '',
      data: json['data'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      isNewUser: json['isNewUser'], // 👈 added here
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'status_code': statusCode,
    'message': message,
    'data': data,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'isNewUser': isNewUser, // 👈 include it in toJson too
  };

  @override
  String toString() {
    return 'CommonResponse{status: $status, statusCode: $statusCode, message: $message, accessToken: $accessToken, refreshToken: $refreshToken, isNewUser: $isNewUser, data: $data}';
  }
}
