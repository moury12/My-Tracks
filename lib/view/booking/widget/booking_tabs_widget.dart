import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking_management_controller.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';


class BookingTabsWidget extends StatelessWidget {
  const BookingTabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
/*
    Get.put(BookingManagementController());
*/
    return Obx(() {
      return Row(
        spacing: 16.w,
        children: [
          ...List.generate(
            BookingManagementController.to.tabs.length,
                (index) {
                  final isSelected =
                      BookingManagementController.to.selectedLabel.value == index;

                return  Expanded(
                    flex: 2,
                    child:isSelected? GradientContainerWidget(
                      padding: padding12,
                      radius: 4.r,
                      text: BookingManagementController.to.tabs[index],
                    ): BlackContainerWidget(
                      padding: padding12,
                      radius: 4.r,
                      onTap: () {
                       BookingManagementController.to.handleLabelChange(index);

                        // print(BookingManagementController.to.selectedLabel.value);
                      },
                      text: BookingManagementController
                          .to.tabs[index],
                    ),
                  );
                }
          ),
          const Expanded(child: SizedBox.shrink())
        ],
      );
    },);
  }
}
