import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/controller/auth_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/text_style.dart';

class NewPasswordScreen extends StatelessWidget {
  static const String routeName = '/new-pass';
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    spacing: 16.h,
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
                      ),
                      CustomTextField(
                        title: AppStaticString.confirmPassword,
                        isPassword: true,
                        textEditingController:
                            AuthController.to.confirmPassNewController.value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: padding16,
            child: CustomButton(
              onTap: () {},
              title: AppStaticString.updatePass,
            ),
          )
        ],
      ),
    );
  }
}
