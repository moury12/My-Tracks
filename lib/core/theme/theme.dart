import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    colorScheme: ColorScheme.light(
      primary: AppColors.blueColor, // header background color
      onPrimary: AppColors.blackBackgroundColor, // header text color
      onSurface: AppColors.blackBackgroundColor, // body text color
    ),
    datePickerTheme: DatePickerThemeData(
      dayOverlayColor: const WidgetStatePropertyAll<Color>(AppColors.blackLightColor),

      headerHelpStyle: TextStyle(
        color: AppColors.blackLightColor,
        fontSize: 16.sp,
      ), yearOverlayColor: const WidgetStatePropertyAll<Color>(AppColors.blackLightColor) ,
      headerForegroundColor: AppColors.blackLightColor,
      rangePickerHeaderForegroundColor: AppColors.blackLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.blackLightColor;  // Change this color
        }
        return null; // Default background
      }),
      rangeSelectionBackgroundColor: AppColors.blackLightColor,
      todayBackgroundColor: const WidgetStatePropertyAll<Color>(AppColors.blackLightColor),
      yearForegroundColor:
      const WidgetStatePropertyAll<Color>(AppColors.blackLightColor),
      dayForegroundColor:
      WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.whiteLightColor;   // Change this color
        }
        return AppColors.blackLightColor; // Default background
      }),
      todayForegroundColor:
      const WidgetStatePropertyAll<Color>(AppColors.whiteLightColor),
      confirmButtonStyle: const ButtonStyle(
        foregroundColor:
        WidgetStatePropertyAll<Color>(AppColors.blackLightColor),
      ),
      rangePickerHeaderHeadlineStyle:
      const TextStyle(color: AppColors.blackLightColor),
      rangePickerSurfaceTintColor: AppColors.blackLightColor,
      cancelButtonStyle: const ButtonStyle(
        foregroundColor:
        WidgetStatePropertyAll<Color>(AppColors.blackLightColor),
      ),
      backgroundColor: AppColors.blueColor,
      dividerColor: Colors.transparent,
      // todayBackgroundColor: const WidgetStatePropertyAll<Color>(AppColors.blackLightColor),
      yearStyle: TextStyle(
        color: AppColors.blackLightColor,
        fontSize: 16.sp,
      ),
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: AppColors.blackLightColor),
      weekdayStyle: TextStyle(
        color: AppColors.blackLightColor, // Color for week names
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      // rangeSelectionBackgroundColor: AppColors.blackLightColor,
      headerHeadlineStyle: TextStyle(
        color:
        AppColors.blackLightColor, // Color for month/year in header
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(
        color: AppColors.blackLightColor, // Dropdown text color
        fontSize: 16.sp,
      ),
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