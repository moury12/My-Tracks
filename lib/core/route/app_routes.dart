import 'package:get/get.dart';
import 'package:track_trek/core/binding/auth_binding.dart';
import 'package:track_trek/core/binding/create_track_event_binding.dart';
import 'package:track_trek/core/binding/home_binding.dart';
import 'package:track_trek/core/binding/initial_binding.dart';
import 'package:track_trek/view/add/create_track.dart';
import 'package:track_trek/view/add/upload_track.dart';
import 'package:track_trek/view/auth/forget_password.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/auth/new_password_page.dart';
import 'package:track_trek/view/auth/otp_page.dart';
import 'package:track_trek/view/auth/sign_up.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_page.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_payment_page.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_payment_page.dart';
import 'package:track_trek/view/feedback/feedback_page.dart';
import 'package:track_trek/view/history/history_page.dart';
import 'package:track_trek/view/home/host/home_screen.dart';
import 'package:track_trek/view/home/host/user_details_page.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';
import 'package:track_trek/view/initial/splash.dart';
import 'package:track_trek/view/manage/event_user_page.dart';
import 'package:track_trek/view/profile/profile_page.dart';
import 'package:track_trek/view/settings/change_password_page.dart';
import 'package:track_trek/view/settings/privacy_terms_page.dart';
import 'package:track_trek/view/settings/settings_page.dart';

class AppRoutes {
  static route() => [
        GetPage(
            name: '/',
            page: () => const SplashScreen(),
            binding: InitialBinding()),
        GetPage(
            name: SignUpScreen.routeName,
            page: () => const SignUpScreen(),
            binding: AuthBinding()),
        GetPage(
            name: LoginScreen.routeName,
            page: () => const LoginScreen(),
            binding: AuthBinding()),
        GetPage(
            name: BottomNavigationScreen.routeName,
            page: () => BottomNavigationScreen()),
        GetPage(
            name: ForgetPasswordScreen.routeName,
            page: () => const ForgetPasswordScreen(),
            binding: AuthBinding()),
        GetPage(
            name: ForgetPasswordScreen.routeName,
            page: () => const ForgetPasswordScreen(),
            binding: AuthBinding()),
        GetPage(
            name: HomeScreen.routeName,
            page: () => const HomeScreen(),
            binding: HomeBinding()),
        GetPage(
            name: CreateTrackScreen.routeName,
            page: () => const CreateTrackScreen(),
            bindings: [CreateTrackBinding(), CreateEventBinding()]),
        GetPage(
            name: UploadTrackScreen.routeName,
            page: () => const UploadTrackScreen(),
            binding: CreateTrackBinding()),
        GetPage(
            name: ProfileScreen.routeName,
            page: () => const ProfileScreen(),
            binding: ProfileBinding()),
        GetPage(
            name: EventUserScreen.routeName,
            page: () => const EventUserScreen()),
        GetPage(
            name: HistoryScreen.routeName, page: () => const HistoryScreen()),
        GetPage(
            name: UserDetailsScreen.routeName,
            page: () => const UserDetailsScreen()),
        GetPage(
            name: FeedbackScreen.routeName, page: () => const FeedbackScreen()),
        GetPage(
            name: BookTrackJoinEventScreen.routeName,
            page: () => const BookTrackJoinEventScreen(),
        binding: BookTrackJoinEventBinding()),  GetPage(
            name: BookTrackJoinEventPaymentScreen.routeName,
            page: () => const BookTrackJoinEventPaymentScreen(),
        binding: BookTrackJoinEventBinding()),
        GetPage(
            name: SettingsScreen.routeName, page: () => const SettingsScreen()),
        GetPage(
            name: OTPScreen.routeName,
            page: () => const OTPScreen(),
            binding: AuthBinding()),
        GetPage(
            name: NewPasswordScreen.routeName,
            page: () => const NewPasswordScreen(),
            binding: AuthBinding()),
        GetPage(
            name: PrivacyTermsScreen.routeName,
            page: () => const PrivacyTermsScreen()),
        GetPage(
            name: ChangePasswordScreen.routeName,
            page: () => const ChangePasswordScreen()),
      ];
}
