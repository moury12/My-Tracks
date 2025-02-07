import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/add/widgets/track_event_slot_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

class DescriptionLoadingEffect extends StatelessWidget {
  const DescriptionLoadingEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 60.h, // Adjust height to match the text widget
        color: Colors.grey,
      ),
    );
  }
}

class DateTimeLoadingEffect extends StatelessWidget {
  const DateTimeLoadingEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Placeholder for Date
          Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              height: 12.0,
              width: 150.0,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8.0),

          /// Placeholder for Time
          Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              height: 12.0,
              width: 200.0,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}

class NameLocationLoadingEffect extends StatelessWidget {
  const NameLocationLoadingEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Column(
        spacing: 6.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 24.h,
            width: MediaQuery.of(context).size.width * 0.6,
            color: Colors.grey,
          ),
          SizedBox(height: 8.h),
          Container(
            height: 16.h,
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class ShimmerEffectForListOfImageList extends StatelessWidget {
  const ShimmerEffectForListOfImageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkTheme ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDarkTheme ? Colors.grey[600]! : Colors.grey[100]!,
      child: BlackContainerWidget(
        padding: padding16H,
        child: Container(
          color: isDarkTheme ? Colors.grey[900]! : Colors.grey,
          height: 200.h,
          width: double.infinity,
        ),
      ),
    );
  }
}
class SlotListLoadingWidget extends StatelessWidget {
  const SlotListLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),

        child: Row(
          spacing: 12.h,
          children: List.generate(
            4,
                (index) => SizedBox(
                width: 200.w,
                child: const SlotLoadingWidget()),
          ),
        ),
      ),
    );
  }
}
