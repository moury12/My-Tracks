import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

class EventCardLoadingWidget extends StatelessWidget {
  const EventCardLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[600]!,
        child: Column(
          children: [
            /// Image Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),

            /// Title Placeholder
            Container(
              height: 20,
              width: double.infinity,
              color: Colors.grey[800],
            ),
            const SizedBox(height: 8),

            /// Location Placeholder
            Container(
              height: 16,
              width: MediaQuery.of(context).size.width * 0.6,
              color: Colors.grey[800],
            ),
            const SizedBox(height: 16),

            /// Row with Multiple Placeholders
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Left Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Date Placeholder
                    Container(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.4,
                      color: Colors.grey[800],
                    ),
                    const SizedBox(height: 8),

                    /// Time Placeholder
                    Container(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.2,
                      color: Colors.grey[800],
                    ),
                  ],
                ),

                /// Right Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Total Slots Placeholder
                    Container(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: Colors.grey[800],
                    ),
                    const SizedBox(height: 8),

                    /// Status Placeholder
                    Container(
                      height: 16,
                      width: MediaQuery.of(context).size.width * 0.2,
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListOfEventLoadingWidget extends StatelessWidget {
  const ListOfEventLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: List.generate(
        4,
        (index) => const BlackContainerWidget(child: EventCardLoadingWidget()),
      ),
    );
  }
}

Widget userInfoLoadingWidget(BuildContext context) {
  return Row(
    children: [
      // Shimmer for profile image
      Shimmer.fromColors(
        baseColor: Colors.grey.shade800,
        highlightColor: Colors.grey.shade600,
        child: CircleAvatar(
          radius: 26.w, // Half of 52.w
          backgroundColor: Colors.grey.shade800,
        ),
      ),
      SizedBox(width: 12.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer for name
          Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade600,
            child: Container(
              height: getFontSizeLarge(context),
              width: 120.w, // Fixed width for name placeholder
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 8.w),
          Row(
            children: [
              // Shimmer for location icon
              Shimmer.fromColors(
                baseColor: Colors.grey.shade800,
                highlightColor: Colors.grey.shade600,
                child: Icon(
                  Icons.location_on,
                  size: 21.w,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(width: 8.w),
              // Shimmer for address
              Shimmer.fromColors(
                baseColor: Colors.grey.shade800,
                highlightColor: Colors.grey.shade600,
                child: Container(
                  height: getFontSizeSemiSmall(context),
                  width: 150.w, // Fixed width for address placeholder
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
