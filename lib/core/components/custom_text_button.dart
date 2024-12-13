import 'package:flutter/material.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/text_style.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const CustomTextButton({
    super.key, required this.title,  this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed:onPressed??(){} , child:  Text(title,style: poppinsRegular.copyWith(
      fontSize: getFontSizeSmall(context),)));
  }
}