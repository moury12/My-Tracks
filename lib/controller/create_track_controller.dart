import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/location/place_search_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/service/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/add/upload_track.dart';

class CreateTrackController extends GetxController {
  static CreateTrackController get to => Get.find();

  ///=======================text editing controller =======================///
  Rx<TextEditingController> trackNameController =
      TextEditingController(text: kDebugMode ? 'track name' : '').obs;
  Rx<TextEditingController> trackLocationController =
      TextEditingController(text: kDebugMode ? 'mirpur' : '').obs;
  Rx<TextEditingController> trackDescriptionController = TextEditingController(
          text: kDebugMode
              ? 'The best description of music genre of your song should be explained in a few sentences. tools that help music anywhere new listeners let us know descriptive This is usually the first sentence or two that potential listeners will read, so it\'s important to get them excited about what they\'re going to hear. Think about word choice and how you might use certain words or phrases when describing your sound.'
                  'rhythmic, pulsing bass lines and hypnotic dance beats. optimize time-based help you stay audio files create a professional Techno also has a strong focus on the use of sequencers to create repetitive rhythmic patterns.'
                  'Techno is one of the most popular genres in nightclubs all over the world.'
              : '')
      .obs;
  Rx<TextEditingController> uploadTrackPeopleNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadTrackPriceController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadTrackDescriptionController =
      TextEditingController().obs;
  Rx<TextEditingController> slotNoController = TextEditingController().obs;

  ///=================dynamic lists=============================///
  RxList<Map<String, dynamic>> weekDays = <Map<String, dynamic>>[].obs;
  var locationSuggestions = RxList<LocationSuggestion>([]);
  Rx<SingleTrackModel> singleTrack = SingleTrackModel().obs;

  ///=================dynamic Strings=============================///
  var selectedCategory = Rx<String?>(null);
  var destinationLat = Rx<String?>(null);
  var destinationLng = Rx<String?>(null);
  RxInt selectedDay = 0.obs;
  RxList<String> trackPhotosList = <String>[].obs;
  RxString days = '0'.obs;
  RxString trackId = ''.obs;
  RxString selectedWeekDay = ''.obs;
  RxString selectedStartTime = ''.obs;
  RxString selectedEndTime = ''.obs;

  ///=====================loading variables=====================///
  RxBool isLoadingPostTrack = false.obs;
  RxBool isLoadingUpdateTrack = false.obs;
  RxBool isLoadingCreateSlot = false.obs;
  RxBool isLoadingTrack = false.obs;

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
        final initialSelectedDays =
            weekDays.where((e) => e['selected'] == true).toList();
        days.value = initialSelectedDays
            .map((e) => e['day_name'] as String)
            .toList()
            .length
            .toString();

        if (initialSelectedDays.isNotEmpty) {
          selectedDay.value = 0; // Set index to the first selected day
          selectedWeekDay.value = initialSelectedDays[0]['day_name'].toString();
        }
      }

      isLoadingUpdateTrack.value = false;
    } else {
      isLoadingUpdateTrack.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  createSlotTrackCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingCreateSlot.value = true;
      bool isUpdate = await TrackEventService.createTrackSlotRequest(
          trackId: trackId.value,
          day: selectedWeekDay.value,
          slotNo: slotNoController.value.text,
          startTime: selectedStartTime.value,
          endTime: selectedEndTime.value,
          price: uploadTrackPriceController.value.text,
          maxPeople: uploadTrackPeopleNumberController.value.text,
          description: uploadTrackDescriptionController.value.text);
      if (isUpdate) {
        isLoadingCreateSlot.value = false;
        getTrackDetailsCall(trackId: trackId.value);
      }

      isLoadingCreateSlot.value = false;
    } else {
      isLoadingCreateSlot.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  getTrackDetailsCall({required String trackId}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingTrack.value = true;
      singleTrack.value = await TrackEventService.getSingleTrackData(
        trackId: trackId,
      );
      if (singleTrack.value.sId != null) {
        isLoadingTrack.value = false;
      } else {
        isLoadingTrack.value = false;
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: AppStaticString.failedToLoadData,
            type: SnackBarType.failed);
      }
    } else {
      isLoadingTrack.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  deleteSlotCall({required String slotId}) async {
    if (NetworkController.to.isConnected.value) {
      bool isDeleted = await TrackEventService.deleteSlotRequest(
        slotId: slotId,
      );
      if (isDeleted) {
        getTrackDetailsCall(trackId: trackId.value);
      }
    } else {
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
