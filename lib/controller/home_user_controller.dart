import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/event_for_user_panel_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/event_for_user_panel_model.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/track_for_user_panel.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/service/user-home/user_home_service.dart';

class HomeUserController extends GetxController {
  static HomeUserController get to => Get.find();
  RxInt currentPage = 0.obs;
  RxInt selectedIndexCategory = 0.obs;
  RxBool react = false.obs;
  Timer? timer;
  Rx<PageController> controller =
      PageController(initialPage: 0, viewportFraction: 0.9, keepPage: true).obs;
  List<String> pages = [dummyBannerUrl, dummyBanner2Url, dummyEventImgUrl];

  ///================== dynamic list variable =====================///
  RxList<CategoryModel> catList = <CategoryModel>[].obs;
  RxList<TrackForUserPanelModel> trackList = <TrackForUserPanelModel>[].obs;
  RxList<EventForUserPanelModel> eventList = <EventForUserPanelModel>[].obs;

  ///================== loading variable =====================///

  RxBool isLoadingCategory = false.obs;
  RxBool isLoadingTrackList = false.obs;
  RxBool isLoadingEventList = false.obs;

  ///========================= String dynamic variable =====================///
  RxString categorySearch = ''.obs;
  Rx<String?> lat = (null).obs;
  Rx<String?> lng = (null).obs;

  getCategoryListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingCategory.value = true;
      catList.value = await UserHomeService.getCategoryList();
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
      categorySearch.value = catList[selectedIndexCategory.value].name ?? ''; // Safely update
    } else {
      categorySearch.value = ''; // Fallback to empty if the list or index is invalid
    }}
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (currentPage.value < pages.length - 1) {
          currentPage.value++;
        } else {
          currentPage.value = 0;
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
    getCategoryListCall();
    getEventListCall();
    getTrackListCall();
    updateCategorySearch();
    super.onInit();
  }
}
