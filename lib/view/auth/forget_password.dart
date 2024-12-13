import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/controller/auth_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName ='/forget-pass';
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.forgotPass,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding16,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              space16H,
              Text(
                AppStaticString.forgetPass,
                style: poppinsMedium.copyWith(
                  color: AppColors.whiteBrightColor,
                    fontSize: getFontSizeExtraLarge(context)),
              ),   space16H,Text(
                AppStaticString.enterEmailToSendCode,
                textAlign: TextAlign.center,
                style: poppinsRegular.copyWith(
                    fontSize: getFontSizeSemiSmall(context)),
              ),
              space16H,
              CustomTextField(
                textEditingController:
                AuthController.to.emailSignUpController.value,
                title: AppStaticString.email,
                hintText: AppStaticString.emailEnter,

              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: padding16.copyWith(bottom: 24.sp),
        child: CustomButton(onTap: (){},title:AppStaticString.sendCode ,),
      ),
    );
  }
}
