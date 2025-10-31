import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class BlackContainerWithBroder extends StatelessWidget {
  final String? text;
  const BlackContainerWithBroder({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding12V,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.blueColorDark,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(width: 1, color: AppColors.textFieldColor)),
        child: Text(
          text ?? AppStaticString.customerInfo,
          style: poppinsMedium.copyWith(
              color: AppColors.whiteBrightColor,
              fontSize: getFontSizeDefault(context)),
        ));
  }
}