import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_user_controller.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
class CategoryCircleWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Function()? onTap;
  final int index;
  const CategoryCircleWidget({
    super.key, required this.index, required this.title, required this.imageUrl, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            Container(
              // padding: EdgeInsets.all(4.sp),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  border: Border.all(color:HomeUserController.to.selectedIndexCategory.value==index? AppColors.pinkColor:AppColors.blackBorderColor),
                  shape: BoxShape.circle),
              child: InkWell(
                onTap:onTap?? () {

                },
                child: Padding(
                  padding: EdgeInsets.all(4.sp),
                  child: CustomNetworkImage(imageUrl: imageUrl,
                      height:70.w, width:70.w,boxShape: BoxShape.circle,),
                ),
              ),
            ),
            space4H,
            ///================== dynamic category name=====================///
            Text(title,style: poppinsRegular.copyWith(fontSize:getFontSizeSmall(context)),)
          ],
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