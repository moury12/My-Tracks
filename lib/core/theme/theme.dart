import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';

TextStyle style = const TextStyle(color: AppColors.whiteLightColor);

const lightThemeFont = "Poppins", darkThemeFont = "Poppins";

final darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.blackBackgroundColor,
    brightness: Brightness.dark,
bottomSheetTheme: BottomSheetThemeData(
  backgroundColor: AppColors.blackLightColor,
  showDragHandle: true,
  surfaceTintColor: Colors.transparent,
  dragHandleColor: AppColors.greyColor,
    dragHandleSize: Size(74.w, 5.h)
),
dialogTheme: DialogTheme(

),
    // useMaterial3: true,
    // fontFamily: darkThemeFont,
    splashColor: Colors.transparent,
    inputDecorationTheme: inputDecorationTheme,
    ///============================Drawer===================================///

    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.blackBackgroundColor,
    ),
    textButtonTheme:  TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.blueColor,

      ),
    ),
    textTheme: TextTheme(
      bodySmall: const TextStyle(
        color: AppColors.whiteLightColor,
      ),
      bodyMedium:
      GoogleFonts.poppins(color: AppColors.whiteLightColor, fontSize: 18),
      bodyLarge: const TextStyle(
        color: AppColors.whiteLightColor,
      ),
      labelSmall: const TextStyle(
        color: AppColors.whiteLightColor,
      ),
      labelMedium: const TextStyle(
        color: AppColors.whiteLightColor,
      ),
      labelLarge: const TextStyle(
        color: AppColors.whiteLightColor,
      ),
      displaySmall: const TextStyle(
        color: AppColors.whiteLightColor,
      ),
      displayMedium: const TextStyle(
        color: AppColors.whiteLightColor,
      ),
      displayLarge: const TextStyle(
        color: AppColors.whiteLightColor,
      ),
    ),
    // switchTheme: SwitchThemeData(
    //   thumbColor:
    //       WidgetStateProperty.resolveWith<Color>((states) => lightThemeColor),
    // ),
    appBarTheme: appBarTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme);

////=================== Input Decoration =======================

final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: const BorderSide(color:Colors.transparent, width: 1),
      gapPadding: 0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(color: AppColors.blackBackgroundColor, width: 1),
        gapPadding: 0),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(color:Colors.transparent, width: 1),
        gapPadding: 0),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(color: AppColors.blackBackgroundColor, width: 1),
        gapPadding: 0),
    fillColor: AppColors.blackBackgroundColor,

   );

//=========================== App Bar =============================
final AppBarTheme appBarTheme = AppBarTheme(
  //color:CustomColor.kPrimaryColorx,

  elevation: 0,
  centerTitle: true,
  iconTheme: const IconThemeData(color: AppColors.whiteLightColor),
  backgroundColor: AppColors.blackBackgroundColor,
  foregroundColor: AppColors.whiteLightColor,
  scrolledUnderElevation: 0,
  titleTextStyle: poppinsMedium.copyWith(fontSize: 24,),
  actionsIconTheme: const IconThemeData(color: AppColors.whiteLightColor),

);

///========================= Bottom NavigationBar ==============================
const BottomNavigationBarThemeData bottomNavigationBarTheme =
BottomNavigationBarThemeData(
    backgroundColor: AppColors.navigationColor,
    elevation: 1,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.whiteColor,
    showUnselectedLabels: true,
    selectedIconTheme: IconThemeData(size: 28),
    unselectedItemColor: AppColors.whiteColor,
    selectedLabelStyle: TextStyle(color: AppColors.primaryColor));

// ===================== Comon colors =========================
const Color lightThemeColor = Colors.white,
    white = Colors.white,
    black = Colors.black,
    darkThemeColor = AppColors.primaryColor;