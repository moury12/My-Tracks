import 'package:get/get.dart';
import 'package:track_trek/controller/auth/auth_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthController(),
      fenix: true
    )/*<AuthController>(AuthController())*/;
  }

}/*class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut( ()=>ProfileController(), fenix: true);

  }

}*/