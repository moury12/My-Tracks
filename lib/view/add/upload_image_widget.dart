import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class UploadImageWidget extends StatelessWidget {
  const UploadImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        Text(
          AppStaticString.uploadPhoto,
          style:
              poppinsRegular.copyWith(fontSize: getFontSizeSemiSmall(context)),
        ),

        ///========================upload image=======================///
        const LightBlackFillWidget(),
      ],
    );
  }
}

class LightBlackFillWidget extends StatelessWidget {
  const LightBlackFillWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 153.h,
      decoration: BoxDecoration(
          color: AppColors.navigationColor,
          borderRadius: BorderRadius.circular(4.r)),
      child: const UploadImageIconTextWidget(),
    );
  }
}

class UploadImageIconTextWidget extends StatelessWidget {
  const UploadImageIconTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          addPhotoIconUrl,
          height: 24.w,
          width: 24.w,
        ),
        space6H,
        Text(
          AppStaticString.uploadPhoto,
          style: poppinsLight.copyWith(
              color: AppColors.normalDarkWhite,
              fontSize: getFontSizeSmall(context)),
        )
      ],
    );
  }
}
