// import 'package:flutter/material.dart';
// import 'package:privee_club/Utils/helper.dart';
// import 'package:privee_club/services/api_urls.dart';
// import 'api_methods.dart';
//
// class Api {
//   static final Api _api = Api._internal();
//
//   Api._internal();
//
//   factory Api() {
//     return _api;
//   }
//
//   ///-------------Header Without Token----------------------
//
//   static final ApiMethods _apiCalling = ApiMethods();
//
//   static Map<String, String> headerWithoutToken() {
//     return {
//       'Content-Type': 'application/json',
//       'accept': 'application/json',
//       'X-CLIENT': 'e0271afd8a3b8257af70deacee4',
//     };
//   }
//
//   ///-------------Header With Token----------------------
//
//   static Future<Map<String, String>> headerWithToken([
//     bool? isMultipart,
//   ]) async {
//     String? token = await Helper.getAccessToken();
//     debugPrint("Token: $token ");
//     // String? id = await Utility.getUserID();
//     if (isMultipart ?? false) {
//       debugPrint("Trueeee");
//       return {
//         'Authorization': "Bearer $token",
//         // 'Authorization':
//         //     "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxNiwiaWF0IjoxNzMyMDk5MTcyfQ.Ehmez8L_TAf--XDKX4TIvr98hObtBa5WSOGJoHNEecU",
//         'accept': 'application/json',
//         'content-type': 'application/json',
//       };
//     } else {
//       debugPrint("Falseeeee");
//       return {
//         "api-access-token":
//             "eb8b0f58c895019fcbc3bb17480ced3a2d1e12a346d6ed0f0d0267a24587a203",
//         'content-type': 'application/json',
//         'accept': 'application/json',
//       };
//     }
//   }
//
//   ///------------->>>  login  <<<----------------------
//   static Future<CommonResponse> login(
//     Map<String, dynamic> body,
//   ) async {
//     if (await Helper.checkInternetConnection()) {
//       var header = headerWithoutToken();
//
//       String res = await _apiCalling.postMethod(
//           method: ApiUrls.login, body: body, header: header);
//       if (res.isNotEmpty) {
//         try {
//           return commonResponseFromJson(res);
//         } catch (ex) {
//           debugPrint(
//             'Error:-  -------> ${ApiUrls.login}  --  ${ex.toString()} <--------',
//           );
//           return CommonResponse(
//             status: false,
//             message: 'One: ${ex.toString()}',
//           );
//         }
//       } else {
//         return CommonResponse(
//           status: false,
//           message: "Something went wrong, Try again later",
//         );
//       }
//     } else {
//       return CommonResponse(status: false, message: "No Internet");
//     }
//   }
//
//   ///------------->>>  addFlockWeight  <<<----------------------
//   static Future<CommonResponse> addFlockWeight(
//     Map<String, dynamic> body,
//   ) async {
//     if (await Helper.checkInternetConnection()) {
//       var header = await headerWithToken(true);
//
//       String res = await _apiCalling.postMethod(
//           method: ApiUrls.addFlockWeight, body: body, header: header);
//       if (res.isNotEmpty) {
//         try {
//           return commonResponseFromJson(res);
//         } catch (ex) {
//           debugPrint(
//             'Error:-  -------> ${ApiUrls.addFlockWeight}  --  ${ex.toString()} <--------',
//           );
//           return CommonResponse(
//             status: false,
//             message: 'One: ${ex.toString()}',
//           );
//         }
//       } else {
//         return CommonResponse(
//           status: false,
//           message: "Something went wrong, Try again later",
//         );
//       }
//     } else {
//       return CommonResponse(status: false, message: "No Internet");
//     }
//   }
//
//   ///------------->>>  addFlockMedication  <<<----------------------
//   static Future<CommonResponse> addFlockMedication(
//     Map<String, dynamic> body,
//   ) async {
//     if (await Helper.checkInternetConnection()) {
//       var header = await headerWithToken(true);
//
//       String res = await _apiCalling.postMethod(
//           method: ApiUrls.addFlockMedication, body: body, header: header);
//       if (res.isNotEmpty) {
//         try {
//           return commonResponseFromJson(res);
//         } catch (ex) {
//           debugPrint(
//             'Error:-  -------> ${ApiUrls.addFlockMedication}  --  ${ex.toString()} <--------',
//           );
//           return CommonResponse(
//             status: false,
//             message: 'One: ${ex.toString()}',
//           );
//         }
//       } else {
//         return CommonResponse(
//           status: false,
//           message: "Something went wrong, Try again later",
//         );
//       }
//     } else {
//       return CommonResponse(status: false, message: "No Internet");
//     }
//   }
//
//   ///------------->>>  addFlockFeed  <<<----------------------
//   static Future<CommonResponse> addFlockFeed(
//     Map<String, dynamic> body,
//   ) async {
//     if (await Helper.checkInternetConnection()) {
//       var header = await headerWithToken(true);
//
//       String res = await _apiCalling.postMethod(
//           method: ApiUrls.addFlockFeed, body: body, header: header);
//       if (res.isNotEmpty) {
//         try {
//           return commonResponseFromJson(res);
//         } catch (ex) {
//           debugPrint(
//             'Error:-  -------> ${ApiUrls.addFlockFeed}  --  ${ex.toString()} <--------',
//           );
//           return CommonResponse(
//             status: false,
//             message: 'One: ${ex.toString()}',
//           );
//         }
//       } else {
//         return CommonResponse(
//           status: false,
//           message: "Something went wrong, Try again later",
//         );
//       }
//     } else {
//       return CommonResponse(status: false, message: "No Internet");
//     }
//   }
//
//   ///------------->>>  addFlockMortality  <<<----------------------
//   static Future<CommonResponse> addFlockMortality(
//     Map<String, dynamic> body,
//   ) async {
//     if (await Helper.checkInternetConnection()) {
//       var header = await headerWithToken(true);
//
//       String res = await _apiCalling.postMethod(
//           method: ApiUrls.addFlockMortality, body: body, header: header);
//       if (res.isNotEmpty) {
//         try {
//           return commonResponseFromJson(res);
//         } catch (ex) {
//           debugPrint(
//             'Error:-  -------> ${ApiUrls.addFlockMortality}  --  ${ex.toString()} <--------',
//           );
//           return CommonResponse(
//             status: false,
//             message: 'One: ${ex.toString()}',
//           );
//         }
//       } else {
//         return CommonResponse(
//           status: false,
//           message: "Something went wrong, Try again later",
//         );
//       }
//     } else {
//       return CommonResponse(status: false, message: "No Internet");
//     }
//   }
//   ///------------->>>  addFlockMortality  <<<----------------------
//   static Future<CommonResponse> addFlockGeneralNote(
//     Map<String, dynamic> body,
//   ) async {
//     if (await Helper.checkInternetConnection()) {
//       var header = await headerWithToken(true);
//
//       String res = await _apiCalling.postMethod(
//           method: ApiUrls.addFlockGeneralNote, body: body, header: header);
//       if (res.isNotEmpty) {
//         try {
//           return commonResponseFromJson(res);
//         } catch (ex) {
//           debugPrint(
//             'Error:-  -------> ${ApiUrls.addFlockGeneralNote}  --  ${ex.toString()} <--------',
//           );
//           return CommonResponse(
//             status: false,
//             message: 'One: ${ex.toString()}',
//           );
//         }
//       } else {
//         return CommonResponse(
//           status: false,
//           message: "Something went wrong, Try again later",
//         );
//       }
//     } else {
//       return CommonResponse(status: false, message: "No Internet");
//     }
//   }
//
//   ///------------->>>  editFlockDepletionDataInFlock  <<<----------------------
//   static Future<CommonResponse> editFlockDepletionDataInFlock(
//     Map<String, dynamic> body,
//   ) async {
//     if (await Helper.checkInternetConnection()) {
//       var header = await headerWithToken(true);
//
//       String res = await _apiCalling.postMethod(
//           method: ApiUrls.editFlockDepletionDataInFlock,
//           body: body,
//           header: header);
//       if (res.isNotEmpty) {
//         try {
//           return commonResponseFromJson(res);
//         } catch (ex) {
//           debugPrint(
//             'Error:-  -------> ${ApiUrls.editFlockDepletionDataInFlock}  --  ${ex.toString()} <--------',
//           );
//           return CommonResponse(
//             status: false,
//             message: 'One: ${ex.toString()}',
//           );
//         }
//       } else {
//         return CommonResponse(
//           status: false,
//           message: "Something went wrong, Try again later",
//         );
//       }
//     } else {
//       return CommonResponse(status: false, message: "No Internet");
//     }
//   }
//
//   ///------------->>>  addFlockDepletionType  <<<----------------------
//   static Future<CommonResponse> addFlockDepletionType(
//     Map<String, dynamic> body,
//   ) async {
//     if (await Helper.checkInternetConnection()) {
//       var header = await headerWithToken(true);
//
//       String res = await _apiCalling.postMethod(
//           method: ApiUrls.addFlockDepletionType, body: body, header: header);
//       if (res.isNotEmpty) {
//         try {
//           return commonResponseFromJson(res);
//         } catch (ex) {
//           debugPrint(
//             'Error:-  -------> ${ApiUrls.addFlockDepletionType}  --  ${ex.toString()} <--------',
//           );
//           return CommonResponse(
//             status: false,
//             message: 'One: ${ex.toString()}',
//           );
//         }
//       } else {
//         return CommonResponse(
//           status: false,
//           message: "Something went wrong, Try again later",
//         );
//       }
//     } else {
//       return CommonResponse(status: false, message: "No Internet");
//     }
//   }
//
//
// }
