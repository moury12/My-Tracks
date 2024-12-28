import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/service/auth_service.dart';
import 'package:track_trek/core/utils/arguments.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/auth/new_password_page.dart';
import 'package:track_trek/view/auth/otp_page.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';

import '../core/global/string_variable.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  @override
  void onInit() {
    reinitializeSignUpControllers();
    super.onInit();
  }
///=------------------user yolice5132@nongnue.com ======================///
///=------------------user mepoc17213@myweblaw.com ======================///
  reinitializeSignUpControllers() {
    emailSignUpController.value =
        TextEditingController(text: kDebugMode ? 'mepoc17213@myweblaw.com' : '');
    nameSignUpController.value =
        TextEditingController(text: kDebugMode ? 'mouri' : '');
    passSignUpController.value =
        TextEditingController(text: kDebugMode ? '123456' : '');
    confirmPassSignUpController.value =
        TextEditingController(text: kDebugMode ? '123456' : '');
    passNewController.value =
        TextEditingController(text: kDebugMode ? '123456' : '');
    confirmPassNewController.value =
        TextEditingController(text: kDebugMode ? '123456' : '');
    passLoginController.value =
        TextEditingController(text: kDebugMode ? '123456' : '');
    emailLoginController.value =
        TextEditingController(text: kDebugMode ? 'mepoc17213@myweblaw.com' : '');
  }

  Rx<bool> isLoadingSignUp = false.obs;
  Rx<bool> isLoadingLogin = false.obs;
  Rx<bool> isLoadingActiveAcc = false.obs;
  Rx<bool> isLoadingForgetPass = false.obs;
  Rx<bool> isLoadingResetPass = false.obs;
  Rx<bool> isLoadingForgetPassVerifyOtp = false.obs;
  Rx<TextEditingController> emailSignUpController =
      TextEditingController(text: kDebugMode ? 'mepoc17213@myweblaw.com' : '')
          .obs;
  Rx<TextEditingController> emailForgetController =
      TextEditingController(text: kDebugMode ? 'mepoc17213@myweblaw.com' : '')
          .obs;
  //tanzibamouri28@gmail.com

  Rx<TextEditingController> nameSignUpController =
      TextEditingController(text: kDebugMode ? 'mouri' : '').obs;
  Rx<TextEditingController> passSignUpController =
      TextEditingController(text: kDebugMode ? '123456' : '').obs;
  Rx<TextEditingController> confirmPassSignUpController =
      TextEditingController(text: kDebugMode ? '123456' : '').obs;
  Rx<TextEditingController> emailLoginController =
      TextEditingController(text: kDebugMode ? 'mepoc17213@myweblaw.com' : '')
          .obs;
  Rx<TextEditingController> passLoginController =
      TextEditingController(text: kDebugMode ? '123456' : '').obs;
  Rx<TextEditingController> passNewController =
      TextEditingController(text: kDebugMode ? '123456' : '').obs;
  Rx<TextEditingController> confirmPassNewController =
      TextEditingController(text: kDebugMode ? '123456' : '').obs;

  Rx<String> otpScreen = ''.obs;

  var focusedFieldIndex = -1.obs;

  activeAccountRequest({required String otpPinController}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingActiveAcc.value = true;
      bool isActivate = await AuthService.activeUser(
          email: emailSignUpController.value.text, code: otpPinController);
      if (isActivate) {
        isLoadingActiveAcc.value = false;
        otpPinController = '';
        Get.offAllNamed(LoginScreen.routeName);
      } else {
        isLoadingActiveAcc.value = false;
      }
    } else {
      isLoadingActiveAcc.value = false;
      showCustomSnackbar(
          title: AppStaticString.failed,
          message: AppStaticString.connectToInternet,
          type: SnackBarType.failed);
    }
  }

  verifyOtpRequest({required String otpPinController}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingForgetPassVerifyOtp.value = true;
      bool isActivate = await AuthService.forgetPassVerifyOtpUser(
          email: emailForgetController.value.text, code: otpPinController);
      if (isActivate) {
        isLoadingForgetPassVerifyOtp.value = false;
        otpPinController = '';
        Get.toNamed(NewPasswordScreen.routeName);
      } else {
        isLoadingForgetPassVerifyOtp.value = false;
      }
    } else {
      isLoadingForgetPassVerifyOtp.value = false;
      showCustomSnackbar(
          title: AppStaticString.failed,
          message: AppStaticString.connectToInternet,
          type: SnackBarType.failed);
    }
  }

  forgetPassRequest() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingForgetPass.value = true;
      bool isActivate = await AuthService.forgetPasswordRequest(
        email: emailForgetController.value.text,
      );
      if (isActivate) {
        isLoadingForgetPass.value = false;
        // emailForgetController.value.clear();
        Get.toNamed(OTPScreen.routeName);
      } else {
        isLoadingForgetPass.value = false;
      }
    } else {
      isLoadingForgetPass.value = false;
      showCustomSnackbar(
          title: AppStaticString.failed,
          message: AppStaticString.connectToInternet,
          type: SnackBarType.failed);
    }
  }

  loginRequest() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingLogin.value = true;
      bool isActivate = await AuthService.loginRequest(
          email: emailForgetController.value.text,
          password: passLoginController.value.text);
      if (isActivate) {
        isLoadingLogin.value = false;
        // emailForgetController.value.clear();
        CommonController.to.selectedRoleOption.value =
            Boxes.getUserData().get(roleKey) == 'USER' ? 0 : 1;
        emailLoginController.value.dispose();
        passLoginController.value.dispose();
        Get.offAllNamed(BottomNavigationScreen.routeName);
      } else {
        isLoadingLogin.value = false;
      }
    } else {
      isLoadingLogin.value = false;
      showCustomSnackbar(
          title: AppStaticString.failed,
          message: AppStaticString.connectToInternet,
          type: SnackBarType.failed);
    }
  }

  resetPassRequest() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingResetPass.value = true;
      bool isActivate = await AuthService.resetPasswordRequest(
        email: emailForgetController.value.text,
        newPassword: passNewController.value.text,
        confirmPassword: confirmPassNewController.value.text,
      );
      if (isActivate) {
        isLoadingResetPass.value = false;
        emailForgetController.value.clear();
        passNewController.value.clear();
        confirmPassNewController.value.clear();
        Get.offAllNamed(LoginScreen.routeName);
      } else {
        isLoadingResetPass.value = false;
      }
    } else {
      isLoadingResetPass.value = false;
      showCustomSnackbar(
          title: AppStaticString.failed,
          message: AppStaticString.connectToInternet,
          type: SnackBarType.failed);
    }
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
        "role": CommonController.to.selectedRoleOption.value == 0 ? 'USER' : 'HOST'
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
    // emailSignUpController.value.dispose();
    // nameSignUpController.value.dispose();
    // passSignUpController.value.dispose();
    // confirmPassSignUpController.value.dispose();
    emailSignUpController.value.clear();
    nameSignUpController.value.clear();
    passSignUpController.value.clear();
    confirmPassSignUpController.value.clear();
  }

  @override
  void onClose() {
    // emailLoginController.value.dispose();
    // passLoginController.value.dispose();
    emailForgetController.value.dispose();
    emailSignUpController.value.dispose();
    nameSignUpController.value.dispose();
    passSignUpController.value.dispose();
    confirmPassSignUpController.value.dispose();
    passNewController.value.dispose();
    confirmPassNewController.value.dispose();
    super.onClose();
  }
}
