import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class DeleteAlertDialog extends StatelessWidget {
  final Widget? title;
  final String? text;
  final Widget? widgets;
  final bool? showButton;
  final String? text1;
  final String? text2;
  const DeleteAlertDialog({
    super.key, this.title, this.widgets, this.text1, this.text2, this.showButton=true, this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.blackColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [Spacer(),
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(CupertinoIcons.multiply)),
            ],
          ),
          title??SizedBox.shrink(),
          Text(textAlign: TextAlign.center,
          text??  AppStaticString.areYouSureToDelete,
            style: poppinsRegular.copyWith(fontSize: getFontSizeLarge(context)),
          ),
          space16H,
          widgets??SizedBox.shrink(),
       showButton==true?   Row(
            spacing: 16.w,
            children: [
              Expanded(
                  child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                // height: 44.h,
               width: 92.w,
                title: text1??AppStaticString.yes,
                textColor: AppColors.whiteLightColor,
                borderColor: AppColors.redBrightColor,
                fillColor: AppColors.redBrightColor,
              )),
              Expanded(
                  child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                // height: 44.h,
               width: 92.w,
                title: text2??AppStaticString.no,
                textColor: AppColors.whiteLightColor,
                borderColor: AppColors.greenColor,
                fillColor: AppColors.greenColor,
              )),
            ],
          ):SizedBox.shrink(),
        ],
      ),
    );
  }
}
