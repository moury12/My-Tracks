import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/home_app_bar.dart';

import '../widgets/gradient_container_widget.dart';
import '../widgets/track_card_widget.dart';

class HomeScreen extends StatelessWidget {
  final Function()? openDrawer;
  static const String routeName = '/home';

  const HomeScreen({super.key, this.openDrawer});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    // Initial tab content setup
    HomeController.to.tabContent.addAll([
      const TrackListWidget(),
      const EventListWidget(),
    ]);

    return Column(
      children: [
        HomeAppBar(openDrawer: openDrawer),
        Expanded(
          child: ListView(
            padding: padding16,
            children: [
              // Dynamic Label Row
              Obx(() {
                return Row(
                  children: [
                    ...List.generate(
                      HomeController.to.labelTabs.length,
                      (index) => HomeController.to.selectedLabel.value == index
                          ? Expanded(
                              child: GradientContainerWidget(
                                text: HomeController.to.labelTabs[index],
                              ),
                            )
                          : HomeController.to.labelTabs[index].isEmpty
                              ? space16W
                              : Expanded(
                                  child: BlackContainerWidget(
                                    onTap: () {
                                      HomeController.to.selectedLabel.value =
                                          index;

                                      // Update tabs and content dynamically
                                      if (HomeController.to.labelTabs[index] ==
                                          AppStaticString.booked) {
                                        HomeController.to.tabs.value = [
                                          AppStaticString.event
                                        ];
                                        HomeController.to.tabContent.value = [
                                          const EventListWidget(),
                                        ];
                                      } else {
                                        // Reset to default tabs and content
                                        HomeController.to.tabs.value = [
                                          AppStaticString.track,
                                          AppStaticString.event,
                                        ];
                                        HomeController.to.tabContent.value = [
                                          const TrackListWidget(),
                                          const EventListWidget(),
                                        ];
                                      }
                                    },
                                    text: HomeController.to.labelTabs[index],
                                  ),
                                ),
                    ),
                  ],
                );
              }),
          DynamicTabWidget(
                  tabs: HomeController.to.tabs,
                  tabContent: HomeController.to.tabContent,
                )
            ],
          ),
        ),
      ],
    );
  }
}

class EventListWidget extends StatelessWidget {
  const EventListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12V,
      child: Obx(

              () {
          return Column(
            children: List.generate(HomeController.to.eventList.length, (i) =>  EventCardWidget(eventModel: HomeController.to.eventList[i],)),
          );
        }
      ),
    );
  }
}

class TrackListWidget extends StatelessWidget {
  const TrackListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12V,
      child: Obx(
         () {
          return Column(
            children: List.generate(
               HomeController.to.trackList.length, (i) => TrackCardWidget(react: HomeController.to.react,trackModel: HomeController.to.trackList[i],)),
          );
        }
      ),
    );
  }
}
