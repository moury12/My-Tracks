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
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/home_app_bar.dart';

import 'widgets/gradient_container_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    HomeController.to.tabContent.add(Center(child: Text('Content for Tab 1')),
      );   HomeController.to.tabContent.add(Center(child: Text('Content for Tab 2')),
      );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
            Expanded(
                child: ListView(
              padding: padding16,
              children: [
                Row(
                  children: [
                    GradientContainerWidget(),
                    space24W,
                    BlackContainerWidget(text: AppStaticString.booked,)
                  ],
                ),
                 DynamicTabWidget(tabs: HomeController.to.tabs, tabContent:HomeController.to.tabContent ,)

              ],
            ))
          ],
        ),
      ),
    );
  }
}
