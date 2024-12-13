import 'package:get/get.dart';
import 'package:track_trek/core/binding/auth_binding.dart';
import 'package:track_trek/core/binding/home_binding.dart';
import 'package:track_trek/core/binding/initial_binding.dart';
import 'package:track_trek/view/auth/forget_password.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/auth/sign_up.dart';
import 'package:track_trek/view/home/home_screen.dart';
import 'package:track_trek/view/home/home_screen.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';
import 'package:track_trek/view/initial/splash.dart';

class AppRoutes {
  static route() => [
        GetPage(
            name: '/',
            page: () => const SplashScreen(),
            binding: InitialBinding()),
        GetPage(name: SignUpScreen.routeName, page: () => const SignUpScreen(),binding: AuthBinding()),
        GetPage(name: LoginScreen.routeName, page: () => const LoginScreen(),binding: AuthBinding()),
        GetPage(name: BottomNavigationScreen.routeName, page: () =>  BottomNavigationScreen()),
        GetPage(name: ForgetPasswordScreen.routeName, page: () => const ForgetPasswordScreen(),binding: AuthBinding()),
        GetPage(name: ForgetPasswordScreen.routeName, page: () => const ForgetPasswordScreen(),binding: AuthBinding()),
        GetPage(name: HomeScreen.routeName, page: () => const HomeScreen(),binding: HomeBinding()),
      ];
}
