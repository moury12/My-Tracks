import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/tab_content_view.dart';

class DynamicTabWidget extends StatelessWidget {
  final RxList<String> tabs;
  final RxList<Widget> tabContent;
  const DynamicTabWidget({super.key, required this.tabs, required this.tabContent});

  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
      length: tabs.length,
      // Dynamically set the number of tabs
      child: Column(
        children: [
          space16H,
          Obx(() => TabBar(
            // padding: EdgeInsets.zero,

            // isScrollable: true,
            dividerHeight: 4.h,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(20.r)),
              borderSide: BorderSide(
                color: AppColors.blueColor,
                width: 10.w,
              ),
            ),
            labelColor: AppColors.whiteLightColor,
            unselectedLabelColor: AppColors.whiteLightColor,
            labelStyle: poppinsRegular.copyWith(
                fontSize: getFontSizeLarge(context)),
            unselectedLabelStyle: poppinsMedium.copyWith(
                fontSize: getFontSizeLarge(context)),
            dividerColor: AppColors.blackLightColor,
            tabs: tabs
                .map((tabName) => Padding(
              padding: padding16b24,
              child: FittedBox(
                child: Text(
                  tabName,
                ),
              ),
            ))
                .toList(),
          )),
        Obx(() => TabContentView(
          children: tabContent.toList(),
        )),
        ],
      ),
    );
  }
}
