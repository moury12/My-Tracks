import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/model/location/place_search_model.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/service/track-event/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/add/create_track_event_slot.dart';

class CreateTrackEventController extends GetxController {
  static CreateTrackEventController get to => Get.find();

  ///=======================text editing controller for track =======================///

  Rx<TextEditingController> trackNameController =
      TextEditingController(text: kDebugMode ? 'track name' : '').obs;

  Rx<TextEditingController> trackLocationController =
      TextEditingController(text: kDebugMode ? 'mirpur' : '').obs;
  Rx<TextEditingController> trackDescriptionController = TextEditingController(
          text: kDebugMode
              ? 'The best description of music genre of your song should be explained in a few sentences. tools that help music anywhere new listeners let us know descriptive This is usually the first sentence or two that potential listeners will read, so it\'s important to get them excited about what they\'re going to hear. Think about word choice and how you might use certain words or phrases when describing your sound.'
                  'rhythmic, pulsing bass lines and hypnotic dance beats. optimize time-based help you stay audio files create a professional Techno also has a strong focus on the use of sequencers to create repetitive rhythmic patterns.'
                  'Techno is one of the most popular genres in nightclubs all over the world.'
              : '')
      .obs;
  Rx<TextEditingController> uploadTrackPeopleNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadTrackPriceController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadTrackDescriptionController =
      TextEditingController().obs;
  Rx<TextEditingController> slotNoController = TextEditingController().obs;

  ///=======================text editing controller for Event =======================///

  Rx<TextEditingController> eventNameController =
      TextEditingController(text: kDebugMode ? 'event name' : '').obs;
  Rx<TextEditingController> eventLocationController =
      TextEditingController(text: kDebugMode ? 'dhaka' : '').obs;
  Rx<TextEditingController> eventStartDateController =
      TextEditingController(text: kDebugMode ? '2025-01-10' : '').obs;
  Rx<TextEditingController> eventEndDateController =
      TextEditingController(text: kDebugMode ? '2025-01-22' : '').obs;
  Rx<TextEditingController> eventDescriptionController = TextEditingController(
          text: kDebugMode
              ? 'A dummy is a type of doll that looks like a person. Entertainers called ventriloquists can make dummies appear to talk. The automobile industry uses dummies in cars to study how safe cars are during a crash. A dummy can also be anything that looks real but doesn\'t work: a fake.'
              : '')
      .obs;
  Rx<TextEditingController> uploadEventTotalSeatController =
      TextEditingController(text: kDebugMode ? '20' : '').obs;
  Rx<TextEditingController> uploadEventPriceController =
      TextEditingController(text: kDebugMode ? '200' : '').obs;
  Rx<TextEditingController> slotNoControllerForEvent =
      TextEditingController(text: kDebugMode ? 'zeta' : '').obs;

  Rx<TextEditingController> uploadEventDescriptionController =
      TextEditingController(
              text: kDebugMode
                  ? 'A dummy is a type of doll that looks like a person. Entertainers called ventriloquists can make dummies appear to talk. The automobile industry uses dummies in cars to study how safe cars are during a crash. A dummy can also be anything that looks real but doesn\'t work: a fake.'
                  : '')
          .obs;

  ///======================upload event focusnode========================///
  ///
  FocusNode uploadEventTotalSeatFocusNode = FocusNode();
  FocusNode uploadEventPriceFocusNode = FocusNode();
  FocusNode slotNoFocusNodeForEvent = FocusNode();

  FocusNode uploadEventDescriptionFocusNode = FocusNode();

  ///======================upload track focusnode========================///

  FocusNode uploadTrackPeopleNumberFocusNode = FocusNode();
  FocusNode uploadTrackPriceFocusNode = FocusNode();
  FocusNode slotNoFocusNodeForTrack = FocusNode();

  FocusNode uploadTrackDescriptionFocusNode = FocusNode();

