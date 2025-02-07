import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/host/event_track_slot_page.dart';
import 'package:track_trek/view/home/user/widget/loading_widgets.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';

class TrackSearchListWidget extends StatelessWidget {
  const TrackSearchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12H,
      child: Obx(() {
        return HomeUserController.to.trackList
                .isEmpty /*&&
                        HomeUserController.to.lat.value.isEmpty &&
                        HomeUserController.to.lng.value.isEmpty*/
            ? const EmptyTextWidget(text: AppStaticString.noTrackFound)
            : HomeUserController.to.isLoadingTrackList.value
                ? const LoadingTrackListWidget()
                : Column(
          spacing: 12.h ,
                    children: List.generate(
                      HomeUserController.to.trackList.length,
                      (index) => TrackCardWidget(
                        fromUser: true,
                        trackModelUserPanel:
                            HomeUserController.to.trackList[index],
                      ),
                    ),
                  );
      }),
    );
  }
}
