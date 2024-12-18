import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/components/custom_button.dart';
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
    super.key,
    this.onTap,
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
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
    super.key,
    this.onTap,
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
            textStyle: poppinsRegular.copyWith(
                color: AppColors.blackLightColor,
                fontSize: getFontSizeSmall(context)),
            text: AppStaticString.save,
            padding: EdgeInsets.all(4.w),
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
    return GestureDetector(
      onTap: () {
        showDialog(barrierDismissible: false,
          context: context,
          builder: (context) => const DefaultDialogWithButton(),
        );
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

class DefaultDialogWithButton extends StatelessWidget {
  final Widget? content;
  final String? firstButtonText;
  final String? secendtButtonText;
  final Color? borderColor;
  final Color? textColor;
  final Color? fillColor;
  final double? radius;
  const DefaultDialogWithButton({
    super.key, this.content, this.firstButtonText, this.secendtButtonText, this.borderColor, this.textColor, this.fillColor, this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.blackBackgroundColor,

      content: SizedBox(
    width: double.maxFinite,
        child: Column(
          spacing: 16.h,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: content??  CustomTextField(
                    title: AppStaticString.fieldName,
                    fillColor: AppColors.blackBackgroundColor,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide: const BorderSide(
                            color: AppColors.blackBorderColor, width: 1),
                        gapPadding: 0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.r),
                        borderSide: const BorderSide(
                            color: AppColors.blackBorderColor, width: 1),
                        gapPadding: 0),

                    // border: a,
                  ),
                ),
                IconButton(onPressed: () {
                  Navigator.pop(context);
                }, icon: const Icon(CupertinoIcons.multiply)),
              ],
            ),
            RowButton(borderColor: borderColor, radius: radius, firstButtonText: firstButtonText, textColor: textColor, secendtButtonText: secendtButtonText)
          ],
        ),
      ),
    );
  }
}

class RowButton extends StatelessWidget {
  const RowButton({
    super.key,
     this.borderColor,
     this.radius,
     this.firstButtonText,
     this.textColor,
     this.secendtButtonText,
  });

  final Color? borderColor;
  final double? radius;
  final String? firstButtonText;
  final Color? textColor;
  final String? secendtButtonText;

  @override
  Widget build(BuildContext context) {
    return Row(
       spacing: 12.w,
      children: [
        Expanded(
            child:CustomButton(
              onTap: () {},
              fillColor: Colors.transparent,
              borderColor:borderColor?? AppColors.blackBorderColor,
              radius:radius,
              title:firstButtonText?? AppStaticString.cancel,
              textColor:textColor?? AppColors.whiteLightColor,
            ), ),
        Expanded(
          child: CustomButton(

            radius:radius,
            onTap: () {},
            title: secendtButtonText?? AppStaticString.save,
          ),
        )
      ],
    );
  }
}
