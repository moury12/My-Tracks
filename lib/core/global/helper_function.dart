import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SnackbarUtil {
  static void show({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    IconData? icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: duration,
      backgroundColor: backgroundColor,
      colorText: textColor,
      icon: icon != null ? Icon(icon, color: textColor) : null,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
