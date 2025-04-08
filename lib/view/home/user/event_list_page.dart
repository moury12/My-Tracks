import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';

import '../../search/widgets/event_search_list_widget.dart';

class EventListScreen extends StatefulWidget {
  static const String routeName = "/event-list";
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(
      () {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          HomeUserController.to.getEventListCall(loadMore: true);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        tile: "Event List",
      ),
      body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              EventSearchListWidget(),
              Padding(
                padding: padding12,
                child: Obx(
                  () {
                    return HomeUserController.to.isEventLoadingMore.value ? DefaultProgressIndicator(color: AppColors.primaryColor,) : SizedBox.shrink();
                  },
                ),
              )
            ],
          )),
    );
  }
}
