import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateTrackController extends GetxController {
  static CreateTrackController get to => Get.find();

  Rx<TextEditingController> trackNameController = TextEditingController().obs;
  Rx<TextEditingController> trackLocationController =
      TextEditingController().obs;
  Rx<TextEditingController> trackDescriptionController =
      TextEditingController().obs; Rx<TextEditingController> uploadTrackPeopleNumberController = TextEditingController().obs;
  Rx<TextEditingController> uploadTrackPriceController =
      TextEditingController().obs;
  Rx<TextEditingController> uploadTrackDescriptionController =
      TextEditingController().obs;
  RxList<Map<String, dynamic>> weekDays = <Map<String, dynamic>>[].obs;

  RxInt selectedDay = 0.obs;
  getWeekDays() {
    weekDays.value = generateWeekDays();
  }

  List<Map<String, dynamic>> generateWeekDays() {
    DateTime now = DateTime.now();
    List<Map<String, dynamic>> weekdays = [];
    for (int i = 0; i < 7; i++) {
      weekdays.add({ 'day_name':DateFormat("EEEE")
          .format(now.add(Duration(days: i - now.weekday + 1))),
        'selected':false});
    }
    return weekdays;
  }
  void toggleWeekDay(int index) {
    weekDays[index]['selected'] = !weekDays[index]['selected'];
    weekDays.refresh(); // Notify GetX of the change
  }
  @override
  void onInit() {
    getWeekDays();
    super.onInit();
  }
  @override
  void onClose() {
    trackNameController.value.dispose();
    trackLocationController.value.dispose();
    trackDescriptionController.value.dispose();
  super.onClose();
  }
}
