import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/add/widgets/upload_image_widget.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
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
                isLoading: HomeController.to.isLoadingTrackList.value,
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

            ///===============================upload images================================///
            Obx(() {
              return UploadImageWidget(
                  showImageLimit: false,
                  isRequired: true,
                  function: () {
                    pickImages(
                        singleImagePath:
                            HomeController.to.promotionBannerImage);
                  },
                  images: HomeController
                          .to.promotionBannerImage.value.isNotEmpty
                      ? Stack(
                          children: [
                            Image.file(File(
                                HomeController.to.promotionBannerImage.value)),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: () {
                                    HomeController
                                        .to.promotionBannerImage.value = '';
                                  },
                                  icon: Icon(
                                    CupertinoIcons.multiply_circle_fill,
                                    color: AppColors.primaryColor,
                                  )),
                            )
                          ],
                        )
                      : null);
            }),
            Obx(() {
              return HomeController.to.selectedTrack.value == null
                  ? const EmptyTextWidget(text: 'Select a track to pay')
                  : TrackCardWidget(
                      fromPromote: true,
                      trackModel: HomeController.to.selectedTrack.value,
                    );
            }),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Obx(() {
                return CustomButton(
                  isLoading: HomeController.to.isLoadingPromoteTrack.value,
                  onTap: () {
                    // Get.toNamed(PaymentScreen.routeName);
                    HomeController.to.promoteTrack();
                  },
                  title: AppStaticString.goPay,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
