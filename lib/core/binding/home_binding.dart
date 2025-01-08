import 'package:get/get.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/controller/home_user_controller.dart';
import 'package:track_trek/controller/home_user_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<HomeController>(HomeController());
  }
}
class HomeUserBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<HomeUserController>(HomeUserController());
  }
}