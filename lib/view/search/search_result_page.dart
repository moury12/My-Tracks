
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/search/widgets/event_search_list_widget.dart';
import 'package:track_trek/view/search/widgets/track_search_list_widget.dart';

import '../../core/components/custom_button.dart';
import '../../core/utils/app_color.dart';

class SearchResultScreen extends StatefulWidget {
  static const String routeName = '/search-result';
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    HomeUserController.to.resetEventList();
    HomeUserController.to.resetTrackList();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          if (HomeUserController.to.currentTabIndex.value == 1) {
            HomeUserController.to.getEventListCall(loadMore: true);
          } else {
            HomeUserController.to.getTrackListCall(loadMore: true);
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeUserController.to.tabContent.addAll([
      const TrackSearchListWidget(),
      const EventSearchListWidget(),
    ]);
    // Get.put(HomeUserController());
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {

        HomeUserController.to.originalLng.value="";
     HomeUserController.to.originalLng.value="";
        HomeUserController.to.selectedAddress.value = '';
        HomeUserController.to.searchFieldController.value.clear();
        HomeUserController.to.getTrackListCall();
        HomeUserController.to.getEventListCall();
      },
      child: Scaffold(
        appBar: const CustomAppbar(
          tile: AppStaticString.searchResult,
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              DynamicTabWidget(
                function: (p0) {
                  HomeUserController.to.currentTabIndex.value = p0;
                  if (p0 == 1) {
                    HomeUserController.to.getEventListCall(latitude:HomeUserController.to.originalLat.value,lngi:HomeUserController.to.originalLng.value);
                  }
                },
                tabs: HomeUserController.to.tabs,
                tabContent: HomeUserController.to.tabContent,
              ),
              Padding(
                padding: padding12,
                child: Obx(
                  () {
                    bool isLoading = HomeUserController.to.currentTabIndex.value == 1
                        ? HomeUserController.to.isEventLoadingMore.value
                        : HomeUserController.to.isTrackLoadingMore.value;
                    return isLoading
                        ? DefaultProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : SizedBox.shrink();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
