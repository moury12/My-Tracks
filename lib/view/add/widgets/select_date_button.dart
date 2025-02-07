import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

class SelectDateButton extends StatelessWidget {
  final Function()? onTap;
  final String? date;
  final bool? isDisable;
  String? selectedDay;
  SelectDateButton({
    super.key,
    this.onTap, this.selectedDay, this.date, this.isDisable =false,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainerWidget(
      secondColor:isDisable==true? AppColors.greyColor:null,
      onTap: onTap ??
              () {
            selectedDay =selectDate(context).toString();
            ///==========Select date
          },
      radius: 4.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              date?? AppStaticString.selectDay,
              style: poppinsRegular.copyWith(
                  color: AppColors.blackLightColor,
                  fontSize: getFontSizeDefault(context)),
            ),
          ),
          space8W,
          Image.asset(
            calenderIconUrl,
            height: 24.w,
            width: 24.w,
          )
        ],
      ),
    );
  }
}
