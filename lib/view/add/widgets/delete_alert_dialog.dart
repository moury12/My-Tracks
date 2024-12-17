import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.blackColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStaticString.areYouSureToDelete,
            style: poppinsRegular.copyWith(
                fontSize: getFontSizeLarge(context)),
          ),
          space16H,
          Row(
            spacing: 16.w,
            children: [
              Expanded(
                  child: CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    height: 44.h,
                    width: 92.w,
                    title: AppStaticString.yes,
                    textColor: AppColors.whiteLightColor,
                    borderColor: AppColors.redBrightColor,
                    fillColor: AppColors.redBrightColor,
                  )),
              Expanded(
                  child: CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    height: 44.h,
                    width: 92.w,
                    title: AppStaticString.no,
                    textColor: AppColors.whiteLightColor,
                    borderColor: AppColors.greenColor,
                    fillColor: AppColors.greenColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
