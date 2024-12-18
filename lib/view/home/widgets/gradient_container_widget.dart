import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class GradientContainerWidget extends StatelessWidget {
  final Color? firstColor;
  final Color? secondColor;
  final Color? textColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final String? text;
  final double? radius;
  final double? borderWidth;
  final Widget? child;
  final EdgeInsets? padding;
  final Function()? onTap;

  const GradientContainerWidget({
    super.key, this.firstColor, this.secondColor, this.textColor, this.text, this.radius, this.borderColor, this.borderWidth, this.onTap, this.child, this.textStyle, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:onTap?? (){},
      child: Container(
        alignment: Alignment.center,
        padding:padding??padding16,
        decoration:  BoxDecoration(
            borderRadius:BorderRadius.circular(radius??12.r) ,
            border: Border.all(width:borderWidth??0 ,color: borderColor??Colors.transparent),
            gradient: LinearGradient(colors: [
             firstColor?? AppColors.blueColor,
            secondColor??  AppColors.blueColorDark,
            ],end: Alignment.bottomRight)
        ),
        child: child?? Text(text??'Running',style:textStyle?? poppinsMedium.copyWith(
            fontSize: getFontSizeLarge(context),color:textColor?? AppColors.blackLightColor
        ),),
      ),
    );
  }
}
class BlackContainerWidget extends StatelessWidget {

  final String? text;
  final TextStyle? textStyle;

  final Widget? child;
  final double? radius;
  final Color? borderColor;
  final Color? fillColor;
  final Function()? onTap;

  const BlackContainerWidget({super.key, this.text, this.onTap, this.child, this.textStyle, this.radius, this.borderColor, this.fillColor});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:onTap?? (){},
      child: Container(
        alignment: Alignment.center,
        padding:padding16,
        decoration:  BoxDecoration(
            borderRadius:BorderRadius.circular(radius??12.r) ,
            border: Border.all(width:.5.w ,color:borderColor?? AppColors.greyColor.withOpacity(.5)),
           color: fillColor??AppColors.blackExtraLightColor.withOpacity(.5)
        ),
        child: child?? Text(text??'Running',style: textStyle?? poppinsMedium.copyWith(
            fontSize: getFontSizeLarge(context),color:AppColors.whiteLightColor
        ),),
      ),
    );
  }
}class PrimaryColorContainer extends StatelessWidget {
  final String? text;
  const PrimaryColorContainer({
    super.key, this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          alignment: Alignment.center,

          padding: padding16,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(4.r)),
          child: Text(text??'',
            style: poppinsRegular.copyWith(
                color: AppColors.blackLightColor,
                fontSize: getFontSizeDefault(context)),
          ),
        ));
  }
}

