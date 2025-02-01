import 'package:get/get.dart';
import 'package:track_trek/controller/booking/booking_management_controller.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/controller/notification_controller.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/controller/splash_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}

class CommonBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
    Get.put<CommonController>(CommonController(), permanent: true);

  }
}
