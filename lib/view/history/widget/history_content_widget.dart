import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_text_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';
import 'package:track_trek/view/add/widgets/delete_alert_dialog.dart';

class HistoryContentWidget extends StatelessWidget {
  final bool? addRating;
  const HistoryContentWidget({
    super.key,
    this.addRating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.h,
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

            Expanded(
                child: Text(
              '${AppStaticString.fee} \$120',
              textAlign: TextAlign.end,
              style: poppinsSemiBold.copyWith(
                  color: AppColors.normalDarkWhite,
                  fontSize: getFontSizeExtraLarge(context)),
            )),
          ],
        ),

        ///===================dynamic week day =============================///

        Row(
          children: [
            Text(
              AppStaticString.dummyDay,
              style:
                  poppinsMedium.copyWith(fontSize: getFontSizeDefault(context)),
            ),
            const Spacer(),

            ///=======================rating button=================///
            addRating == true
                ? RattingButtonWidget()
                : const SizedBox.shrink()
          ],
        ),
        Text(
          AppStaticString.startDateTime,
          style: poppinsMedium.copyWith(fontSize: getFontSizeSmall(context)),
        ),

        ///===================dynamic start date time =============================///

        Text(
          AppStaticString.dummyTime,
          style: poppinsMedium.copyWith(
              color: AppColors.primaryColor,
              fontSize: getFontSizeSmall(context)),
        ),
        Text(
          AppStaticString.endDateTime,
          style: poppinsMedium.copyWith(fontSize: getFontSizeSmall(context)),
        ),

        ///===================dynamic end date time =============================///

        Text(
          AppStaticString.dummyTime,
          style: poppinsMedium.copyWith(
              color: AppColors.blueColor, fontSize: getFontSizeSmall(context)),
        ),
      ],
    );
  }
}

class RattingButtonWidget extends StatelessWidget {
  const RattingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
        fontSize: getFontSizeDefault(context),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => DefaultDialogWithButton(
              title: AppStaticString.rating,
              content: Column(
                spacing: 16.h,
                children: [
                  space6H,
                RatingBar(
                initialRating: 3,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: Image.asset(starFillIconUrl),
        half:Image.asset(starFillIconUrl),
                  empty:Image.asset(starIconUrl),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.sp),
                onRatingUpdate: (rating) {

                },
              ),
                  CustomTextField(title: AppStaticString.feedback,
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,),
                space6H,
                ],
              ),
              rowButton: Row(
                spacing: 16.w,
                children: [
                  Expanded(
                    child: CustomButton(onTap: () {
                      Navigator.pop(context);
                    },
                    fillColor: AppColors.redBrightColor,
                    borderColor: AppColors.redBrightColor,
                    title: AppStaticString.cancel,
                    textColor: AppColors.blackLightColor,),
                  ),Expanded(
                    child: CustomButton(onTap: () {
                      Navigator.pop(context);
                    },
                    fillColor: AppColors.blueColor,
                    borderColor: AppColors.blueColor,
                    title: AppStaticString.send,
                    textColor: AppColors.blackLightColor,),
                  )
                ],
              ),
            ),
          );
        },
        title: AppStaticString.rating,
        textColor: AppColors.yellowColor,
      );
  }
}
