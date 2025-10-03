import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking/book_track_join_event_controller.dart';
import 'package:track_trek/controller/booking/booking_management_controller.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/feedback/feedback_controller.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/controller/home/user/home_user_controller.dart';
import 'package:track_trek/controller/notification_controller.dart';
import 'package:track_trek/controller/profile_controller.dart';
import 'package:track_trek/controller/track_management_controller.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/init/hive_boxes.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_page.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';


class SplashController extends GetxController {
  static SplashController get to => Get.find();
  late final AppLinks _appLinks;

  final Completer<void> _loadingCompleter = Completer<void>();

  @override
  void onInit() {
    super.onInit();

    log(Boxes.getUserData().values.toString());
    _initializeApp();
    // // Initialize AppLinks for deep link handling
    // _appLinks = AppLinks();
    //
    // _appLinks.getInitialLink().then((Uri? uri) {
    //   if (uri != null) {
    //     _handleDeepLink(uri);
    //   }
    // });
    //
    // _appLinks.uriLinkStream.listen((Uri? uri) {
    //   if (uri != null) {
    //     _handleDeepLink(uri);
    //   }
    // });

    // Initialize app state and handle navigation

  }

  Future<void> _initializeApp() async {
    try {
      // Simulate data loading
      await Future.delayed(const Duration(seconds: 3));

      // Determine navigation based on user state
      if (Boxes.getUserData().get(tokenKey) != null &&
          Boxes.getUserData().get(tokenKey).toString().isNotEmpty) {
        // Set the user role
        CommonController.to.selectedRoleOption =
        Boxes.getUserData().get(roleKey) == 'USER' ? 0.obs : 1.obs;

        // Initialize controllers based on role
        if (Boxes.getUserData().get(roleKey) == 'USER') {
          Get.lazyPut(() => HomeUserController(),fenix: true);
          Get.put(BookingManagementController());
        } else {
          Get.put(HomeController());
          Get.put(TrackManagementController());
        }

        // Navigate to home screen
        Get.offAllNamed(BottomNavigationScreen.routeName);

        // Initialize additional controllers
        Get.put(ProfileController());
        Get.put(NotificationController());
        Get.put(FeedBackController());
      } else {
        Get.lazyPut(() => HomeUserController(),fenix: true);
        Get.put(FeedBackController());

        // Navigate to login screen
        Get.offAllNamed(BottomNavigationScreen.routeName);
      }
    } catch (e) {
      log('Error during initialization: $e');
    } finally {
      // Complete the loading process
      _loadingCompleter.complete();
    }
  }

  Future<void> _handleDeepLink(Uri uri) async {
    // Extract query parameters
    final String? trackId = uri.queryParameters['trackId'];
    final String? type = uri.queryParameters['type'];
    print('Deep link received: ${uri.toString()}');
    print('Deep link path received: ${uri.path}');
    if (trackId != null && type != null) {
      // Wait for initialization to complete
      await _loadingCompleter.future;
      if (Boxes.getUserData().get(roleKey) == 'USER') {
        // if (!Get.isRegistered<HomeUserController>()) {
        //   Get.lazyPut(() => HomeUserController(), fenix: true);
        // }
        if (uri.path == '/') {// Adjust this based on your deep link URL format

          Get.put(HomeUserController());
          Get.put(BookingManagementController());
          Get.put(ProfileController());
          Get.put(NotificationController());
          Get.put(BookTrackJoinEventController());

          Get.toNamed(
            BookTrackJoinEventScreen.routeName,
            arguments: {'id': trackId, 'type': type},
          );
        }

        // Get.toNamed(
        //   BookTrackJoinEventScreen.routeName,
        //   arguments: {'id': trackId, 'type': type},
        // );
      }
    }
  }
  @override
  void onClose() {
_appLinks.getInitialLink().ignore();
    super.onClose();
  }
}
