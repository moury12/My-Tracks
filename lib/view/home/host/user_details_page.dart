import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/user_details_content_host_panel_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class UserDetailsScreen extends StatelessWidget {
  static const String routeName = '/user_details';
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? argument = Get.arguments;
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.userDetails,
      ),
      body: ListView.builder(
        padding: padding16H.copyWith(bottom: 16.h),
        itemBuilder: (context, index) => Padding(
          padding: padding12T,
          child: argument != null && argument == userPanel
              ? const MarronGradientContainerWidget(

                  ///=========================user details from user panel==================///
                  child: UserInfoContentWidget())
              : const BlackContainerWidget(
                  ///=========================user details host user panel==================///

                  child: UserDetailsContentOfHostPanel(),
                ),
        ),
        itemCount: 6,
      ),
    );
  }
}
