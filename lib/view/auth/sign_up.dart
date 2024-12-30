import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/auth_controller.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_radio_button.dart';
import 'package:track_trek/core/components/custom_text_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/auth/login.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign-up';
   SignUpScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.signUp,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: padding16,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // space16H,
                  Image.asset(
                    loginImgUrl,
                    height: 92.w,
                  ),
                  space16H,
                  Text(
                    AppStaticString.signUpUser,
                    style: poppinsRegular.copyWith(
                        fontSize: getFontSizeSemiSmall(context)),
                  ),
                  space16H,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          CommonController.to.selectedRoleOption.value = 0;
                        },
                        child: Row(
                          children: [
                            const CustomRadioButton(
                              index: 0,
                            ),space8W,
                            Text(
                              AppStaticString.user,
                              style: poppinsRegular.copyWith(
                                  fontSize: getFontSizeSemiSmall(context)),
                            ),
                          ],
                        ),
                      ),

                      space16W,

                      InkWell(
                        onTap: () {
                          CommonController.to.selectedRoleOption.value = 1;
                        },
                        child: Row(
                          children: [const CustomRadioButton(
                            index: 1,
                          ),
                            space8W,
                            Text(
                              AppStaticString.host,
                              style: poppinsRegular.copyWith(
                                  fontSize: getFontSizeSemiSmall(context)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  space16H,
                  CustomTextField(
                    textEditingController:
                        AuthController.to.emailSignUpController.value,
                    title: AppStaticString.email,
                    hintText: AppStaticString.emailEnter,
                    fillColor: AppColors.textFieldColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStaticString.emailRequired;
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return AppStaticString.enterValidEmail;
                      }
                      return null;
                    },
                  ),
                  space16H,
                  CustomTextField(
                    textEditingController:
                        AuthController.to.nameSignUpController,
                    title: AppStaticString.userName,
                    hintText: AppStaticString.userNameEnter,
                    fillColor: AppColors.textFieldColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStaticString.nameRequired;
                      }
                      return null;
                    },
                  ),
                  space16H,
                  CustomTextField(
                    textEditingController:
                        AuthController.to.passSignUpController,
                    title: AppStaticString.password,
                    hintText: AppStaticString.passwordEnter,
                    fillColor: AppColors.textFieldColor,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStaticString.passRequired;
                      }
                      if (value.length < 6) {
                        return AppStaticString.passAtLeast6Character;
                      }
                      return null;
                    },
                  ),
                  space16H,
                  CustomTextField(
                    textEditingController:
                        AuthController.to.confirmPassSignUpController,
                    title: AppStaticString.confirmPassword,
                    hintText: AppStaticString.passwordEnter,
                    fillColor: AppColors.textFieldColor,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStaticString.confirmPassRequired;
                      }
                      if (value != AuthController.to.passSignUpController.value.text) {
                        return AppStaticString.passwordDoNotMatch;
                      }
                      return null;
                    },
                  ),
                  space16H,
                  Obx(
                    () {
                      return CustomButton(
                        isLoading: AuthController.to.isLoadingSignUp.value,
                        onTap: () {
                          if(formKey.currentState!.validate()){
                            AuthController.to.registrationRequest();
                          }
                        },
                        title: AppStaticString.signUp,
                      );
                    }
                  ),
                  // Obx(() {
                  //   return Center(
                  //     child: Text(
                  //       NetworkController.to.isConnected.value
                  //           ? "You are connected to the internet."
                  //           : "No internet connection.",
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //   );
                  // }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStaticString.alreadyHaveAcc,
                        style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSmall(context)),
                      ),
                      CustomTextButton(
                        title: AppStaticString.signIn,
                        onPressed: () {
                          Get.toNamed(LoginScreen.routeName);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
