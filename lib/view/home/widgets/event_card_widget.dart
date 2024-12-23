
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
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/event_user_page.dart';

class EventCardWidget extends StatelessWidget {
  final bool? noButton;
  final bool? fromUser;
  final String? buttonText;
  final String? buttonImg;
  final Function()? onTap;
  const EventCardWidget({
    super.key,
    this.noButton = false,
    this.fromUser = false,
    this.buttonText,
    this.buttonImg,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12T,
      child: BlackContainerWidget(
        child: Column(
          spacing: 12.h,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.r),

                ///==============dynamic event image==============///
                child: Image.asset(dummyEventImgUrl)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///==============dynamic event name==============///

                    Text(
                      AppStaticString.dummyEvent,
                      style: poppinsMedium.copyWith(
                          fontSize: getFontSizeSmall(context)),
                    ),

                    ///==============dynamic event location==============///

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
                    ///==============dynamic event date==============///

                    Text('${AppStaticString.dateWithClone} 05 january ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSmall(context))),

                    ///==============dynamic event time==============///

                    Text(AppStaticString.dummyTime,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSmall(context)))
                  ],
                ))
              ],
            ),
            !fromUser!
                ? Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BlueTextWidget(),
                        const DividerVertical(),

                        ///==============dynamic event total slot==============///

                        Text(
                          '${AppStaticString.totalSlot}20',
                          style: poppinsRegular.copyWith(
                              fontSize: getFontSizeSmall(context)),
                        ),
                        HomeController.to.selectedLabel.value == 2
                            ? const SizedBox.shrink()
                            : const DividerVertical(),
                        HomeController.to.selectedLabel.value == 2
                            ? const SizedBox.shrink()

                            ///==============dynamic event unsold==============///

                            : Text('${AppStaticString.unsold}10',
                                style: poppinsRegular.copyWith(
                                    fontSize: getFontSizeSmall(context))),
                      ],
                    );
                  })
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///=====================dynamic total slot==================///
                      const Expanded(
                          child: BlueTextWidget(
                        text: '${AppStaticString.totalSlot} 20',
                      )),
                      const DividerVertical(
                        color: AppColors.blueColor,
                      ),
                      ///=====================dynamic unsold==================///

                      const Expanded(
                          child: BlueTextWidget(
                        text: '${AppStaticString.unsold} 20',
                      )),
                      space8W,
                      Expanded(
                          child: OptionWidget(
                              icon: shareIconUrl, text: AppStaticString.share))
                    ],
                  ),
            ///======================dynamic user===================///
            !fromUser!
                ? const ExpandableText(
              text:
              "${AppStaticString.dummyDesc}${AppStaticString.dummyDesc}${AppStaticString.dummyDesc}",
              maxLines: 3, // Number of lines to show before truncating
            )
                : const SizedBox.shrink(),
            noButton == false
                ? CustomButton(
                    onTap: onTap ??
                        () {
                          Get.toNamed(EventUserScreen.routeName);
                        },
                    title: buttonText ?? AppStaticString.viewAllParticipent,
                    img: buttonImg ?? arrowTopImgUrl,
                    /*child: Row(
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
              ),*/
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class BlueTextWidget extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  const BlueTextWidget({
    super.key,
    this.text, this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 2,textAlign:textAlign?? TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text ?? '${AppStaticString.priceWithClone}\$120',
      style:
          poppinsBlueMedium.copyWith(fontSize: getFontSizeSemiSmall(context)),
    );
  }
}

class DividerVertical extends StatelessWidget {
  final Color? color;
  final double? height;
  const DividerVertical({
    super.key,
    this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding6H,
      child: Image.asset(
        verticalDividerImgUrl,
        height: height ?? 10.w,
        color: color,
      ),
    );
  }
}
