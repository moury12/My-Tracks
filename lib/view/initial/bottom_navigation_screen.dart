import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/track_management_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_drawer_widget.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/view/add/create_screen.dart';
import 'package:track_trek/view/booking/booking_management.dart';
import 'package:track_trek/view/home/host/home_screen.dart';
import 'package:track_trek/view/home/user/home_user_page.dart';
import 'package:track_trek/view/initial/widgets/custom_bottom_navigation.dart';
import 'package:track_trek/view/manage/manage_screen.dart';
import 'package:track_trek/view/notification/notification_screen.dart';
import 'package:track_trek/view/profile/profile_page.dart';
import 'package:track_trek/view/promote/promote_screen.dart';

class BottomNavigationScreen extends StatelessWidget {
  static const String routeName = '/nav';
  BottomNavigationScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String?> appbarTitle = [
    null,
    CommonController.to.selectedRoleOption.value == 0
        ? AppStaticString.bookingManagement
        : AppStaticString.trackManagement,
    AppStaticString.create,
    AppStaticString.notification,
    CommonController.to.selectedRoleOption.value == 0
        ? AppStaticString.profile
        : AppStaticString.promoteTrack
  ];

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      CommonController.to.selectedRoleOption.value == 0
          ? HomeUserScreen(
              openDrawer: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            )
          : HomeScreen(
              openDrawer: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
      CommonController.to.selectedRoleOption.value == 0
          ? const BookingManagementScreen()
          : const ManagementScreen(),
      const CreateScreen(),
      const NotificationScreen(),
      CommonController.to.selectedRoleOption.value == 0
          ? const ProfileScreen(
              showAppbar: false,
            )
          : const PromoteScreen(),
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
                  tile: CommonController.to.selectedRoleOption.value != 0&& selectedIndex==1?'${TrackManagementController.to.tabs[TrackManagementController.to.selectedTabIndex.value]} Management':appbarTitle[selectedIndex],
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
