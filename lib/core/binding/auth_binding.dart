import 'package:get/get.dart';
import 'package:track_trek/controller/auth_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }

}