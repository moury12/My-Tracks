import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/model/review/review_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/event_for_user_panel_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/track_for_user_panel.dart';
import 'package:track_trek/core/model/track-event/promote_track_model.dart';
import 'package:track_trek/core/model/track-event/promote_track_model.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/service/review/review_service.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/service/user-home/user_home_service.dart';

class HomeUserController extends GetxController {
  static HomeUserController get to => Get.find();
  RxInt currentPage = 0.obs;
  RxInt selectedIndexCategory = 0.obs;
  RxBool react = false.obs;
  Timer? timer;
  Rx<PageController> controller =
      PageController(initialPage: 0, viewportFraction: 0.9, keepPage: true).obs;

  ///================== dynamic list variable =====================///
  RxList<CategoryModel> catList = <CategoryModel>[].obs;
  RxList<PromoteTrackModel> promoteTrackList = <PromoteTrackModel>[].obs;
  RxList<TrackForUserPanelModel> trackList = <TrackForUserPanelModel>[].obs;
  RxList<EventForUserPanelModel> eventList = <EventForUserPanelModel>[].obs;
  RxList<ReviewModel> reviewList = <ReviewModel>[].obs;

  ///================== loading variable =====================///

  RxBool isLoadingCategory = false.obs;
  RxBool isLoadingTrackList = false.obs;
  RxBool isLoadingEventList = false.obs;
  RxBool isLoadingTrackReviewList = false.obs;
  RxBool isLoadingMoreForReview = false.obs;
  RxBool isLoadingPromoteTrack = false.obs;

  ///========================= String dynamic variable =====================///
  RxString categorySearch = ''.obs;
  RxString lat = ''.obs;
  RxString lng = ''.obs;
  RxString selectedAddress = ''.obs;
  RxInt currentPageForReview = 1.obs;

  ///==================textEditing controller variable =====================///

  Rx<TextEditingController> searchFieldController = TextEditingController().obs;

  getCategoryListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingCategory.value = true;
      catList.value = await TrackEventService.getCategoryListCall();
      if (catList.isNotEmpty) {
        isLoadingCategory.value = false;
      } else {
        isLoadingCategory.value = false;
        // showCustomSnackbar(
        //     title: AppStaticString.failed,
        //     message: AppStaticString.failedToLoadData,
        //     type: SnackBarType.failed);
      }
    } else {
      isLoadingCategory.value = false;
      // noInternetShowCustomSnackbar();
    }
  }

  getTrackListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingTrackList.value = true;
      trackList.value = await UserHomeService.getTrackListForUserPanel(
          category: categorySearch.value, lat: lat.value, long: lng.value);
      if (trackList.isNotEmpty) {
        isLoadingTrackList.value = false;
      } else {
        isLoadingTrackList.value = false;
        // showCustomSnackbar(
        //     title: AppStaticString.failed,
        //     message: AppStaticString.failedToLoadData,
        //     type: SnackBarType.failed);
      }
    } else {
      isLoadingTrackList.value = false;
      // noInternetShowCustomSnackbar();
    }
  }

  getPromoteTrackListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingPromoteTrack.value = true;
      promoteTrackList.value =
          await TrackEventService.getPromoteTrackListCall();
      if (promoteTrackList.isNotEmpty) {
        isLoadingPromoteTrack.value = false;
      } else {
        isLoadingPromoteTrack.value = false;
        // showCustomSnackbar(
        //     title: AppStaticString.failed,
        //     message: AppStaticString.failedToLoadData,
        //     type: SnackBarType.failed);
      }
    } else {
      isLoadingPromoteTrack.value = false;
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

  getEventListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingEventList.value = true;
      eventList.value = await UserHomeService.getEventListForUserPanel(
          lat: lat.value, long: lng.value);
      if (eventList.isNotEmpty) {
        isLoadingEventList.value = false;
      } else {
        isLoadingEventList.value = false;
        // showCustomSnackbar(
        //     title: AppStaticString.failed,
        //     message: AppStaticString.failedToLoadData,
        //     type: SnackBarType.failed);
      }
    } else {
      isLoadingEventList.value = false;
      // noInternetShowCustomSnackbar();
    }
  }

  void updateCategorySearch() {
    if (catList.isNotEmpty && selectedIndexCategory < catList.length) {
      categorySearch.value =
          catList[selectedIndexCategory.value].name ?? ''; // Safely update
    } else {
      categorySearch.value =
          ''; // Fallback to empty if the list or index is invalid
    }
  }

  ///=========================== Refresh method ===========================///
  onRefreshUserPanel() {
    Get.put(ProfileController());
    ProfileController.to.getUserProfileData();
    selectedIndexCategory.value = 0;
    getPromoteTrackListCall();
    getCategoryListCall();
    getEventListCall();
    getTrackListCall();
    updateCategorySearch();
  }

  @override
  void onInit() {
    onRefreshUserPanel();
    bool isForward = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        timer = Timer.periodic(const Duration(seconds: 2), (timer) {
          if (isForward) {
            if (currentPage.value < (promoteTrackList.length>10?10:promoteTrackList.length) - 1) {
              currentPage.value++;
            } else {
              isForward = false; // Reverse direction
              currentPage.value--;
            }
          } else {
            if (currentPage.value > 0) {
              currentPage.value--;
            } else {
              isForward = true; // Change direction to forward
              currentPage.value++;
            }
          }
          if (controller.value.hasClients) {
            controller.value.animateToPage(
              currentPage.value,
              duration: const Duration(milliseconds: 400),
              curve: Curves.linear,
            );
          }
        });
      });


    super.onInit();
  }
}
