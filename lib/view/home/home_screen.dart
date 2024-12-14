import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/home_app_bar.dart';

import 'widgets/gradient_container_widget.dart';
import 'widgets/track_card_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    HomeController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Column(
        children: List.generate(5, (i) => const TrackCardWidget()),
      ),
    ));
    HomeController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Column(
        children: List.generate(5, (i) => EventCardWidget()),
      ),
    ));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HomeAppBar(),
            Expanded(
                child: ListView(
              padding: padding16,
              children: [
                Obx(() {
                  return Row(
                    children: [
                      // const GradientContainerWidget(),
                      // space24W,
                      // const Expanded(
                      //     child: BlackContainerWidget(
                      //   text: AppStaticString.booked,
                      // ))
                      ...List.generate(
                        HomeController.to.labelTabs.length,
                        (index) => HomeController.to.selectedLabel.value ==
                                index
                            ? GradientContainerWidget(
                                text: HomeController.to.labelTabs[index],
                              )
                            : HomeController.to.labelTabs[index].isEmpty
                                ? space16W
                                : Expanded(
                                    child: BlackContainerWidget(
                                    onTap: () {
                                      HomeController.to.selectedLabel.value =
                                          index;
                                    },
                                    text: HomeController.to.labelTabs[index],
                                  )),
                      )
                    ],
                  );
                }),
                DynamicTabWidget(
                  tabs: HomeController.to.tabs,
                  tabContent: HomeController.to.tabContent,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
