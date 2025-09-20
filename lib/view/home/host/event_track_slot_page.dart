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
  final arguments = Get.arguments as Map<String, dynamic>? ?? {};

  String type = '';
  String id = '';
  String title = '';
  List<DateTime> dates = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    type = arguments['type']?.toString() ?? '';
    id = arguments['id']?.toString() ?? '';
    title =
    type == 'event' ? AppStaticString.eventSlot : AppStaticString.trackSlot;

    if (id.isNotEmpty && type.isNotEmpty) {
      if (type == event) {
        CreateTrackEventController.to.getEventDetailsCall(eventId: id);
      } else {
        getDates();
        //
        // // Pagination listener
        scrollController.addListener(() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            fetchSlots(loadMore: true);
          }
        });
      }
    } else {
      debugPrint('Error: Missing eventId or trackId.');
    }
  }

  void getDates() async {
    await CreateTrackEventController.to.getTrackDetailsCall(trackId: id).then((
        _) {
      final slotDates = CreateTrackEventController
          .to.singleTrack.value.slotAvailableDates;

      if (slotDates != null && slotDates.isNotEmpty) {
        final parsedDates = slotDates
            .map((e) => DateFormat("MM/dd/yyyy").parse(e.toString()))
            .toList();

        final List<DateTime> expandedDates = [];
        for (final date in parsedDates) {
          for (int month = 1; month <= 12; month++) {
            try {
              final lastDayOfMonth = DateTime(date.year, month + 1, 0).day;

              if (date.day <= lastDayOfMonth) {
                expandedDates.add(DateTime(date.year, month, date.day));
              }            } catch (_) {}
          }
        }

        setState(() {
          dates = {...parsedDates, ...expandedDates}.toList()
            ..sort();
        });
      }
      fetchSlots();
    });
  }

  void fetchSlots({bool loadMore = false}) async {
    await CreateTrackEventController.to.getTrackSlotForDayCall(
        trackId: id, loadMore: loadMore);
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
                  CreateTrackEventController.to.isLoadingSlotsList.value;
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
                CreateTrackEventController.to.slotList;
            isLoading = CreateTrackEventController.to.isLoadingTrack.value ||
                CreateTrackEventController.to.isLoadingSlotsList.value;
          }

          return CustomScrollView(
            controller: scrollController,
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
                    preSelectedDates: dates,
                    // This is an empty list, which is fine now
                    onDateSelected: (selectedDates) {

                      CreateTrackEventController.to.selectedDates.value =
                          selectedDates;
                      print(  CreateTrackEventController.to.selectedDates);
                    },
                  ),
                ),
              ),),
              Obx(() {
                return SliverToBoxAdapter(
                    child: CreateTrackEventController.to
                        .selectedDates.isNotEmpty ?
                    Padding(
                      padding: padding12H6V,
                      child: Row(spacing: 6.w,
                        children: [
                          Expanded(
                            child: CustomButton(
                              isLoading: CreateTrackEventController.to.isLoadingSetSlot.value,
                              fillColor:AppColors.blueColorDark,
                              borderColor:AppColors.blueColorDark,
                              onTap: () {
                              CreateTrackEventController.to.setSlotTrackCall(
                                  trackId: id, slotIds: CreateTrackEventController.to.slotIdsList, arrOfDayNo: [],);
                            },
                              title: AppStaticString.setSlot,

                            ),
                          ),Expanded(
                            child: CustomButton(

                              onTap: () {
                              CreateTrackEventController.to.getTrackSlotForDayCall(
                                  trackId: id, dates: CreateTrackEventController.to
                                  .selectedDates.map((element) => element.day,)
                                  .toSet()
                                  .toList());
                            },
                              title: AppStaticString.filterSlot,

                            ),
                          ),Expanded(
                            child: CustomButton(onTap: () {
                              print("CreateTrackEventController.to.selectedDates");
                              CreateTrackEventController.to
                                  .selectedDates.clear();
                              CreateTrackEventController.to
                                  .selectedDates.value=[];
                              CreateTrackEventController.to.getTrackSlotForDayCall(
                                  trackId: id,);
                            },
                              fillColor:AppColors.greenColor,
                              borderColor:AppColors.greenColor,
                              title: AppStaticString.clear,
                            ),
                          ),
                        ],
                      ),
                    )
                        : SizedBox.shrink());
              }),

              // ListView Sliver below the calendar
              isLoading
                  ? SliverToBoxAdapter(child: SlotListHorizontalLoadingWidget())
                  : slotList.isEmpty
                  ? SliverToBoxAdapter(
                child: const EmptyTextWidget(
                  text: AppStaticString.slotListIsEmpty,
                ),
              )
                  : SliverList(

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
