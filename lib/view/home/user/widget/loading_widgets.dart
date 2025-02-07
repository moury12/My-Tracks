import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:track_trek/view/add/widgets/black_container_with_border.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

class LoadingCategoryListWidget extends StatelessWidget {
  const LoadingCategoryListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors based on the current theme
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Color baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    Color highlightColor = isDarkMode ? Colors.grey[600]! : Colors.grey[100]!;

    return Row(
      children: List.generate(
        5, // Adjust the count to match the placeholder shimmer items
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Column(
              children: [
                Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    color: baseColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 70.w,
                  height: 10.h,
                  color: baseColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingEventListWidget extends StatelessWidget {
  const LoadingEventListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(spacing: 12.w,
        children: List.generate(
          5, // Number of shimmer items to display
          (index) => ShimmerTrackEventWidget(baseColor: baseColor, highlightColor: highlightColor),
        ),
      ),
    );
  }
}
class LoadingTrackListWidget extends StatelessWidget {
  const LoadingTrackListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return SingleChildScrollView(

      child: Column(spacing: 12.h,
        children: List.generate(
          5, // Number of shimmer items to display
          (index) => ShimmerTrackEventWidget(
            padding:  EdgeInsets.only(top: 12.h),
              baseColor: baseColor, highlightColor: highlightColor,width: MediaQuery.sizeOf(context).width),
        ),
      ),
    );
  }
}

class ShimmerTrackEventWidget extends StatelessWidget {
  final double? width;
  final EdgeInsets? padding;
  const ShimmerTrackEventWidget({
    super.key,
    required this.baseColor,
    required this.highlightColor, this.width, this.padding,
  });

  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return BlackContainerWidget(
      child: Padding(
        padding:padding?? EdgeInsets.only(right: 12.w,top: 12.h),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: SizedBox(
            width:width?? MediaQuery.sizeOf(context).width / 1.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Simulate event image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    height: 150.h,
                    width: double.infinity,
                    color: baseColor,
                  ),
                ),
                SizedBox(height: 12.h),
                // Simulate event name
                Container(
                  width: 100.w,
                  height: 12.h,
                  color: baseColor,
                ),
                SizedBox(height: 8.h),
                // Simulate event location
                Container(
                  width: 150.w,
                  height: 10.h,
                  color: baseColor,
                ),
                SizedBox(height: 12.h),
                // Simulate event date and time
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 10.h,
                        color: baseColor,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 10.h,
                        color: baseColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Simulate button
                Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
