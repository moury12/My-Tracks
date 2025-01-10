import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking_management_controller.dart';
import 'package:track_trek/core/model/booking/event_booking_model.dart';
import 'package:track_trek/core/model/booking/track_booking_model.dart';
import 'package:track_trek/view/booking/widget/booking_list_widget.dart';
import 'package:track_trek/view/booking/widget/loading/shimmer_booking_card.dart';
import 'package:track_trek/view/history/widget/history_content_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class BookingTabContent extends StatelessWidget {
  final int index;
  const BookingTabContent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {

    return Obx(
      () {
        final isEventTab =
            BookingManagementController.to.selectedLabel.value == 1;
        final dataList = isEventTab
            ? BookingManagementController.to.eventBookingList
            : BookingManagementController.to.trackBookingList;
        final emptyText = isEventTab
            ? "Booked Event Not Found!!!"
            : "Booked Track Not Found!!!";
        final isLoading = isEventTab?
            BookingManagementController.to.isLoadingEventHistoryBooking.value:
            BookingManagementController.to.isLoadingHistoryBooking.value;
        return isLoading? const LoadingBookingList(): BookingListWidget(
          dataList: dataList,
          emptyText: emptyText,
          itemBuilder: (item) {
            return isEventTab
                ? TrackEventInfoContentWidget(

                    eventModel: item as EventHistoryRunningModel,
                  )
                : HistoryContentWidget(
              ratingVal: BookingManagementController.to.ratingValue.value,
                    trackModel: item as TrackHistoryRunningModel,
                    addRating: index == 1 ? true : false,
                  );
          },
        );
      },
    );
  }
}
