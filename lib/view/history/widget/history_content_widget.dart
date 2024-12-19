import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_text_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
class HistoryContentWidget extends StatelessWidget {
  final bool? addRating;
  const HistoryContentWidget({
    super.key, this.addRating=false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 6.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 12.w,
          children: [
            ///===================dynamic slot no =============================///
            Expanded(
                child: Text(
                  '${AppStaticString.slotNumber} 01',
                  style: poppinsSemiBold.copyWith(
                      fontSize: getFontSizeExtraLarge(context)),

                )),

            ///===================dynamic price =============================///

            Expanded(child: Text('${AppStaticString.fee} \$120',
              textAlign: TextAlign.end,
              style: poppinsSemiBold.copyWith(
                  color: AppColors.normalDarkWhite,
                  fontSize: getFontSizeExtraLarge(context)),)),
          ],
        ),
        ///===================dynamic week day =============================///

        Row(
          children: [
            Text(
              AppStaticString.dummyDay,
              style: poppinsMedium.copyWith(
                  fontSize: getFontSizeDefault(context)),

            ),
            Spacer(),
            addRating==true?CustomTextButton(fontSize: getFontSizeDefault(context),
              title: AppStaticString.rating,textColor: AppColors.yellowColor,):SizedBox.shrink()
          ],
        ),  Text(
          AppStaticString.startDateTime,
          style: poppinsMedium.copyWith(
              fontSize: getFontSizeSmall(context)),

        ),
        ///===================dynamic start date time =============================///

        Text(
          AppStaticString.dummyTime,
          style: poppinsMedium.copyWith(
              color: AppColors.primaryColor,
              fontSize: getFontSizeSmall(context)),

        ),Text(
          AppStaticString.endDateTime,
          style: poppinsMedium.copyWith(
              fontSize: getFontSizeSmall(context)),

        ),
        ///===================dynamic end date time =============================///

        Text(
          AppStaticString.dummyTime,
          style: poppinsMedium.copyWith(
              color: AppColors.blueColor,
              fontSize: getFontSizeSmall(context)),

        ),
      ],
    );
  }
}
