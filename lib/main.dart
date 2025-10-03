import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:track_trek/core/binding/initial_binding.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/route/app_routes.dart';
import 'package:track_trek/core/theme/theme.dart';
import 'package:track_trek/view/initial/splash.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await Hive.initFlutter();
  await Hive.openBox(userBoxName);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp( const MyApp()
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(675, 812),
      designSize: const Size(375, 812),

      minTextAdapt: true,
      useInheritedMediaQuery: true,

       builder: (context, child) =>GetMaterialApp(
         useInheritedMediaQuery: true,
         // locale: DevicePreview.locale(context),
         // builder: DevicePreview.appBuilder,
         title: 'My Tracks',
initialBinding: CommonBinding(),
          theme: darkTheme,
        themeMode: ThemeMode.dark,
        // initialRoute: BottomNavigationScreen.routeName,
         initialRoute: SplashScreen.routeName,
         getPages: AppRoutes.route(),
         debugShowCheckedModeBanner: false,

       ) ,
    );
  }
}



