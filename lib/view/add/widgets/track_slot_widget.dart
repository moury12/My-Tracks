import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/create_track_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/delete_alert_dialog.dart';
import 'package:track_trek/view/add/widgets/point_text_widget.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/event_user_page.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class TrackSlotWidget extends StatelessWidget {
  final String? argument;
  final bool? needToShowSeat;
  final Slots? slots;
  final Function()? onTap;
  const TrackSlotWidget({
    super.key,
    this.argument,
    this.needToShowSeat = false,
    this.onTap,
    this.slots,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              ///================= slot num dynamic========================///
              Expanded(
                flex: 4,
                child: Text(
                  '${AppStaticString.slotNumber} ${slots != null ? slots!.slotNo ?? 'n/a' : '01'}',
                  style: poppinsRegular.copyWith(
                      fontSize: getFontSizeExtraLarge(context)),
                ),
              ),

              ///================= slot price dynamic========================///
              Expanded(
                  flex: 2,
                  child: Text(
                    '\$${slots != null ? slots!.price ?? 'n/a' : '120.00'}',
                    style: poppinsSemiBold.copyWith(
                        fontSize: getFontSizeExtraLarge(context),
                        color: AppColors.primaryColor),
                    textAlign: TextAlign.end,
                  ))
            ],
          ),
          space6H,
          Row(
            children: needToShowSeat == true
                ? [
                    const BlueTextWidget(
                      text:
                          '${AppStaticString.allowedPeople} 30   ${AppStaticString.unsold} 10',
                      textAlign: TextAlign.start,
                    )
                  ]
                : [
                    ///================= slot week dynamic========================///
                    Expanded(
                      child: argument == userPanel
                          ? Text(
                              ///=================with total seat number================///
                              '${slots != null ? slots!.day ?? 'n/a' : 'sunday'}(${AppStaticString.totalSeatWithClone}${slots != null ? slots!.maxPeople ?? 'n/a' : '10'})',
                              style: poppinsRegular.copyWith(
                                  fontSize: getFontSizeSmall(context)),
                            )
                          : Text(
                              slots != null ? slots!.day ?? 'n/a' : 'sunday',
                              style: poppinsRegular.copyWith(
                                  fontSize: getFontSizeSmall(context)),
                            ),
                    ),

                    ///================= slot time dynamic========================///
                    Expanded(
                        child: Text(
                      slots != null
                          ? '${slots!.startTime} - ${slots!.endTime}'
                          : AppStaticString.dummyTime,
                      textAlign: TextAlign.end,
                      style: poppinsRegular.copyWith(
                          color: AppColors.blueColor,
                          fontSize: getFontSizeSmall(context)),
                    ))
                  ],
          ),
          space12H,
        ///============================dynamic slot description===========================///
        if ( slots!= null)   ExpandableText(
    text: slots!.description??'',
    maxLines: 3, // Number of lines to show before truncating
    ),
          argument != null && argument == 'track_management'
              ? GestureDetector(
                  onTap: () {
                    Get.toNamed(EventUserScreen.routeName);
                  },
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
                                builder: (context) => const DeleteAlertDialog(),
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
                    Text(
                      AppStaticString.seeMore,
                      style: poppinsMedium.copyWith(
                          fontSize: getFontSizeSmall(context)),
                    ),
                    space8W,
                    const Icon(Icons.arrow_drop_down_outlined)
                  ],
                )
        ],
      ),
    );
  }
}
