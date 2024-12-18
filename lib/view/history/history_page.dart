import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = '/history';
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.history,
      ),
      body: ListView.builder(
padding: padding16,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: MarronGradientContainerWidget(
            child: Column(spacing: 6.h,
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
                      style: poppinsRegular.copyWith(
                        color: AppColors.normalDarkWhite,
                          fontSize: getFontSizeExtraLarge(context)),)),
                  ],
                ),
                ///===================dynamic week day =============================///

                Text(
                  AppStaticString.dummyDay,
                  style: poppinsMedium.copyWith(
                      fontSize: getFontSizeDefault(context)),

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
            ),
          ),
        ),
        itemCount: 5,
      ),
    );
  }
}
