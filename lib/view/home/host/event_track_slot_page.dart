import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:track_trek/controller/create_track_event_controller.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_refresh_indicator.dart';
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
import 'package:track_trek/view/add/widgets/multiple_date_picker.dart';
import 'package:track_trek/view/add/widgets/track_event_slot_widget.dart';
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
  List<DateTime> dates=[];

  @override
  void initState() {
    type = arguments['type'] as String;
    id = arguments['id'] as String;
    final List<dynamic>? dateListDynamic = arguments['dates'] as List<dynamic>?;


    dates =dateListDynamic != null
        ? dateListDynamic.map((e) => DateFormat("MM/dd/yyyy").parse(e.toString())).toList()
        : [];
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
              isLoading = CreateTrackEventController.to.isLoadingTrack.value;
            } else {
              isLoading = CreateTrackEventController.to.isLoadingEvent.value;
            }
            return IconButton(
              onPressed: () {
                if (type == 'track') {
                  // CreateTrackEventController.to.weekDays.clear();
                  if (CreateTrackEventController.to.weekDays.isEmpty) {
                    for (String day in CreateTrackEventController
                        .to.singleTrack.value.trackDays ??
                        []) {
                      CreateTrackEventController.to.weekDays
                          .add({'day_name': day, 'selected': true});
                    }
                    if (CreateTrackEventController
                        .to.singleTrack.value.trackDays !=
                        null &&
                        CreateTrackEventController
                            .to.singleTrack.value.trackDays!.isNotEmpty) {
                      CreateTrackEventController
                          .to.selectedWeekDay.value = CreateTrackEventController
                          .to.singleTrack.value.trackDays![0];
                    }
                  }
                  CreateTrackEventController.to.days.value =
                      CreateTrackEventController
                          .to.singleTrack.value.totalTrackDayInMonth
                          .toString();
                }
                if (!isLoading) {
                  Get.toNamed(CreateTrackEventSlotScreen.routeName, arguments: {
                    'type': type,
                    'id': id,
                    'edit': CreateTrackEventController
                        .to.singleTrack.value.trackDays !=
                        null &&
                        CreateTrackEventController
                            .to.singleTrack.value.trackDays!.isNotEmpty
                        ? true
                        : false,
                  });
                }
              },
              icon: Container(
                padding: padding12,
                // height: 40.w,
                // width: 40.w,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(addIconUrl))),
                child: isLoading
                    ? DefaultProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primaryColor,
                )
                    : Image.asset(
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
      body: CustomRefreshIndicator(
        onRefresh: () async {
          if (type == event) {
            await CreateTrackEventController.to.getEventDetailsCall(
                eventId: id);
          } else {
            await CreateTrackEventController.to.getTrackDetailsCall(
                trackId: id);
          }
        },
        child: Obx(() {
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
              : CustomScrollView(
            slivers: [
              if (type != event) SliverToBoxAdapter(child: Container(
                margin: padding12H,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(colors: [
                      AppColors.blueColor,
                      AppColors.blueColorDark
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MultipleDatePicker(
                    preSelectedDates: dates, // This is an empty list, which is fine now
                    onDateSelected: (selectedDates) {
                      CreateTrackEventController.to.selectedDates.value =
                          selectedDates;
                      print(selectedDates);
                    },
                  ),
                ),
              ),),

              // ListView Sliver below the calendar
              SliverList(

                delegate: SliverChildBuilderDelegate(

                  childCount: slotList.length, (context, index) {
                  final slot = slotList[index];

                  return Padding(
                    padding: padding12H6V,
                    child: MarronGradientContainerWidget(
                      child: Obx(() {
                        return TrackEventSlotWidget(
                          needToShowCheckbox: CreateTrackEventController.to
                              .selectedDates.isNotEmpty,
                          needToShowSeat: type == 'event',
                          eventSlots: type == 'event'
                              ? slot as EventSlots
                              : null,
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
                        );
                      }),
                    ),
                  );
                },
                ),

              ),
            ],
          );
        }),
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
