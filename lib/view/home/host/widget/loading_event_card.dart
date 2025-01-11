import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

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
      children: List.generate(4, (index) => EventCardLoadingWidget(),),
    );
  }
}
