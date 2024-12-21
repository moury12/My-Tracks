import 'package:flutter/material.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/notification/widgets/notification_title_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding16,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStaticString.new_,
                  style: poppinsMedium.copyWith(
                      fontSize: getFontSizeExtraLarge(context)),
                ),
                Text(
                  AppStaticString.clearAll,
                  style:
                      poppinsLight.copyWith(fontSize: getFontSizeLarge(context)),
                ),
              ],
            ),
            space16H,
            ...List.generate(
              10,
              (index) =>

                  ///=============notification title===================///

                  const NotificationTitleWidget(
                title: 'You add a new service in your account',
                    ///<====================================== date ================================>///
                date: '05-12-2024',
              ),
            )
          ],
        ),
      ),
    );
  }
}
