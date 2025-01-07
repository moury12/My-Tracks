import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/participants/event_participants_model.dart';
import 'package:track_trek/core/model/participants/track_participants_model.dart';
import 'package:track_trek/core/model/review/review_model.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/service/review/review_service.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var selectedLabel = 0.obs;
  var react = false.obs;
  RxString isBooked = ''.obs;
  Rx<SingleTrackModel?> selectedTrack = Rx<SingleTrackModel?>(null);

  ///========================List variables=====================///
  ///
  RxList<String> tabs = [AppStaticString.track, AppStaticString.event].obs;
  RxList<String> labelTabs =
      [AppStaticString.running, '', AppStaticString.booked].obs;
  var tabContent = <Widget>[].obs;
  RxList<SingleTrackModel> trackList = <SingleTrackModel>[].obs;
  RxList<SingleEventModel> eventList = <SingleEventModel>[].obs;
  RxList<TrackParticipantsModel> trackParticipantList =
      <TrackParticipantsModel>[].obs;
  RxList<EventParticipantsModel> eventParticipantList =
      <EventParticipantsModel>[].obs;
  RxList<ReviewModel> reviewList = <ReviewModel>[].obs;

  ///========================Loading variables=====================///

  RxBool isLoadingTrackList = false.obs;
  RxBool isLoadingEventList = false.obs;
  RxBool isLoadingTrackParticipantList = false.obs;
  RxBool isLoadingTrackReviewList = false.obs;
  RxBool isLoadingEventParticipantList = false.obs;
  RxBool isLoadingPostLike = false.obs;

  ///=====================pagination variable====================///

  RxInt currentPageForReview = 1.obs;
  var isLoadingMoreForReview = false.obs;

  getTrackListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingTrackList.value = true;
      trackList.value = await TrackEventService.getMyBusinessTrack();
      if (trackList.isNotEmpty) {
        isLoadingTrackList.value = false;
      } else {
        isLoadingTrackList.value = false;
        /* showCustomSnackbar(
            title: AppStaticString.failed,
            message: AppStaticString.failedToLoadData,
            type: SnackBarType.failed);*/
      }
    } else {
      isLoadingTrackList.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  getEventListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingEventList.value = true;
      eventList.value =
          await TrackEventService.getMyBusinessEvent(booked: isBooked.value);
      if (eventList.isNotEmpty) {
        isLoadingEventList.value = false;
      } else {
        isLoadingEventList.value = false;
        /*  showCustomSnackbar(
            title: AppStaticString.failed,
            message: AppStaticString.failedToLoadData,
            type: SnackBarType.failed);*/
      }
    } else {
      isLoadingEventList.value = false;
      // noInternetShowCustomSnackbar();
    }
  }

  getEventParticipantListCall({required String eventSlotID}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingEventParticipantList.value = true;
      eventParticipantList.value = await TrackEventService.getEventParticipants(
          eventSlotId: eventSlotID);
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
      trackParticipantList.value = await TrackEventService.getTrackParticipants(
          trackSlotId: trackSlotId);
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

  postLikeDisLikeCall({required String trackId}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingPostLike.value = true;
      final bool likeHitted =
          await ReviewService.likeDislikeRequest(trackId: trackId);
      if (likeHitted) {
        isLoadingPostLike.value = false;
      } else {
        isLoadingPostLike.value = false;
        // showCustomSnackbar(
        //     title: AppStaticString.failed,
        //     message: AppStaticString.failedToLoadData,
        //     type: SnackBarType.failed);
      }
    } else {
      isLoadingPostLike.value = false;
      // noInternetShowCustomSnackbar();
    }
  }

  getTrackReviewListCall(
      {required String trackId,
      String sort = '',
      bool loadMoreData = false}) async {
    if (NetworkController.to.isConnected.value) {
      if (loadMoreData) {
        isLoadingMoreForReview.value = true;
      } else {
        isLoadingTrackReviewList.value = true;
        currentPageForReview.value = 1;
      }

      List<ReviewModel> reviews = await ReviewService.getReviewList(
          trackId: trackId, page: currentPageForReview.value, sort: sort);
      if (reviews.isNotEmpty) {
        isLoadingTrackReviewList.value = false;
        if (loadMoreData) {
          reviewList.addAll(reviews);
        } else {
          reviewList.assignAll(reviews);
        }
        currentPageForReview.value++;
      } else if (!loadMoreData) {
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

  @override
  void onInit() {
    getTrackListCall();
    getEventListCall();
    super.onInit();
  }
}
