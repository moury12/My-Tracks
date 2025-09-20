import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/service/auth/auth_service.dart';
import 'package:track_trek/core/utils/arguments.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/auth/new_password_page.dart';
import 'package:track_trek/view/auth/otp_page.dart';
import 'package:track_trek/view/initial/splash.dart';

import '../../core/global/string_variable.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  @override
  void onInit() {
    reinitializeSignUpControllers();
    super.onInit();
  }
///=------------------user yolice5132@nongnue.com ======================///
///=------------------host mepoc17213@myweblaw.com ======================///
  ///=------------------host host1@gmailre.com ======================///
  ///=------------------host cacakos833@downlor.com ======================///


  Rx<bool> isLoadingSignUp = false.obs;
  Rx<bool> isLoadingLogin = false.obs;
  Rx<bool> isLoadingActiveAcc = false.obs;
  Rx<bool> isLoadingForgetPass = false.obs;
  Rx<bool> isLoadingResetPass = false.obs;
  Rx<bool> isLoadingForgetPassVerifyOtp = false.obs;

  Rx<TextEditingController> emailSignUpController =
      TextEditingController().obs
          ;

  TextEditingController emailForgetController =
      TextEditingController()
          ;
  //tanzibamouri28@gmail.com


    TextEditingController nameSignUpController =
      TextEditingController();

    TextEditingController passSignUpController =
      TextEditingController();

    TextEditingController confirmPassSignUpController =
      TextEditingController();
TextEditingController emailLoginController =
      TextEditingController();
TextEditingController passLoginController =
      TextEditingController();

TextEditingController passNewController =
      TextEditingController();

TextEditingController confirmPassNewController =
      TextEditingController();

  Rx<String> otpScreen = ''.obs;

  var focusedFieldIndex = -1.obs;
  reinitializeSignUpControllers() {
    if (kDebugMode) {
      emailSignUpController.value.text = 'vegov38491@dfesc.com';
      nameSignUpController.text = 'vegov';
      passSignUpController.text = '123456';
      confirmPassSignUpController.text = '123456';
      // emailLoginController.text = 'tanzibamouri28@gmail.com';
      // passLoginController.text = '123457';
      // emailLoginController.text = 'boxepi4925@fenxz.com';
      // passLoginController.text = '123457';
      // emailLoginController.text = 'cenaro7871@bmixr.com';
      // passLoginController.text = '123456';
      emailLoginController.text = 'host1@gmail.com';
      // emailLoginController.text = 'mepoc17213@myweblaw.com';
      passLoginController.text = '123456';
      // emailLoginController.text = 'cacakos833@downlor.com';
      // passLoginController.text = '123456';
      // emailLoginController.text = 'cocaja1869@citdaca.com';
      // passLoginController.text = '123456';
      passNewController.text = '123456';
      confirmPassNewController.text = '123456';
    }}
  activeAccountRequest({required String otpPinController}) async {
    if (NetworkController.to.isConnected.value) {
      isLoadingActiveAcc.value = true;
      bool isActivate = await AuthService.activeUser(
          email: emailSignUpController.value.text, code: otpPinController);
      if (isActivate) {
        isLoadingActiveAcc.value = false;
        otpPinController = '';
        clearSignUpController();
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
          email: emailLoginController.value.text,
          password: passLoginController.value.text);
      if (isActivate) {
        isLoadingLogin.value = false;
        // emailForgetController.value.clear();
        CommonController.to.selectedRoleOption.value =
            Boxes.getUserData().get(roleKey) == 'USER' ? 0 : 1;


        emailLoginController.clear();
        passLoginController.clear();
        Get.offAllNamed(SplashScreen.routeName);
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
        emailForgetController.clear();
        passNewController.clear();
        confirmPassNewController.clear();
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
          response['success'] == true ) {
        isLoadingSignUp.value = false;
        Get.toNamed(
          OTPScreen.routeName,
          arguments: signingArgument
        );


      } else {
        if (data != null && data['isActive'] == false) {
          Get.toNamed(OTPScreen.routeName, arguments: signingArgument);
           showCustomSnackbar(
            title: AppStaticString.failed,
              message: 'Your account not verified yet! please verify now!!',
            type: SnackBarType.failed
             );
          isLoadingSignUp.value = false;
        } else {
          Get.offAllNamed(
            LoginScreen.routeName,
          );

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
    // emailSignUpController.value.value.dispose();
    // nameSignUpController.value.dispose();
    // passSignUpController.value.dispose();
    // confirmPassSignUpController.value.dispose();
    emailSignUpController.value.clear();
    nameSignUpController.clear();
    passSignUpController.clear();
    confirmPassSignUpController.clear();
  }

  @override
  void onClose() {
    // emailLoginController.dispose();
    // passLoginController.dispose();
    emailForgetController.dispose();
    emailSignUpController.value.dispose();
    nameSignUpController.dispose();
    passSignUpController.dispose();
    confirmPassSignUpController.dispose();
    passNewController.dispose();
    confirmPassNewController.dispose();
    super.onClose();
  }
}
