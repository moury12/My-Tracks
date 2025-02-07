import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/delete_alert_dialog.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class TrackEventSlotWidget extends StatelessWidget {
  final String? argument;
  final bool? needToShowSeat;
  final bool? needToBook;
  final bool? buttonLoading;
  final TrackSlots? slots;
  final EventSlots? eventSlots;
  final Function()? onTap;
  final Function()? onViewAllParticipant;
  final Function()? onDelete;
  final Function()? onBook;
  const TrackEventSlotWidget({
    super.key,
    this.argument,
    this.needToShowSeat = false,
    this.onTap,
    this.slots,
    this.onDelete,
    this.eventSlots,
    this.onViewAllParticipant,
    this.needToBook = false,
    this.onBook,
    this.buttonLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${slots != null ? slots!.slotNo ?? 'n/a' : ''} ${eventSlots != null ? eventSlots!.slotNo ?? 'n/a' : ''} Slot',
            style: poppinsRegular.copyWith(
                fontSize: getFontSizeExtraLarge(context)),
          ),
          space6H,

          ///================= slot price dynamic========================///
          Text(
            '${slots != null ?( slots!.currency?? '\$' ).toUpperCase(): '' } ${slots != null ? slots!.price ?? 'n/a' : ''}'
            '${eventSlots != null ? (eventSlots!.currency ?? 'n/a').toUpperCase() : ''} ${eventSlots != null ? eventSlots!.price ?? 'n/a' : ''}',
            style: poppinsSemiBold.copyWith(
                fontSize: getFontSizeExtraLarge(context),
                color: AppColors.primaryColor),
            textAlign: TextAlign.end,
          ),
          space6H,
          Row(
            children: needToShowSeat == true
                ? [
                    Expanded(
                      child: BlueTextWidget(
                        text:
                            '${AppStaticString.allowedPeople} ${eventSlots != null ? eventSlots!.maxPeople : ''}   ${AppStaticString.unsold} ${eventSlots != null ? (eventSlots!.maxPeople ?? 0) - (eventSlots!.currentPeople ?? 0) : ''}',
                        textAlign: TextAlign.start,
                      ),
                    )
                  ]
                : slots != null
                    ? [
                        ///================= slot week dynamic========================///
                        Expanded(
                          child: argument == userPanel
                              ? Text(
                                  ///=================with total seat number================///
                                  '${slots != null ? slots!.day ?? '' : ''}(${AppStaticString.totalSeatWithClone}${slots != null ? slots!.maxPeople ?? 'n/a' : ''})',
                                  style: poppinsRegular.copyWith(
                                      fontSize: getFontSizeSmall(context)),
                                )
                              : Text(
                                  slots != null
                                      ? slots!.day ?? 'n/a'
                                      : 'sunday',
                                  style: poppinsRegular.copyWith(
                                      fontSize: getFontSizeSmall(context)),
                                ),
                        ),
                      ]
                    : [],
          ),
          space6H,

          ///================= slot time dynamic========================///
          Text(
            slots != null
                ? '${slots!.startTime} - ${slots!.endTime}'
                : AppStaticString.dummyTime,
            textAlign: TextAlign.end,
            style: poppinsRegular.copyWith(
                color: AppColors.blueColor,
                fontSize: getFontSizeSmall(context)),
          ),
          space6H,

          ///============================dynamic slot description===========================///

          ExpandableText(
            text: slots != null
                ? slots!.description ?? ''
                : eventSlots != null
                    ? eventSlots!.description ?? ''
                    : '',
            maxLines: 4, // Number of lines to show before truncating
          ),
          argument != null && argument == 'track_management'
              ? GestureDetector(
                  onTap: onViewAllParticipant,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        AppStaticString.viewAllParticipent,
                        style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSmall(context)),
                      ),
                      space12W,
                      Image.asset(
                        arrowTopImgUrl,
                        color: AppColors.whiteLightColor,
                        height: 14.w,
                        width: 14.w,
                      )
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    argument == userPanel
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => DeleteAlertDialog(
                                  yesFunction: onDelete,
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Image.asset(
                                deleteIconUrl,
                                height: 24.w,
                                width: 24.w,
                              ),
                            ),
                          ),
                  ],
                ),
          needToBook == true
              ? CustomButton(
                  isLoading: buttonLoading,
                  marginVerticel: 6.h,
                  onTap: onBook ?? () {},
                  title: AppStaticString.bookSlot,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class SlotLoadingWidget extends StatelessWidget {
  const SlotLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MarronGradientContainerWidget(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[600]!,
        child: Column(
          children: [
            // Loading effect for Slot number and price
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 20.h,
                    color: Colors.grey,
                  ),
                ),
                space6W,
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 20.h,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            space12H,
            // Loading effect for Slot description or time
            Container(
              height: 20.h,
              width: double.infinity,
              color: Colors.grey,
            ),
            space12H,
            // Loading effect for ExpandableText
            Container(
              height: 80.h,
              width: double.infinity,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    ); // Return an empty widget in light mode or when not loading.
  }
}
