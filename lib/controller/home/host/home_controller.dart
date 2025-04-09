import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/participants/event_participants_model.dart';
import 'package:track_trek/core/model/participants/track_participants_model.dart';
import 'package:track_trek/core/model/review/review_model.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/service/review/review_service.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/home/host/home_screen.dart';
import 'package:track_trek/view/promote/payment_screen.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var selectedLabel = 0.obs;
  RxInt currentTabIndex = 0.obs;
  RxInt currentManageTabIndex = 0.obs;

  var react = false.obs;
  RxString isBooked = ''.obs;
  Rx<SingleTrackModel?> selectedTrack = Rx<SingleTrackModel?>(null);
  RxString promotionBannerImage = ''.obs;
  var selectedCurrencyFrom = Rx<String?>(null);

  ///====================Event pagination variable========================///

  final RxInt currentEventPage = 1.obs;
  final RxInt itemsEventPerPage = 7.obs;
  final RxInt totalEventPages = 7.obs;
  final RxBool isEventLoadingMore = false.obs;

  ///====================Track pagination variable========================///

  final RxInt currentTrackPage = 1.obs;
  final RxInt itemsTrackPerPage = 7.obs;
  final RxInt totalTrackPages = 7.obs;
  final RxBool isTrackLoadingMore = false.obs;

  ///========================List variables=====================///
  ///
  RxList<String> tabs = [AppStaticString.track, AppStaticString.event].obs;
  RxList<String> labelTabs = [AppStaticString.running, '', AppStaticString.booked].obs;
  var tabContent = <Widget>[].obs;
  RxList<SingleTrackModel> trackList = <SingleTrackModel>[].obs;
  RxList<SingleEventModel> eventList = <SingleEventModel>[].obs;
  RxList<TrackParticipantsModel> trackParticipantList = <TrackParticipantsModel>[].obs;
  RxList<EventParticipantsModel> eventParticipantList = <EventParticipantsModel>[].obs;
  RxList<ReviewModel> reviewList = <ReviewModel>[].obs;

  ///========================Loading variables=====================///

  RxBool isLoadingTrackList = false.obs;
  RxBool isLoadingEventList = false.obs;
  RxBool isLoadingTrackParticipantList = false.obs;
  RxBool isLoadingTrackReviewList = false.obs;
  RxBool isLoadingEventParticipantList = false.obs;
  RxBool isLoadingPromoteTrack = false.obs;

  ///=====================pagination variable====================///

  RxInt currentPageForReview = 1.obs;
  var isLoadingMoreForReview = false.obs;
  Future<void> refreshCall() async {
    await getTrackListCall();
    await getEventListCall();
    trackList.refresh();
    eventList.refresh();
    selectedLabel.value = 0;
    Get.put(ProfileController());

    await ProfileController.to.getUserProfileData();
  }

  getTrackListCall({
    bool loadMore = false,
  }) async {
    if (NetworkController.to.isConnected.value) {
      if (loadMore && currentTrackPage.value >= totalTrackPages.value) {
        return;
      }
      if (loadMore) {
        isTrackLoadingMore.value = true;
        currentTrackPage.value++;

        // Don't increment page here - we'll do it after successful response
      } else {
        isLoadingTrackList.value = true;
        currentTrackPage.value = 1;
      }
      final trackInitialList = await TrackEventService.getMyBusinessTrack(
          currentTrackPage: currentTrackPage.value.toString(),
          itemsTrackPerPage: itemsTrackPerPage.value.toString(),
          totalTrackPages: totalTrackPages.value.toString());
      isLoadingTrackList.value = false;
      isTrackLoadingMore.value = false;
      if (loadMore) {
        trackList.addAll(trackInitialList);
      } else {
        trackList.value = trackInitialList;
      }
    } else {
      isLoadingTrackList.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  getEventListCall({bool loadMore = false}) async {
    if (NetworkController.to.isConnected.value) {
      if (loadMore && currentEventPage.value >= totalEventPages.value) {
        return;
      }
      if (loadMore) {
        isEventLoadingMore.value = true;
        currentEventPage.value++;

        // Don't increment page here - we'll do it after successful response
      } else {
        isLoadingEventList.value = true;
        currentEventPage.value = 1;
      }
      final eventInitialList = await TrackEventService.getMyBusinessEvent(
          booked: isBooked.value,
          currentEventPage: currentEventPage.value.toString(),
          itemsEventPerPage: itemsEventPerPage.value.toString(),
          totalEventPages: totalEventPages.value.toString());
      isLoadingEventList.value = false;
      isEventLoadingMore.value = false;
      if (loadMore) {
        eventList.addAll(eventInitialList);
      } else {
        eventList.value = eventInitialList;
      }
    } else {
      isLoadingEventList.value = false;
      // noInternetShowCustomSnackbar();
    }
  }

  getEventParticipantListCall({required String eventSlotID}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingEventParticipantList.value = true;
      eventParticipantList.value = await TrackEventService.getEventParticipants(eventSlotId: eventSlotID);
      if (eventParticipantList.isNotEmpty) {
        isLoadingEventParticipantList.value = false;
      } else {
        isLoadingEventParticipantList.value = false;
        // showCustomSnackbar(
        //     title: AppStaticString.failed,
        //     message: AppStaticString.failedToLoadData,
        //     type: SnackBarType.failed);
      }
    } else {
      isLoadingEventParticipantList.value = false;
      // noInternetShowCustomSnackbar();
    }
  }

  getTrackParticipantListCall({required String trackSlotId}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingTrackParticipantList.value = true;
      trackParticipantList.value = await TrackEventService.getTrackParticipants(trackSlotId: trackSlotId);
      if (trackParticipantList.isNotEmpty) {
        isLoadingTrackParticipantList.value = false;
      } else {
        isLoadingTrackParticipantList.value = false;
        // showCustomSnackbar(
        //     title: AppStaticString.failed,
        //     message: AppStaticString.failedToLoadData,
        //     type: SnackBarType.failed);
      }
    } else {
      isLoadingTrackParticipantList.value = false;
      // noInternetShowCustomSnackbar();
    }
  }

  getTrackReviewListCall({required String trackId, String sort = '', bool loadMoreData = false}) async {
    if (NetworkController.to.isConnected.value) {
      if (loadMoreData) {
        isLoadingMoreForReview.value = true;
      } else {
        isLoadingTrackReviewList.value = true;
        currentPageForReview.value = 1;
      }

      List<ReviewModel> reviews = await ReviewService.getReviewList(trackId: trackId, page: currentPageForReview.value, sort: sort);
      if (reviews.isNotEmpty) {
        isLoadingTrackReviewList.value = false;
        if (loadMoreData) {
          reviewList.addAll(reviews);
        } else {
          reviewList.assignAll(reviews);
        }
        currentPageForReview.value++;
      } else if (!loadMoreData) {
        isLoadingTrackReviewList.value = false;
        // Clear the list if it's a fresh request and no data
        reviewList.clear();
      } else {
        isLoadingTrackReviewList.value = false;
        // showCustomSnackbar(
        //     title: AppStaticString.failed,
        //     message: AppStaticString.failedToLoadData,
        //     type: SnackBarType.failed);
      }
    } else {
      isLoadingTrackReviewList.value = false;
      // noInternetShowCustomSnackbar();
    }
    reviewList.refresh();
  }

  handleLabelChange({required int index}) {
    selectedLabel.value = index;

    // Update tabs and content dynamically
    if (labelTabs[index] == AppStaticString.booked) {
      isLoadingEventList.value = true;
      tabs.value = [AppStaticString.event];
      isBooked.value = 'yes';
      getEventListCall();
      tabContent.value = [
        const EventListWidget(),
      ];
    } else {
      isLoadingEventList.value = true;
      isBooked.value = '';
      getEventListCall();
      // Reset to default tabs and content
      tabs.value = [
        AppStaticString.track,
        AppStaticString.event,
      ];
      tabContent.value = [
        const TrackListWidget(),
        const EventListWidget(),
      ];
    }
  }

  ///===========================track promotion ============================///

  promoteTrack() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingPromoteTrack.value = true;
      if (selectedTrack.value != null) {
        String isPromoted = await TrackEventService.checkoutPromotion(
            trackId: selectedTrack.value!.sId ?? '',
            amount: '10',
            file: File(promotionBannerImage.value),
            currency: selectedCurrencyFrom.value ?? 'AUD');
        if (isPromoted.isNotEmpty) {
          isLoadingPromoteTrack.value = false;
          selectedTrack.value = null;
          promotionBannerImage.value = '';
          CommonController.to.stripeUrl.value = isPromoted;
          Get.toNamed(PaymentScreen.routeName);
        } else {
          isLoadingPromoteTrack.value = false;
        }
      } else {
        isLoadingPromoteTrack.value = false;
        showCustomSnackbar(title: AppStaticString.failed, message: AppStaticString.selectATrackFirst, type: SnackBarType.failed);
      }
    } else {
      isLoadingPromoteTrack.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  void resetEventList() {
    // eventList.clear();                 // Clear the current list
    currentEventPage.value = 1; // Reset page number
    totalEventPages.value = 7; // Reset total pages
    itemsEventPerPage.value = 7; // Reset item limit
    isEventLoadingMore.value = false; // Reset loading flags
    // getEventListCall();
  }

  void resetTrackList() {
    // eventList.clear();                 // Clear the current list
    currentTrackPage.value = 1; // Reset page number
    totalTrackPages.value = 7; // Reset total pages
    itemsTrackPerPage.value = 7; // Reset item limit
    isTrackLoadingMore.value = false; // Reset loading flags
    // getEventListCall();
  }

  @override
  void onInit() {
    getTrackListCall();
    getEventListCall();
    super.onInit();
  }
}
