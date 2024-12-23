import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/manage/event_user_page.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class EventSlotScreen extends StatelessWidget {
  static const String routeName='/event-slot';
  const EventSlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tile:AppStaticString.eventSlot ,
      ),
      body: ListView.builder(
        padding: padding16,
        itemBuilder: (context, index) =>Padding(
        padding: padding6V,
        child: MarronGradientContainerWidget(
          child: TrackSlotWidget(
            onTap: () {
            Get.toNamed(EventUserScreen.routeName);
            },
            argument: userPanel,
            needToShowSeat: false,
          ),
        ),
      ) , itemCount: 7,),
    );
  }
}
