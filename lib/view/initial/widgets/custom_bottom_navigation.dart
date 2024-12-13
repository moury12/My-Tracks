import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';


class CustomBottomNavBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
    padding: paddingH16V6.copyWith(bottom: 16.sp),
      decoration: BoxDecoration(
        color: AppColors.navigationColor,
        boxShadow: [

        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(context,homeIconUrl,homeFillIconUrl, 0, AppStaticString.home),
          _buildNavItem(context,manageIconUrl,manageFillIconUrl, 1, AppStaticString.manage),
          GestureDetector(
            onTap: (){
              CommonController.to.updateIndex(2);
            },
              child: Image.asset(addIconUrl,height: 40.w,)),
          _buildNavItem(context,notificationIconUrl,notificationFillIconUrl, 3, AppStaticString.notification),
          _buildNavItem(context,promoteIconUrl,promoteFillIconUrl, 4, AppStaticString.promote),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context,String icon,String selectedIcon, int index, String label,) {
    return GestureDetector(
      onTap: () => CommonController.to.updateIndex(index),
      child: Obx(
            () {
          bool isSelected = CommonController.to.selectedIndex.value == index;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(isSelected?selectedIcon:icon, height: 24.w),
              space8H,
              Text(
                label,
                style:poppinsRegular.copyWith(fontSize: getFontSizeSemiSmall(context)) ,
              ),
            ],
          );
        },
      ),
    );
  }
}
