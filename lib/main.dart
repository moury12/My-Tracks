import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/binding/initial_binding.dart';
import 'package:track_trek/core/route/app_routes.dart';
import 'package:track_trek/core/theme/theme.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';
import 'package:track_trek/view/initial/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) {
      return const MyApp();
    }
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,

       builder: (context, child) =>GetMaterialApp(
         useInheritedMediaQuery: true,
         locale: DevicePreview.locale(context),
         builder: DevicePreview.appBuilder,
         title: 'Track Trek',
initialBinding: CommonBinding(),
          theme: darkTheme,
        // initialRoute: BottomNavigationScreen.routeName,
         initialRoute: SplashScreen.routeName,
         getPages: AppRoutes.route(),
         debugShowCheckedModeBanner: false,

       ) ,
    );
  }
}



