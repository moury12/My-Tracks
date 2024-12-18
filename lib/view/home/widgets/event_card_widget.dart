import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/dynamic_tab_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12T,
      child: BlackContainerWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(dummyEventImgUrl)),
            space12H,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStaticString.dummyEvent,
                      style: poppinsMedium.copyWith(
                          fontSize: getFontSizeSmall(context)),
                    ),
                    Text('${AppStaticString.locationWithClone}Rock hill boston',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSmall(context)))
                  ],
                )),
                space16W,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${AppStaticString.dateWithClone} 05 january ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSmall(context))),
                    Text(AppStaticString.dummyTime,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSmall(context)))
                  ],
                ))
              ],
            ),
            space16H,
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceTextWidget(),
                  DividerVertical(),
                  Text(
                    '${AppStaticString.totalSlot}20',
                    style: poppinsRegular.copyWith(
                        fontSize: getFontSizeSmall(context)),
                  ),
                  HomeController.to.selectedLabel.value == 2
                      ? SizedBox.shrink()
                      : DividerVertical(),
                  HomeController.to.selectedLabel.value == 2
                      ? SizedBox.shrink()
                      : Text('${AppStaticString.unsold}10',
                          style: poppinsRegular.copyWith(
                              fontSize: getFontSizeSmall(context))),
                ],
              );
            }),
            space16H,
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: AppStaticString.dummyDesc,
                style: poppinsRegular.copyWith(
                    fontSize: getFontSizeSmall(context),
                    color: AppColors.fadeWhiteColor),
              ),
              TextSpan(
                text: AppStaticString.seeMore,
                style: poppinsSemiBold.copyWith(
                    fontSize: getFontSizeSmall(context)),
              )
            ])),
            space16H,
            CustomButton(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStaticString.viewAllParticipent,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackLightColor,
                          fontSize: getFontSizeSemiSmall(context))),
                  space8W,
                  Image.asset(
                    arrowTopImgUrl,
                    height: 24.w,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PriceTextWidget extends StatelessWidget {
  const PriceTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${AppStaticString.priceWithClone}\$120',
      style:
          poppinsBlueMedium.copyWith(fontSize: getFontSizeSemiSmall(context)),
    );
  }
}

class DividerVertical extends StatelessWidget {
  final Color? color;
  final double? height;
  const DividerVertical({
    super.key, this.color, this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding6H,
      child: Image.asset(
        verticalDividerImgUrl,
        height: height??10.w,
        color: color??null,
      ),
    );
  }
}
