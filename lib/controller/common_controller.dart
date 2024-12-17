import 'package:get/get.dart';

class CommonController extends GetxController{
  static CommonController get to =>Get.find();
  var selectedOption = 0.obs;
  var selectedIndex = 2.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}