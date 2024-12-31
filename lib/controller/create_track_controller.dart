import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/model/location/place_search_model.dart';
import 'package:track_trek/core/service/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/add/upload_track.dart';

class CreateTrackController extends GetxController {
  static CreateTrackController get to => Get.find();
  var locationSuggestions = RxList<LocationSuggestion>([]);
  Rx<TextEditingController> trackNameController = TextEditingController().obs;
  Rx<TextEditingController> trackLocationController =
      TextEditingController().obs;
  Rx<TextEditingController> trackDescriptionController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadTrackPeopleNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadTrackPriceController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadTrackDescriptionController =
      TextEditingController().obs;
  RxList<Map<String, dynamic>> weekDays = <Map<String, dynamic>>[].obs;
  var selectedCategory = Rx<String?>(null);
  var destinationLat = Rx<String?>(null);
  var destinationLng = Rx<String?>(null);
  RxInt selectedDay = 0.obs;
  RxList<String> trackPhotosList = <String>[].obs;
  RxString days = '0'.obs;
  RxString trackId = ''.obs;

  ///=====================loading variables=====================///
  RxBool isLoadingPostTrack = false.obs;
  RxBool isLoadingUpdateTrack = false.obs;
  getWeekDays() {
    weekDays.value = generateWeekDays();
  }

  List<Map<String, dynamic>> generateWeekDays() {
    DateTime now = DateTime.now();
    List<Map<String, dynamic>> weekdays = [];
    for (int i = 0; i < 7; i++) {
      weekdays.add({
        'day_name': DateFormat("EEEE")
            .format(now.add(Duration(days: i - now.weekday + 1))),
        'selected': false
      });
    }
    return weekdays;
  }

  void toggleWeekDay(int index) {
    weekDays[index]['selected'] = !weekDays[index]['selected'];
    weekDays.refresh(); // Notify GetX of the change
  }

  postTrackRequest() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingPostTrack.value = true;
      List<File> files = trackPhotosList.map((path) => File(path)).toList();

      String value = await TrackEventService.addTrackCall(
          trackName: trackNameController.value.text,
          category: selectedCategory.value ?? '',
          address: trackLocationController.value.text,
          longitude: destinationLng.toString(),
          latitude: destinationLat.toString(),
          description: trackDescriptionController.value.text,
          files: files);
      if (value.isNotEmpty) {
        isLoadingPostTrack.value = false;
        trackId.value = value;
        Get.toNamed(UploadTrackScreen.routeName, arguments: 'track');
        // navigator!.pop();
      } else {
        isLoadingPostTrack.value = false;
      }
    } else {
      isLoadingPostTrack.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  updateTrackCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingUpdateTrack.value = true;
      bool isUpdate = await TrackEventService.updateTrackRequest(
        trackId: trackId.value,
        trackDays: weekDays
            .where((e) => e['selected'] == true)
            .map((e) =>
                e['day_name'].toString()) // Extract the 'day' field as a String
            .toList(),
      );
      if (isUpdate) {
        days.value=weekDays
            .where((e) => e['selected'] == true)
            .map((e) =>
        e['day_name'] as String)
            .toList().length.toString();
      }

      isLoadingUpdateTrack.value = false;
    } else {
      isLoadingUpdateTrack.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  @override
  void onInit() {
    getWeekDays();
    super.onInit();
  }

  @override
  void onClose() {
    trackNameController.value.dispose();
    trackLocationController.value.dispose();
    trackDescriptionController.value.dispose();
    super.onClose();
  }
}
