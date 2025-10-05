import 'dart:convert';

CommonResponse commonResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  bool? status;
  String? message;
  dynamic data;
  int? statusCode;

  CommonResponse({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      status: json['status'] ?? false,
      statusCode: json['status_code'],
      // 🔹 Handle both "message" and "messsage"
      message: json['message'] ?? json['messsage'] ?? '',
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'status_code': statusCode,
    'message': message,
    'data': data,
  };

  @override
  String toString() {
    return 'CommonResponse{status: $status, statusCode: $statusCode, message: $message, data: $data}';
  }
}

// class CommonResponse {
//   bool? status;
//   int? statusCode;
//   String? message;
//   Data? data;
//
//   CommonResponse({this.status, this.statusCode, this.message, this.data});
//
//   CommonResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     statusCode = json['status_code'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['status_code'] = this.statusCode;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? name;
//   String? email;
//   String? image;
//   String? showPassword;
//   String? createdAt;
//   String? updatedAt;
//   String? token;
//
//   Data(
//       {this.id,
//         this.name,
//         this.email,
//         this.image,
//         this.showPassword,
//         this.createdAt,
//         this.updatedAt,
//         this.token});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     image = json['image'];
//     showPassword = json['show_password'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     token = json['token'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['image'] = this.image;
//     data['show_password'] = this.showPassword;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['token'] = this.token;
//     return data;
//   }
// }
