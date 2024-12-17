import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateTrackController extends GetxController {
  static CreateTrackController get to => Get.find();

  Rx<TextEditingController> trackNameController = TextEditingController().obs;
  Rx<TextEditingController> trackLocationController =
      TextEditingController().obs;
  Rx<TextEditingController> trackDescriptionController =
      TextEditingController().obs;
  RxList<String> weekDays = <String>[].obs;
RxInt selectedDay =0.obs;
  getWeekDays() {
    weekDays.value = generateWeekDays();
  }

  List<String> generateWeekDays() {
    DateTime now = DateTime.now();
    List<String> weekdays = [];
    for (int i = 0; i < 7; i++) {
      weekdays.add(DateFormat("EEEE")
          .format(now.add(Duration(days: i - now.weekday + 1))));
    }
    return weekdays;
  }
  @override
  void onInit() {
 getWeekDays();
    super.onInit();
  }
}
