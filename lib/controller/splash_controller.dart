import 'package:get/get.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/auth/sign_up.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';

class SplashController extends GetxController{
  static SplashController get to =>Get.find();
  @override
  void onInit() {
Future.delayed(const Duration(seconds: 3),(){
  if(Boxes.getUserData().get(tokenKey)!=null&&Boxes.getUserData().get(tokenKey).toString().isNotEmpty){
    Get.offAllNamed(BottomNavigationScreen.routeName);
  }
  else{
    Get.offAllNamed(LoginScreen.routeName);
  }
});
    super.onInit();
  }
}