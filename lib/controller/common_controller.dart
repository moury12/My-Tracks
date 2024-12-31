import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/category/category_model.dart';
import 'package:track_trek/core/service/track_event_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find();
  @override
  void onInit() {
    Boxes.getUserData().get(roleKey) != null
        ? Boxes.getUserData().get(roleKey) == 'USER'
            ? 0.obs
            : 1.obs
        : 0.obs;
    // categoryListCall();
    super.onInit();
  }

  var selectedRoleOption = Boxes.getUserData().get(roleKey) != null
      ? Boxes.getUserData().get(roleKey) == 'USER'
          ? 0.obs
          : 1.obs
      : 0.obs;
  var selectedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  RxString image = ''.obs;

}
