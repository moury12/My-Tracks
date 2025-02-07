import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/create_track_event_controller.dart';
import 'package:track_trek/controller/create_track_event_controller.dart';
import 'package:track_trek/controller/create_track_event_controller.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
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
import 'package:track_trek/view/book-track-join-event/widgets/loading_widgets.dart';
import 'package:track_trek/view/home/host/widget/loading_slot_widget.dart';
import 'package:track_trek/view/manage/event_user_page.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class EventTrackSlotScreen extends StatefulWidget {
  static const String routeName = '/event-track-slot';
  const EventTrackSlotScreen({super.key});

  @override
  State<EventTrackSlotScreen> createState() => _EventTrackSlotScreenState();
}

class _EventTrackSlotScreenState extends State<EventTrackSlotScreen> {
  final arguments = Get.arguments;

  String type = '';
  String id = '';

  // Determine the title dynamically
  String title = '';
  @override
  void initState() {
    type = arguments['type'] as String;
    id = arguments['id'] as String;
    title =
        type == 'event' ? AppStaticString.eventSlot : AppStaticString.trackSlot;
    if (id.isNotEmpty && type.isNotEmpty) {
      if (type == event) {
        CreateTrackEventController.to.getEventDetailsCall(eventId: id);
      } else {
        CreateTrackEventController.to.getTrackDetailsCall(trackId: id);
        // CreateTrackEventController.to.getTrackSlotListCall(trackId: sId);
      }
    } else {
      debugPrint('Error: Missing eventId or trackId.');
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tile: title,
        action: [
          Obx(() {
            bool isLoading = true;
            if (type == 'track') {
              isLoading =
                  CreateTrackEventController.to.isLoadingTrack.value;}else {
              isLoading =
                  CreateTrackEventController.to.isLoadingEvent.value;
            }
            return IconButton(
              onPressed: () {
                if (type == 'track') {

                  for (String day in CreateTrackEventController
                          .to.singleTrack.value.trackDays ??
                      []) {
                    CreateTrackEventController.to.weekDays
                        .add({'day_name': day, 'selected': true});
                  }
                  CreateTrackEventController.to.days.value=CreateTrackEventController.to.singleTrack.value.totalTrackDayInMonth.toString();
                }
                if (!isLoading) {
                  Get.toNamed(CreateTrackEventSlotScreen.routeName,
                      arguments: {
                    'type': type,
                        'id': id,
                        'edit':true,
                      });
                }
              },
              icon: Container(
                padding: padding12,
                // height: 40.w,
                // width: 40.w,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(addIconUrl))),
                child:isLoading?DefaultProgressIndicator(strokeWidth: 2 ,color: AppColors.primaryColor,): Image.asset(
                  plusIconUrl,
                  height: 17.w,
                  width: 17.w,
                  color: AppColors.whiteLightColor,
                ),
              ),
            );
          })
        ],
      ),
      body: Obx(() {
        List<dynamic> slotList = [];
        bool isLoading = true;
        if (type == event) {
          slotList =
              CreateTrackEventController.to.singleEvent.value.slots ?? [];
          isLoading = CreateTrackEventController.to.isLoadingEvent.value;
        } else {
          slotList =
              CreateTrackEventController.to.singleTrack.value.slots ?? [];
          isLoading = CreateTrackEventController.to.isLoadingTrack.value;
        }
        return isLoading
            ? SlotListHorizontalLoadingWidget()
            : slotList.isEmpty
                ? const EmptyTextWidget(
                    text: AppStaticString.slotListIsEmpty,
                  )
                : ListView.builder(
                    padding: padding16,
                    itemBuilder: (context, index) {
                      final slot = slotList[index];

                      // Determine the ID dynamically

                      return Padding(
                        padding: padding6V,
                        child: MarronGradientContainerWidget(
                          child: TrackSlotWidget(
                            needToShowSeat: type == 'event',
                            eventSlots:
                                type == 'event' ? slot as EventSlots : null,
                            slots: type == 'track' ? slot as TrackSlots : null,
                            onTap: () {
                              if (type == 'track') {
                                debugPrint('slotId');
                                debugPrint(slot.sId);
                                HomeController.to.getTrackParticipantListCall(
                                  trackSlotId: slot.sId,
                                );
                              } else {
                                HomeController.to.getEventParticipantListCall(
                                  eventSlotID: slot.sId!,
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
                  );
      }),
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
