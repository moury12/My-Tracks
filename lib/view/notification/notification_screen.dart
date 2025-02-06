import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/notification_controller.dart';
import 'package:track_trek/core/components/custom_refresh_indicator.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/host/event_track_slot_page.dart';
import 'package:track_trek/view/notification/widgets/loading_widget.dart';
import 'package:track_trek/view/notification/widgets/notification_title_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: NotificationController.to.refreshCall,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Obx(() {
          return Padding(
            padding: padding16,
            child: NotificationController.to.isLoadingNotification.value
                ? ListOfNotificationLoading()
                : NotificationController.to.notifyList.isEmpty
                    ? const EmptyTextWidget(text: 'Notification List is Empty')
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStaticString.new_,
                                style: poppinsMedium.copyWith(
                                    fontSize: getFontSizeExtraLarge(context)),
                              ),
                              Text(
                                AppStaticString.clearAll,
                                style: poppinsLight.copyWith(
                                    fontSize: getFontSizeLarge(context)),
                              ),
                            ],
                          ),
                          space16H,
                          ...List.generate(
                            NotificationController.to.notifyList.length,
                            (index) =>

                                ///=============notification title===================///

                                NotificationTitleWidget(
                              title: NotificationController
                                      .to.notifyList[index].title ??
                                  '',
                              subtitle: NotificationController
                                      .to.notifyList[index].message ??
                                  '',

                              ///<====================================== date ================================>///
                              date: formatTimestamp(
                                  timestamp: NotificationController
                                          .to.notifyList[index].createdAt ??
                                      ''),
                            ),
                          )
                        ],
                      ),
          );
        }),
      ),
    );
  }
}
