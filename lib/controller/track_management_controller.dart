import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/renter/renters_model.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';

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
  Rx<SingleEventModel?> selectedEvent = Rx<SingleEventModel?>(null);
  RxList<SingleEventModel> eventList = <SingleEventModel>[].obs;
  RxList<RentersModel> renterList = <RentersModel>[].obs;
  RxBool isLoadingEventList = false.obs;
  RxBool isLoadingTrackActive = false.obs;
  RxBool isLoadingRentersList = false.obs;
  getEventListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingEventList.value = true;
      eventList.value = await TrackEventService.getMyBusinessEvent(itemsEventPerPage: "100");
      if (eventList.isNotEmpty) {
        isLoadingEventList.value = false;
      } else {
        isLoadingEventList.value = false;
         
      }
    } else {
      isLoadingEventList.value = false;
      // noInternetShowCustomSnackbar();
    }
  }
Future<void> refreshManageScreen() async{
  await  HomeController.to.getTrackListCall();
  HomeController.to.trackList.refresh();
  await  HomeController.to.getEventListCall();
  HomeController.to.eventList.refresh();
}
  getRentersListCall({required String date}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingRentersList.value = true;
      renterList.value = await TrackEventService.getRentersOnDate(date: date);
      if (renterList.isNotEmpty) {
        isLoadingRentersList.value = false;
      } else {
        isLoadingRentersList.value = false;
print('renterList.length');
print(renterList.length);
      }
    } else {
      isLoadingRentersList.value = false;
      // noInternetShowCustomSnackbar();
    }
  }

  trackActiveDeactivateCall({
    required String trackId,
    required String status,
  }) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingTrackActive.value = true;
      final bool apiHited =
          await TrackEventService.trackActiveDeactivateRequest(
              trackId: trackId, status: status);
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
