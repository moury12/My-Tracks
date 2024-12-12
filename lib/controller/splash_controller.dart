import 'package:get/get.dart';
import 'package:track_trek/view/auth/login.dart';

class SplashController extends GetxController{
  static SplashController get to =>Get.find();
  @override
  void onInit() {
Future.delayed(Duration(seconds: 3),(){
  Get.toNamed(LoginScreen.routeName);
});
    super.onInit();
  }
}