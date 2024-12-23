import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BookTrackJoinEventController extends GetxController{
  static BookTrackJoinEventController get to => Get.find();
  RxInt currentIndex= 0.obs;
  RxList<int> memberList =[1,2,3].obs;
  RxList<String> bookingForList =['Self','Others'].obs;
  RxList<String?> subSelectedValue = <String?>[].obs;
  Rx<int?> selectedValue = Rx<int?>(null);
  Rx<PageController> pageController = PageController(initialPage: 0).obs;
  void updateSubSelectedValue() {
    if (selectedValue.value != null && selectedValue.value! > 0) {
      subSelectedValue.value = List.generate(selectedValue.value!, (index) => null);  // Generate a list with the size of selectedValue
    } else {
      subSelectedValue.clear();
    }
  }
}