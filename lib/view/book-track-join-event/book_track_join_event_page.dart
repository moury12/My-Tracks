import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking/book_track_join_event_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/components/custom_refresh_indicator.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/upload_track.dart';
import 'package:track_trek/view/add/widgets/select_date_button.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/book-track-join-event/book_track_payment_page.dart';
import 'package:track_trek/view/book-track-join-event/join_event_payment_page.dart';
import 'package:track_trek/view/book-track-join-event/widgets/buttons_widget.dart';
import 'package:track_trek/view/book-track-join-event/widgets/loading_widgets.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
import 'package:track_trek/view/home/widgets/category_circle_widget.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class BookTrackJoinEventScreen extends StatelessWidget {
  static const String routeName = '/book-join-track-event';
  const BookTrackJoinEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = Get.arguments??{};
    String sId = argument['id']??'';
    String type = argument['type'];
    final controller = BookTrackJoinEventController.to;
    type == event
        ? controller.getEventDetailsCall(eventId: sId)
        : controller.getTrackDetailsCall(trackId: sId);
    type == event
        ? null
        : BookTrackJoinEventController.to.getTrackSlotListCall(trackId: sId);
    return Scaffold(
      appBar: CustomAppbar(
        tile: argument != null && type == event
            ? AppStaticString.joinEvent
            : AppStaticString.bookTRack,
      ),
      body: CustomRefreshIndicator(
        onRefresh: () {
          if (argument != null && type == event) {
            /* controller.selectDate.value='';*/
            return controller.getEventDetailsCall(eventId: sId);
          } else {
            /* controller.selectDate.value='';*/
            return controller.getTrackDetailsCall(trackId: sId);
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: padding16V,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  ///=======================dynamic img url===================///
                  List<String> imageUrl = argument != null && type == event
                      ? controller.singleEvent.value.eventImage ?? []
                      : controller.singleTrack.value.trackImage ?? [];
                  return Stack(
                    children: [
                      Padding(
                        padding: padding16H,
                        child: SizedBox(
                          height: 150.h,
                          child: controller.isLoadingTrackEvent.value
                              ? const ShimmerEffectForListOfImageList()
                              : PageView.builder(
                                  controller: BookTrackJoinEventController
                                      .to.pageController.value,
                                  itemCount: imageUrl.length,
                                  itemBuilder: (context, index) =>
                                      BlackContainerWidget(
                                          padding: padding16H,
                                          child: CustomNetworkImage(
                                              imageUrl:
                                                  '${ApiClient.baseUrl}/${imageUrl[index]}',
                                              height: 150.h,
                                              width: double.infinity)),
                                ),
                        ),
                      ),
                      const ArrowForwardIconButton(),
                      const ArrowBackwardIconButton(),
                    ],
                  );
                }),
                space16H,
                Padding(
                  padding: padding16H,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6.w,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Obx(() {
                              ///=======================dynamic name===================///

                              String name = argument != null && type == event
                                  ? controller.singleEvent.value.eventName ??
                                      'n/a'
                                  : controller.singleTrack.value.trackName ??
                                      'n/a';

                              ///=======================dynamic location===================///
                              String location =
                                  argument != null && type == event
                                      ? controller.singleEvent.value.address ??
                                          'n/a'
                                      : controller.singleTrack.value.address ??
                                          'n/a';
                              return controller.isLoadingTrackEvent.value
                                  ? const NameLocationLoadingEffect()
                                  : Column(
                                      spacing: 6.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ///===========dynamic event name================///
                                        Text(
                                          name,
                                          style: poppinsMedium.copyWith(
                                              fontSize: getFontSizeExtraLarge(
                                                  context)),
                                        ),

                                        ///===========dynamic event location================///

                                        Text(
                                          '${AppStaticString.locationWithClone} $location',
                                          style: poppinsRegular.copyWith(
                                              fontSize:
                                                  getFontSizeDefault(context)),
                                        ),
                                      ],
                                    );
                            }),
                          ),
                          Expanded(
                              flex: 2,
                              child: argument != null && type == event
                                  ? Obx(() {
                                      String date = (controller.singleEvent
                                                  .value.startDate ??
                                              'n/a')
                                          .toString();
                                      String time =
                                          '${controller.singleEvent.value.startTime ?? 'n/a'} - ${controller.singleEvent.value.endTime ?? 'n/a'}';
                                      return controller
                                              .isLoadingTrackEvent.value
                                          ? const DateTimeLoadingEffect()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ///===========dynamic event date================///

                                                  Text(
                                                    '${AppStaticString.dateWithClone}$date',
                                                    style:
                                                        poppinsRegular.copyWith(
                                                            fontSize:
                                                                getFontSizeSmall(
                                                                    context)),
                                                  ),

                                                  ///===========dynamic event time ================///
                                                  Text(
                                                    time,
                                                    style:
                                                        poppinsRegular.copyWith(
                                                            fontSize:
                                                                getFontSizeSmall(
                                                                    context)),
                                                  ),
                                                ],
                                              ),
                                            );
                                    })
                                  : Obx(() {
                                      ///====================select date for search slot==================///
                                      return SelectDateButton(
                                        date: BookTrackJoinEventController
                                                .to.selectDate.value.isNotEmpty
                                            ? BookTrackJoinEventController
                                                .to.selectDate.value
                                            : null,
                                        onTap: () async {
                                          BookTrackJoinEventController
                                                  .to.selectDate.value =
                                              await selectDate(context);
                                          debugPrint(
                                              BookTrackJoinEventController
                                                  .to.selectDate.value);
                                          await BookTrackJoinEventController.to
                                              .getTrackSlotListCall(
                                                  trackId: sId);
                                        },
                                        selectedDay:
                                            BookTrackJoinEventController
                                                .to.selectDate.value,
                                      );
                                    })),
                        ],
                      ),
                      argument != null && type == event
                          ? Obx(() {
                              String totalSlot =
                                  (controller.singleEvent.value.totalSeat ??
                                          '0')
                                      .toString();
                              String unSold =
                                  (controller.singleEvent.value.unSold ?? '0')
                                      .toString();
                              return controller.isLoadingTrackEvent.value
                                  ? const DescriptionLoadingEffect()
                                  : BlueTextWidget(
                                      text:
                                          '${AppStaticString.allowedPeople} $totalSlot   ${AppStaticString.unsold} $unSold',
                                      textAlign: TextAlign.start,
                                    );
                            })
                          : const SizedBox.shrink(),

                      ///======================dynmaic Description==================///
                      Obx(() {
                        String desc = argument != null && type == event
                            ? controller.singleEvent.value.description ?? 'n/a'
                            : controller.singleTrack.value.description ?? 'n/a';

                        return controller.isLoadingTrackEvent.value
                            ? const DescriptionLoadingEffect()
                            : ExpandableText(
                                text: desc,
                              );
                      }),

                      ///===================regular slot list======================///
                      const TitleTextWidget(title: AppStaticString.regularSlot),
                      Obx(
                        () {
                          List<dynamic> slotsList = [];
                          if (type == event) {
                            slotsList =
                                controller.singleEvent.value.slots ?? [];
                          } else {
                            slotsList =
                                controller.singleTrack.value.slots ?? [];
                          }
                          return controller.isLoadingTrackEvent.value
                              ? const SlotListLoadingWidget()
                              : slotsList.isEmpty
                                  ? const EmptyTextWidget(
                                      text: AppStaticString.slotListIsEmpty)
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        spacing: 12.h,
                                        children: List.generate(
                                          slotsList.length,
                                          (index) =>
                                              MarronGradientContainerWidget(
                                            child: SizedBox(
                                              width: 200.w,
                                              child: TrackSlotWidget(
                                                needToBook: type == event
                                                    ? true
                                                    : false,
                                                onBook: () {
                                                  Get.toNamed(
                                                      JoinEventPaymentScreen
                                                          .routeName,
                                                      arguments: {
                                                        'type': event,
                                                        'slot':
                                                            slotsList[index],
                                                        'event': controller
                                                            .singleEvent
                                                      });
                                                },
                                                slots: argument != null &&
                                                        type == event
                                                    ? null
                                                    : controller.singleTrack
                                                        .value.slots![index],
                                                eventSlots: argument != null &&
                                                        type == event
                                                    ? controller.singleEvent
                                                        .value.slots![index]
                                                    : null,
                                                onTap: () {
                                                  /*    Get.toNamed(
                                                      BookTrackJoinEventPaymentScreen
                                                          .routeName,
                                                      arguments: {
                                                        'type': type,
                                                        'slot': slotsList[index]
                                                      });*/
                                                },
                                                argument: userPanel,
                                                needToShowSeat:
                                                    argument != null &&
                                                            type == event
                                                        ? true
                                                        : false,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                        },
                      ),

                      ///===================available slot list======================///
                      if (type != event)
                        const TitleTextWidget(
                            title: AppStaticString.availableSlot),
                      if (type != event)
                        Obx(
                          () {
                            List<dynamic> slotsList = [];

                            slotsList = BookTrackJoinEventController
                                    .to.selectDate.value.isNotEmpty
                                ? BookTrackJoinEventController.to.trackSlotList
                                : [];

                            return controller.isLoadingTrackEvent.value ||
                                    controller.isLoadingSlotList.value
                                ? const SlotListLoadingWidget()
                                : slotsList.isEmpty
                                    ? EmptyTextWidget(
                                        text:
                                            '${controller.selectDate.value} this day not contain any slot kindly choose another date')
                                    : controller.selectDate.value.isEmpty
                                        ? const EmptyTextWidget(
                                            text: 'Please! choose valid date!!')
                                        : SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              spacing: 12.h,
                                              children: List.generate(
                                                slotsList.length,
                                                (index) =>
                                                    MarronGradientContainerWidget(
                                                  child: SizedBox(
                                                    /*height: 150.h, */
                                                    width: 200.w,
                                                    child: TrackSlotWidget(
                                                      slots: argument != null &&
                                                              type == event
                                                          ? null
                                                          : BookTrackJoinEventController
                                                                  .to
                                                                  .selectDate
                                                                  .value
                                                                  .isNotEmpty
                                                              ? controller
                                                                      .trackSlotList[
                                                                  index]
                                                              : controller
                                                                  .singleTrack
                                                                  .value
                                                                  .slots![index],
                                                      argument: userPanel,
                                                      onBook: () {
                                                        Get.toNamed(
                                                            BookTrackPaymentScreen
                                                                .routeName,
                                                            arguments: {
                                                              'type': type,
                                                              'slot': slotsList[
                                                                  index],
                                                              /*'event':controller.singleEvent*/
                                                            });
                                                      },
                                                      needToBook: true,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                          },
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
