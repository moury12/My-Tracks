import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking/booking_management_controller.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/history/widget/history_content_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeName = '/history';
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    Get.put(BookingManagementController());
   /* BookingManagementController.to.trackHistory.value='yes';*/
    BookingManagementController.to.getTrackHistoryBookingListCall();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.history,
      ),
      body: Obx(
        () {

          return ListView.builder(
          padding: padding16,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child:  MarronGradientContainerWidget(
                child: HistoryContentWidget(
                   trackModel:BookingManagementController.to.trackHistoryBookingList[index] ,
                  addRating: CommonController.to.selectedRoleOption.value==0,),
              ),
            ),
            itemCount: BookingManagementController.to.trackHistoryBookingList.length,
          );
        }
      ),
    );
  }
}

