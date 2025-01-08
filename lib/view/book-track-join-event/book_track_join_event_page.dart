import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:track_trek/controller/book_track_join_event_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/upload_track.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_payment_page.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class BookTrackJoinEventScreen extends StatelessWidget {
  static const String routeName = '/book-join-track-event';
  const BookTrackJoinEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = Get.arguments;
    String sId = argument['id'];
    String type = argument['type'];
    final controller = BookTrackJoinEventController.to;
    type == event
        ? controller.getEventDetailsCall(eventId: sId)
        : controller.getTrackDetailsCall(trackId: sId);

    return Scaffold(
      appBar: CustomAppbar(
        tile: argument != null && type == event
            ? AppStaticString.joinEvent
            : AppStaticString.bookTRack,
      ),
      body: SingleChildScrollView(
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
                        height: 200.h,
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
                                            height: 200.h,
                                            width: double.infinity)),
                              ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(iconCircleWithBorderUrl))),
                        child: IconButton(
                            highlightColor: BookTrackJoinEventController
                                        .to.currentIndex.value >
                                    0
                                ? Colors.white10
                                : Colors.transparent,
                            onPressed: () {
                              if (BookTrackJoinEventController
                                      .to.currentIndex.value >
                                  0) {
                                BookTrackJoinEventController
                                    .to.currentIndex.value--;
                                BookTrackJoinEventController
                                    .to.pageController.value
                                    .animateToPage(
                                        BookTrackJoinEventController
                                            .to.currentIndex.value,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                              }
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: BookTrackJoinEventController
                                          .to.currentIndex.value >
                                      0
                                  ? AppColors.normalDarkWhite
                                  : null,
                            )),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(iconCircleWithBorderUrl))),
                        child: IconButton(
                            highlightColor: BookTrackJoinEventController
                                        .to.currentIndex.value >
                                    0
                                ? Colors.white10
                                : Colors.transparent,
                            onPressed: () {
                              BookTrackJoinEventController
                                  .to.currentIndex.value++;
                              BookTrackJoinEventController
                                  .to.pageController.value
                                  .animateToPage(
                                      BookTrackJoinEventController
                                          .to.currentIndex.value,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                            },
                            icon: const Icon(Icons.arrow_forward_ios)),
                      ),
                    ),
                  ],
                );
              }),
              space16H,
              Padding(
                padding: padding16H,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.h,
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
                            String location = argument != null && type == event
                                ? controller.singleEvent.value.address ?? 'n/a'
                                : controller.singleTrack.value.address ?? 'n/a';
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
                                            fontSize:
                                                getFontSizeExtraLarge(context)),
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
                                    String date = (controller
                                                .singleEvent.value.startDate ??
                                            'n/a')
                                        .toString();
                                    String time =
                                        '${controller.singleEvent.value.startTime ?? 'n/a'} - ${controller.singleEvent.value.endTime ?? 'n/a'}';
                                    return controller.isLoadingTrackEvent.value
                                        ? const DateTimeLoadingEffect()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
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
                                : SelectDateButton()),
                      ],
                    ),
                    argument != null && type == event
                        ? Obx(() {
                            String totalSlot =
                                (controller.singleEvent.value.totalSeat ?? '0')
                                    .toString();
                            String unSold =
                                (controller.singleEvent.value.unSold ?? '0')
                                    .toString();
                            return controller.isLoadingTrackEvent.value
                                ? DescriptionLoadingEffect()
                                : BlueTextWidget(
                                    text:
                                        '${AppStaticString.allowedPeople} $totalSlot   ${AppStaticString.unsold} $unSold',
                                    textAlign: TextAlign.start,
                                  );
                          })
                        : const SizedBox.shrink(),
                    Obx(() {
                      String desc = argument != null && type == event
                          ? ''
                          : controller.singleTrack.value.description ?? 'n/a';

                      return controller.isLoadingTrackEvent.value
                          ? const DescriptionLoadingEffect()
                          : ExpandableText(
                              text: desc,

                              // maxLines: 3,
                            );
                    }),
                    /*Obx(
                      () {
                        List<dynamic> slotsList = [];
                        if (type == event) {
                          slotsList = controller.singleEvent.value.slots ?? [];
                        } else {
                          slotsList = controller.singleTrack.value.slots ?? [];
                        }
                        return controller.isLoadingTrackEvent.value
                            ? Column(
                                spacing: 12.h,
                                children: List.generate(
                                  4,
                                  (index) => const SlotLoadingWidget(),
                                ),
                              )
                            :
                                    slotsList.isEmpty
                                ? const EmptyTextWidget(
                                    text: AppStaticString.slotListIsEmpty)
                                : Column(
                                    spacing: 12.h,
                                    children: List.generate(
                                      argument != null && type == event
                                          ? controller
                                          .singleEvent.value.slots!.length
                                          : controller
                                              .singleTrack.value.slots!.length,
                                      (index) => MarronGradientContainerWidget(
                                        child: TrackSlotWidget(
                                          slots:argument != null && type == event
                                              ?null: controller
                                              .singleTrack.value.slots![index],
                                          eventSlots:argument != null && type == event
                                        ?controller
                                            .singleEvent.value.slots![index] :null,
                                          onTap: () {
                                            Get.toNamed(
                                                BookTrackJoinEventPaymentScreen
                                                    .routeName,
                                                arguments: type);
                                          },
                                          argument: userPanel,
                                          needToShowSeat:
                                              argument != null && type == event
                                                  ? true
                                                  : false,
                                        ),
                                      ),
                                    ),
                                  );
                      },
                    )*/
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionLoadingEffect extends StatelessWidget {
  const DescriptionLoadingEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60.h, // Adjust height to match the text widget
        color: Colors.grey,
      ),
    );
  }
}

class DateTimeLoadingEffect extends StatelessWidget {
  const DateTimeLoadingEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Placeholder for Date
          Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              height: 12.0,
              width: 150.0,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8.0),

          /// Placeholder for Time
          Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              height: 12.0,
              width: 200.0,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}

class NameLocationLoadingEffect extends StatelessWidget {
  const NameLocationLoadingEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Column(
        spacing: 6.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 24.h,
            width: MediaQuery.of(context).size.width * 0.6,
            color: Colors.grey,
          ),
          SizedBox(height: 8.h),
          Container(
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class ShimmerEffectForListOfImageList extends StatelessWidget {
  const ShimmerEffectForListOfImageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkTheme ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDarkTheme ? Colors.grey[600]! : Colors.grey[100]!,
      child: BlackContainerWidget(
        padding: padding16H,
        child: Container(
          color: isDarkTheme ? Colors.grey[900]! : Colors.grey,
          height: 200.h,
          width: double.infinity,
        ),
      ),
    );
  }
}
