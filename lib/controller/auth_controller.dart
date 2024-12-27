import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/service/auth_service.dart';
import 'package:track_trek/core/utils/arguments.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/auth/otp_page.dart';
import 'package:track_trek/view/auth/sign_up.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  Rx<bool> isLoadingSignUp = false.obs;
  Rx<TextEditingController> emailSignUpController =
      TextEditingController(text: kDebugMode ? 'tanzibamouri28@gmail.com' : '')
          .obs;
  Rx<TextEditingController> emailForgotController = TextEditingController().obs;
  Rx<TextEditingController> nameSignUpController =
      TextEditingController(text: kDebugMode ? 'mouri' : '').obs;
  Rx<TextEditingController> passSignUpController =
      TextEditingController(text: kDebugMode ? '123456' : '').obs;
  Rx<TextEditingController> confirmPassSignUpController =
      TextEditingController(text: kDebugMode ? '123456' : '').obs;
  Rx<TextEditingController> emailLoginController = TextEditingController().obs;
  Rx<TextEditingController> passLoginController = TextEditingController().obs;
  Rx<TextEditingController> passNewController = TextEditingController().obs;
  Rx<TextEditingController> confirmPassNewController =
      TextEditingController().obs;
  Rx<TextEditingController> otpPinController = TextEditingController().obs;
  Rx<String> otpScreen = ''.obs;

  final otpControllers = List.generate(
    4,
    (index) => TextEditingController().obs,
  );
  final otpFocusNode = List.generate(
    4,
    (index) => FocusNode().obs,
  );
  var focusedFieldIndex = -1.obs;
  @override
  void onInit() {
    for (int i = 0; i < otpFocusNode.length; i++) {
      otpFocusNode[i].value.addListener(
        () {
          if (otpFocusNode[i].value.hasFocus) {
            focusedFieldIndex = i;
          }
        },
      );
    }
    super.onInit();
  }

  registrationRequest() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingSignUp.value = true;
      Map<String, dynamic> response =
          await AuthService.registrationRequest(bodyMap: {
        "name": nameSignUpController.value.text,
        "email": emailSignUpController.value.text,
        "password": passSignUpController.value.text,
        "confirmPassword": confirmPassSignUpController.value.text,
        "role": CommonController.to.selectedIndex.value == 0 ? 'USER' : 'HOST'
      });
      Map<String, dynamic>? data = response['data'];
      if (response['success'] != null &&
          response['success'] == true &&
          data != null &&
          data['isActive'] == true) {
        isLoadingSignUp.value = false;
        Get.toNamed(
          LoginScreen.routeName,
        );

        clearSignUpController();
      } else {
        if (data != null && data['isActive'] == false) {
          Get.toNamed(OTPScreen.routeName, arguments: signingArgument);
          /* showCustomSnackbar(
            title: AppStaticString.failed,
              message: 'Your account not verified yet! please verify now!!',
            type: SnackBarType.failed
             );*/
          isLoadingSignUp.value = false;
        } else {
          showCustomSnackbar(
              title: AppStaticString.failed,
              message: 'Unexpected response from server',
              type: SnackBarType.failed);
          isLoadingSignUp.value = false;
        }
      }
    } else {
      isLoadingSignUp.value = false;
      showCustomSnackbar(
          title: AppStaticString.failed,
          message: AppStaticString.connectToInternet,
          type: SnackBarType.failed);
    }
  }

  clearSignUpController() {
    emailSignUpController.value.dispose();
    nameSignUpController.value.dispose();
    passSignUpController.value.dispose();
    confirmPassSignUpController.value.dispose();
    // emailSignUpController.value.clear();
    // nameSignUpController.value.clear();
    // passSignUpController.value.clear();
    // confirmPassSignUpController.value.clear();
  }

  @override
  void onClose() {

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
