import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking/booking_management_controller.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/create_track_event_controller.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/controller/notification_controller.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/controller/track_management_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_drawer_widget.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/view/add/create_screen.dart';
import 'package:track_trek/view/booking/booking_management.dart';
import 'package:track_trek/view/home/host/home_screen.dart';
import 'package:track_trek/view/home/user/home_user_page.dart';
import 'package:track_trek/view/initial/widgets/custom_bottom_navigation.dart';
import 'package:track_trek/view/manage/manage_screen.dart';
import 'package:track_trek/view/notification/notification_screen.dart';
import 'package:track_trek/view/profile/profile_page.dart';
import 'package:track_trek/view/promote/promote_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const String routeName = '/nav';
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
if(!CommonController.to.isLoggedIn){
  Get.put(HomeUserController());

}

    else{
      if (Boxes.getUserData().get(roleKey) == 'HOST') {
        Get.put(HomeController());

        Get.put(TrackManagementController());
        Get.put(CreateTrackEventController());
      } else {
        Get.put(HomeUserController());
        Get.put(BookingManagementController());
      }
      Get.put(ProfileController());
      Get.put(NotificationController());
    }
  }

  String? getAppBarTitle(int index) {
    if (index == 1) {
      return CommonController.to.selectedRoleOption.value == 0
          ? AppStaticString.bookingManagement
          : AppStaticString.trackManagement;
    } else if (index == 2) {
      return AppStaticString.create;
    } else if (index == 3) {
      return AppStaticString.notification;
    } else if (index == 4) {
      return CommonController.to.selectedRoleOption.value == 0
          ? AppStaticString.profile
          : AppStaticString.promoteTrack;
    }
    return null;
  }

  List<Widget> getPages() {
    return [
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
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int selectedIndex = CommonController.to.selectedIndex.value;

      return PopScope(
        canPop: selectedIndex == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && selectedIndex != 0) {
            CommonController.to.updateIndex(0);
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: selectedIndex == 0 ? const CustomDrawerWidget() : null,
          appBar: getAppBarTitle(selectedIndex) == null
              ? const PreferredSize(
            preferredSize: Size.zero,
            child: SizedBox.shrink(),
          )
              : CustomAppbar(
            tile: CommonController.to.selectedRoleOption.value != 0 &&
                selectedIndex == 1
                ? '${TrackManagementController.to.tabs[TrackManagementController.to.selectedTabIndex.value]} Management'
                : getAppBarTitle(selectedIndex),
          ),
          body: SafeArea(
            child: Column(
              children: [
                selectedIndex == 0
                    ? SizedBox(height: MediaQuery.of(context).viewPadding.top)
                    : const SizedBox.shrink(),
                Expanded(
                  child: IndexedStack(
                    index: selectedIndex,
                    children: getPages(),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(),
        ),
      );
    });
  }
}

