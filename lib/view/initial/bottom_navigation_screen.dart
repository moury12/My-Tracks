import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
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
    const PromoteScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[CommonController.to.selectedIndex.value]),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
