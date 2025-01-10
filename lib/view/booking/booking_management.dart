import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking_management_controller.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/booking/widget/booking_tab_content.dart';
import 'package:track_trek/view/booking/widget/booking_tabs_widget.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';

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
            const BookingTabsWidget(),
            DynamicTabWidget(
                function: (p0)=>BookingManagementController.to.handleTabChange(p0) ,
                tabs: BookingManagementController.to.labelTabs,
                tabContent: [
                  const BookingTabContent(),
                  const BookingTabContent(),
                ].obs)
          ],
        ),
      ),
    );
  }
}


