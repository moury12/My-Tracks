import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:track_trek/controller/home_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';
import 'package:track_trek/view/add/widgets/delete_alert_dialog.dart';
import 'package:track_trek/view/home/user_details_page.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

class TrackCardWidget extends StatelessWidget {
  final bool? fromManage;
  const TrackCardWidget({
    super.key,
    this.fromManage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12T,
      child: BlackContainerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: padding14V,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(dummyEventImgUrl)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  AppStaticString.dummyEvent,
                  style: poppinsMedium.copyWith(
                      fontSize: getFontSizeLarge(context)),
                )),
                space16W,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        locationIconUrl,
                        height: 24.w,
                      ),
                      space6W,
                      Expanded(
                          child: Text(
                        AppStaticString.dummyAddress,
                        style: poppinsMedium.copyWith(
                            fontSize: getFontSizeSmall(context)),
                      ))
                    ],
                  ),
                )
              ],
            ),
            space16H,
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: AppStaticString.dummyDesc,
                style: poppinsRegular.copyWith(
                  fontSize: getFontSizeSmall(context),
                ),
              ),
              TextSpan(
                text: AppStaticString.seeMore,
                style: poppinsSemiBold.copyWith(
                    fontSize: getFontSizeSmall(context)),
              )
            ])),
            space16H,
            Text(
              '${AppStaticString.totalSlot}10',
              style:
                  poppinsSemiBold.copyWith(fontSize: getFontSizeLarge(context)),
            ),
            space16H,
            fromManage == true
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: SizedBox(
                          height: 45.w,
                          child: Stack(
                            children: List.generate(
                                5,
                                (index) => Positioned(
                                    left: (30 * index).toDouble(),
                                    child: const ProfileCircleImageWidget())),
                          ),
                        ),
                      ),
                      space8W,
                      Flexible(
                          flex: 4,
                          child: CustomButton(
                            onTap: () {
                              Get.toNamed(UserDetailsScreen.routeName);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppStaticString.viewAll,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.blackLightColor,
                                        fontSize:
                                            getFontSizeSemiSmall(context))),
                                space8W,
                                Image.asset(
                                  arrowTopImgUrl,
                                  height: 24.w,
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
            fromManage == true ? const SizedBox.shrink() : space16H,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OptionWidget(
                  icon: commentIconUrl,
                  function: () {
                    showBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  AppStaticString.comments,
                                  style: poppinsMedium.copyWith(
                                    fontSize: getFontSizeSmall(context),
                                  ),
                                ),
                                space16H,
                                Image.asset(horizontalDividerUrl),
                                ...List.generate(
                                  5,
                                  (index) => Column(
                                    children: [
                                      Padding(
                                        padding: padding16,
                                        child: Row(
                                          children: [
                                            ProfileCircleImageWidget(),
                                            space16W,
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ///=======================user name dynamic + duration ========================///
                                                  RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: AppStaticString
                                                              .dummyName,
                                                          style: poppinsRegular
                                                              .copyWith(
                                                                  fontSize:
                                                                      getFontSizeSmall(
                                                                          context))),
                                                      TextSpan(text: ' 3d .',
                                                          style: poppinsRegular
                                                              .copyWith( color: AppColors.normalDarkWhite,
                                                              fontSize:
                                                              getFontSizeSmall(
                                                                  context))),
                                                    ]),
                                                  ),
                                                  space6H,

                                                  ///=======================dynamic comment========================///
                                                  Text(
                                                      'Nice to see, in something elseNice to see, in something elseNice to see, in something else',style: poppinsRegular.copyWith(
                                                    color: Color(0xffD2D2D2),
                                                      fontSize: getFontSizeDefault(context)),)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Image.asset(horizontalDividerUrl)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  text: '120',
                ),
                Obx(
                   () {
                    return OptionWidget(
                      function: () {
                        HomeController.to.react.value=!HomeController.to.react.value;
                      },
                      icon:HomeController.to.react.value?reactFillIconUrl: reactIconUrl,
                      text: '120',
                    );
                  }
                ),
                OptionWidget(
                  icon: mapIconUrl,
                  text: AppStaticString.map,
                ),
                fromManage == true
                    ? const SizedBox.shrink()
                    : OptionWidget(
                        function: () async {
                          await Share.share('Check out this cool Flutter app!');
                        },
                        icon: shareIconUrl,
                        text: AppStaticString.share,
                      ),
              ],
            ),
            fromManage == true ? space16H : const SizedBox.shrink(),
            fromManage == true
                ? Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => const DeleteAlertDialog(),
                            );
                          },
                          fillColor: Colors.transparent,
                          borderColor: AppColors.redColor,
                          height: 48.h,
                          title: AppStaticString.delete,
                          textColor: AppColors.redColor,
                        ),
                      ),
                      space12W,

                      ///========================active button========================///
                      Expanded(
                        child: CustomButton(
                          fillColor: AppColors.greenColor,
                          borderColor: AppColors.greenColor,
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => DefaultDialogWithButton(
                                content: Text(
                                  AppStaticString.areYouSureWantToReactivate,
                                  textAlign: TextAlign.center,
                                  style: poppinsRegular.copyWith(
                                      fontSize: getFontSizeDefault(context),
                                      color: AppColors.whiteLightColor),
                                ),
                                textColor: AppColors.redColor,
                                borderColor: AppColors.marronColor,
                                firstButtonText: AppStaticString.no,
                                secendtButtonText: AppStaticString.yes,
                              ),
                            );
                          },
                          height: 48.h,
                          title: AppStaticString.active,
                        ),
                      )
                    ],
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class ProfileCircleImageWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const ProfileCircleImageWidget({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Image.asset(
      dummyProfileImgUrl,
      height: height ?? 45.w,
      width: width ?? 45.w,
      fit: BoxFit.cover,
    ));
  }
}

class OptionWidget extends StatelessWidget {
  final String icon;
  final String text;
  final Function()? function;
  const OptionWidget({
    super.key,
    required this.icon,
    required this.text,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Row(
        children: [
          Image.asset(
            icon,
            height: 24.sp,
          ),
          space6W,
          Text(
            text,
            style: poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),
          )
        ],
      ),
    );
  }
}
