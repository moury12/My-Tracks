import 'package:flutter/material.dart';
import 'package:track_trek/core/utils/app_color.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primaryColor,
      displacement: 40.0, // Adjust the distance the indicator moves
      child: child,
    );
  }
}
