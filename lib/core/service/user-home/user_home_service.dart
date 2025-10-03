import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/event_for_user_panel_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/track_for_user_panel.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class UserHomeService {
  static Future<List<TrackForUserPanelModel>> getTrackListForUserPanel({
    String category = '',
    String? long,
    String? lat,
    String currentTrackPage = "1",
    String itemsTrackPerPage = "7",
    String totalTrackPages = "7",
  })
  async {
    List<TrackForUserPanelModel> trackList = [];
    try {
      final url = Uri.parse(
          '${ApiClient.getAllBusinessUrl}?track=yes${lat != null && long != null ? '&longitude=$long&latitude=$lat' : ''}${category.isNotEmpty ? '&category=$category' : ''}&page=$currentTrackPage&limit=$itemsTrackPerPage');
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if(Boxes.getUserData().get(tokenKey)!=null)'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
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
          trackList = (responseData['data']["tracks"] as List).map((e) => TrackForUserPanelModel.fromJson(e)).toList();
          final imageUrls = trackList
              .map((cat) {
            if (cat.trackImage != null && cat.trackImage!.isNotEmpty) {
              return "${ApiClient.baseUrl}/${cat.trackImage![0]}";
            }
            return null;
          })
              .whereType<String>() // filters out nulls safely
              .where((url) => url.isNotEmpty)
              .toList();

          preloadImagesFromUrls(imageUrls);

        }
        if (responseData["data"]['pagination'] != null) {
          currentTrackPage = responseData["data"]['pagination']['page'] ?? 1;
          totalTrackPages = responseData["data"]['pagination']['totalTracks'] ?? 1; // Add this line
          itemsTrackPerPage = responseData["data"]['pagination']['limit'] ?? 7;
        }
        return trackList;
      } else {
        showCustomSnackbar(title: AppStaticString.failed, message: responseData['message'], type: SnackBarType.failed);
        return trackList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return trackList;
  }

  static Future<List<EventForUserPanelModel>> getEventListForUserPanel({
    String? long,
    String? lat,
    String currentEventPage = "1",
    String itemsEventPerPage = "7",
    String totalEventPages = "7",
  })
  async {
    List<EventForUserPanelModel> eventList = [];
    try {
      final url = Uri.parse(
          '${ApiClient.getAllBusinessUrl}?event=yes${lat != null && long != null ? '&longitude=$long&latitude=$lat' : ''}&page=$currentEventPage&limit=$itemsEventPerPage');
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if(Boxes.getUserData().get(tokenKey)!=null)'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
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
          eventList = (responseData['data']["events"] as List).map((e) => EventForUserPanelModel.fromJson(e)).toList();
          final imageUrls = eventList
              .map((cat) {
            if (cat.eventImage != null && cat.eventImage!.isNotEmpty) {
              return "${ApiClient.baseUrl}/${cat.eventImage![0]}";
            }
            return null;
          })
              .whereType<String>() // filters out nulls safely
              .where((url) => url.isNotEmpty)
              .toList();

          preloadImagesFromUrls(imageUrls);
        }
        if (responseData["data"]['pagination'] != null) {
          currentEventPage = responseData["data"]['pagination']['page'] ?? 1;
          totalEventPages = responseData["data"]['pagination']['totalEvents'] ?? 1; // Add this line
          itemsEventPerPage = responseData["data"]['pagination']['limit'] ?? 7;
        }
        return eventList;
      } else {
        showCustomSnackbar(title: AppStaticString.failed, message: responseData['message'], type: SnackBarType.failed);
        return eventList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return eventList;
  }
}
