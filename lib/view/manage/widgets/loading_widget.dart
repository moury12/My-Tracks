import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class UserInfoShimmer extends StatelessWidget {
  const UserInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Profile Image Placeholder
          Container(
            height: 45.0,
            width: 45.0,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16.0),

          /// Text Content Placeholder
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name Placeholder
                Container(
                  height: 16.0,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.grey[800],
                ),
                const SizedBox(height: 8.0),

                /// Email Placeholder
                Container(
                  height: 14.0,
                  width: MediaQuery.of(context).size.width * 0.6,
                  color: Colors.grey[800],
                ),
                const SizedBox(height: 8.0),

                /// Phone Placeholder
                Container(
                  height: 14.0,
                  width: MediaQuery.of(context).size.width * 0.4,
                  color: Colors.grey[800],
                ),
                const SizedBox(height: 8.0),

                /// Address Placeholder
                Container(
                  height: 14.0,
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Colors.grey[800],
                ),
                const SizedBox(height: 16.0),

                /// Dynamic More Info Placeholder
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    2, // Number of placeholder rows (adjust as needed)
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        height: 14.0,
                        width: MediaQuery.of(context).size.width * 0.8,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoListLoading extends StatelessWidget {
  const UserInfoListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: List.generate(
        5,
        (index) =>
            const MarronGradientContainerWidget(child: UserInfoShimmer()),
      ),
    );
  }
}
