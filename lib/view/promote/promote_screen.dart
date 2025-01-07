import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';

class PromoteScreen extends StatelessWidget {
  const PromoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding16,
        child: Column(
          spacing: 16.h,
          children: [
            Obx(() {
              return CustomDropdown<SingleTrackModel>(
                selectedValue: HomeController.to.selectedTrack.value,
                radius: 8.r,
                borderColor: AppColors.blackLightColor,
                fillColor: AppColors.blackBackgroundColor,
                hintColor: AppColors.whiteLightColor,
                hintText: AppStaticString.selectTrack,
                items: HomeController.to
                    .trackList /*.map((element) => element.eventName).toList()*/,
                onChanged: (value) {
                  HomeController.to.selectedTrack.value = value;
                },
              );
            }),

            Obx(
              () {
                return HomeController.to.selectedTrack.value==null?const EmptyTextWidget(text: 'Select a track to pay'): TrackCardWidget(
                  fromPromote: true,
                  react: RxBool(false),
                   trackModel:HomeController.to.selectedTrack.value ,


                );
              }
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: CustomButton(
                onTap: () {},
                title: AppStaticString.goPay,
              ),
            )
          ],
        ),
      ),
    );
  }
}
