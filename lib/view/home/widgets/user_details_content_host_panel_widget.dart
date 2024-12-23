import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';

class UserDetailsContentOfHostPanel extends StatelessWidget {
  const UserDetailsContentOfHostPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [
        Row(
          children: [
            const ProfileCircleImageWidget(),
            space16W,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///======================= dynamic name======================///
                Text(
                  AppStaticString.dummyName,
                  style: poppinsRegular.copyWith(
                      fontSize: getFontSizeDefault(context)),
                ),

                ///======================= dynamic email======================///
                Text('mdhasan854@gmail.com',
                    style: poppinsRegular.copyWith(
                        fontSize: getFontSizeSmall(context),
                        color: AppColors.normalDarkWhite)),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///======================= dynamic slot no======================///
            Text(
              AppStaticString.slotNo,
              style: poppinsRegular.copyWith(
                  fontSize: getFontSizeDefault(context)),
            ),
            const DividerVertical(),

            ///======================= dynamic date======================///
            Text('${AppStaticString.dateWithClone}01-12-2024',
                style: poppinsRegular.copyWith(
                    fontSize: getFontSizeSmall(context))),
          ],
        ),
        Row(
          spacing: 6.w,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6.h,
                children: [
                  Text(AppStaticString.startTime,
                      style: poppinsRegular.copyWith(
                          fontSize: getFontSizeSmall(context))),

                  ///======================dynamic start time=============================///
                  Text(AppStaticString.dummyTime,
                      style: poppinsRegular.copyWith(
                          fontSize: getFontSizeSmall(context),
                          color: AppColors.blueColor)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                spacing: 6.h,
                children: [
                  Text(AppStaticString.endTime,
                      style: poppinsRegular.copyWith(
                          fontSize: getFontSizeSmall(context))),

                  ///======================dynamic end time=============================///
                  Text(AppStaticString.dummyTime,
                      style: poppinsRegular.copyWith(
                          fontSize: getFontSizeSmall(context),
                          color: AppColors.blueColor)),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
