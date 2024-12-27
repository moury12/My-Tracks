import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/utils/app_color.dart';

class CustomRadioButton extends StatelessWidget {
  final int index;  // Index of the radio button
  const CustomRadioButton({
    super.key,
    required this.index,  // Require an index to know which radio button it is
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 20.w,
        width: 20.w,
        padding: EdgeInsets.all(3.sp),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: CommonController.to.selectedOption.value == index
                ?AppColors.primaryColor
                : AppColors.whiteLightColor,
            width: CommonController.to.selectedOption.value == index
                ? 6.sp
                : 2.sp,
          ),
        ),
        child: CommonController.to.selectedOption.value != index
            ? Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.whiteLightColor,
          ),
        )
            : const SizedBox.shrink(),
      );
    });
  }
}
