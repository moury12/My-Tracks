import 'package:get/get.dart';
import 'package:track_trek/controller/auth_controller.dart';
import 'package:track_trek/controller/profile_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthController(),
      fenix: true
    )/*<AuthController>(AuthController())*/;
  }

}class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ProfileController>( ProfileController(), permanent: true);

  }

}