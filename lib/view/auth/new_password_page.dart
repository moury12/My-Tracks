import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/auth_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
class NewPasswordScreen extends StatelessWidget {
  static const String routeName = '/new-pass';
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formNewPassKey = GlobalKey<FormState>();
    final FocusNode newPasswordFocus = FocusNode();
    final FocusNode confirmPasswordFocus = FocusNode();

    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.newPass,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: padding16,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStaticString.setNewPass,
                        style: poppinsMedium.copyWith(
                            fontSize: getFontSizeExtraLarge(context)),
                      ),
                      Text(
                        AppStaticString.createANewPass,
                        textAlign: TextAlign.center,
                        style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSmall(context)),
                      ),
                      CustomTextField(
                        title: AppStaticString.newPass,
                        isPassword: true,

                        textEditingController:
                        AuthController.to.passNewController.value,
                        focusNode: newPasswordFocus,
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
                      CustomTextField(
                        textEditingController:
                        AuthController.to.confirmPassNewController.value,
                        title: AppStaticString.confirmPassword,
                        hintText: AppStaticString.passwordEnter,
                        fillColor: AppColors.textFieldColor,
                        isPassword: true,
                        focusNode: confirmPasswordFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStaticString.confirmPassRequired;
                          }
                          if (value !=
                              AuthController.to.passNewController.value.text) {
                            return AppStaticString.passwordDoNotMatch;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: padding16,
            child: Obx(() {
              return CustomButton(
                isLoading: AuthController.to.isLoadingResetPass.value,
                onTap: () {
                  if (AuthController.to.passNewController.value.text.isNotEmpty&&AuthController.to.confirmPassNewController.value.text.isNotEmpty&&AuthController.to.emailForgetController.value.text.isNotEmpty) {
                    AuthController.to.resetPassRequest();
                  }else{
                    showCustomSnackbar(title: AppStaticString.failed,
                        message: AppStaticString.passRequired, type: SnackBarType.failed);
                  }
                },
                title: AppStaticString.updatePass,
              );
            }),
          ),
        ],
      ),
    );
  }
}