  ///=================dynamic lists=============================///
  RxList<String> eventNameControllerList = <String>[].obs;
  RxList<Map<String, dynamic>> weekDays = <Map<String, dynamic>>[].obs;
  var locationSuggestions = RxList<LocationSuggestion>([]);
  Rx<SingleTrackModel> singleTrack = SingleTrackModel().obs;
  Rx<SingleEventModel> singleEvent = SingleEventModel().obs;
  RxList<CategoryModel> catList = <CategoryModel>[].obs;
  Rx<TextEditingController> fieldNameController =
      TextEditingController(text: kDebugMode ? 'NID' : '').obs;
  RxList<TextEditingController> eventControllerList =
      <TextEditingController>[].obs;
  RxMap currencyList = {}.obs;

  ///=====================dynamic Strings=============================///

  var selectedCategory = Rx<String?>(null);
  var selectedCurrencyFrom = Rx<String?>(null);
  RxString destinationLat = ''.obs;
  RxString destinationLng = ''.obs;
  RxString selectedAddress = ''.obs;
  RxInt selectedDay = 0.obs;
  RxList<String> trackPhotosList = <String>[].obs;
  RxList<String> eventPhotosList = <String>[].obs;
  RxString days = '0'.obs;
  RxString trackId = ''.obs;
  RxString selectedWeekDay = ''.obs;
  RxString selectedStartTime = ''.obs;
  RxString selectedEndTime = ''.obs;
  RxString selectedEventStartTime = ''.obs;
  RxString selectedEventEndTime = ''.obs;
  RxString eventId = ''.obs;

  ///=======================loading variables=====================///

