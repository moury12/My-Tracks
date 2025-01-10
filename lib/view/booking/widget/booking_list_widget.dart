import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking_management_controller.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class BookingListWidget<T> extends StatelessWidget {
  final RxList<T> dataList;
  final String emptyText;
  final Widget Function(T item) itemBuilder;
  const BookingListWidget(
      {super.key,
      required this.dataList,
      required this.emptyText,
      required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
/*
    Get.put(BookingManagementController());
*/
    return Obx(
      () {
        return dataList.isEmpty?
        EmptyTextWidget(text: emptyText): Column(
          children: List.generate(
           dataList.length,
                (index) => Padding(
              padding: padding12V,
              child: MarronGradientContainerWidget(
                child: itemBuilder(dataList[index])
              ),
            ),
          ),
        );
      }
    );
  }
}
