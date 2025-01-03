import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/create_track_event_page.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding16,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the start (left)
        children: [
          // Top-Left Text
          Text(
            AppStaticString.selectOneYouCreate,
            style: poppinsMedium.copyWith(fontSize: getFontSizeLarge(context)),
          ),
          const Spacer(), // Pushes the button to the center
          Center(
            child: CustomButton(
              title: AppStaticString.createTrack,
              img: plusIconUrl,

              onTap: () {
               Get.toNamed(CreateTrackEventScreen.routeName,arguments: 'track');
              },
            ),
          ),
          space20H,
          Center(
            child: CustomButton(
              title: AppStaticString.createEvent,
              img: plusIconUrl,
              fillColor:AppColors.blueColor ,
              borderColor:AppColors.blueColor ,
              onTap: () {
                Get.toNamed(CreateTrackEventScreen.routeName,arguments: 'event');
                // Button Action
              },
            ),
          ),
          const Spacer(), // Adds remaining space below the button
        ],
      ),
    );
  }
}
