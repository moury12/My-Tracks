import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:track_trek/controller/auth_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/auth/new_password_page.dart';

class OTPScreen extends StatelessWidget {
  static const String routeName = '/otp';

  const OTPScreen({super.key});

  void verifyOTP(BuildContext context) {
    final otp = AuthController.to.otpControllers
        .map(
          (e) => e.value.text,
        )
        .join();
    Get.toNamed(NewPasswordScreen.routeName);
    // if (otp.length == 4) {
    //   // Add OTP verification logic here
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("OTP Entered: $otp")),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const CustomAppbar(
        tile: AppStaticString.otp,
      ),
      body: Padding(
        padding: padding16,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      ///===============dynamic email=====================///
                      '${AppStaticString.enter4Digit} email@gmail.com',
                      style:
                          poppinsMedium.copyWith(fontSize: getFontSizeSmall(context)),
                    ),
                    PinCodeTextField(
                      cursorColor: AppColors.primaryColor,
                      keyboardType: TextInputType.number,
                      controller: AuthController.to.otpPinController.value,
                      enablePinAutofill: true,

                      appContext: (context),
                      onCompleted: (value) {
                        AuthController.to.otpScreen.value = value.toString();
                        AuthController.to.update();
                      },
                      autoFocus: true,
                      textStyle: poppinsRegular.copyWith(color: AppColors.blackLightColor,fontSize: getFontSizeExtraLarge(context)),
                      pinTheme: PinTheme(
                        disabledColor: Colors.transparent,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        fieldHeight: 70.w,
                        fieldWidth: 70.w,
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
                      length: 4,
                      enableActiveFill: true,
                    ),
                    // Row(
                    //   spacing: 8.w,
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     ...List.generate(
                    //       4,
                    //       (index) => _buildOTPField(context, index),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            CustomButton(
              onTap: () {
                verifyOTP(context);
              },
              title: AppStaticString.next,
            ),
          ],
        ),
      ),

      ///=================verify otp====================///

    );
  }

  Widget _buildOTPField(BuildContext context, int index) {
    return Expanded(
        child: Obx(
          () {
            return CustomTextField(
                  keyboardType: TextInputType.number,
                  focusNode: AuthController.to.otpFocusNode[index].value,
                  textEditingController: AuthController.to.otpControllers[index].value,
                  textAlign: TextAlign.center,
                  hintText: '',
                  height: 70.h,
                  onChanged: (value) {
            if (value.isNotEmpty) {
              FocusScope.of(context).nextFocus();

            }
                  },
              inputTextStyle:AuthController.to.focusedFieldIndex == index? poppinsRegular.copyWith(color: AppColors.blackLightColor,fontSize: getFontSizeExtraLarge(context)):null,
                  fillColor: AuthController.to.focusedFieldIndex == index
              ? AppColors.whiteLightColor // Focused fill color
              : AppColors.blackBackgroundColor,
                  focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.blackBorderColor),
              borderRadius: BorderRadius.circular(8.r)),
                  border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.blackBorderColor),
              borderRadius: BorderRadius.circular(8.r)),
                  enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.blackBorderColor),
              borderRadius: BorderRadius.circular(8.r)),
                );
          }
        ));
  }
}
