import 'package:flutter/material.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/text_style.dart';
class SearchAddress extends StatelessWidget {
  final Function()? onTap;
  const SearchAddress({
    super.key, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding12V,
            child: Text(
              AppStaticString.dummyAddress,
              style:
              poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),
            ),
          ),
          Image.asset(horizontalDividerUrl)
        ],
      ),
    );
  }
}
