import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/network_controller.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/core/model/user_model.dart';
import 'package:track_trek/core/service/user_service.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/initial/splash.dart';
import 'package:track_trek/view/no-internet/no_internet_page.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  RxBool isLoadingUserData = false.obs;
  RxBool isLoadingUpdateProfile = false.obs;
  RxBool isLoadingChangePass = false.obs;
  RxBool isLoadingDeleteProfile = false.obs;
  Rx<UserModel> userModel = UserModel().obs;

  ///=====================add dynmic name ====================///
  Rx<TextEditingController> nameController =
      TextEditingController(/*text: kDebugMode ? 'Khushi akter' : ''*/).obs;

  ///=====================add dynmic email ====================///
  Rx<TextEditingController> emailController =
      TextEditingController(/*text: kDebugMode ? 'youremail@gmail.com' : ''*/)
          .obs;

  ///=====================add dynmic contactNumber ====================///
  Rx<TextEditingController> contactNumberController =
      TextEditingController(/*text: kDebugMode ? '+999 68526546 65' : ''*/).obs;

  ///=====================add dynmic location ====================///
  Rx<TextEditingController> locationController = TextEditingController(
          /* text: kDebugMode ? '4140 Parker Rd. Allentown, New Mexico 31134' : ''*/)
      .obs;

  ///====================change password controller====================///
  Rx<TextEditingController> currentPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  ///====================delete controller====================///
  Rx<TextEditingController> deletePasswordController =
      TextEditingController().obs;

  RxString uploadProfileImg = ''.obs;
  getUserProfileData() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingUserData.value = true;
      if (Boxes.getUserData().get(tokenKey) != null &&
          Boxes.getUserData().get(tokenKey).toString().isNotEmpty) {
        userModel.value = await UserService.getUserData();
        reinitializeProfileControllers();
      } else {
        isLoadingUserData.value = false;
        Boxes.getUserData().delete(roleKey);
        Get.offAllNamed(LoginScreen.routeName);
      }
      isLoadingUserData.value = false;
    } else {
      isLoadingUserData.value = false;
      Get.to(NoInternetScreen(
        onRetry: () {
          Get.offAllNamed(SplashScreen.routeName);
        },
      ));
    }
  }

  updateProfileRequest() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingUpdateProfile.value = true;
      bool isActivate = await UserService.updateProfileCall(
          name: nameController.value.text,
          phoneNumber: contactNumberController.value.text,
          address: locationController.value.text,
          file: File(uploadProfileImg.value));
      if (isActivate) {
        isLoadingUpdateProfile.value = false;
        await getUserProfileData();
        uploadProfileImg.value = '';
        navigator!.pop();
      } else {
        isLoadingUpdateProfile.value = false;
      }
    } else {
      isLoadingUpdateProfile.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  changePasswordRequest() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingChangePass.value = true;
      bool isActivate = await UserService.changePasswordRequest(
          oldPassword: currentPasswordController.value.text,
          newPassword: newPasswordController.value.text,
          confirmPassword: confirmPasswordController.value.text);
      if (isActivate) {
        isLoadingChangePass.value = false;
        currentPasswordController.value.clear();
        newPasswordController.value.clear();
        confirmPasswordController.value.clear();
        navigator!.pop();
      } else {
        isLoadingChangePass.value = false;
      }
    } else {
      isLoadingChangePass.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  deleteProfileRequest() async {
    if (NetworkController.to.isConnected.value) {
      isLoadingDeleteProfile.value = true;
      bool isActivate = await UserService.deleteAccountRequest(
          email: userModel.value.email ?? '',
          password: deletePasswordController.value.text);
      if (isActivate) {
        isLoadingDeleteProfile.value = false;
        deletePasswordController.value.clear();
        logOutCall();
      } else {
        isLoadingDeleteProfile.value = false;
      }
    } else {
      isLoadingDeleteProfile.value = false;
      noInternetShowCustomSnackbar();
    }
  }

  reinitializeProfileControllers() {
    nameController.value.text = userModel.value.name ?? 'n/a';

    ///=====================add dynmic email ====================///
    emailController.value.text = userModel.value.email ?? 'n/a';

    ///=====================add dynmic contactNumber ====================///
    contactNumberController.value.text = userModel.value.phoneNumber ?? 'n/a';

    ///=====================add dynmic location ====================///
    locationController.value.text = userModel.value.address ?? 'n/a';
  }

  @override
  void onInit() {
    getUserProfileData();

    super.onInit();
  }

  @override
  void onClose() {
    nameController.value.dispose();
    emailController.value.dispose();
    locationController.value.dispose();
    contactNumberController.value.dispose();
    super.onClose();
  }
}
