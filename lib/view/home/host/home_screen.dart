import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/core/components/custom_refresh_indicator.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/host/event_track_slot_page.dart';
import 'package:track_trek/view/home/host/widget/loading_event_card.dart';
import 'package:track_trek/view/home/user/widget/loading_widgets.dart';
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


    // Initial tab content setup
    HomeController.to.tabContent.addAll([
      const TrackListWidget(),
      const EventListWidget(),
    ]);

    return CustomRefreshIndicator(
      onRefresh: HomeController.to.refreshCall,
      child: Column(
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
                                        HomeController.to.handleLabelChange(index: index);
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
      ),
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
      child: Obx(() {
        return   HomeController.to.isLoadingEventList.value
            ? const ListOfEventLoadingWidget()
            : HomeController.to.eventList.isEmpty
                ? const EmptyTextWidget(text: AppStaticString.eventNotFound)
                : Column(
                    children: List.generate(
                        HomeController.to.eventList.length,
                        (i) => EventCardWidget(
                              eventModel: HomeController.to.eventList[i],
                            )),
                  );
      }),
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
      child: Obx(() {
        return HomeController.to.isLoadingTrackList.value
            ? const LoadingTrackListWidget()
            : HomeController.to.trackList.isEmpty
            ? const EmptyTextWidget(text: AppStaticString.trackNotFound)
            : Column(
          children: List.generate(
              HomeController.to.trackList.length,
              (i) => TrackCardWidget(

                    trackModel: HomeController.to.trackList[i],
                  )),
        );
      }),
    );
  }
}
