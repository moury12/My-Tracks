import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
        boxShadow: [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildNavItem(context, homeIconUrl, homeFillIconUrl, 0,
                      AppStaticString.home),
                ),
                Expanded(
                  child: CommonController.to.selectedRoleOption.value==0?_buildNavItem(context, bookingIconUrl,
                      bookingFillIconUrl, 1, AppStaticString.booking): _buildNavItem(context, manageIconUrl,
                      manageFillIconUrl, 1, AppStaticString.manage),
                ),
              ],
            ),
          ),
          CommonController.to.selectedRoleOption.value==0?SizedBox.shrink() :Padding(
            padding: padding12H,
            child: GestureDetector(
                onTap: () {
                  CommonController.to.updateIndex(2);
                },
                child: Container(
                  padding: padding12,
                  // height: 40.w,
                  // width: 40.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(addIconUrl))),
                  child: Image.asset(
                    plusIconUrl,
                    height: 17.w,
                    width: 17.w,
                    color: CommonController.to.selectedIndex.value == 2
                        ? null
                        : AppColors.whiteLightColor,
                  ),
                )),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildNavItem(context, notificationIconUrl,
                      notificationFillIconUrl, 3, AppStaticString.notification),
                ),
                Expanded(
                  child:CommonController.to.selectedRoleOption.value==0?_buildNavItem(context, profileIconUrl,
                      profileFillIconUrl, 4, AppStaticString.profile): _buildNavItem(context, promoteIconUrl,
                      promoteFillIconUrl, 4, AppStaticString.promote),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String icon,
    String selectedIcon,
    int index,
    String label,
  ) {
    return Tooltip(
      message: label,
      /*decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(8),
    ),*/
      waitDuration: Duration(milliseconds: 500),
      child: InkWell(
        onTap: () => CommonController.to.updateIndex(index),
        child: Obx(
          () {
            bool isSelected = CommonController.to.selectedIndex.value == index;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(isSelected ? selectedIcon : icon, height: 24.w),
                space8H,
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: poppinsRegular.copyWith(
                        fontSize: getFontSizeSemiSmall(context)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
