import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/manage/manage_model.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class ManageService {
  static Future<bool> postFeedbackRequest({
    required String userName,
    required String feedback,
  }) async {
    try {
      final url = Uri.parse(ApiClient.postFeedbackUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };
      final body = jsonEncode({
        "userName": userName,
        "feedback": feedback,
      });
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log('-----------------post feedback call--------------------');
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

  static Future<ManageModel> getPrivacyPolicy() async {
    ManageModel privacyPolicy = ManageModel();
    try {
      final url = Uri.parse(ApiClient.getPrivacyPolicy);
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
      log('----------------- privacy policy call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        privacyPolicy = ManageModel.fromJson(responseData['data']);

        return privacyPolicy;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return privacyPolicy;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return privacyPolicy;
  }

  static Future<bool> getSinglePayoutInfo() async {
    try {
      final url = Uri.parse(ApiClient.getSinglePayoutUrl);
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
      log('----------------- single payout call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        return true;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }
  static Future<String> redirectToStripeInfo() async {
    try {
      final url = Uri.parse(ApiClient.paymentOnboardingUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };

      final response = await http.post(
        url,
        headers: headers,
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      log('----------------- stripe Onboarding call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        return responseData['data']['accountLink']['url'];
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return '';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return '';
  }

  static Future<ManageModel> getTermsCondition() async {
    ManageModel terms = ManageModel();
    try {
      final url = Uri.parse(ApiClient.getTermsConditionUrl);
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
      log('----------------- terms condition call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        terms = ManageModel.fromJson(responseData['data']);

        return terms;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return terms;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return terms;
  }
}
