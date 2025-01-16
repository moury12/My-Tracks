import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/controller/track_management_controller.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_refresh_indicator.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
import 'package:track_trek/view/home/user/widget/loading_widgets.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/event_user_page.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';
import 'package:track_trek/view/manage/widgets/loading_widget.dart';

class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(TrackManagementController());
    ///============================track part=============================///
    ///
    TrackManagementController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Obx(
       () {
          return HomeController.to.isLoadingTrackList.value
              ? const LoadingTrackListWidget()
              : HomeController.to.trackList.isEmpty
              ? const EmptyTextWidget(text: AppStaticString.trackNotFound)
              : Column(
            ///============================track part=============================///
            children: List.generate(
                HomeController.to.trackList.length,
                (i) => TrackCardWidget(
                      onActive: () {
                        Navigator.pop(context);
                        TrackManagementController.to.trackActiveDeactivateCall(
                            trackId: HomeController.to.trackList[i].sId.toString(),
                            status: "active");
                      },
                      onDeactivate: () {
                        TrackManagementController.to.trackActiveDeactivateCall(
                            trackId: HomeController.to.trackList[i].sId.toString(),
                            status: "deactivated");
                      },
                      fromManage: true,
                      react: false.obs,
                      trackModel: HomeController.to.trackList[i],
                    )),
          );
        }
      ),
    ));

    ///============================event part=============================///

    TrackManagementController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Obx(() {
        return Column(children: [
          CustomDropdown<SingleEventModel>(
            isLoading: TrackManagementController.to.isLoadingEventList.value,
            selectedValue: TrackManagementController.to.selectedEvent.value,
            radius: 8.r,
            borderColor: AppColors.blackLightColor,
            fillColor: AppColors.blackBackgroundColor,
            hintColor: AppColors.whiteLightColor,
            hintText: "Select Event",
            items: TrackManagementController
                .to.eventList /*.map((element) => element.eventName).toList()*/,
            onChanged: (value) {
              TrackManagementController.to.selectedEvent.value = value;
            },
          ),
          TrackManagementController.to.selectedEvent.value == null ||
                  TrackManagementController.to.selectedEvent.value!.slots ==
                      null ||
                  TrackManagementController
                      .to.selectedEvent.value!.slots!.isEmpty
              ? Padding(
                  padding: padding14,
                  child: const EmptyTextWidget(
                      text: AppStaticString.slotListIsEmpty),
                )
              : Column(
                  children: List.generate(
                      TrackManagementController
                          .to.selectedEvent.value!.slots!.length,
                      (i) => Padding(
                            padding: padding12T,
                            child: MarronGradientContainerWidget(
                              child: TrackSlotWidget(
                                onViewAllParticipant: () {
                                  HomeController.to.getEventParticipantListCall(
                                    eventSlotID: TrackManagementController
                                            .to
                                            .selectedEvent
                                            .value!
                                            .slots![i]
                                            .sId ??
                                        '',
                                  );
                                  Get.toNamed(
                                    EventUserScreen.routeName,
                                    arguments: 'event',
                                  );
                                },
                                needToShowSeat: true,
                                eventSlots: TrackManagementController
                                    .to.selectedEvent.value!.slots![i],
                                argument: 'track_management',
                              ),
                            ),
                          )),
                )
        ]);
      }),
    ));

    ///============================renters part=============================///

    TrackManagementController.to.tabContent.add(Obx(() {
      return Padding(
        padding: padding12V,
        child: TrackManagementController.to.isLoadingRentersList.value?
        const UserInfoListLoading():TrackManagementController.to.renterList.isEmpty
            ? const EmptyTextWidget(text: 'Renters not found')
            : Column(
                children: List.generate(
                    TrackManagementController.to.renterList.length,
                    (i) => Padding(
                          padding: padding12T,
                          child: MarronGradientContainerWidget(
                            child: UserInfoContentWidget(
                              rentersModel:
                                  TrackManagementController.to.renterList[i],
                            ),
                          ),
                        )),
              ),
      );
    }));

    return Scaffold(
        body: CustomRefreshIndicator(

          onRefresh: () async{
          await  HomeController.to.getTrackListCall();
            HomeController.to.trackList.refresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

                child: Padding(
          padding: padding16.copyWith(top: 0),
          child: DynamicTabWidget(
              function: (val) async {
                TrackManagementController.to.selectedTabIndex.value = val;

                if (val == 2) {
                  String selectedDate = await selectDate(context);
                  await TrackManagementController.to
                      .getRentersListCall(date: selectedDate);
                }
              },
              tabs: TrackManagementController.to.tabs,
              tabContent: TrackManagementController.to.tabContent),
                ),
              ),
        ));
  }
}
