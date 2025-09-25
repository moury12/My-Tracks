import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/notification/Notification_model.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class NotificationService {
  static Future<List<NotificationModel>> getNotificationList() async {
    List<NotificationModel> notificationList = [];
    try {
      final url = Uri.parse(ApiClient.getNotificationUrl);
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
      log('----------------- notification List call--------------------');
      // log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        if (responseData['data'] is List) {
          notificationList = (responseData['data'] as List)
              .map((e) => NotificationModel.fromJson(e))
              .toList();
        }
        return notificationList;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return notificationList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return notificationList;
  }
}
