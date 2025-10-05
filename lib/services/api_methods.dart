import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utils/helper.dart';
import 'api_key_word.dart';
import 'common_response.dart';
import 'local_storage.dart';
class ApiHeaders {
  static Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-CLIENT': ApiKeyWord.xCLIENT,
  };

  // static Map<String, String> withAuth(String token) {
  //   return {
  //     ...defaultHeaders,
  //     'Authorization': 'Bearer $token',
  //   };
  // }

  static Future<Map<String, String>> withStoredToken() async {
    final token = await StorageManager.readData(StorageManager.accessToken);
    return {
      ...defaultHeaders,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}

///.........use.........
// Map<String, String> headers = ApiHeaders.defaultHeaders;

// Map<String, String> headers = ApiHeaders.withAuth(userToken);

///.........................

class ApiMethods {
  static final ApiMethods _apiCalling = ApiMethods._internal();

  ApiMethods._internal();

  factory ApiMethods() {
    return _apiCalling;
  }




  ///--------------Get Method (Pagination)-----------------------

  Future<String> getMethod(
      {required String method,
      required Map<String, dynamic> body,
      Map<String, String>? header}) async {
    if (await Helper.checkInternetConnection()) {
      try {
        debugPrint('Get Url: $method');

        if (header != null) {
          debugPrint('header:- ${header.toString()}');
        }
        log('Params11: $body');

        final response = await http.get(
          Uri.parse(method),
          // .replace(queryParameters: body),
          headers: header,
        );
        log('$method----> Response11: ${response.body} <----');
        return response.body;
      } catch (e) {
        debugPrint('Error:- $method----> ${e.toString()} <----');
        return '';
      }
    } else {
      Helper.customToast("No internet");
      return '';
    }
  }

  ///--------------Get Method-----------------------

  Future<String> getMethodTwo(
      {required String method,
      required Map<String, dynamic> body,
      Map<String, String>? header}) async {
    if (await Helper.checkInternetConnection()) {
      try {
        debugPrint('Get Url: $method');

        if (header != null) {
          debugPrint('header:- ${header.toString()}');
        }
        log('Params: $body');

        final response = await http.get(
          Uri.parse(method).replace(queryParameters: body),
          headers: header,
        );
        log('$method----> Response: ${response.body} <----');
        return response.body;
      } catch (e) {
        debugPrint('Error:- $method----> ${e.toString()} <----');
        return '';
      }
    } else {
      Helper.customToast("No internet");
      return '';
    }
  }

  ///-------------- Delete Method-----------------------

  Future<String> deleteMethod(
      {required String method,
      required Map<String, dynamic> body,
      Map<String, String>? header}) async {
    if (await Helper.checkInternetConnection()) {
      try {
        debugPrint('Delete Url: $method');

        if (header != null) {
          debugPrint('header:- ${header.toString()}');
        }
        log('Params: $body');
        final response = await http.delete(
          Uri.parse(method),
          body: jsonEncode(body),
          headers: header,
        );
        log('$method ----> Response: ${response.body} <----');
        return response.body;
      } catch (ex) {
        debugPrint('Error:- $method ----> ${ex.toString()} <----');
        return "";
      }
    } else {
      Helper.customToast("No internet");
      return '';
    }
  }

  ///--------------Multipart POST Method (for file uploads)-----------------------
  //
  // Future<String> postMultipartMethod({
  //   required String method,
  //   required File file,
  //   required String fileFieldName,
  //   required Map<String, String> fields,
  //   Map<String, String>? headers,
  // }) async {
  //   if (await Helper.checkInternetConnection()) {
  //     try {
  //       log(' POST Multipart URL: $method');
  //       log(' Fields: $fields');
  //       log(' File Path: ${file.path}');
  //
  //       var uri = Uri.parse(method);
  //       var request = http.MultipartRequest('POST', uri);
  //
  //       // Add headers if available
  //       if (headers != null) {
  //         request.headers.addAll(headers);
  //       }
  //
  //       // Add fields
  //       request.fields.addAll(fields);
  //
  //       // Add file
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           fileFieldName,
  //           file.path,
  //           contentType: MediaType('image', 'jpeg'),
  //         ),
  //       );
  //
  //       // Send the request
  //       var streamedResponse = await request.send();
  //
  //       // Convert the streamed response to a normal response
  //       var response = await http.Response.fromStream(streamedResponse);
  //
  //       log(' Multipart Response: ${response.body}');
  //       return response.body;
  //     } catch (ex) {
  //       log(' Multipart Error: $ex');
  //       return '';
  //     }
  //   } else {
  //     Helper.customToast("No internet");
  //     return '';
  //   }
  // }



  // Future<CommonResponse?> postMultipartMethodCM({
  //   required String method,
  //   required File file,
  //   required String fileFieldName,
  //   required Map<String, String> fields,
  //   Map<String, String>? headers,
  // }) async {
  //   if (await Helper.checkInternetConnection()) {
  //     try {
  //       log('📤 POST Multipart URL: $method');
  //       log('📤 Fields: $fields');
  //       log('📤 File Path: ${file.path}');
  //
  //       var uri = Uri.parse(method);
  //       var request = http.MultipartRequest('POST', uri);
  //
  //       // Add headers if available
  //       if (headers != null) {
  //         request.headers.addAll(headers);
  //       }
  //
  //       // Add fields
  //       request.fields.addAll(fields);
  //
  //       // Add file
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           fileFieldName,
  //           file.path,
  //           contentType: MediaType('image', 'jpeg'), // Adjust type if needed
  //         ),
  //       );
  //
  //       // Send the request
  //       var streamedResponse = await request.send();
  //
  //       // Convert the streamed response to a normal response
  //       var response = await http.Response.fromStream(streamedResponse);
  //
  //       log('📩 Multipart Status Code: ${response.statusCode}');
  //       log('📩 Multipart Raw Response: ${response.body}');
  //
  //       final Map<String, dynamic> json = jsonDecode(response.body);
  //
  //       log('📩 Parsed JSON: $json');
  //
  //       final commonRes = CommonResponse.fromJson(json);
  //
  //       // ✅ Toast show kro
  //       Helper.customToast(commonRes.message ?? "Something went wrong");
  //
  //       return commonRes;
  //     } catch (ex) {
  //       log('❌ Multipart Error: $ex');
  //       return CommonResponse(status: false, message: "Something went wrong");
  //     }
  //   } else {
  //     Helper.customToast("No internet");
  //     return CommonResponse(status: false, message: "No internet");
  //   }
  // }

  // Future<CommonResponse?> postMultipartMethodMultipalPhotosCM({
  //   required String method,
  //   required List<File> files,
  //   required String fileFieldName,
  //   required Map<String, String> fields,
  //   Map<String, String>? headers,
  // }) async {
  //   if (await Helper.checkInternetConnection()) {
  //     try {
  //       log('📤 POST Multipart URL: $method');
  //       log('📤 Fields: $fields');
  //       log('📤 File Paths: ${files.map((e) => e.path).toList()}');
  //
  //       var uri = Uri.parse(method);
  //       var request = http.MultipartRequest('POST', uri);
  //
  //       // Add headers if available
  //       if (headers != null) {
  //         request.headers.addAll(headers);
  //       }
  //
  //       // Add fields
  //       request.fields.addAll(fields);
  //
  //       // Add multiple files
  //       for (var file in files) {
  //         request.files.add(
  //           await http.MultipartFile.fromPath(
  //             fileFieldName,
  //             file.path,
  //             contentType: MediaType('image', 'jpeg'), // or 'png'
  //           ),
  //         );
  //       }
  //
  //       var streamedResponse = await request.send();
  //       var response = await http.Response.fromStream(streamedResponse);
  //
  //       log('📩 Multipart Status Code: ${response.statusCode}');
  //       log('📩 Multipart Raw Response: ${response.body}');
  //
  //       final Map<String, dynamic> json = jsonDecode(response.body);
  //       log('📩 Parsed JSON: $json');
  //
  //       final commonRes = CommonResponse.fromJson(json);
  //
  //       Helper.customToast(commonRes.message ?? "Something went wrong");
  //
  //       return commonRes;
  //     } catch (ex) {
  //       log('❌ Multipart Error: $ex');
  //       return CommonResponse(status: false, message: "Something went wrong");
  //     }
  //   } else {
  //     Helper.customToast("No internet");
  //     return CommonResponse(status: false, message: "No internet");
  //   }
  // }

  ///--------------Post Method-----------------------

  Future<String> postMethod(
      {required String method,
      required Map<String, dynamic> body,
      Map<String, String>? header}) async {
    if (await Helper.checkInternetConnection()) {
      try {
        debugPrint('Post Url: $method');

        if (header != null) {
          debugPrint('header:- ${header.toString()}');
        }
        log('Params: $body');
        final response = await http.post(
          Uri.parse(method),
          body: jsonEncode(body),
          headers: header,
        );
        log('$method ----> Response: ${response.body} <----');
        return response.body;
      } catch (ex) {
        debugPrint('Error:- $method ----> ${ex.toString()} <----');
        return "";
      }
    } else {
      Helper.customToast("No internet");
      return '';
    }
  }



  ///--------------Post Method-----------------------
  Future<CommonResponse?> postMethodCM({
    required String method,
    required Map<String, dynamic> body,
    Map<String, String>? header,
  }) async {
    if (await Helper.checkInternetConnection()) {
      try {
        print("🔹 API CALL → $method");
        print("🔹 Headers → ${header ?? {}}");
        print("🔹 Request Body → ${jsonEncode(body)}");

        final response = await http.post(
          Uri.parse(method),
          body: jsonEncode(body),
          headers: header,
        );

        print("🔹 Status Code → ${response.statusCode}");
        print("🔹 Raw Response → ${response.body}");

        final Map<String, dynamic> json = jsonDecode(response.body);
        print("🔹 Parsed JSON → $json");

        final commonResponse = CommonResponse.fromJson(json);
        if (commonResponse.status == false) {
          Helper.customToast(commonResponse.message!);
        }


        return commonResponse;
      } catch (ex) {

        print("❌ API Exception → $ex");
        return CommonResponse(status: false, message: "Something went wrong");
      }
    } else {
      print("❌ No internet connection");
      Helper.customToast("No internet");
      return CommonResponse(status: false, message: "No internet");
    }
  }



}
