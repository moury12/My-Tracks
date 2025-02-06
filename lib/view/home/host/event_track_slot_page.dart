import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/create_track_event_slot.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/manage/event_user_page.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class EventTrackSlotScreen extends StatelessWidget {
  static const String routeName = '/event-track-slot';
  const EventTrackSlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;

    // Extract the slot list and type (track or event)
    final List<dynamic> slotList = arguments['slots'] as List<dynamic>;
    final String type = arguments['type'] as String;
    final String id = arguments['id'] as String;

    // Determine the title dynamically
    final String title =
        type == 'event' ? AppStaticString.eventSlot : AppStaticString.trackSlot;

    return Scaffold(
      appBar: CustomAppbar(
        tile: title,
        action: [IconButton(onPressed: () {
          Get.toNamed(CreateTrackEventSlotScreen.routeName,arguments: {'type':type,'id':id});
        }, icon: Container(
          padding: padding12,
          // height: 40.w,
          // width: 40.w,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(addIconUrl))),
          child: Image.asset(
            plusIconUrl,
            height: 17.w,
            width: 17.w,
            color: AppColors.whiteLightColor,
          ),
        ),)],
      ),
      body: slotList.isEmpty
          ? const EmptyTextWidget(
              text: AppStaticString.slotListIsEmpty,
            )
          : ListView.builder(
              padding: padding16,
              itemBuilder: (context, index) {
                final slot = slotList[index];

                // Determine the ID dynamically
                final String? slotId = type == 'track'
                    ? (slot as TrackSlots).sId
                    : (slot as EventSlots).sId;

                return Padding(
                  padding: padding6V,
                  child: MarronGradientContainerWidget(
                    child: TrackSlotWidget(
                      needToShowSeat: type == 'event',
                      eventSlots: type == 'event' ? slot as EventSlots : null,
                      slots: type == 'track' ? slot as TrackSlots : null,
                      onTap: () {
                        if (type == 'track') {
                          debugPrint('slotId');
                          debugPrint(slotId!);
                          HomeController.to.getTrackParticipantListCall(
                            trackSlotId: slotId,
                          );
                        } else {
                          HomeController.to.getEventParticipantListCall(
                            eventSlotID: slotId!,
                          );
                        }
                        Get.toNamed(
                          EventUserScreen.routeName,
                          arguments: type,
                        );
                      },
                      argument: userPanel,
                    ),
                  ),
                );
              },
              itemCount: slotList.length,
            ),
    );
  }
}

class EmptyTextWidget extends StatelessWidget {
  final String text;
  const EmptyTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding8,
      child: Center(
        child: Text(
          text,
          style: poppinsMedium.copyWith(fontSize: getFontSizeDefault(context)),
        ),
      ),
    );
  }
}
