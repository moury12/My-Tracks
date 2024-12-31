import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/service/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class CreateEventController extends GetxController {
  static CreateEventController get to => Get.find();

  Rx<TextEditingController> eventNameController = TextEditingController().obs;
  Rx<TextEditingController> eventLocationController =
      TextEditingController().obs;
  Rx<TextEditingController> eventStartDateController =
      TextEditingController().obs;
  Rx<TextEditingController> eventEndDateController =
      TextEditingController().obs;
  Rx<TextEditingController> eventDescriptionController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadEventTotalSeatController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadEventPriceController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadEventDescriptionController =
      TextEditingController().obs;
  Rx<TextEditingController> fieldNameController =
      TextEditingController().obs;
RxList<TextEditingController> eventControllerList =<TextEditingController>[].obs;
RxList<String> eventNameControllerList =<String>[].obs;

  @override
  void onInit() {
    categoryListCall();
    super.onInit();
  }
  // void addEventName() {
  //   final eventName = eventNameController.text.trim();
  //   if (eventName.isNotEmpty) {
  //     eventNameControllerList.add(eventName);
  //     eventNameController.clear(); // Optional: Clear the input field
  //   } else {
  //     Get.snackbar('Error', 'Event name cannot be empty');
  //   }
  // }
  RxBool isLoadingCategory = false.obs;
  RxList<CategoryModel> catList = <CategoryModel>[].obs;
  var selectedCategory =Rx<String?>(null);
  categoryListCall() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingCategory.value = true;
      catList.value = await TrackEventService.getCategoryListCall();

      isLoadingCategory.value = false;
    } else {
      isLoadingCategory.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  @override
  void onClose() {
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
