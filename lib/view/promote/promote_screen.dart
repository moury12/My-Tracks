import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';

class PromoteScreen extends StatelessWidget {
  const PromoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding:padding16,
        child: Column(spacing: 16.h,
          children: [
            CustomDropdown(
              radius: 4.r,
              fillColor: AppColors.navigationColor,
              borderColor:AppColors.blackBorderColor ,
              iconColor: AppColors.normalDarkWhite,
              hintText: AppStaticString.selectTrack,
            ),

            const EventCardWidget(noButton: true,),

            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: CustomButton(onTap: () {

              },
              title: AppStaticString.goPay,),
            )
          ],
        ),
      ),
    );
  }
}