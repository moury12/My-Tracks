import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/host/event_track_slot_page.dart';
import 'package:track_trek/view/home/user/widget/loading_widgets.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';

class EventSearchListWidget extends StatelessWidget {
  const EventSearchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12H,
      child: Obx(() {
        return HomeUserController.to.eventList
            .isEmpty /*&&
                        HomeUserController.to.lat.value.isEmpty &&
                        HomeUserController.to.lng.value.isEmpty*/
            ? const EmptyTextWidget(text: AppStaticString.noTrackFound)
            : HomeUserController.to.isLoadingEventList.value
            ? const LoadingTrackListWidget()
            : Column(
          spacing: 12.h ,
          children: List.generate(
            HomeUserController.to.eventList.length,
                (index) => EventCardWidget(
              fromUser: true,
              eventModelForUser:
              HomeUserController.to.eventList[index],
            ),
          ),
        );
      }),
    );
  }
}
