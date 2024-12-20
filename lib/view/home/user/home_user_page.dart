import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:track_trek/controller/home_user_controller.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_page.dart';
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
            CustomTextField(
              hintText: AppStaticString.searchHerr,
              prefixIcon: Padding(
                padding: padding8,
                child: Image.asset(
                  searchIconUrl,
                  height: 24.w,
                  width: 24.w,
                ),
              ),
            ),

            ///================dynamic banner==================///
            SizedBox(
              height: 150.h,
              child: Obx(() {
                return PageView.builder(
                  itemCount: HomeUserController.to.pages.length,
                  controller: HomeUserController.to.controller.value,
                  // itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: padding6H,
                      child: Image.asset(HomeUserController.to.pages[index]),
                    );
                  },
                );
              }),
            ),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 6.w,
                children: List.generate(
                  10,
                  (index) => CategoryCircleWidget(
                    index: index,
                  ),
                ),
              ),
            ),
            space16H,
            TitleTextWidget(title: AppStaticString.event),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 12.w,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                      width: MediaQuery.sizeOf(context).width/1.3,
                      child: EventCardWidget(
                        onTap: () {
                          Get.toNamed(BookTrackJoinEventScreen.routeName,arguments: event);
                        },
                        fromUser: true,
                        buttonText: AppStaticString.joinEvent,
                        buttonImg: doubleArrowIconUrl,
                      )),
                ),
              ),
            ),
            space16H,
            TitleTextWidget(title: AppStaticString.track),
            ...List.generate(5, (index) => TrackCardWidget(fromUser: true,react:HomeUserController.to.react ,),)
          ],
        ))
      ],
    );
  }
}
