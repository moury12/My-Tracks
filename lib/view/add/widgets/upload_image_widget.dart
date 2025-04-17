import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';

import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

class UploadImageWidget extends StatelessWidget {
  final Function()? function;
  final Widget? images;
  final bool? isRequired;
  final bool? showImageLimit;

  const UploadImageWidget(
      {super.key,
      this.function,
      this.images,
      this.isRequired = false,
      this.showImageLimit = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Row(
          children: [
            Text(
              AppStaticString.uploadPhoto,
              style: poppinsRegular.copyWith(
                  fontSize: getFontSizeSemiSmall(context)),
            ),
            isRequired == true
                ? Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      '*',
                      style: poppinsRegular.copyWith(
                          color: Colors.red,
                          fontSize: getFontSizeSemiSmall(context)),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        showImageLimit == true
            ? Text(
                AppStaticString.uploadImageLimit,
                style: poppinsRegular.copyWith(fontSize: 10.sp),
              )
            : SizedBox.shrink(),
        showImageLimit == true ? space8H : SizedBox.shrink(),

        ///========================upload image=======================///
        images ??
            LightBlackFillWidget(
              function: function,
            ),
      ],
    );
  }
}

class LightBlackFillWidget extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final Function()? function;
  const LightBlackFillWidget({
    super.key,
    this.child,
    this.width,
    this.height,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 153.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.navigationColor,
          borderRadius: BorderRadius.circular(4.r)),
      child: child ??
          UploadImageIconTextWidget(
            function: function,
          ),
    );
  }
}

class UploadImageIconTextWidget extends StatelessWidget {
  final Function()? function;
  const UploadImageIconTextWidget({
    super.key,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: function ?? () {},
        child: CommonController.to.image.isNotEmpty
            ? Image.file(File(CommonController.to.image.value))
            : Column(
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
              ),
      );
    });
  }
}
