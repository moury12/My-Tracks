import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/booking/event_booking_model.dart';
import 'package:track_trek/core/model/booking/track_booking_model.dart';
import 'package:track_trek/core/service/review/review_service.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class BookingManagementController extends GetxController {
  static BookingManagementController get to => Get.find();
  @override
  void onInit() async {
    await onRefreshBookingManagement();
    super.onInit();
  }

  onRefreshBookingManagement() async {
    selectedLabel.value = 0;
    selectedTab.value = 0;
    /*  trackHistory.value ='';*/

    await getTrackBookingListCall();
    await getEventBookingListCall();
    trackBookingList.refresh();
    eventBookingList.refresh();
  }

  var selectedLabel = 0.obs;
  var selectedTab = 0.obs;
  RxDouble ratingValue = 2.5.obs;

  ///============================dynamic list variable==========================///
  RxList<String> tabs = [AppStaticString.track, AppStaticString.event].obs;
  RxList<String> labelTabs =
      [AppStaticString.runningBooking, AppStaticString.history].obs;
  var tabContent = <Widget>[].obs;
  RxList<TrackHistoryRunningModel> trackBookingList =
      <TrackHistoryRunningModel>[].obs;
  RxList<TrackHistoryRunningModel> trackHistoryBookingList =
      <TrackHistoryRunningModel>[].obs;
  RxList<EventHistoryRunningModel> eventBookingList =
      <EventHistoryRunningModel>[].obs;
  RxList<EventHistoryRunningModel> eventBookingHistoryList =
      <EventHistoryRunningModel>[].obs;

  ///========================dynamic String variable======================///

  ///========================dynamic Loading variable======================///

  RxBool isLoadingHistoryBooking = false.obs;
  RxBool isLoadingEventHistoryBooking = false.obs;
  RxBool isLoadingRating = false.obs;

  ///========================dynamic controller variable======================///

  TextEditingController reviewController = TextEditingController();

  void handleTabChange(int tabIndex) async {
    if (tabIndex == selectedTab.value) return;

    selectedTab.value = tabIndex;

    final isTrackTab = selectedLabel.value == 0;
    if (tabIndex == 1) {
      if (isTrackTab) {
        isLoadingHistoryBooking.value = true;

        await getTrackHistoryBookingListCall();
        trackHistoryBookingList.refresh();
        isLoadingHistoryBooking.value = false;
      } else {
        isLoadingEventHistoryBooking.value = true;

        await getEventHistoryBookingListCall();
        eventBookingHistoryList.refresh();
        isLoadingEventHistoryBooking.value = false;
      }
    } else {
      if (isTrackTab) {
        isLoadingHistoryBooking.value = true;

        /*trackHistory.value = '';*/
        await getTrackBookingListCall();
        trackBookingList.refresh();
        isLoadingHistoryBooking.value = false;
      } else {
        isLoadingEventHistoryBooking.value = true;

        await getEventBookingListCall();
        eventBookingList.refresh();
        isLoadingEventHistoryBooking.value = false;
      }
    }
  }

  handleLabelChange(int index) async {
    BookingManagementController.to.selectedLabel.value = index;
    if (BookingManagementController.to.selectedLabel.value == 0) {
      BookingManagementController.to.isLoadingHistoryBooking.value = true;
    } else {
      BookingManagementController.to.isLoadingEventHistoryBooking.value = true;
    }
    if (selectedTab.value == 1) {
      await getEventHistoryBookingListCall();
      eventBookingHistoryList.refresh();

      await getTrackHistoryBookingListCall();
      trackHistoryBookingList.refresh();
    } else {
      await getTrackBookingListCall();
      trackBookingList.refresh();

      await getEventBookingListCall();
      eventBookingList.refresh();
    }
  }

  getTrackBookingListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingHistoryBooking.value = true;
      var response =
          await TrackEventService.getTrackBookingCall(/*trackHistory.value*/);
      trackBookingList.assignAll(response.isNotEmpty ? response : []);

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

  getTrackHistoryBookingListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingHistoryBooking.value = true;
      var response =
          await TrackEventService.getTrackBookingCall(history: 'yes');
      trackHistoryBookingList.assignAll(response.isNotEmpty ? response : []);

      if (trackHistoryBookingList.isNotEmpty) {
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
      eventBookingList.value = await TrackEventService.getEventBookingCall();
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

  getEventHistoryBookingListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingEventHistoryBooking.value = true;
      eventBookingHistoryList.value =
          await TrackEventService.getEventBookingCall(history: 'yes');
      if (eventBookingHistoryList.isNotEmpty) {
        isLoadingEventHistoryBooking.value = false;
      } else {
        isLoadingEventHistoryBooking.value = false;
      }
    } else {
      isLoadingEventHistoryBooking.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  postReviewCall({
    required String trackId,
  }) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingRating.value = true;
      bool isGivenRating = await ReviewService.postReviewRequest(
          trackId: trackId,
          review: reviewController.text,
          rating: ratingValue.value);
      if (isGivenRating) {
        reviewController.clear();
        ratingValue.value=2.5;
        isLoadingRating.value = false;
      } else {
        isLoadingRating.value = false;
      }
    } else {
      isLoadingRating.value = false;
      noInternetShowCustomSnackbar();
    }
  }
}
