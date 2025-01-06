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
import 'package:track_trek/core/model/participants/event_participants_model.dart';
import 'package:track_trek/core/model/participants/track_participants_model.dart';
import 'package:track_trek/core/model/renter/renters_model.dart';
import 'package:track_trek/core/model/renter/renters_model.dart';
import 'package:track_trek/core/model/renter/renters_model.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class TrackEventService {
  ///==========================Track Functionality==============================///

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
      debugPrint('Error during add track: $e');
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
  }) async {
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

  static Future<bool> deleteSlotRequest(
      {required String slotId, bool? isEvent}) async {
    try {
      final url = Uri.parse(ApiClient.deleteSlotUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };
      final body = jsonEncode(isEvent == true
          ? {"slotId": slotId, "event": "yes"}
          : {
              "slotId": slotId,
            });
      final response = await http.delete(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log('-----------------delete slot call--------------------');
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

  ///===============================Event Functionality==============================///

  static Future<String> addEventCall(
      {required Map<String, dynamic> bodyData,
      required List<File>? files}) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiClient.createEventUrl),
      );

      request.headers['Authorization'] =
          'Bearer ${Boxes.getUserData().get(tokenKey)}';

      request.fields['data'] = jsonEncode(bodyData);

      if (files != null && files.isNotEmpty) {
        for (File file in files) {
          if (await file.exists()) {
            final mimeType =
                lookupMimeType(file.path) ?? 'application/octet-stream';
            final mimeSplit = mimeType.split('/');
            request.files.add(
              await http.MultipartFile.fromPath(
                'event_image', // Key for multiple files
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

      log('-----------------post event call--------------------');
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
      debugPrint('Error during add event: $e');
      return '';
    }
  }

  static Future<SingleEventModel> getSingleEventData({
    required String eventId,
  }) async {
    SingleEventModel singleEventDetails = SingleEventModel();
    try {
      final url = Uri.parse(
          '${ApiClient.getSingleBusinessUrl}?eventId=$eventId&getSlots=yes');
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
      log('-----------------single Event Details call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        singleEventDetails = SingleEventModel.fromJson(responseData['data']);
        return singleEventDetails;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return singleEventDetails;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return singleEventDetails;
  }

  static Future<bool> createEventSlotRequest({
    required String eventId,
    required String slotNo,
    required String maxPeople,
    required String price,
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
        "eventId": eventId,
        "slotNo": slotNo,
        "maxPeople": maxPeople,
        "price": price,
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

  static Future<List<SingleTrackModel>> getMyBusinessTrack() async {
    List<SingleTrackModel> myTrackList = [];
    try {
      final url = Uri.parse(ApiClient.myBusinessUrl);
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
      log('----------------- my Track List call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        if (responseData['data']["tracks"] is List) {
          myTrackList = (responseData['data']["tracks"] as List)
              .map((e) => SingleTrackModel.fromJson(e))
              .toList();
        }
        return myTrackList;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return myTrackList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return myTrackList;
  }

  static Future<List<SingleEventModel>> getMyBusinessEvent(
      {String booked = ''}) async {
    List<SingleEventModel> myEventList = [];
    try {
      final url = Uri.parse(
          '${ApiClient.myBusinessUrl}?data=event${booked.isNotEmpty ? '&booked=yes' : ''}');
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
      log('----------------- my event List call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        if (responseData['data']["events"] is List) {
          myEventList = (responseData['data']["events"] as List)
              .map((e) => SingleEventModel.fromJson(e))
              .toList();
        }
        return myEventList;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return myEventList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return myEventList;
  }

  static Future<List<EventParticipantsModel>> getEventParticipants(
      {required String eventSlotId}) async {
    List<EventParticipantsModel> myEventList = [];
    try {
      final url =
          Uri.parse('${ApiClient.getParticipantsUrl}?eventSlotId=$eventSlotId');
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
      log('----------------- event Participant List call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        if (responseData['data'] is List) {
          myEventList = (responseData['data'] as List)
              .map((e) => EventParticipantsModel.fromJson(e))
              .toList();
        }
        return myEventList;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return myEventList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return myEventList;
  }

  static Future<List<TrackParticipantsModel>> getTrackParticipants(
      {required String trackSlotId}) async {
    List<TrackParticipantsModel> myEventList = [];
    try {
      final url =
          Uri.parse('${ApiClient.getParticipantsUrl}?trackSlotId=$trackSlotId');
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
      log('-----------------  track Participant List call--------------------');
      log(responseData.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        if (responseData['data'] is List) {
          myEventList = (responseData['data'] as List)
              .map((e) => TrackParticipantsModel.fromJson(e))
              .toList();
        }
        return myEventList;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return myEventList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return myEventList;
  }

  static Future<List<RentersModel>> getRentersOnDate(
      {required String date}) async {
    List<RentersModel> renterList = [];
    try {
      final url = Uri.parse('${ApiClient.getAllRentersOnDateUrl}?date=$date');
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
      log('-----------------  Renters List call--------------------');
      log(responseData.toString());
      log(url.toString());
      if (responseData['success'] != null && responseData['success'] == true) {
        if (responseData['data']['renters'] is List) {
          renterList = (responseData['data']['renters'] as List)
              .map((e) => RentersModel.fromJson(e))
              .toList();
        }
        return renterList;
      } else {
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: responseData['message'],
            type: SnackBarType.failed);
        return renterList;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return renterList;
  }

  static Future<bool> trackActiveDeactivateRequest({
    required String trackId,
    required String status,
  }) async {
    try {
      final url = Uri.parse(ApiClient.activeDeactivateUrl);
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Boxes.getUserData().get(tokenKey)}',
      };
      final body = jsonEncode({
        "trackId": trackId,
        "status": status,
      });
      final response = await http.patch(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      log('-----------------track active deactive call--------------------');
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
