import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/history/history_page.dart';
import 'package:track_trek/view/profile/profile_page.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child:Column(
      
        children: [
          Image.asset( trackImgUrl),
          Image.asset( horizontalDividerUrl),

      DrawerContentWidget(icon: historyIconUrl, text: AppStaticString.history,onTap: () {
      Navigator.pop(context);
      Get.toNamed(HistoryScreen.routeName);
      },),
      DrawerContentWidget(icon: termsConditionIconUrl, text: AppStaticString.termsCondition,),
      DrawerContentWidget(icon: privacyPolicyIconUrl, text: AppStaticString.privacyPolicy,),
      DrawerContentWidget(icon: feedBackIconUrl, text: AppStaticString.feedback,),
      DrawerContentWidget(
        icon: profileIconUrl, text: AppStaticString.profile,onTap: () {
        Navigator.pop(context);
          Get.toNamed(ProfileScreen.routeName);
        },),
      DrawerContentWidget(icon: promoteIconUrl, text: AppStaticString.promoteTrack,),
      DrawerContentWidget(icon: settingsIconUrl, text: AppStaticString.settings,),
        ],
      ) ,),
    );
  }
}

class DrawerContentWidget extends StatelessWidget {
  final String icon;
  final String text;
  final Function()? onTap;
  const DrawerContentWidget({
    super.key, required this.icon, required this.text, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap??(){} ,
      child: Column(
        children: [
          Padding(
            padding: padding16,
            child: Row(children: [
              Image.asset(icon,
              height: 24.w,
              width: 24.w,),
              space16W,
              Text(text,style:poppinsRegular.copyWith(fontSize: getFontSizeDefault(context)) ,),
            ],),
          ),
          Image.asset(horizontalDividerUrl)

        ],
      ),
    );
  }
}
