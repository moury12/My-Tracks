import 'package:flutter/material.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/text_style.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderSide? border;
  final double? borderRadius;
  final double? fontSize;
  const CustomTextButton({
    super.key, required this.title,  this.onPressed, this.textColor,
    this.backgroundColor,
    this.padding,
    this.border,
    this.borderRadius, this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: textColor ,
        backgroundColor: backgroundColor ,
        padding: EdgeInsets.zero ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          side: border ?? BorderSide.none,
        ),
      ) ,
        onPressed:onPressed??(){} , child:  Text(title,style: poppinsRegular.copyWith(
      fontSize:fontSize?? getFontSizeSmall(context),)));
  }
}