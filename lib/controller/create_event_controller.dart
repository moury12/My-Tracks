import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  @override
  void onInit() {
    super.onInit();
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
