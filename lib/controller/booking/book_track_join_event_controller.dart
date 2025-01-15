import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';
import 'package:track_trek/view/initial/splash.dart';

class BookTrackJoinEventController extends GetxController {
  static BookTrackJoinEventController get to => Get.find();

  ///===================dynamic int variable==============///
  RxInt currentIndex = 0.obs;
  Rx<int?> selectedValue = Rx<int?>(null);
  RxString selectDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

  ///==========================dynamic list======================///
  RxList<int> memberList = [1, 2, 3,10].obs;
  RxList<String> bookingForList = ['Self', 'Others'].obs;
  RxList<String?> subSelectedValue = <String?>[].obs;
  RxList<dynamic> eventField= [].obs;
  List<List<TextEditingController>> moreInfoControllers = [];
  RxList<TrackSlots> trackSlotList = <TrackSlots>[].obs;


  ///=======================single dynamic object====================///
  ///
  Rx<SingleEventModel> singleEvent = SingleEventModel().obs;
  Rx<SingleTrackModel> singleTrack = SingleTrackModel().obs;

  ///===================loading value==================///
  RxBool isLoadingTrackEvent = false.obs;
  RxBool isLoadingSlotList = false.obs;
  RxBool isLoadingBookTrack = false.obs;

  ///======================dynamic controller======================///
  Rx<PageController> pageController = PageController(initialPage: 0).obs;
  Rx<TextEditingController> peopleNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> peopleNumberForEventController =
      TextEditingController(text: '0').obs;

  void updateSubSelectedValue() {
    if (selectedValue.value != null && selectedValue.value! > 0) {
      subSelectedValue.value = List.generate(selectedValue.value!,
          (index) => null); // Generate a list with the size of selectedValue
    } else {
      subSelectedValue.clear();
    }
  }

  getTrackSlotListCall({required String trackId}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingSlotList.value = true;
      trackSlotList.value = await TrackEventService.getSlotListCall(
          trackId: trackId, date: selectDate.value);
      if (trackSlotList.isNotEmpty) {
        isLoadingSlotList.value = false;
      } else {
        isLoadingSlotList.value = false;
      }
    } else {
      isLoadingSlotList.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  bookTrackSlotCall({required String slotId}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingBookTrack.value = true;
      bool isBooked = await TrackEventService.bookTrackSlotRequest(
        date: selectDate.value,
        numOfPeople: peopleNumberController.value.text,
        slotId: slotId,
      );
      if (isBooked) {
        isLoadingBookTrack.value = false;
        peopleNumberController.value.clear();
        Get.offAllNamed(SplashScreen.routeName);
      } else {
        isLoadingBookTrack.value = false;
      }
    } else {
      isLoadingBookTrack.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  joinEventSlotCall({required String slotId,required String eventId,required int price,}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingBookTrack.value = true;
      bool isBooked = await TrackEventService.joinEventSlotRequest(
       slotId: slotId,
        eventId: eventId,
        data: eventField,
        price:price
      );
      if (isBooked) {
        isLoadingBookTrack.value = false;
        eventField.clear();
        selectedValue.value=null;
        Get.offAllNamed(SplashScreen.routeName);
      } else {
        isLoadingBookTrack.value = false;
      }
    } else {
      isLoadingBookTrack.value = false;
      noInternetShowCustomSnackbar();
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
      }
    } else {
      isLoadingTrackEvent.value = false;
      noInternetShowCustomSnackbar();
    }
  }
}
