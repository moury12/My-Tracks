import 'package:get/get.dart';
import 'package:track_trek/core/binding/auth_binding.dart';
import 'package:track_trek/core/binding/create_track_event_binding.dart';
import 'package:track_trek/core/binding/home_binding.dart';
import 'package:track_trek/core/binding/initial_binding.dart';
import 'package:track_trek/view/add/create_track_event_page.dart';
import 'package:track_trek/view/add/upload_track.dart';
import 'package:track_trek/view/auth/forget_password.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/auth/new_password_page.dart';
import 'package:track_trek/view/auth/otp_page.dart';
import 'package:track_trek/view/auth/sign_up.dart';
import 'package:track_trek/view/book-track-join-event/book_track_join_event_page.dart';
import 'package:track_trek/view/book-track-join-event/book_track_payment_page.dart';
import 'package:track_trek/view/book-track-join-event/join_event_payment_page.dart';
import 'package:track_trek/view/feedback/feedback_page.dart';
import 'package:track_trek/view/history/history_page.dart';
import 'package:track_trek/view/home/host/add_bank_acc_host.dart';
import 'package:track_trek/view/home/host/add_bank_acc_host.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
import 'package:track_trek/view/home/host/home_screen.dart';
import 'package:track_trek/view/home/host/user_details_page.dart';
import 'package:track_trek/view/promote/payment_screen.dart';
import 'package:track_trek/view/promote/payment_screen.dart';
import 'package:track_trek/view/search/search_page.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';
import 'package:track_trek/view/initial/splash.dart';
import 'package:track_trek/view/manage/event_user_page.dart';
import 'package:track_trek/view/profile/profile_page.dart';
import 'package:track_trek/view/search/search_result_page.dart';
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
            page: () => SignUpScreen(),
            binding: AuthBinding()),
        GetPage(
            name: LoginScreen.routeName,
            page: () => LoginScreen(),
            binding: AuthBinding()),
        GetPage(
            name: BottomNavigationScreen.routeName,
            page: () => BottomNavigationScreen()),
        GetPage(
            name: ForgetPasswordScreen.routeName,
            page: () => ForgetPasswordScreen(),
            binding: AuthBinding()),
        GetPage(
          name: PaymentScreen.routeName,
          page: () => const PaymentScreen(),
        ),
        GetPage(
            name: EventTrackSlotScreen.routeName,
            page: () => const EventTrackSlotScreen(),
            binding: HomeBinding()),
        GetPage(
            name: HomeScreen.routeName,
            page: () => const HomeScreen(),
            binding: HomeBinding()),
        GetPage(
            name: CreateTrackEventScreen.routeName,
            page: () => CreateTrackEventScreen(),
            binding: CreateTrackBinding()),
        GetPage(
            name: UploadTrackScreen.routeName,
            page: () => UploadTrackScreen(),
            binding: CreateTrackBinding()),
        GetPage(
          name: ProfileScreen.routeName,
          page: () => const ProfileScreen(), /*  binding: ProfileBinding()*/
        ),
        GetPage(
            name: SearchScreen.routeName,
            page: () => SearchScreen(),
            binding: HomeUserBinding()),
        GetPage(
            name: SearchResultScreen.routeName,
            page: () => const SearchResultScreen(),
            binding: HomeUserBinding()),
        GetPage(
            name: EventUserScreen.routeName,
            page: () => const EventUserScreen()),
        GetPage(
            name: HistoryScreen.routeName, page: () => const HistoryScreen()),
        GetPage(
            name: UserDetailsScreen.routeName,
            page: () => const UserDetailsScreen()),
        GetPage(
            name: FeedbackScreen.routeName,
            page: () => FeedbackScreen(),
            binding: FeedbackBinding()),
        GetPage(
            name: BookTrackJoinEventScreen.routeName,
            page: () => const BookTrackJoinEventScreen(),
            binding: BookTrackJoinEventBinding()),
        GetPage(
            name: JoinEventPaymentScreen.routeName,
            page: () => const JoinEventPaymentScreen(),
            binding: BookTrackJoinEventBinding()),
        GetPage(
            name: BookTrackPaymentScreen.routeName,
            page: () => const BookTrackPaymentScreen(),
            binding: BookTrackJoinEventBinding()),
        GetPage(
            name: SettingsScreen.routeName, page: () => const SettingsScreen()),
        GetPage(
            name: OTPScreen.routeName,
            page: () => OTPScreen(),
            binding: AuthBinding()),
        GetPage(
            name: AddBankAccHost.routeName,
            page: () => AddBankAccHost(),
            binding: HostStripeBinding()),
        GetPage(
            name: NewPasswordScreen.routeName,
            page: () => NewPasswordScreen(),
            binding: AuthBinding()),
        GetPage(
            name: PrivacyTermsScreen.routeName,
            page: () => const PrivacyTermsScreen(),
            binding: FeedbackBinding()),
        GetPage(
            name: ChangePasswordScreen.routeName,
            page: () => ChangePasswordScreen()),
      ];
}
