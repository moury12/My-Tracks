import 'package:flutter/material.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/text_style.dart';

class PointTextWidget extends StatelessWidget {
  const PointTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:padding6T,
          child: Icon(
            Icons.circle,
            size: 5,
          ),
        ),
        space6W,
        Expanded(
            child: Text(
              'The readable content of a page when looking at its layout.',
              style: poppinsRegular.copyWith(
                fontSize: getFontSizeSmall(context),
              ),
            ))
      ],
    );
  }
}