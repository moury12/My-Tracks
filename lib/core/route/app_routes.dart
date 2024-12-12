import 'package:get/get.dart';
import 'package:track_trek/core/binding/initial_binding.dart';
import 'package:track_trek/view/auth/login.dart';
import 'package:track_trek/view/initial/splash.dart';

class AppRoutes{
  static route()=>[
    GetPage(name: '/', page: ()=> const SplashScreen()  , binding: InitialBinding()),
    GetPage(name: LoginScreen.routeName, page: ()=> const LoginScreen()  ),
  ];
}