import 'package:get/get.dart';
import 'package:track_trek/controller/feedback/feedback_controller.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/controller/home/host/stripe_onboarding_controller.dart';
import 'package:track_trek/controller/home/host/stripe_onboarding_controller.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<HomeController>(HomeController());
  }
}class HostStripeBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<StripeOnboardingController>(StripeOnboardingController());
  }
}
class HomeUserBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<HomeUserController>(HomeUserController());
  }
}class FeedbackBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<FeedBackController>(FeedBackController());
  }
}