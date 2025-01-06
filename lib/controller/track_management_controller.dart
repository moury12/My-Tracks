import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class TrackManagementController extends GetxController {
  static TrackManagementController get to => Get.find();
  var selectedTabIndex = 0.obs;
  RxList<String> tabs = <String>[
    AppStaticString.track,
    AppStaticString.event,
    AppStaticString.renters
  ].obs;
  @override
  void onInit() {
    getEventListCall();
    // TODO: implement onInit
    super.onInit();
  }
  var tabContent = <Widget>[].obs;
  Rx<SingleEventModel?> selectedEvent=Rx<SingleEventModel?>(null);
  RxList<SingleEventModel> eventList = <SingleEventModel>[].obs;
  RxBool isLoadingEventList = false.obs;
  RxBool isLoadingTrackActive = false.obs;
  getEventListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingEventList.value = true;
      eventList.value =
      await TrackEventService.getMyBusinessEvent();
      if (eventList.isNotEmpty) {
        isLoadingEventList.value = false;
      } else {
        isLoadingEventList.value = false;
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: AppStaticString.failedToLoadData,
            type: SnackBarType.failed);
      }
    } else {
      isLoadingEventList.value = false;
      // noInternetShowCustomSnackbar();
    }
  }
  trackActiveDeactivateCall({
    required String trackId,
    required String status,
}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingTrackActive.value = true;
      final  bool apiHited=
      await TrackEventService.trackActiveDeactivateRequest(trackId: trackId, status: status);
      if (apiHited) {
        isLoadingTrackActive.value = false;
      } else {
        isLoadingTrackActive.value = false;
      }
    } else {
      isLoadingTrackActive.value = false;
      // noInternetShowCustomSnackbar();
    }
  }
}
