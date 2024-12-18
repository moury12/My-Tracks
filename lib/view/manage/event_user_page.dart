import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/manage/widgets/blue_container_widget.dart';
import 'package:track_trek/view/manage/widgets/event_details_info_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class EventUserScreen extends StatelessWidget {
  static const String routeName = '/event-user';
  const EventUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.eventUser,
      ),
      body: Padding(
        padding: padding16,
        child: SingleChildScrollView(
          child: Column(
            spacing:8.h,
            children: [
              const BlueContainerWidget(
                child: EventDetailsInfoWidget(),
              ),
              space12H,
              ...List.generate(3, (index) => const MarronGradientContainerWidget(child: UserInfoContentWidget(seatNo: '04',)),)
            ],
          ),
        ),
      ),
    );
  }
}

