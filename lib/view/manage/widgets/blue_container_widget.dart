import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';

class BlueContainerWidget extends StatelessWidget {
  final Widget? child;
  const BlueContainerWidget({
    super.key, this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding12,
      decoration: BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.circular(8.r)),
      child: child??const SizedBox.shrink(),
    );
  }
}
