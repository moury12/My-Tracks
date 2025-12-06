import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/model/review/review_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/event_for_user_panel_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/track_for_user_panel.dart';
import 'package:track_trek/core/model/track-event/promote_track_model.dart';
import 'package:track_trek/core/service/review/review_service.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/service/user-home/user_home_service.dart';

class HomeUserController extends GetxController {
  static HomeUserController get to => Get.find();
  RxInt currentPage = 0.obs;
  RxInt currentTabIndex = 0.obs;
  Rxn<int> selectedIndexCategory = Rxn<int>();
  RxBool react = false.obs;
  Timer? timer;
  Rx<PageController> controller = PageController(initialPage: 0, viewportFraction: 0.9, keepPage: true).obs;

  ///================== dynamic list variable =====================///
  RxList<CategoryModel> catList = <CategoryModel>[].obs;
  RxList<PromoteTrackModel> promoteTrackList = <PromoteTrackModel>[].obs;
  RxList<TrackForUserPanelModel> trackList = <TrackForUserPanelModel>[].obs;
  RxList<EventForUserPanelModel> eventList = <EventForUserPanelModel>[].obs;
  RxList<ReviewModel> reviewList = <ReviewModel>[].obs;
  var tabContent = <Widget>[].obs;
  RxList<String> tabs = [AppStaticString.track, AppStaticString.event].obs;

  ///================== loading variable =====================///

  RxBool isLoadingCategory = false.obs;
  RxBool isLoadingTrackList = false.obs;
  RxBool isLoadingEventList = false.obs;
  RxBool isLoadingTrackReviewList = false.obs;
  RxBool isLoadingMoreForReview = false.obs;
  RxBool isLoadingPromoteTrack = false.obs;

  ///========================= String dynamic variable =====================///
  RxString categorySearch = ''.obs;
  RxString originalLat = ''.obs;
  RxString originalLng = ''.obs;
  RxString lat = ''.obs;
  RxString lng = ''.obs;
  RxString selectedAddress = ''.obs;
  RxInt currentPageForReview = 1.obs;

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

  ///==================textEditing controller variable =====================///

  Rx<TextEditingController> searchFieldController = TextEditingController().obs;

  Future<void> getCategoryListCall() async {
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

  Future<void> getPromoteTrackListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingPromoteTrack.value = true;
      promoteTrackList.value = await TrackEventService.getPromoteTrackListCall();
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

  Future<void> getTrackListCall({
    bool loadMore = false,
    String ? latitude ,
    String?  lngi
  })
  async {
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
      final trackInitialList = await UserHomeService.getTrackListForUserPanel(
          category: categorySearch.value,
          lat:latitude?? lat.value,
          long: lngi?? lng.value,
          totalTrackPages: totalTrackPages.value.toString(),
          itemsTrackPerPage: itemsTrackPerPage.value.toString(),
          currentTrackPage: currentTrackPage.value.toString());
      isLoadingTrackList.value = false;
      isTrackLoadingMore.value = false;
      if (loadMore) {
        trackList.addAll(trackInitialList);
      } else {
        trackList.value = trackInitialList;
      }
    } else {
      isLoadingTrackList.value = false;
      // noInternetShowCustomSnackbar();
    }
  }

  Future<void> getEventListCall({
    bool loadMore = false,
    String ? latitude,
    String ? lngi
  })
  async {
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

      debugPrint('lat.value');
      debugPrint(lat.value);
      final eventInitialList = await UserHomeService.getEventListForUserPanel(
          currentEventPage: currentEventPage.value.toString(),
          itemsEventPerPage: itemsEventPerPage.value.toString(),
          totalEventPages: totalEventPages.value.toString(),
        lat:latitude?? lat.value,
        long: lngi?? lng.value,);
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


  void updateCategorySearch() {
    // Check if selectedIndexCategory is not null and within bounds of the list
    if (selectedIndexCategory.value != null &&
        selectedIndexCategory.value! < catList.length) {
      // Safely update the categorySearch if the index is valid
      categorySearch.value = catList[selectedIndexCategory.value!].name ?? '';
    } else {
      // Fallback to empty if the index is null or out of bounds
      categorySearch.value = '';
    }
  }

  ///=========================== Refresh method ===========================///
  onRefreshUserPanel() {
    Future.wait([
    fetchLocation(),
    getPromoteTrackListCall(),
    getCategoryListCall(),
    ]);
    categorySearch.value = '';
    Get.put(ProfileController());
    ProfileController.to.getUserProfileData();
    selectedIndexCategory.value = null;



    // updateCategorySearch();
  }

  Future<void> fetchLocation() async {
    try {
      isLoadingTrackList.value = true;
      isLoadingEventList.value = true;
      // Step 1: Fetch location
      Map<String, dynamic> locationData = await CommonController.to.getCurrentLocation();

      lat.value =locationData.isNotEmpty? locationData["lat"].toString():"";
      lng.value =locationData.isNotEmpty? locationData["lng"].toString():"";
      print('Latitude: ${lat.value}, Longitude: ${lng.value}');

      // Step 2: Trigger loading flags and data calls

      // Start all async operations in parallel
      await Future.wait([
        getEventListCall(),
        getTrackListCall(),
      ]);
    } catch (e) {
      print('Error fetching location or initializing data: $e');
    }
  }

  @override
  void onInit() {
    onRefreshUserPanel();

    bool isForward = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (isForward) {
          if (currentPage.value < (promoteTrackList.length > 10 ? 10 : promoteTrackList.length) - 1) {
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

  void resetEventList() {
    // eventList.clear();                 // Clear the current list
    currentEventPage.value = 1; // Reset page number
    totalEventPages.value = 7; // Reset total pages
    itemsEventPerPage.value = 7; // Reset item limit
    isEventLoadingMore.value = false; // Reset loading flags
  }

  void resetTrackList() {
    // eventList.clear();                 // Clear the current list
    currentTrackPage.value = 1; // Reset page number
    totalTrackPages.value = 7; // Reset total pages
    itemsTrackPerPage.value = 7; // Reset item limit
    isTrackLoadingMore.value = false; // Reset loading flags
  }
}
