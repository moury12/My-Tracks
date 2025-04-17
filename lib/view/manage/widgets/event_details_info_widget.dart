import 'package:flutter/material.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';

class EventDetailsInfoWidget extends StatelessWidget {
  const EventDetailsInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
     
      children: [
        ///=============dynamic event name+ date====================///
        const RowBlackTextWidget(
          text2: '${AppStaticString.dateWithClone}05 january',
        ),
        ///=============dynamic location + time====================///

        const RowBlackTextWidget(
          text1:
          '${AppStaticString.locationWithClone}${AppStaticString.dummyAddress}',
          text2: AppStaticString.dummyTime,
          textStyle1: poppinsRegular,
        ),
        ///=============dynamic event price + total seat====================///

        Row(
          children: [
            Text(
              '${AppStaticString.priceWithClone}\$120',
              style: poppinsMedium.copyWith(
                  color: AppColors.blackLightColor,
                  fontSize: getFontSizeDefault(context)),
            ),
            const DividerVertical(
              color: AppColors.blackLightColor,
            ),
            Text(
              '${AppStaticString.totalSeatWithClone}04',
              textAlign: TextAlign.right,
              style: poppinsRegular.copyWith(
                  fontSize: getFontSizeSmall(context),
                  color: AppColors.blackLightColor),
            ),
          ],
        )
      ],
    );
  }
}

class RowBlackTextWidget extends StatelessWidget {
  final String? text1;
  final String? text2;
  final TextStyle? textStyle1;
  final TextStyle? textStyle2;
  final double? fontSize1;
  final double? fontSize2;
  const RowBlackTextWidget({
    super.key,
    this.text1,
    this.text2,
    this.textStyle1 = poppinsMedium,
    this.textStyle2 = poppinsRegular,
    this.fontSize1,
    this.fontSize2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///=========================dynamic event name=====================///
        Expanded(
          flex: 2,
          child: Text(
            text1 ?? AppStaticString.dummyEvent,
            textAlign: TextAlign.left,
            style: textStyle1!.copyWith(
                fontSize: fontSize1 ?? getFontSizeSmall(context),
                color: AppColors.blackLightColor),
          ),
        ),

        ///=========================dynamic event date=====================///

        Expanded(
          flex: 1,
          child: Text(
            text2 ?? '',
            textAlign: TextAlign.right,
            style: textStyle2!.copyWith(
                fontSize: fontSize2 ?? getFontSizeSmall(context),
                color: AppColors.blackLightColor),
          ),
        ),
      ],
    );
  }
}