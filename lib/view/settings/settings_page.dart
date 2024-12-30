import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_drawer_widget.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/delete_alert_dialog.dart';
import 'package:track_trek/view/settings/change_password_page.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tile: AppStaticString.settings,
      ),
      body: Padding(
        padding: padding16,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerContentWidget(
                icon: keyIconUrl,
                text: AppStaticString.changePass,
                onTap: () {
                  Get.toNamed(ChangePasswordScreen.routeName);
                },
              ),
              DrawerContentWidget(
                  onTap: () {
                    ///====================delete Account===================///
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => Obx(
                        () {
                          return DeleteAlertDialog(
                            isLoading: ProfileController.to.isLoadingDeleteProfile.value,
                            yesFunction: () {
                              if (ProfileController.to.deletePasswordController
                                      .value.text.isNotEmpty &&
                                  ProfileController.to.userModel.value.email !=
                                      null) {
                                ProfileController.to.deleteProfileRequest();
                              }else{
                                showCustomSnackbar(title: AppStaticString.failed, message: AppStaticString.passRequired, type: SnackBarType.failed);
                              }
                            },
                            text2: AppStaticString.cancel,
                            title: Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: Text(
                                AppStaticString.deleteAcc,
                                style: poppinsMedium.copyWith(
                                    fontSize: getFontSizeLarge(context)),
                              ),
                            ),
                            widgets: Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: CustomTextField(
                                title: AppStaticString.confirmPassword,
                                fillColor: AppColors.navigationColor,
                                textEditingController: ProfileController
                                    .to.deletePasswordController.value,
                                isPassword: true,
                              ),
                            ),
                          );
                        }
                      ),
                    );
                  },
                  icon: deleteIconUrl,
                  text: AppStaticString.deleteAcc),
            ],
          ),
        ),
      ),
    );
  }
}
