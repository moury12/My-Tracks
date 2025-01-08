import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class BookTrackJoinEventController extends GetxController {
  static BookTrackJoinEventController get to => Get.find();

  ///===================dynamic int variable==============///
  RxInt currentIndex = 0.obs;
  Rx<int?> selectedValue = Rx<int?>(null);

  ///==========================dynamic list======================///
  RxList<int> memberList = [1, 2, 3].obs;
  RxList<String> bookingForList = ['Self', 'Others'].obs;
  RxList<String?> subSelectedValue = <String?>[].obs;

  ///=======================single dynamic object====================///
  Rx<SingleEventModel> singleEvent = SingleEventModel().obs;
  Rx<SingleTrackModel> singleTrack = SingleTrackModel().obs;

  ///===================loading value==================///
  RxBool isLoadingTrackEvent = false.obs;


  ///======================dynamic controller======================///
  Rx<PageController> pageController = PageController(initialPage: 0).obs;
  void updateSubSelectedValue() {
    if (selectedValue.value != null && selectedValue.value! > 0) {
      subSelectedValue.value = List.generate(selectedValue.value!,
          (index) => null); // Generate a list with the size of selectedValue
    } else {
      subSelectedValue.clear();
    }
  }

  getTrackDetailsCall({required String trackId}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingTrackEvent.value = true;
      singleTrack.value = await TrackEventService.getSingleTrackData(
        trackId: trackId,
      );
      if (singleTrack.value.sId != null) {
        isLoadingTrackEvent.value = false;
      } else {
        isLoadingTrackEvent.value = false;
      }
    } else {
      isLoadingTrackEvent.value = false;
      noInternetShowCustomSnackbar();
    }
  }
  getEventDetailsCall({required String eventId}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingTrackEvent.value = true;
      singleEvent.value = await TrackEventService.getSingleEventData(
        eventId: eventId,
      );
      if (singleEvent.value.sId != null) {
        isLoadingTrackEvent.value = false;
      } else {
        isLoadingTrackEvent.value = false;
        print(singleEvent.value.toString());
      }
    } else {
      isLoadingTrackEvent.value = false;
      noInternetShowCustomSnackbar();
    }
  }
}
