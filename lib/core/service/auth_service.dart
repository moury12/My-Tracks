import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class AuthService {
  static Future<Map<String, dynamic>> loginRequest({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse(ApiClient.loginUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      final body = jsonEncode({'email': email, 'password': password});
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log(responseData.toString());
      if (responseData['status'] != null &&
          responseData['status'] == 'Success') {
        return responseData;
      } else {
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }

  static Future<Map<String, dynamic>> activeUser({
    required String email,
    required String code,
  }) async {
    try {
      final url = Uri.parse(ApiClient.activeUserUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      final body = jsonEncode({'email': email, 'code': code});
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log(responseData.toString());
      if (responseData['status'] != null &&
          responseData['status'] == 'Success') {
        return responseData;
      } else {
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }

  static Future<bool> registrationRequest({
    required Map<String, dynamic> bodyMap,
    // File? file,
  }) async {
    try {
      final url = Uri.parse(ApiClient.registrationUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      final body = jsonEncode(bodyMap);
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log('-----------------registration call--------------------');
      log(body.toString());
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        showCustomSnackbar(
            title: AppStaticString.success,
            message: responseData['message'],
            type: SnackBarType.success);
        return true;
      } else {
        showCustomSnackbar(
            title:AppStaticString.failed ,
            message: responseData['message'],
            type: SnackBarType.failed);
        return false;
      }
    } catch (e) {
      showCustomSnackbar(
          title:AppStaticString.failed ,
          message: e.toString(),
          type: SnackBarType.failed);
      return false;
    }
    return false;
  }

  static Future<Map<String, dynamic>> fetchUserProfile(
      {required String token}) async {
    try {
      final url = Uri.parse(ApiClient.userProfileUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      final response = await http.get(
        url,
        headers: headers,
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      log(responseData.toString());
      if (responseData['status'] != null &&
          responseData['status'] == 'Success') {
        return responseData;
      } else {
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }

  static Future<Map<String, dynamic>> updateProfile({
    required String firstName,
    required String lastName,
    required String address,
    required File? file,
    required String token,
  }) async {
    try {
      final request =
          http.MultipartRequest('PATCH', Uri.parse(ApiClient.updateUserUrl));

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['address'] = address;

      if (file != null && await file.exists()) {
        final mimeType =
            lookupMimeType(file.path) ?? 'application/octet-stream';
        final mimeSplit = mimeType.split('/');
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            file.path,
            contentType: MediaType(mimeSplit[0], mimeSplit[1]),
          ),
        );
      } else {
        debugPrint('No file selected or file does not exist.');
      }

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final data = json.decode(responseData.body);
        debugPrint('Success: ${data['message']}');
        return data;
      } else {
        debugPrint('Failed to update profile: ${response.statusCode}');
        debugPrint('Error details: ${responseData.body}');
      }
    } catch (e) {
      debugPrint('Error during profile update: $e');
    }
    return {};
  }
}
