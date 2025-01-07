import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/event_for_user_panel_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/event_for_user_panel_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/event_for_user_panel_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/track_for_user_panel.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class UserHomeService {
  static Future<List<CategoryModel>> getCategoryList() async {
    List<CategoryModel> catList = [];
    try {
      final url = Uri.parse('${ApiClient.getCategoryUrl}'
          '?page=1&limit=1000');
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
      log('----------------- category List call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        if (responseData['data']["category"] is List) {
          catList = (responseData['data']["category"] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList();
        }
        return catList;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return catList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return catList;
  }

  static Future<List<TrackForUserPanelModel>> getTrackListForUserPanel(
      {String category = '', String? long, String? lat}) async {
    List<TrackForUserPanelModel> trackList = [];
    try {
      final url = Uri.parse(
          '${ApiClient.getAllBusinessUrl}?track=yes${lat != null && long != null ? '&longitude=$long&latitude=$lat' : ''}${category.isNotEmpty?'&category=$category':''}');
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
      log('----------------- track List call--------------------');
      log(url.toString());
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        if (responseData['data']["tracks"] is List) {
          trackList = (responseData['data']["tracks"] as List)
              .map((e) => TrackForUserPanelModel.fromJson(e))
              .toList();
        }
        return trackList;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return trackList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return trackList;
  }

  static Future<List<EventForUserPanelModel>> getEventListForUserPanel(
      {String? long, String? lat}) async {
    List<EventForUserPanelModel> eventList = [];
    try {
      final url = Uri.parse(
          '${ApiClient.getAllBusinessUrl}?event=yes${lat != null && long != null ? '&longitude=$long&latitude=$lat' : ''}');
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
      log('----------------- event List call--------------------');
      log(url.toString());
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        if (responseData['data']["events"] is List) {
          eventList = (responseData['data']["events"] as List)
              .map((e) => EventForUserPanelModel.fromJson(e))
              .toList();
        }
        return eventList;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return eventList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return eventList;
  }
}
