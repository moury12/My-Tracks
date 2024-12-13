import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.height = 48,
      this.width = double.maxFinite,
      required this.onTap,
      this.title = '',
      this.marginVerticel = 0,
      this.marginHorizontal = 0,
      this.fillColor = AppColors.primaryColor,
      this.textColor = AppColors.blackLightColor,
      this.borderColor = AppColors.primaryColor});

  final double height;
  final double width;
  final Color fillColor;
  final Color borderColor;

  final Color textColor;

  final VoidCallback onTap;

  final String title;

  final double marginVerticel;
  final double marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: marginVerticel, horizontal: marginHorizontal),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8.r),
            color: fillColor),
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: textColor,
              fontSize: getFontSizeSemiSmall(context)),
        ),
      ),
    );
  }
}
