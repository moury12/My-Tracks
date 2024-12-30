import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:track_trek/core/utils/helper_function.dart';

class UserService {
  static Future<UserModel> getUserData() async {
    UserModel user = UserModel();
    try {
      final url = Uri.parse(ApiClient.userProfileUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };

      final response = await http.get(
        url,
        headers: headers,
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      log('-----------------user profile call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        user = UserModel.fromJson(responseData['data']);
        return user;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return user;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return user;
  }

  static Future<bool> updateProfileCall({
    required String name,
    required String phoneNumber,
    required String address,
    required File? file,
  })
  async {
    try {
      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse(ApiClient.userEditProfileUrl),
      );

      request.headers['Authorization'] =
          'Bearer ${Boxes.getUserData().get(tokenKey)}';

      request.fields['name'] = name;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['address'] = address;

      if (file != null && await file.exists()) {
        final mimeType =
            lookupMimeType(file.path) ?? 'application/octet-stream';
        final mimeSplit = mimeType.split('/');
        request.files.add(
          await http.MultipartFile.fromPath(
            'profile_image',
            file.path,
            contentType: MediaType(mimeSplit[0], mimeSplit[1]),
          ),
        );
      } else {
        debugPrint('No file selected or file does not exist.');
      }

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      log('-----------------update profile call--------------------');
      log(responseData.body);

      // Decode the response body
      final Map<String, dynamic> data = json.decode(responseData.body);

      if (data['success'] != null && data['success'] == true) {
        showCustomSnackbar(
            title: AppStaticString.success,
            message: data['message'],
            type: SnackBarType.success);
        return true;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: data['message'],
            type: SnackBarType.failed);
        return false;
      }
    } catch (e) {
      debugPrint('Error during profile update: $e');
      return false;
    }

  }
  static Future<bool> changePasswordRequest({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  })
  async {
    try {
      final url = Uri.parse(ApiClient.changePassUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };
      final body = jsonEncode({
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,

      });
      final response = await http.patch(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log('-----------------change password call--------------------');
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
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return false;
      }
    } catch (e) {
      showCustomSnackbar(
          title: AppStaticString.failed,
          message: e.toString(),
          type: SnackBarType.failed);
      debugPrint(e.toString());
      return false;
    }
  }
  static Future<bool> deleteAccountRequest({
    required String email,
    required String password,

  })
  async {
    try {
      final url = Uri.parse(ApiClient.deleteProfileUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };
      final body = jsonEncode({
        "email": email,
        "password": password,


      });
      final response = await http.delete(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log('-----------------delete account call--------------------');
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
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return false;
      }
    } catch (e) {
      showCustomSnackbar(
          title: AppStaticString.failed,
          message: e.toString(),
          type: SnackBarType.failed);
      debugPrint(e.toString());
      return false;
    }
  }
}
