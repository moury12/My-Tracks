import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';

class SlotListHorizontalLoadingWidget extends StatelessWidget {
  const SlotListHorizontalLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:padding12,
        child: Column(
          spacing: 12.h,
          children: List.generate(5, (index) => SlotLoadingWidget(),),),
      ),
    );
  }
}
