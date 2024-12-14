import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/view/add/create_track_event_screen.dart';
import 'package:track_trek/view/home/home_screen.dart';
import 'package:track_trek/view/initial/widgets/custom_bottom_navigation.dart';
import 'package:track_trek/view/manage/manage_screen.dart';
import 'package:track_trek/view/notification/notification_screen.dart';
import 'package:track_trek/view/promote/promote_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  static const String routeName = '/nav';
  BottomNavigationScreen({super.key});

  final List<Widget> pages = [
    const HomeScreen(),
    const ManageScreen(),
    const CreateTrackEventScreen(),
    const NotificationScreen(),
    const PromoteScreen(),
  ];

  final List<String?> appbarTitle = [
    null,
    AppStaticString.trackManagement,
    AppStaticString.createEvent,
    AppStaticString.notification,
    AppStaticString.promote
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get the selected index
      int selectedIndex = CommonController.to.selectedIndex.value;

      return Scaffold(

        appBar: appbarTitle[selectedIndex] == null
            ? const PreferredSize(
                preferredSize: Size.zero, child: SizedBox.shrink())
            : CustomAppbar(
                tile: appbarTitle[selectedIndex],
              ),
        body: SafeArea(child: Column(

          children: [
            selectedIndex==0?SizedBox(height: MediaQuery.of(context).viewPadding.top):SizedBox.shrink(),
            Expanded(child: pages[selectedIndex]),
          ],
        )),
        bottomNavigationBar: CustomBottomNavBar(),
      );
    });
  }
}
