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

import '../../../core/components/custom_button.dart';
import '../../../core/utils/app_color.dart';
import '../widgets/gradient_container_widget.dart';
import '../widgets/track_card_widget.dart';

class HomeScreen extends StatefulWidget {
  final Function()? openDrawer;
  static const String routeName = '/home';

  const HomeScreen({super.key, this.openDrawer});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    HomeController.to.resetEventList();
    HomeController.to.resetTrackList();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (HomeController.to.currentTabIndex.value == 1) {
          HomeController.to.getEventListCall(loadMore: true);
        } else {
          HomeController.to.getTrackListCall(loadMore: true);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Initial tab content setup
    HomeController.to.tabContent.addAll([
      const TrackListWidget(),
      const EventListWidget(),
    ]);

    return CustomRefreshIndicator(
      onRefresh: HomeController.to.refreshCall,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          /// App Bar
          SliverToBoxAdapter(child: HomeAppBar(openDrawer: widget.openDrawer)),

          /// Dynamic Labels
          SliverToBoxAdapter(
            child: Obx(() {
              return Padding(
                padding: paddingH16V6.copyWith(bottom: 0),
                child: Row(
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
                ),
              );
            }),
          ),

          /// Dynamic Tabs (track/event switch)
          SliverToBoxAdapter(
            child: Padding(
              padding: padding16H,
              child: DynamicTabWidget(
                tabs: HomeController.to.tabs,
                function: (p0) {
                  HomeController.to.currentTabIndex.value = p0;
                },
                tabContent: HomeController.to.tabContent,
              ),
            ),
          ),



          /// Bottom loading indicator
          SliverToBoxAdapter(
            child: Obx(() {
              final isTrackTab = HomeController.to.currentTabIndex.value == 0;
              final isLoadingMore = isTrackTab
                  ? HomeController.to.isTrackLoadingMore.value
                  : HomeController.to.isEventLoadingMore.value;

              return isLoadingMore
                  ? Center(
                    child: Padding(
                      padding:padding14,
                      child: DefaultProgressIndicator(color: AppColors.primaryColor,),
                    ),
                  )
                  : const SizedBox.shrink();
            }),
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
          spacing: 12,
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
