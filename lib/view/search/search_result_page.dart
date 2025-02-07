import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/host/event_track_slot_page.dart';
import 'package:track_trek/view/home/user/widget/loading_widgets.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/search/widgets/event_search_list_widget.dart';
import 'package:track_trek/view/search/widgets/track_search_list_widget.dart';

class SearchResultScreen extends StatelessWidget {
  static const String routeName = '/search-result';
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeUserController.to.tabContent.addAll([
      const TrackSearchListWidget(),
      const EventSearchListWidget(),
    ]);
    // Get.put(HomeUserController());
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        HomeUserController.to.lat.value = '';
        HomeUserController.to.lng.value = '';
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
          child: Column(
            children: [
              DynamicTabWidget(
                function: (p0) {
                  if(p0==1){
                    HomeUserController.to.getEventListCall();
                  }
                },
                tabs: HomeUserController.to.tabs,
                tabContent: HomeUserController.to.tabContent,
              ),
              space16H,

            ],
          ),
        ),
      ),
    );
  }
}
