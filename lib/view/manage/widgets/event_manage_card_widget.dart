import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';

class MarronGradientContainerWidget extends StatelessWidget {
  final Widget? child;

  const MarronGradientContainerWidget({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainerWidget(
      firstColor: AppColors.blackColor,
      secondColor: AppColors.marronColor,
      borderColor: const Color(0xff3E3E3E),
      borderWidth: 1,
      child: child ?? const TrackEventInfoContentWidget(),
    );
  }
}

class TrackEventInfoContentWidget extends StatelessWidget {
  const TrackEventInfoContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStaticString.dummyEvent,
          style: poppinsMedium.copyWith(fontSize: getFontSizeSmall(context)),
        ),
        space12H,
        Text(
          '${AppStaticString.locationWithClone} Rock Hill BMX Supercross Track (USA)',
          style: poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),
        ),
        space12H,
        Text(
          '${AppStaticString.dateWithClone} 5 january ${AppStaticString.dummyTime}',
          style: poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),
        ),
        space12H,
        Row(
          children: [
            const PriceTextWidget(),
            const DividerVertical(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${AppStaticString.totalAllowed}20',
                      style: poppinsRegular.copyWith(
                          fontSize: getFontSizeSmall(context)),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        arrowForwardIconUrl,
                        height: 24.w,
                      ))
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class UserInfoContentWidget extends StatelessWidget {
  final String? seatNo;
  const UserInfoContentWidget({
    super.key, this.seatNo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileCircleImageWidget(),
        space16W,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStaticString.dummyName,
                style: poppinsRegular.copyWith(
                    fontSize: getFontSizeDefault(context)),
              ),

              ///===================dynamic email==================///
              const UserInfoText(
                  text: '${AppStaticString.emailUser}mdhasan854@gmail.com'),

              ///===================dynamic phone==================///

              const UserInfoText(
                  text: '${AppStaticString.contact}mdhasan854@gmail.com'),

              ///===================dynamic date of birth==================///

              const UserInfoText(
                  text: '${AppStaticString.dateOfBirth}mdhasan854@gmail.com'),

              ///===================dynamic address==================///

              const UserInfoText(
                text: '${AppStaticString.address}mdhasan854@gmail.com',
              ),
            seatNo!=null?  const UserInfoText(
                text: '${AppStaticString.seat}07',
              ):const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

class UserInfoText extends StatelessWidget {
  final String text;
  const UserInfoText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: poppinsRegular.copyWith(
          fontSize: getFontSizeSmall(context), color: AppColors.fadeWhiteColor),
    );
  }
}
