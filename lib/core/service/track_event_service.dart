import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class TrackEventService {
  static Future<String> addTrackCall(
      {required String trackName,
      required String category,
      required String address,
      required String longitude,
      required String latitude,
      required String description,
      required List<File>? files}) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiClient.addBusinessTrackUrl),
      );

      request.headers['Authorization'] =
          'Bearer ${Boxes.getUserData().get(tokenKey)}';

      request.fields['trackName'] = trackName;
      request.fields['category'] = category;
      request.fields['address'] = address;
      request.fields['longitude'] = longitude;
      request.fields['latitude'] = latitude;
      request.fields['description'] = description;

      if (files != null && files.isNotEmpty) {
        for (File file in files) {
          if (await file.exists()) {
            final mimeType =
                lookupMimeType(file.path) ?? 'application/octet-stream';
            final mimeSplit = mimeType.split('/');
            request.files.add(
              await http.MultipartFile.fromPath(
                'track_image', // Key for multiple files
                file.path,
                contentType: MediaType(mimeSplit[0], mimeSplit[1]),
              ),
            );
          } else {
            debugPrint('File does not exist: ${file.path}');
          }
        }
      } else {
        debugPrint('No files selected or file list is empty.');
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
        return data['data']['_id'];
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: data['message'],
            type: SnackBarType.failed);
        return data['data']['_id'] ?? '';
      }
    } catch (e) {
      debugPrint('Error during profile update: $e');
      return '';
    }
  }

  static Future<List<CategoryModel>> getCategoryListCall() async {
    List<CategoryModel> category = [];
    try {
      final url = Uri.parse('${ApiClient.categoryUrl}?page=1&limit=1000');
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
      log('-----------------category  call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        category = responseData['data']['category'].forEach((e) {
          category.add(CategoryModel.fromJson(e));
        });
        return category;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return category;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return category;
  }
}
