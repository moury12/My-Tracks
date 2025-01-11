import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class NotificationLoadingShimmer extends StatelessWidget {
  const NotificationLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title and Date Row Placeholder
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Title Placeholder
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 16.0,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(width: 16.0),

                /// Date Placeholder
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 14.0,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),

          /// Subtitle Placeholder
          Container(
            height: 14.0,
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.grey[800],
          ),
          const SizedBox(height: 12.0),

          /// Divider Placeholder
          Container(
            height: 1.0,
            color: Colors.grey[800],
          ),
        ],
      ),
    );
  }
}
class ListOfNotificationLoading extends StatelessWidget {
  const ListOfNotificationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,

      children: List.generate(10, (index) => const NotificationLoadingShimmer(),),);
  }
}
