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
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
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

      log('-----------------post track call--------------------');
      log(request.files.toString());
      log(request.fields.toString());
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

  static Future<bool> updateTrackRequest({
    required String trackId,
    required List<String> trackDays,
  }) async {
    try {
      final url = Uri.parse(ApiClient.updateTrackUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };
      final body = jsonEncode({"trackId": trackId, "trackDays": trackDays});
      final response = await http.patch(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log('-----------------update track call--------------------');
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

  static Future<bool> createTrackSlotRequest({
    required String trackId,
    required String day,
    required String slotNo,
    required String startTime,
    required String endTime,
    required String price,
    required String maxPeople,
    required String description,
  }) async {
    try {
      final url = Uri.parse(ApiClient.createTrackSlotUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };
      final body = jsonEncode({
        "trackId": trackId,
        "day": day,
        "slotNo": slotNo,
        "startTime": startTime,
        "endTime": endTime,
        "price": price,
        "maxPeople": maxPeople,
        "description": description
      });
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log('-----------------create slot call--------------------');
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

  static Future<SingleTrackModel> getSingleTrackData({
    required String trackId,
  })
  async {
    SingleTrackModel singleTrackDetails = SingleTrackModel();
    try {
      final url = Uri.parse(
          '${ApiClient.getSingleBusinessUrl}?trackId=$trackId&getSlots=yes');
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
      log('-----------------single Track Details call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        singleTrackDetails = SingleTrackModel.fromJson(responseData['data']);
        return singleTrackDetails;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return singleTrackDetails;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return singleTrackDetails;
  }
/*  static Future<bool> deleteSlot({
    required String slotID
})async{

}*/
}
