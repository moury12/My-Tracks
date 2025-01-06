import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/review/review_model.dart';
import 'package:track_trek/core/model/review/review_model.dart';
import 'package:track_trek/core/model/review/review_model.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class ReviewService {
  static Future<bool> likeDislikeRequest({
    required String trackId,
  }) async {
    try {
      final url = Uri.parse('${ApiClient.getLikeDisLikeUrl}?trackId=$trackId');
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };

      final response = await http.post(url, headers: headers);
      final responseData = json.decode(response.body);
      log('-----------------LIKE DISLIKE call--------------------');
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

  static Future<bool> postReviewRequest({
    required String trackId,
    required String rating,
    required String review,
  }) async {
    try {
      final url = Uri.parse('${ApiClient.getLikeDisLikeUrl}?trackId=$trackId');
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };
      final body =
          jsonEncode({"trackId": trackId, "rating": rating, "review": review});
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log('-----------------post review call--------------------');
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

  static Future<List<ReviewModel>> getReviewList({
    required String trackId,
    String sort = '',
    required int page,
  })
  async {
    List<ReviewModel> reviewList = [];
    try {
      final url = Uri.parse('${ApiClient.getAllReviewUrl}'
          '?trackId=$trackId${sort.isNotEmpty ? '&sort=$sort' : ''}&limit=10&page=$page');
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
      log('----------------- review List call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        if (responseData['data']["result"] is List) {
          reviewList = (responseData['data']["result"] as List)
              .map((e) => ReviewModel.fromJson(e))
              .toList();
        }
        return reviewList;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return reviewList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return reviewList;
  }
}
