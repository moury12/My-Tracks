
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

class ShimmerBookingCard extends StatelessWidget {
  const ShimmerBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final shimmerColor = Colors.grey[800]!;
    final baseColor = Colors.grey[700]!;
    final highlightColor = Colors.grey[500]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20.0,
            width: double.infinity,
            color: shimmerColor,
          ),
          const SizedBox(height: 12),
          Container(
            height: 16.0,
            width: double.infinity,
            color: shimmerColor,
          ),
          const SizedBox(height: 12),
          Container(
            height: 16.0,
            width: double.infinity,
            color: shimmerColor,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 16.0,
                  color: shimmerColor,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 16.0,
                width: 40.0,
                color: shimmerColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
class LoadingBookingList extends StatelessWidget {
  const LoadingBookingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12V,
      child: Column(
        spacing: 12.h,
        children: [
          ...List.generate(4, (index) {
            return const MarronGradientContainerWidget(
              child: ShimmerBookingCard(),
            );
          },)
        ],
      ),
    );
  }
}
