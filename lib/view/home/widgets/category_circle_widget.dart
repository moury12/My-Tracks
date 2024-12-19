import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_user_controller.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
class CategoryCircleWidget extends StatelessWidget {
  final int index;
  const CategoryCircleWidget({
    super.key, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          // padding: EdgeInsets.all(4.sp),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              border: Border.all(color:HomeUserController.to.selectedCategory.value==index? AppColors.pinkColor:AppColors.blackBorderColor),
              shape: BoxShape.circle),
          child: InkWell(
            onTap: () {
              HomeUserController.to.selectedCategory.value=index;
            },
            child: Padding(
              padding: EdgeInsets.all(4.sp),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                    child: Image.asset(
                      height: 70.w,
                      width: 70.w,
                      dummyEventImgUrl,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
        );
      }
    );
  }
}

class TitleTextWidget extends StatelessWidget {
  final String title;
  const TitleTextWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: poppinsMedium.copyWith(fontSize: getFontSizeExtraLarge(context)),
    );
  }
}