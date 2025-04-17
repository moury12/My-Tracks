import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/auth/auth_controller.dart';
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

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
   LoginScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppbar(
        tile: AppStaticString.login,
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
                  ),
                  space16H,
                  Text(
                    AppStaticString.loginToContinue,
                    style: poppinsRegular.copyWith(
                        fontSize: getFontSizeSemiSmall(context)),
                  ),
                  space16H,
                  CustomTextField(
                        textEditingController:
                            AuthController.to.emailLoginController,
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
                            AuthController.to.passLoginController,
                        title: AppStaticString.password,
                        hintText: AppStaticString.passwordEnter,
                        fillColor: AppColors.textFieldColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStaticString.passRequired;
                          }
                          if (value.length < 6) {
                            return AppStaticString.passAtLeast6Character;
                          }
                          return null;
                        },
                        isPassword: true,
                      ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      title: AppStaticString.forgetPass,
                      onPressed: () {
                        Get.toNamed(ForgetPasswordScreen.routeName);
                      },
                    ),
                  ),
                  space16H,
                  Obx(() {
                    return CustomButton(
                      isLoading: AuthController.to.isLoadingLogin.value,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          AuthController.to.loginRequest();
                        }
                      },
                      title: AppStaticString.login,
                    );
                  }),
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
      ),
    );
  }
}
