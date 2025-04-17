import 'package:flutter/material.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class NotificationTitleWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String date;
  const NotificationTitleWidget({
    super.key, required this.title, required this.date, this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding12V,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
        
              Expanded(flex: 4,
                  ///=============notification title===================///
                  child: Text(title,style: poppinsMedium.copyWith(fontSize: getFontSizeDefault(context)),)),
              Expanded(flex: 2,
                ///=============notification title===================///
                child: Text(date,
                  textAlign: TextAlign.end,
                  style: poppinsLight.copyWith(
                    fontSize: getFontSizeSmall(context),color: AppColors.normalDarkWhite
                ),),
              ),
            ],
          ),
        ),
        Text(subtitle??'',style: poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),),
        space12H,
        Image.asset(horizontalDividerUrl)
      ],
    );
  }
}