import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/service/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var selectedLabel = 0.obs;
  var react = false.obs;

  ///========================List variables=====================///
  ///
  RxList<String> tabs = [AppStaticString.track, AppStaticString.event].obs;
  RxList<String> labelTabs =
      [AppStaticString.running, '', AppStaticString.booked].obs;
  var tabContent = <Widget>[].obs;
  RxList<SingleTrackModel> trackList = <SingleTrackModel>[].obs;

  ///========================Loading variables=====================///

  RxBool isLoadingTrackList = false.obs;

  getTrackListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingTrackList.value = true;
      trackList.value = await TrackEventService.getMyBusinessTrack();
      if (trackList.isNotEmpty) {
        isLoadingTrackList.value = false;
      } else {
        isLoadingTrackList.value = false;
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: AppStaticString.failedToLoadData,
            type: SnackBarType.failed);
      }
    } else {
      isLoadingTrackList.value = false;
      noInternetShowCustomSnackbar();
    }
  }
  @override
  void onInit() {
   getTrackListCall();
    super.onInit();
  }
}
