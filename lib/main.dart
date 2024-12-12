import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/route/app_routes.dart';
import 'package:track_trek/core/theme/theme.dart';
import 'package:track_trek/view/initial/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
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
         title: 'Track Trek',

          theme: darkTheme,
         initialRoute: SplashScreen.routeName,
         getPages: AppRoutes.route(),
         debugShowCheckedModeBanner: false,

       ) ,
    );
  }
}



