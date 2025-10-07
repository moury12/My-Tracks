import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/components/custom_refresh_indicator.dart';
import 'package:track_trek/core/components/custom_text_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_page.dart';
import 'package:track_trek/view/home/host/event_track_slot_page.dart';
import 'package:track_trek/view/home/user/event_list_page.dart';
import 'package:track_trek/view/home/user/widget/loading_widgets.dart';
import 'package:track_trek/view/search/search_page.dart';
import 'package:track_trek/view/home/widgets/category_circle_widget.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/home_app_bar.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';

import '../../../core/components/custom_button.dart';

class HomeUserScreen extends StatefulWidget {
  final Function()? openDrawer;
  const HomeUserScreen({super.key, this.openDrawer});

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(
      () {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          HomeUserController.to.getTrackListCall(loadMore: true);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        await HomeUserController.to.onRefreshUserPanel();
      },
      child: Column(
        children: [
          HomeAppBar(
            openDrawer: widget.openDrawer,
          ),
          Expanded(
              child: Padding(
            padding: padding12,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                /* padding: padding16,*/
                children: [
                  GestureDetector(
                    child: CustomTextField(
                      hintText: AppStaticString.searchHerr,
                      prefixIcon: Padding(
                        padding: padding8,
                        child: Image.asset(
                          searchIconUrl,
                          height: 24.w,
                          width: 24.w,
                        ),
                      ),
                      isEnable: false,
                    ),
                    onTap: () {
                      Get.toNamed(SearchScreen.routeName);
                    },
                  ),
                  // space12H,

                  ///================dynamic banner==================///
                  Obx(() {
                    if (HomeUserController.to.promoteTrackList.isEmpty) {
                      return SizedBox.shrink();
                    }

                    bool isLoading = HomeUserController.to.isLoadingPromoteTrack.value;

                    return Padding(
                      padding: padding6V,
                      child: SizedBox(
                        height: 150.h,
                        child: isLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[800]!,
                                highlightColor: Colors.grey[700]!,
                                child: Container(
                                  height: 150.h,
                                  width: double.maxFinite,
                                  color: Colors.grey[800],
                                ),
                              )
                            : PageView.builder(
                                itemCount: HomeUserController.to.promoteTrackList.length > 10 ? 10 : HomeUserController.to.promoteTrackList.length,
                                controller: HomeUserController.to.controller.value,
                                itemBuilder: (_, index) {
                                  final trackItem = HomeUserController.to.promoteTrackList[index];

                                  return GestureDetector(
                                    onTap: () {
                                      log("message");
                                      Get.toNamed(BookTrackJoinEventScreen.routeName, arguments: {'id': trackItem.track ?? '', 'type': 'track'});
                                    },
                                    child: Padding(
                                      padding: padding6H,
                                      child: CustomNetworkImage(
                                        borderRadius: BorderRadius.circular(10.r),
                                        imageUrl: '${ApiClient.baseUrl}/${trackItem.bannerImage ?? ''}',
                                        height: 150.h,
                                        width: double.maxFinite,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    );
                  }),

                  Obx(() {
                    return Center(
                      child: HomeUserController.to.promoteTrackList.isNotEmpty
                          ? Padding(
                            padding:padding6H,
                            child: SmoothPageIndicator(
                                controller: HomeUserController.to.controller.value,
                                count: HomeUserController.to.promoteTrackList.length > 10 ? 10 : HomeUserController.to.promoteTrackList.length,
                                effect: ExpandingDotsEffect(
                                    dotHeight: 12.w, dotWidth: 12.w, dotColor: AppColors.blackBorderColor, activeDotColor: AppColors.blackBorderColor),
                              ),
                          )
                          : SizedBox.shrink(),
                    );
                  }),
                  space8H,
                  const TitleTextWidget(
                    title: AppStaticString.trackCategory,
                  ),
                  space12H,
                  Obx(() {
                    return HomeUserController.to.catList.isEmpty && !HomeUserController.to.isLoadingCategory.value
                        ? const EmptyTextWidget(text: 'Category Service not found')
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: HomeUserController.to.isLoadingCategory.value
                                ? const LoadingCategoryListWidget()
                                : Row(
                                    spacing: 6.w,
                                    children: List.generate(
                                      HomeUserController.to.catList.length,
                                      (index) => CategoryCircleWidget(
                                        index: index,
                                        title: HomeUserController.to.catList[index].name ?? '',
                                        imageUrl: '${ApiClient.baseUrl}${HomeUserController.to.catList[index].categoryImage}',
                                        onTap: () {
                                          HomeUserController.to.selectedIndexCategory.value = index;
                                          HomeUserController.to.categorySearch.value =
                                              HomeUserController.to.catList[HomeUserController.to.selectedIndexCategory.value].name.toString();
                                          HomeUserController.to.getTrackListCall();
                                        },
                                      ),
                                    ),
                                  ),
                          );
                  }),
                  space6H,
                  Row(
                    children: [
                      Expanded(child: const TitleTextWidget(title: AppStaticString.event)),
                      CustomTextButton(
                        title: AppStaticString.seeMore,
                        onPressed: () {
                          Get.toNamed(EventListScreen.routeName);
                        },
                      )
                    ],
                  ),
                  Obx(() {
                    return !HomeUserController.to.isLoadingEventList.value && HomeUserController.to.eventList.isEmpty
                        ? const EmptyTextWidget(text: 'Event Service not found')
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: HomeUserController.to.isLoadingEventList.value
                                ? const LoadingEventListWidget()
                                : Row(
                                    spacing: 12.w,
                                    children: List.generate(
                                      HomeUserController.to.eventList.length,
                                      (index) => SizedBox(
                                          width: MediaQuery.sizeOf(context).width / 1.3,
                                          child: EventCardWidget(
                                            eventModelForUser: HomeUserController.to.eventList[index],
                                            onTap: () {
                                              Get.toNamed(BookTrackJoinEventScreen.routeName,
                                                  arguments: {'id': HomeUserController.to.eventList[index].sId, 'type': 'event'});
                                            },
                                            fromUser: true,
                                            buttonText: AppStaticString.joinEvent,
                                            buttonImg: doubleArrowIconUrl,
                                          )),
                                    ),
                                  ),
                          );
                  }),
                  space6H,
                  const TitleTextWidget(title: AppStaticString.track),
                  Obx(() {
                    return HomeUserController.to.isLoadingTrackList.value
                        ? LoadingTrackListWidget()
                        : HomeUserController.to.trackList.isEmpty && !HomeUserController.to.isLoadingTrackList.value
                            ? const EmptyTextWidget(text: 'Track Service not found')
                            : Column(
                                children: List.generate(
                                  HomeUserController.to.trackList.length,
                                  (index) => TrackCardWidget(
                                    fromUser: true,
                                    trackModelUserPanel: HomeUserController.to.trackList[index],
                                    react: HomeUserController.to.react,
                                  ),
                                ),
                              );
                  })
                ],
              ),
            ),
          )),
          Obx(
            () {
              return HomeUserController.to.isTrackLoadingMore.value
                  ? DefaultProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
