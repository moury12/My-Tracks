import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/track_management_controller.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

import '../home/widgets/event_card_widget.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TrackManagementController());
    TrackManagementController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Column(
        children: List.generate(
            5,
            (i) => const TrackCardWidget(
                  fromManage: true,
                )),
      ),
    ));
    TrackManagementController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Column(
        children: List.generate(
            5,
            (i) => Padding(
                  padding: padding12T,
                  child: MarronGradientContainerWidget(),
                )),
      ),
    ));
    TrackManagementController.to.tabContent.add(Padding(
      padding: padding12V,
      child: Column(
        children: List.generate(
            5,
            (i) => Padding(
              padding:padding12T,
              child: MarronGradientContainerWidget(
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
            tabs: TrackManagementController.to.tabs,
            tabContent: TrackManagementController.to.tabContent),
      ),
    ));
  }
}

