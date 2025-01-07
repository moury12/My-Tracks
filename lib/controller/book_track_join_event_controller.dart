import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class BookTrackJoinEventController extends GetxController{
  static BookTrackJoinEventController get to => Get.find();
  RxInt currentIndex= 0.obs;
  RxList<int> memberList =[1,2,3].obs;
  RxList<String> bookingForList =['Self','Others'].obs;
  RxList<String?> subSelectedValue = <String?>[].obs;
  Rx<int?> selectedValue = Rx<int?>(null);
  Rx<SingleTrackModel> singleTrack = SingleTrackModel().obs;
  RxBool isLoadingTrack = false.obs;

  Rx<PageController> pageController = PageController(initialPage: 0).obs;
  void updateSubSelectedValue() {
    if (selectedValue.value != null && selectedValue.value! > 0) {
      subSelectedValue.value = List.generate(selectedValue.value!, (index) => null);  // Generate a list with the size of selectedValue
    } else {
      subSelectedValue.clear();
    }
  }
  getTrackDetailsCall({required String trackId}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingTrack.value = true;
      singleTrack.value = await TrackEventService.getSingleTrackData(
        trackId: trackId,
      );
      if (singleTrack.value.sId != null) {
        isLoadingTrack.value = false;
      } else {
        isLoadingTrack.value = false;
        showCustomSnackbar(
            title: AppStaticString.failed,
            message: AppStaticString.failedToLoadData,
            type: SnackBarType.failed);
      }
    } else {
      isLoadingTrack.value = false;
      noInternetShowCustomSnackbar();
    }
  }
}