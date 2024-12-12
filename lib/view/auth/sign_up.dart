import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_radio_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign-up';
  const SignUpScreen({super.key});

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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                space16H,
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
                    const CustomRadioButton(
                      index: 0,
                    ),
                    space8W,
                    Text(
                      AppStaticString.user,
                      style: poppinsRegular.copyWith(
                          fontSize: getFontSizeSemiSmall(context)),
                    ),
                    space16W,
                    const CustomRadioButton(
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
                space16H,
                const CustomTextField(
                  title: AppStaticString.email,
                  hintText: AppStaticString.emailEnter,
                  fillColor: AppColors.textFieldColor,
                ),
                space16H,
                const CustomTextField(
                  title: AppStaticString.userName,
                  hintText: AppStaticString.userNameEnter,
                  fillColor: AppColors.textFieldColor,
                ),
                space16H,
                const CustomTextField(
                  title: AppStaticString.password,
                  hintText: AppStaticString.passwordEnter,
                  fillColor: AppColors.textFieldColor,
                ),
                space16H,
                const CustomTextField(
                  title: AppStaticString.confirmPassword,
                  hintText: AppStaticString.passwordEnter,
                  fillColor: AppColors.textFieldColor,
                ),
                space16H,
CustomButton(onTap:  (){},title: AppStaticString.signUp,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(AppStaticString.alreadyHaveAcc,style: poppinsRegular.copyWith(
                    fontSize: getFontSizeSmall(context)),
                ),
                    TextButton(onPressed:(){} , child: const Text(AppStaticString.signIn))
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
