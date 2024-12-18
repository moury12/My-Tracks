import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/custom_space.dart';
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
      this.borderColor = AppColors.primaryColor,
      this.child, this.img, this.icon, this.fontSize,  this.radius});

  final double height;
  final double? radius;
  final double width;
  final Color fillColor;
  final Color borderColor;

  final Color textColor;

  final VoidCallback onTap;

  final String title;
  final Widget? child;
  final String? img;
  final IconData? icon;

  final double marginVerticel;
  final double? fontSize;
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
            borderRadius: BorderRadius.circular(radius??8.r),
            color: fillColor),
        child: child ??
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: textColor,
                      fontSize:fontSize?? getFontSizeSemiSmall(context)),
                ),
                icon != null || img != null ? space8W : const SizedBox.shrink(),
                img != null
                    ? Image.asset(
                        img ?? '',
                        height: 14.w,
                        width: 14.w,
                  color: AppColors.blackColor,
                      )
                    : icon != null
                        ? Icon(
                            icon,
                            size: 24.sp,
                          )
                        : const SizedBox.shrink(),
              ],
            ),
      ),
    );
  }
}
