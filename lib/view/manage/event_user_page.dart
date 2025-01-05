import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class EventUserScreen extends StatelessWidget {
  static const String routeName = '/event-user';
  const EventUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String argument = Get.arguments;
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.eventUser,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding16,
          child: Obx(
            () { final isEvent = argument == 'event';
            final participantList = isEvent
                ? HomeController.to.eventParticipantList
                : HomeController.to.trackParticipantList;

            // Check if the list is empty
            if (participantList.isEmpty) {
              return const EmptyTextWidget(text: AppStaticString.userListIsEmpty);
            }

            return Column(
                spacing: 8.h,
                children: [
                  // const BlueContainerWidget(
                  //   child: EventDetailsInfoWidget(),
                  // ),
                  // space12H,
                  ...List.generate(
                      argument == 'event'
                          ? HomeController.to.eventParticipantList.length
                          : HomeController.to.trackParticipantList.length, (index) {
                    return MarronGradientContainerWidget(
                        child: UserInfoContentWidget(
                      eventPartModel: argument == 'event'
                          ? HomeController.to.eventParticipantList[index]
                          : null,
                      trackPartModel: argument == 'track'
                          ? HomeController.to.trackParticipantList[index]
                          : null,
                      seatNo: '04',
                    ));
                  })
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
