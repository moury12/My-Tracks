import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/utils/app_color.dart';

enum SnackBarType { success, failed, alert }

void showCustomSnackbar({
  required String title,
  required String message,
  required SnackBarType type,
  SnackPosition position = SnackPosition.BOTTOM, // Default position
}) {
  Color backgroundColor = AppColors.primaryColor;
  IconData icon = Icons
      .sentiment_dissatisfied_outlined;
  Color textColor = Colors.white;
  switch (type) {
    case SnackBarType.success:
      backgroundColor = AppColors.greenColor;
      icon = Icons.emoji_emotions_outlined;
      break;
    case SnackBarType.failed:
      backgroundColor = Colors.redAccent;
      Icons.sentiment_dissatisfied_outlined;
      break;
    // TODO: Handle this case.
    case SnackBarType.alert:
      backgroundColor = Colors.orangeAccent;
      icon = Icons.sentiment_neutral;
      break;
    // TODO: Handle this case.
  }
  Get.snackbar(
    title,
    message,
    backgroundColor: backgroundColor,
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.all(12),
    colorText: textColor,
    dismissDirection: DismissDirection.horizontal,
    icon:
        /* Image.asset(splashImgUrl),*/
        Icon(
      icon,
      color: Colors.white,
      size: 30,
    ),
    snackPosition: position,
    duration: Duration(
        seconds: 3), // Duration for how long the snackbar will be displayed
  );
}
