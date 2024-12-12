import 'package:get/get.dart';
import 'package:track_trek/view/auth/sign_up.dart';

class SplashController extends GetxController{
  static SplashController get to =>Get.find();
  @override
  void onInit() {
Future.delayed(Duration(seconds: 3),(){
  Get.toNamed(SignUpScreen.routeName);
});
    super.onInit();
  }
}