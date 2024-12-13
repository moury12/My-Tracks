import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  static AuthController get to => Get.find();
  Rx<TextEditingController> emailSignUpController = TextEditingController().obs;
  Rx<TextEditingController> emailForgotController = TextEditingController().obs;
  Rx<TextEditingController> nameSignUpController = TextEditingController().obs;
  Rx<TextEditingController> passSignUpController = TextEditingController().obs;
  Rx<TextEditingController> confirmPassSignUpController = TextEditingController().obs;
  Rx<TextEditingController> emailLoginController = TextEditingController().obs;
  Rx<TextEditingController> passLoginController = TextEditingController().obs;


  @override
  void onClose() {
emailSignUpController.value.dispose();
nameSignUpController.value.dispose();
passSignUpController.value.dispose();
confirmPassSignUpController.value.dispose();
emailLoginController.value.dispose();
passLoginController.value.dispose();
emailForgotController.value.dispose();
  super.onClose();
  }
}