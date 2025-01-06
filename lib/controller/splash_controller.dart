import 'dart:developer';

import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/controller/notification_controller.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();
  @override
  void onInit() {
    log(Boxes.getUserData().values.toString());

    Future.delayed(const Duration(seconds: 3), () {
      if (Boxes.getUserData().get(tokenKey) != null &&
          Boxes.getUserData().get(tokenKey).toString().isNotEmpty) {
        CommonController.to.selectedRoleOption =
            Boxes.getUserData().get(roleKey) != null
                ? Boxes.getUserData().get(roleKey) == 'USER'
                    ? 0.obs
                    : 1.obs
                : 0.obs;

        Get.offAllNamed(BottomNavigationScreen.routeName);
        Get.put(ProfileController() /*,permanent: true*/);
        Get.put(HomeController() /*,permanent: true*/);
        Get.put(NotificationController() /*,permanent: true*/);
      } else {
        Get.offAllNamed(LoginScreen.routeName);
      }
    });
    super.onInit();
  }
}
