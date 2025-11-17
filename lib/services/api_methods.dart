import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rank_up/custom_classes/loder.dart';

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


  static Future<Map<String, String>> withStoredToken() async {
    final token = await StorageManager.readData(StorageManager.accessToken);
    return {
      ...defaultHeaders,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}


///.........................

class ApiMethods {
  static final ApiMethods _apiCalling = ApiMethods._internal();

  ApiMethods._internal();

  factory ApiMethods() {
    return _apiCalling;
  }


  Future<CommonResponse?> postMultipartMultipleFiles({
    required String method,
    required Map<String, String> fields,
    required List<File> files,
    required String fileFieldName,
    Map<String, String>? headers,
  }) async {
    if (await Helper.checkInternetConnection()) {
      try {
        log("🔵 MULTIPART → $method");
        log("🔵 Fields → $fields");
        log("🔵 Files Count → ${files.length}");

        var uri = Uri.parse(method);
        var request = http.MultipartRequest('POST', uri);

        if (headers != null) {
          request.headers.addAll(headers);
        }

        request.fields.addAll(fields);

        for (var f in files) {
          request.files.add(
            await http.MultipartFile.fromPath(
              fileFieldName,
              f.path,
              contentType: MediaType("image", "jpeg"),
            ),
          );
        }

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        log("📩 MULTIPART RAW RESPONSE → ${response.body}");

        final Map<String, dynamic> json = jsonDecode(response.body);
        return CommonResponse.fromJson(json);

      } catch (e) {
        log("❌ Multipart error: $e");
        return CommonResponse(status: false, message: "Something went wrong");
      }
    } else {
      Helper.customToast("No internet");
      return CommonResponse(status: false, message: "No internet");
    }
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
  Future<CommonResponse?> patchMultipartMethodCM({
    required String method,
    File? file,
    String? fileFieldName,
    required Map<String, String> fields,
    Map<String, String>? headers,
  }) async {
    if (await Helper.checkInternetConnection()) {
      try {
        log('📤 PATCH Multipart URL: $method');
        log('📤 Fields: $fields');
        log('📤 File: ${file?.path ?? 'No file selected'}');

        var uri = Uri.parse(method);
        var request = http.MultipartRequest('PATCH', uri);

        // Add headers if available
        if (headers != null) {
          request.headers.addAll(headers);
        }

        // Add fields
        request.fields.addAll(fields);

        // Add file if provided
        if (file != null && fileFieldName != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              fileFieldName,
              file.path,
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        }

        // Send request
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        log('📩 PATCH Status Code: ${response.statusCode}');
        log('📩 PATCH Raw Response: ${response.body}');

        final Map<String, dynamic> json = jsonDecode(response.body);
        final commonRes = CommonResponse.fromJson(json);

        Helper.customToast(commonRes.message ?? "Something went wrong");
        return commonRes;
      } catch (ex) {
        log('❌ PATCH Multipart Error: $ex');
        return CommonResponse(status: false, message: "Something went wrong");
      }
    } else {
      Helper.customToast("No internet");
      return CommonResponse(status: false, message: "No internet");
    }
  }



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
class ApiHelper {
  static Future<CommonResponse?> callPostApi({
    required BuildContext context,
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      CommonLoaderApi.show(context);

      final res = await ApiMethods().postMethodCM(
        method: endpoint,
        body: body,
        header: {
          "Content-Type": "application/json",
        },
      );

      CommonLoaderApi.hide(context);

      Helper.customToast(res?.message ?? "Something went wrong");
      return res;
    } catch (e) {
      CommonLoaderApi.hide(context);
      Helper.customToast("API error occurred");
      return CommonResponse(status: false, message: "Error: $e");
    }
  }
}

