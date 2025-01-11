import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_page.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
import 'package:track_trek/view/home/user/widget/loading_widgets.dart';
import 'package:track_trek/view/search/search_page.dart';
import 'package:track_trek/view/home/widgets/category_circle_widget.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/home_app_bar.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';

class HomeUserScreen extends StatelessWidget {
  final Function()? openDrawer;
  const HomeUserScreen({super.key, this.openDrawer});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeUserController());
    return Column(
      children: [
        HomeAppBar(
          openDrawer: openDrawer,
        ),
        Expanded(
            child: ListView(
          padding: padding16,
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
            space12H,

            ///================dynamic banner==================///
            SizedBox(
              height: 150.h,
              child: Obx(() {
                return PageView.builder(
                  itemCount: HomeUserController.to.pages.length,
                  controller: HomeUserController.to.controller.value,
                  // itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(BookTrackJoinEventScreen.routeName);
                      },
                      child: Padding(
                        padding: padding6H,
                        child: Image.asset(
                          HomeUserController.to.pages[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            space12H,
            Center(
              child: SmoothPageIndicator(
                controller: HomeUserController.to.controller.value,
                count: HomeUserController.to.pages.length,
                effect: ExpandingDotsEffect(
                    dotHeight: 12.w,
                    dotWidth: 12.w,
                    dotColor: AppColors.blackBorderColor,
                    activeDotColor: AppColors.blackBorderColor),
              ),
            ),
            space16H,
            const TitleTextWidget(
              title: AppStaticString.trackCategory,
            ),
            space16H,
            Obx(() {
              return HomeUserController.to.catList.isEmpty &&
                      !HomeUserController.to.isLoadingCategory.value
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
                                  title: HomeUserController
                                          .to.catList[index].name ??
                                      '',
                                  imageUrl:
                                      '${ApiClient.baseUrl}${HomeUserController.to.catList[index].categoryImage}',
                                  onTap: () {
                                    HomeUserController
                                        .to.selectedIndexCategory.value = index;
                                    HomeUserController.to.categorySearch.value =
                                        HomeUserController
                                            .to
                                            .catList[HomeUserController
                                                .to.selectedIndexCategory.value]
                                            .name
                                            .toString();
                                    HomeUserController.to.getTrackListCall();
                                  },
                                ),
                              ),
                            ),
                    );
            }),
            space16H,
            const TitleTextWidget(title: AppStaticString.event),
            Obx(() {
              return HomeUserController.to.eventList.isEmpty &&
                      !HomeUserController.to.isLoadingEventList.value
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
                                    width:
                                        MediaQuery.sizeOf(context).width / 1.3,
                                    child: EventCardWidget(
                                      eventModelForUser: HomeUserController
                                          .to.eventList[index],
                                      onTap: () {
                                        Get.toNamed(
                                            BookTrackJoinEventScreen.routeName,
                                            arguments: {'id':HomeUserController
                                                .to.eventList[index].sId,
                                            'type':'event'});
                                      },
                                      fromUser: true,
                                      buttonText: AppStaticString.joinEvent,
                                      buttonImg: doubleArrowIconUrl,
                                    )),
                              ),
                            ),
                    );
            }),
            space16H,
            const TitleTextWidget(title: AppStaticString.track),
            Obx(() {
              return HomeUserController.to.isLoadingTrackList.value
                  ? LoadingTrackListWidget()
                  : HomeUserController.to.trackList.isEmpty &&
                          !HomeUserController.to.isLoadingTrackList.value
                      ? const EmptyTextWidget(text: 'Track Service not found')
                      : Column(
                          children: List.generate(
                            HomeUserController.to.trackList.length,
                            (index) => TrackCardWidget(
                              fromUser: true,
                              trackModelUserPanel:
                                  HomeUserController.to.trackList[index],
                              react: HomeUserController.to.react,
                            ),
                          ),
                        );
            })
          ],
        ))
      ],
    );
  }
}
