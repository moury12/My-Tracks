import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/controller/track_management_controller.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/show_custom_calender_widget.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

import '../home/widgets/event_card_widget.dart';

class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TrackManagementController());
    TrackManagementController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Column(
        ///============================track part=============================///
        children: List.generate(
            HomeController.to.trackList.length,
            (i) =>  TrackCardWidget(
                  fromManage: true, react: false.obs,
              trackModel:HomeController.to.trackList[i] ,
                )),
      ),
    ));

    ///============================event part=============================///

    TrackManagementController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Column(children: [
        Obx(
         () {
            return CustomDropdown(
              selectedValue: TrackManagementController.to.selectedEvent.value,
              radius: 8.r,
              borderColor: AppColors.blackLightColor,
              fillColor: AppColors.blackBackgroundColor,
              hintColor: AppColors.whiteLightColor,
              hintText: "Select Event",
              items: HomeController.to.eventList.map((element) => element.eventName,).toList(),
          onChanged: (value) {
            TrackManagementController.to.selectedEvent.value=value;
          },
            );
          }
        ),
        ...List.generate(
            5,
            (i) => Padding(
                  padding: padding12T,
                  child: const MarronGradientContainerWidget(
                    child: TrackSlotWidget(
                      argument: 'track_management',
                    ),
                  ),
                )),
      ]),
    ));

    ///============================renters part=============================///

    TrackManagementController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Column(
        children: List.generate(
            5,
            (i) => Padding(
                  padding: padding12T,
                  child: const MarronGradientContainerWidget(
                    child: UserInfoContentWidget(),
                  ),
                )),
      ),
    ));

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: padding16.copyWith(top: 0),
        child: DynamicTabWidget(
          function: (val) {
            TrackManagementController.to.selectedTabIndex.value = val;
            if(val==2){
              showCustomCalenderWidget(context,goButton: true,onDateSelected: (value) {

              },);
            }
          },
            tabs: TrackManagementController.to.tabs,
            tabContent: TrackManagementController.to.tabContent),
      ),
    ));
  }
}
