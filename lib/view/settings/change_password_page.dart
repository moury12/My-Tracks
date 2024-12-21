import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String routeName = '/change-password';
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.changePass,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: padding16,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12.h,
                  children: const [
                    CustomTextField(
                      title: AppStaticString.currentPass,
                      isPassword: true,
                    ),
                    CustomTextField(
                      title: AppStaticString.newPass,
                      isPassword: true,
                    ),
                    CustomTextField(
                      title: AppStaticString.confirmPassword,
                      isPassword: true,
                    ),
                  ],
                ),
              ),
            ),
          ),Padding(
            padding: padding16,
            child: CustomButton(
              onTap: () {},
              title: AppStaticString.save,
            ),
          ),
        ],
      ),

    );
  }
}
