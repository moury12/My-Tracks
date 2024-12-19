import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  Rx<TextEditingController> emailSignUpController = TextEditingController().obs;
  Rx<TextEditingController> emailForgotController = TextEditingController().obs;
  Rx<TextEditingController> nameSignUpController = TextEditingController().obs;
  Rx<TextEditingController> passSignUpController = TextEditingController().obs;
  Rx<TextEditingController> confirmPassSignUpController =
      TextEditingController().obs;
  Rx<TextEditingController> emailLoginController = TextEditingController().obs;
  Rx<TextEditingController> passLoginController = TextEditingController().obs;
  Rx<TextEditingController> passNewController = TextEditingController().obs;
  Rx<TextEditingController> confirmPassNewController = TextEditingController().obs;
  Rx<TextEditingController> otpPinController = TextEditingController().obs;
  Rx<String> otpScreen = ''.obs;

 final otpControllers = List.generate(4,(index) => TextEditingController().obs,);
final otpFocusNode = List.generate(4,(index) => FocusNode().obs,);
var focusedFieldIndex =-1.obs;
  @override
  void onInit() {
   for(int i =0; i<otpFocusNode.length;i++){
     otpFocusNode[i].value.addListener(() {
       if(otpFocusNode[i].value.hasFocus){
         focusedFieldIndex=i;
       }
     },);
   }
    super.onInit();
  }

  @override
  void onClose() {
    emailSignUpController.value.dispose();
    nameSignUpController.value.dispose();
    passSignUpController.value.dispose();
    confirmPassSignUpController.value.dispose();
    emailLoginController.value.dispose();
    passLoginController.value.dispose();
    emailForgotController.value.dispose();
    for (var controller in otpControllers) {
      controller.value.dispose();
    }
    for (var focusNode in otpFocusNode) {
      focusNode.value.dispose();
    }
    super.onClose();
  }
}
