import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/feedback/feedback_page.dart';
import 'package:track_trek/view/history/history_page.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/profile/profile_page.dart';
import 'package:track_trek/view/settings/privacy_terms_page.dart';
import 'package:track_trek/view/settings/settings_page.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
width: MediaQuery.sizeOf(context).width/1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(trackImgUrl),
                    Image.asset(horizontalDividerUrl),
                    DrawerContentWidget(
                      icon: historyIconUrl,
                      text: AppStaticString.history,
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(HistoryScreen.routeName);
                      },
                    ),
                    DrawerContentWidget(
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(PrivacyTermsScreen.routeName, arguments: 'terms');
                      },
                      icon: termsConditionIconUrl,
                      text: AppStaticString.termsCondition,
                    ),
                    DrawerContentWidget(
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(PrivacyTermsScreen.routeName, arguments: 'privacy');
                      },
                      icon: privacyPolicyIconUrl,
                      text: AppStaticString.privacyPolicy,
                    ),
                    DrawerContentWidget(
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(FeedbackScreen.routeName);
                      },
                      icon: feedBackIconUrl,
                      text: AppStaticString.feedback,
                    ),
                    CommonController.to.selectedOption.value==0?const SizedBox.shrink():   DrawerContentWidget(
                      icon: profileIconUrl,
                      text: AppStaticString.profile,
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(ProfileScreen.routeName);
                      },
                    ),
                    CommonController.to.selectedOption.value==0?const SizedBox.shrink():  DrawerContentWidget(
                      icon: promoteIconUrl,
                      text: AppStaticString.promoteTrack,
                    ),
                    DrawerContentWidget(
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(SettingsScreen.routeName);
                      },
                      icon: settingsIconUrl,
                      text: AppStaticString.settings,
                    ),
                        
                        
                  ],
                ),
              ),
            ),
            BlackContainerWidget(
              onTap: () {
                Get.offAllNamed(LoginScreen.routeName);
              },
              borderColor: Colors.transparent,
              radius: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
        
                children: [
                  Image.asset(logoutIconUrl,height: 24.w,width: 24.w,),
                  space8W,Text(textAlign: TextAlign.center,
                    AppStaticString.logOut,style:poppinsRegular.copyWith(fontSize: getFontSizeDefault(context)) ,)
                ],),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerContentWidget extends StatelessWidget {
  final String icon;
  final String text;
  final Function()? onTap;
  const DrawerContentWidget({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Column(
        children: [
          Padding(
            padding: padding16,
            child: Row(
              children: [
                Image.asset(
                  icon,
                  height: 24.w,
                  width: 24.w,
                  color: AppColors.whiteLightColor,
                ),
                space16W,
                Expanded(
                  child: Text(
                    text,
                    style: poppinsRegular.copyWith(
                        fontSize: getFontSizeDefault(context)),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(horizontalDividerUrl)
        ],
      ),
    );
  }
}
