import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

class CreateSlotButtonSmallWidget extends StatelessWidget {
  final Function()? onTap;

  const CreateSlotButtonSmallWidget({
    super.key, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerRight,
        child: IntrinsicWidth(
          child: GradientContainerWidget(
            radius: 4.r,
            padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStaticString.createSlot,
                  style: poppinsRegular.copyWith(
                      color: AppColors.blackLightColor,
                      fontSize: getFontSizeSmall(context)),
                ),
                space8W,
                Image.asset(
                  plusIconUrl,
                  height: 14.w,
                  width: 14.w,
                  color: AppColors.blackLightColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SaveSmallButtonWidget extends StatelessWidget {
  final Function()? onTap;
  const SaveSmallButtonWidget({
    super.key, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Align(
        alignment: Alignment.centerRight,
        child: IntrinsicWidth(
          child: GradientContainerWidget(
            radius: 4.r,
            textStyle: poppinsRegular.copyWith(
                color: AppColors.blackLightColor,
                fontSize: getFontSizeSmall(context)),
            text: AppStaticString.save,
            padding: EdgeInsets.all( 4.w),
          ),
        ),
      ),
    );
  }
}
class AddButtonInContainer extends StatelessWidget {
  const AddButtonInContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ///============================pending============================///
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (context) => const AlertDialog(
         backgroundColor: AppColors.textFieldColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                title: AppStaticString.fieldName,
                // border: a,
              )
            ],
          ),
        ),);

      },
      child: Container(
        padding: padding12,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.textFieldColor,
        ),
        child: Image.asset(
          plusIconUrl,
          color: AppColors.whiteLightColor,
          height: 20.w,
          width: 20.w,
        ),
      ),
    );
  }
}
