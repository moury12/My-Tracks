import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking_management_controller.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/history/widget/history_content_widget.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class BookingManagementScreen extends StatelessWidget {
  const BookingManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BookingManagementController());

    return SingleChildScrollView(
      child: Padding(
        padding: padding16,
        child: Column(
          children: [
            Obx(() {
              return Row(
                spacing: 16.w,
                children: [
                  ...List.generate(
                    BookingManagementController.to.tabs.length,
                    (index) => BookingManagementController
                                .to.selectedLabel.value ==
                            index
                        ? Expanded(
                            flex: 2,
                            child: GradientContainerWidget(
                              padding: padding12,
                              radius: 4.r,
                              text: BookingManagementController.to.tabs[index],
                            ),
                          )
                        : BookingManagementController.to.tabs[index].isEmpty
                            ? space16W
                            : Expanded(
                                flex: 2,
                                child: BlackContainerWidget(
                                  padding: padding12,
                                  radius: 4.r,
                                  onTap: () {
                                    BookingManagementController
                                        .to.selectedLabel.value = index;
                                    // print(BookingManagementController.to.selectedLabel.value);
                                  },
                                  text: BookingManagementController
                                      .to.tabs[index],
                                )),
                  ),
                  const Expanded(child: SizedBox.shrink())
                ],
              );
            }),
            Obx(() {
              return DynamicTabWidget(
                  tabs: BookingManagementController.to.labelTabs,
                  tabContent: [
                    Column(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: padding12V,
                          child: MarronGradientContainerWidget(
                            child: BookingManagementController
                                        .to.selectedLabel.value ==
                                    1
                                ? const TrackEventInfoContentWidget()
                                : const HistoryContentWidget(),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: padding12V,
                          child: MarronGradientContainerWidget(
                            child: BookingManagementController
                                        .to.selectedLabel.value ==
                                    1
                                ? const TrackEventInfoContentWidget(noArrowButton: true,)
                                : const HistoryContentWidget(
                                    addRating: true,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ].obs);
            })
          ],
        ),
      ),
    );
  }
}
