import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/booking/event_booking_model.dart';
import 'package:track_trek/core/model/booking/track_booking_model.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class BookingManagementController extends GetxController {
  static BookingManagementController get to => Get.find();
  var selectedLabel = 0.obs;

  ///============================dynamic list variable==========================///
  RxList<String> tabs = [AppStaticString.track, AppStaticString.event].obs;
  RxList<String> labelTabs =
      [AppStaticString.runningBooking, AppStaticString.history].obs;
  var tabContent = <Widget>[].obs;
  RxList<TrackHistoryRunningModel> trackBookingList =
      <TrackHistoryRunningModel>[].obs;
  RxList<EventHistoryRunningModel> eventBookingList =
      <EventHistoryRunningModel>[].obs;

  ///========================dynamic String variable======================///

  RxString trackHistory =''.obs;
  RxString eventHistory =''.obs;

  ///========================dynamic Loading variable======================///

  RxBool isLoadingHistoryBooking= false.obs;
  RxBool isLoadingEventHistoryBooking= false.obs;

  void handleTabChange(int tabIndex){
    final isTrackTab =selectedLabel.value==0;

      if (tabIndex == 1) {
        if (isTrackTab) {
          isLoadingHistoryBooking.value = true;
          trackHistory.value = 'yes';
          getTrackBookingListCall();
          isLoadingHistoryBooking.value = false;
        } else {
          isLoadingEventHistoryBooking.value = true;

          eventHistory.value = 'yes';
          getEventBookingListCall();
          isLoadingEventHistoryBooking.value = false;

        }
      } else {
        if (isTrackTab) {
          isLoadingHistoryBooking.value = true;

          trackHistory.value = '';
          getTrackBookingListCall();
          isLoadingHistoryBooking.value = false;
        } else {
          isLoadingEventHistoryBooking.value = true;

          eventHistory.value = '';
          getEventBookingListCall();
          isLoadingEventHistoryBooking.value = false;
        }
      }

  }
  getTrackBookingListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingHistoryBooking.value = true;
      trackBookingList.value = await TrackEventService.getTrackBookingCall(
         history: trackHistory.value );
      if (trackBookingList.isNotEmpty) {
        isLoadingHistoryBooking.value = false;
      } else {
        isLoadingHistoryBooking.value = false;
      }
    } else {
      isLoadingHistoryBooking.value = false;
      noInternetShowCustomSnackbar();
    }
  }
  getEventBookingListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingEventHistoryBooking.value = true;
      eventBookingList.value = await TrackEventService.getEventBookingCall(
         history: eventHistory.value );
      if (eventBookingList.isNotEmpty) {
        isLoadingEventHistoryBooking.value = false;
      } else {
        isLoadingEventHistoryBooking.value = false;
      }
    } else {
      isLoadingEventHistoryBooking.value = false;
      noInternetShowCustomSnackbar();
    }
  }
  @override
  void onInit() {
    getTrackBookingListCall();
    getEventBookingListCall();
    super.onInit();
  }
}
