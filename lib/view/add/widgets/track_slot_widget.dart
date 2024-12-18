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
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/delete_alert_dialog.dart';
import 'package:track_trek/view/add/widgets/point_text_widget.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/manage/event_user_page.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class TrackSlotWidget extends StatelessWidget {
  final String? argument;
  const TrackSlotWidget({
    super.key,
    this.argument,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ///================= slot num dynamic========================///
            Expanded(
              flex: 3,
              child: Text(
                '${AppStaticString.slotNumber} 01',
                style: poppinsRegular.copyWith(
                    fontSize: getFontSizeExtraLarge(context)),
              ),
            ),

            ///================= slot price dynamic========================///
            Expanded(
                flex: 2,
                child: Text(
                  '\$120.00',
                  style: poppinsSemiBold.copyWith(
                      fontSize: getFontSizeExtraLarge(context),
                      color: AppColors.primaryColor),
                  textAlign: TextAlign.end,
                ))
          ],
        ),
        space6H,
        Row(
          children: [
            ///================= slot week dynamic========================///
            Expanded(
              flex: 1,
              child: Text(
                'sunday',
                style: poppinsRegular.copyWith(
                    fontSize: getFontSizeDefault(context)),
              ),
            ),

            ///================= slot time dynamic========================///
            Expanded(
                flex: 3,
                child: Text(
                  AppStaticString.dummyTime,
                  textAlign: TextAlign.end,
                  style: poppinsRegular.copyWith(
                      color: AppColors.blueColor,
                      fontSize: getFontSizeSmall(context)),
                ))
          ],
        ),
        space12H,
        ...List.generate(
          3,
          (index) => const PointTextWidget(),
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
                  GestureDetector(
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
    );
  }
}
