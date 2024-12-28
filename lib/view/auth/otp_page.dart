import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:track_trek/controller/auth_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/arguments.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';

class OTPScreen extends StatelessWidget {
  static const String routeName = '/otp';
  final TextEditingController otpPinController = TextEditingController();

  OTPScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String? argument = Get.arguments;
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.otp,
      ),
      body: Padding(
        padding: padding16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStaticString.enterCode,
                      style: poppinsMedium.copyWith(
                          fontSize: getButtonFontSizeLarge(context)),
                    ),
                    Obx(() {
                      return Text(
                        ///===============dynamic email=====================///
                        AuthController.to.emailSignUpController.value.text
                                    .isNotEmpty ||
                                AuthController.to.emailForgetController.value
                                    .text.isNotEmpty
                            ? '${AppStaticString.enter4Digit} '
                                '${argument != null && argument == signingArgument ? AuthController.to.emailSignUpController.value.text : AuthController.to.emailForgetController.value.text}'
                            : 'email@gmail.com',
                        style: poppinsMedium.copyWith(
                            fontSize: getFontSizeSmall(context)),
                      );
                    }),
                    PinCodeTextField(
                      cursorColor: AppColors.primaryColor,
                      keyboardType: TextInputType.number,
                      controller: otpPinController,
                      enablePinAutofill: true,
                      appContext: (context),
                      onCompleted: (value) {
                        AuthController.to.otpScreen.value = value.toString();
                        AuthController.to.update();
                      },
                      autoFocus: true,
                      textStyle: poppinsRegular.copyWith(
                          color: AppColors.blackLightColor,
                          fontSize: getFontSizeExtraLarge(context)),
                      pinTheme: PinTheme(
                        disabledColor: Colors.transparent,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        // fieldHeight: 70.w,
                        // fieldWidth: 70.w,
                        selectedColor: Colors.transparent,
                        inactiveColor: AppColors.blackBorderColor,
                        activeFillColor: AppColors.whiteLightColor,
                        selectedFillColor: AppColors.whiteLightColor,
                        inactiveFillColor: AppColors.blackBackgroundColor,
                        borderWidth: 0.5,
                        errorBorderColor: Colors.red,
                        activeBorderWidth: 0.5,
                        // selectedColor: AppColors.blue50,
                        // inactiveColor: AppColors.blue50,
                        // activeColor: AppColors.blue800,
                      ),
                      length: 6,
                      enableActiveFill: true,
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              return CustomButton(
                isLoading: argument != null && argument == signingArgument
                    ? AuthController.to.isLoadingActiveAcc.value
                    : AuthController.to.isLoadingForgetPassVerifyOtp.value,
                onTap: () {
                  ///=====================active account======================///
                  if (otpPinController.text.isNotEmpty) {
                    if (argument != null && argument == signingArgument) {
                      AuthController.to.activeAccountRequest(
                          otpPinController: otpPinController.text);
                    }
                    ///========================verify otp forget Password========================///
                    else {
                      AuthController.to.verifyOtpRequest(
                          otpPinController: otpPinController.text);
                    }
                  } else {
                    showCustomSnackbar(
                        title: AppStaticString.failed,
                        message: AppStaticString.otpFieldRequired,
                        type: SnackBarType.failed);
                  }
                },
                title: AppStaticString.next,
              );
            }),
          ],
        ),
      ),

      ///=================verify otp====================///
    );
  }
}
