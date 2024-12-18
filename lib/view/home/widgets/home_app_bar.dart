import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/text_style.dart';
class HomeAppBar extends StatelessWidget {
  final Function()? openDrawer;
  const HomeAppBar({
    super.key, this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingH16V6,
      child: Row(
        children: [
          Image.asset(
            dummyProfileImgUrl,
            height: 52.w,
          ),
          space12W,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStaticString.dummyName,
                style: poppinsMedium.copyWith(
                    fontSize: getFontSizeLarge(context)),
              ),
              Row(
                children: [
                  Image.asset(
                    userLocationIconUrl,
                    height: 21.w,
                  ),
                  Text(AppStaticString.dummyAddress ,style: poppinsMedium.copyWith(
                      fontSize: getFontSizeSemiSmall(context)),
                  )
                ],
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap:openDrawer??(){} ,
              child: Image.asset(drawerIconUrl,height: 50.w,))
        ],
      ),
    );
  }
}
