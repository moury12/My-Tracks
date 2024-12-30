import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String routeName = '/change-password';
   ChangePasswordScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: 12.h,
                    children:  [
                      CustomTextField(
                        title: AppStaticString.currentPass,
                        textEditingController: ProfileController.to.currentPasswordController.value,
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
                      CustomTextField(
                        title: AppStaticString.newPass,
                        isPassword: true,
                        textEditingController: ProfileController.to.newPasswordController.value,
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
                        title: AppStaticString.confirmPassword,
                        isPassword: true,
                        textEditingController: ProfileController.to.confirmPasswordController.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStaticString.passRequired;
                          }
                          if (value != ProfileController.to.newPasswordController.value.text) {
                            return AppStaticString.passNotMatch;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),Padding(
            padding: padding16,
            child: Obx(
               () {
                return CustomButton(
                  isLoading: ProfileController.to.isLoadingChangePass.value,
                  onTap: () {
                   if(formKey.currentState!.validate()) {
                    ProfileController.to.changePasswordRequest();
                  }
                },
                  title: AppStaticString.save,
                );
              }
            ),
          ),
        ],
      ),

    );
  }
}