  RxBool isLoadingPostTrack = false.obs;
  RxBool isLoadingUpdateTrack = false.obs;
  RxBool isLoadingCreateSlot = false.obs;
  RxBool isLoadingTrack = false.obs;
  RxBool isLoadingEvent = false.obs;
  RxBool isLoadingCategory = false.obs;
  RxBool isLoadingPostEvent = false.obs;
  RxBool isLoadingCurrencies = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  categoryListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingCategory.value = true;
      catList.value = await TrackEventService.getCategoryListCall();
      if (catList.isNotEmpty) {
        isLoadingCategory.value = false;
      } else {
        isLoadingCategory.value = false;
      }
    } else {
      isLoadingCategory.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  ///===========================================Track Functionality==============================///

  getWeekDays() {
    weekDays.value = generateWeekDays();
  }

  List<Map<String, dynamic>> generateWeekDays() {
    DateTime now = DateTime.now();
    List<Map<String, dynamic>> weekdays = [];
    for (int i = 0; i < 7; i++) {
      weekdays.add({
        'day_name': DateFormat("EEEE")
            .format(now.add(Duration(days: i - now.weekday + 1))),
        'selected': false
      });
    }
    return weekdays;
  }

  void toggleWeekDay(int index) {
    weekDays[index]['selected'] = !weekDays[index]['selected'];
    weekDays.refresh(); // Notify GetX of the change
  }

  postTrackRequest() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingPostTrack.value = true;
      List<File> files = trackPhotosList.map((path) => File(path)).toList();

      String value = await TrackEventService.addTrackCall(
          trackName: trackNameController.value.text,
          category: selectedCategory.value ?? '',
          address: trackLocationController.value.text,
          // longitude:/* destinationLng.toString()*/'90.37',
          // latitude: /*destinationLat.toString()*/'23.7464',
          longitude: destinationLng.toString(),
          latitude: destinationLat.toString(),
          description: trackDescriptionController.value.text,
          files: files);
      if (value.isNotEmpty) {
        isLoadingPostTrack.value = false;
        trackId.value = value;
        clearAfterPostTrack();
        Get.toNamed(CreateTrackEventSlotScreen.routeName,
            arguments: {'type': 'track', 'id': trackId.value});
        // navigator!.pop();
      } else {
        isLoadingPostTrack.value = false;
      }
    } else {
      isLoadingPostTrack.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  updateTrackCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingUpdateTrack.value = true;
      String isUpdate = await TrackEventService.updateTrackRequest(
        totalTrackDayInMonth: days.value,
        trackId: trackId.value,
        trackDays: weekDays
            .where((e) => e['selected'] == true)
            .map((e) =>
                e['day_name'].toString()) // Extract the 'day' field as a String
            .toList(),
      );
      if (isUpdate.isNotEmpty) {
        final initialSelectedDays =
            weekDays.where((e) => e['selected'] == true).toList();
        days.value = isUpdate;

        if (initialSelectedDays.isNotEmpty) {
          selectedDay.value = 0; // Set index to the first selected day
          selectedWeekDay.value = initialSelectedDays[0]['day_name'].toString();
        }
      }

      isLoadingUpdateTrack.value = false;
    } else {
      isLoadingUpdateTrack.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  getCurrenciesList() async {
    isLoadingCurrencies.value = true;
    currencyList.value = await TrackEventService.fetchCurrencies();
    isLoadingCurrencies.value = false;
  }

  createSlotTrackCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingCreateSlot.value = true;
      bool isUpdate = await TrackEventService.createTrackSlotRequest(
          trackId: trackId.value,
          day: selectedWeekDay.value,
          slotNo: slotNoController.value.text,
          startTime: selectedStartTime.value,
          endTime: selectedEndTime.value,
          price: uploadTrackPriceController.value.text,
          maxPeople: uploadTrackPeopleNumberController.value.text,
          description: uploadTrackDescriptionController.value.text,
          currency: selectedCurrencyFrom.value.toString());
      if (isUpdate) {
        isLoadingCreateSlot.value = false;
        getTrackDetailsCall(trackId: trackId.value);
        clearAfterCreateSlotForTrack();
      }

      isLoadingCreateSlot.value = false;
    } else {
      isLoadingCreateSlot.value = false;
      noInternetShowCustomSnackbar();
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
      }
    } else {
      isLoadingTrack.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  deleteSlotCall({required String slotId, bool? isEvent}) async {
    if (NetworkController.to.isConnected.value) {
      bool isDeleted = await TrackEventService.deleteSlotRequest(
          slotId: slotId, isEvent: isEvent);
      if (isDeleted) {
        if (isEvent == true) {
          getEventDetailsCall(eventId: eventId.value);
        } else {
          getTrackDetailsCall(trackId: trackId.value);
        }
      }
    } else {
      noInternetShowCustomSnackbar();
    }
  }

  ///===================================Event Functionality==============================///

  postEventRequest() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingPostEvent.value = true;
      List<File> files = trackPhotosList.map((path) => File(path)).toList();

      String value = await TrackEventService.addEventCall(bodyData: {
        "eventName": eventNameController.value.text,
        "address": eventLocationController.value.text,
        // "longitude": /*destinationLng.value*/'90.37',
        // "latitude": /*destinationLat.value*/'23.7464',
        "longitude": destinationLng.value,
        "latitude": destinationLat.value,
        "description": eventDescriptionController.value.text,
        "startDate": eventStartDateController.value.text,
        "startTime": selectedEventStartTime.value,
        "endDate": eventEndDateController.value.text,
        "endTime": selectedEventStartTime.value,
        "moreInfo": eventNameControllerList
            .map(
              (element) => {"label": element},
            )
            .toList()
      }, files: files);
      if (value.isNotEmpty) {
        isLoadingPostEvent.value = false;
        eventId.value = value;
        Get.toNamed(
          CreateTrackEventSlotScreen.routeName,
          arguments: {'type': 'event', 'id': eventId.value},
        );
        // navigator!.pop();
        clearAfterPostEvent();
      } else {
        isLoadingPostEvent.value = false;
      }
    } else {
      isLoadingPostEvent.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  createSlotEventCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingCreateSlot.value = true;
      bool isUpdate = await TrackEventService.createEventSlotRequest(
          eventId: eventId.value,
          slotNo: slotNoControllerForEvent.value.text,
          maxPeople: uploadEventTotalSeatController.value.text,
          price: uploadEventPriceController.value.text,
          description: uploadEventDescriptionController.value.text,
          currency: selectedCurrencyFrom.value.toString());
      if (isUpdate) {
        isLoadingCreateSlot.value = false;
        getEventDetailsCall(eventId: eventId.value);
        clearAfterCreateSlotForEvent();
      }

      isLoadingCreateSlot.value = false;
    } else {
      isLoadingCreateSlot.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  getEventDetailsCall({required String eventId}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingEvent.value = true;
      singleEvent.value = await TrackEventService.getSingleEventData(
        eventId: eventId,
      );
      if (singleEvent.value.sId != null) {
        isLoadingEvent.value = false;
      } else {
        isLoadingEvent.value = false;
      }
    } else {
      isLoadingEvent.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  @override
  void onInit() {
    categoryListCall();

    getCurrenciesList();
    super.onInit();
  }

  clearAfterPostTrack() {
    trackPhotosList.clear();
    trackNameController.value.clear();
    trackLocationController.value.clear();
    trackDescriptionController.value.clear();
    // selectedCurrencyFrom.value = null;
    selectedCategory.value = null;
  }

  clearAfterPostEvent() {
    eventPhotosList.clear();
    trackPhotosList.clear();
    eventNameControllerList.clear();
    eventNameController.value.clear();
    eventStartDateController.value.clear();
    eventEndDateController.value.clear();
    eventDescriptionController.value.clear();
    eventLocationController.value.clear();
    selectedEventStartTime.value = '';
    selectedEventEndTime.value = '';
    selectedCategory.value = null;
    // selectedCurrencyFrom.value = null;
  }

  clearAfterCreateSlotForTrack() {
    slotNoController.value.clear();
    uploadTrackDescriptionController.value.clear();
    uploadTrackPriceController.value.clear();
    uploadTrackPeopleNumberController.value.clear();
    selectedEndTime.value = '';
    selectedStartTime.value = '';
    uploadTrackPeopleNumberFocusNode.unfocus();
    uploadTrackPriceFocusNode.unfocus();
    slotNoFocusNodeForTrack.unfocus();
    uploadTrackDescriptionFocusNode.unfocus();
  }

  clearAfterCreateSlotForEvent() {
    slotNoControllerForEvent.value.clear();
    uploadEventTotalSeatController.value.clear();
    uploadEventPriceController.value.clear();
    uploadEventDescriptionController.value.clear();
    // selectedCurrencyFrom.value = null;
    FocusScope.of(Get.context!).unfocus();
// formKey.currentState?.reset();

    uploadEventTotalSeatFocusNode.unfocus();
    uploadEventPriceFocusNode.unfocus();
    slotNoFocusNodeForEvent.unfocus();
    uploadEventDescriptionFocusNode.unfocus();
  }

  clearAfterPop() {
    destinationLat.value = '';
    destinationLng.value = '';
    selectedAddress.value = '';
    selectedDay.value = 0;
    trackPhotosList.clear();
    eventPhotosList.clear();
    days.value = '0';
    // trackId.value = '';
    selectedWeekDay.value = '';
    selectedStartTime.value = '';
    selectedEndTime.value = '';
    selectedEventStartTime.value = '';
    selectedEventEndTime.value = '';
    // eventId.value = '';
    clearAfterPostTrack();
    clearAfterPostTrack();
  }

  @override
  void onClose() {
    trackNameController.value.dispose();
    trackLocationController.value.dispose();
    trackDescriptionController.value.dispose();
    eventNameController.value.dispose();
    eventLocationController.value.dispose();
    eventDescriptionController.value.dispose();
    eventStartDateController.value.dispose();
    eventEndDateController.value.dispose();
    uploadEventDescriptionController.value.dispose();
    uploadEventTotalSeatController.value.dispose();
    uploadEventPriceController.value.dispose();
    super.onClose();
  }
}
