import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_drawer_widget.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/view/add/create_track_event_screen.dart';
import 'package:track_trek/view/home/host/home_screen.dart';
import 'package:track_trek/view/home/user/home_user_page.dart';
import 'package:track_trek/view/initial/widgets/custom_bottom_navigation.dart';
import 'package:track_trek/view/manage/manage_screen.dart';
import 'package:track_trek/view/notification/notification_screen.dart';
import 'package:track_trek/view/promote/promote_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  static const String routeName = '/nav';
  BottomNavigationScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String?> appbarTitle = [
    null,
    AppStaticString.trackManagement,
    AppStaticString.create,
    AppStaticString.notification,
    AppStaticString.promoteTrack
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CommonController.to.selectedOption.value==0? HomeUserScreen(
        openDrawer: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ):HomeScreen(
        openDrawer: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      const ManageScreen(),
      const CreateTrackEventScreen(),
      const NotificationScreen(),
      const PromoteScreen(),
    ];
    return Obx(() {
      int selectedIndex = CommonController.to.selectedIndex.value;

      return PopScope(
        canPop: selectedIndex != 0 ? false : true,
        onPopInvokedWithResult: (didPop, result) {
          if (selectedIndex != 0) {
            CommonController.to.updateIndex(0);
          }
        },
        child: Scaffold(
          drawer: selectedIndex == 0 ? const CustomDrawerWidget() : null,
          key: _scaffoldKey,
          appBar: appbarTitle[selectedIndex] == null
              ? const PreferredSize(
                  preferredSize: Size.zero, child: SizedBox.shrink())
              : CustomAppbar(
                  tile: appbarTitle[selectedIndex],
                ),
          body: SafeArea(
              child: Column(
            children: [
              selectedIndex == 0
                  ? SizedBox(height: MediaQuery.of(context).viewPadding.top)
                  : const SizedBox.shrink(),
              Expanded(child: pages[selectedIndex]),
            ],
          )),
          bottomNavigationBar: CustomBottomNavBar(),
        ),
      );
    });
  }
}
