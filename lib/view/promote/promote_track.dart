import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/utils/app_color.dart';

class PromoteTrackScreen extends StatelessWidget {
  static const String routeName ='/promote-tracK';
  const PromoteTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.promoteTrack,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: padding16,
              children:  [
                Obx(
                   () {
                    return CustomDropdown<SingleTrackModel>(
                      selectedValue: HomeController.to.selectedTrack.value,
                      radius: 8.r,
                      borderColor: AppColors.blackLightColor,
                      fillColor: AppColors.blackBackgroundColor,
                      hintColor: AppColors.whiteLightColor,
                      hintText: "Select Event",
                      items: HomeController
                          .to.trackList /*.map((element) => element.eventName).toList()*/,
                      onChanged: (value) {
                        HomeController.to.selectedTrack.value = value;
                      },
                    );
                  }
                ),
              ],
            ),
          ),
          Padding(
            padding: padding16,
            child: CustomButton(onTap: () {

            },title: AppStaticString.done,),
          )
        ],
      ),
    );
  }
}
