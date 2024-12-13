import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/auth_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_text_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/auth/forget_password.dart';
import 'package:track_trek/view/auth/sign_up.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName='/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(tile: AppStaticString.login,),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: padding16,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                space16H,
                Image.asset(
                  loginImgUrl,
                  height: 150.w,
                ),
                space16H,
                Text(
                  AppStaticString.login,
                  style: poppinsMedium.copyWith(
                      fontSize: getButtonFontSizeLarge(context)),
                ),   space16H,Text(
                  AppStaticString.loginToContinue,
                  style: poppinsRegular.copyWith(
                      fontSize: getFontSizeSemiSmall(context)),
                ),
                space16H,

                CustomTextField(
                  textEditingController:
                  AuthController.to.emailForgotController.value,
                  title: AppStaticString.email,
                  hintText: AppStaticString.emailEnter,
                  fillColor: AppColors.textFieldColor,
                ),

                space16H,
                CustomTextField(
                  textEditingController:
                  AuthController.to.passLoginController.value,
                  title: AppStaticString.password,
                  hintText: AppStaticString.passwordEnter,
                  fillColor: AppColors.textFieldColor,
                  isPassword: true,
                ),  Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    title: AppStaticString.forgetPass,
                    onPressed: () {
                      Get.toNamed(ForgetPasswordScreen.routeName);
                    },
                  ),
                ),
                space16H,

                CustomButton(
                  onTap: () {
                    Get.toNamed(BottomNavigationScreen.routeName);
                  },
                  title: AppStaticString.login,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStaticString.dontHaveAcc,
                      style: poppinsRegular.copyWith(
                          fontSize: getFontSizeSmall(context)),
                    ),
                    CustomTextButton(
                      title: AppStaticString.signUp,
                      onPressed: () {
                        Get.toNamed(SignUpScreen.routeName);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
