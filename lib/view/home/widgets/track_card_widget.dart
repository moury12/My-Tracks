import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:track_trek/view/book-track-join-event/book_track_join_event_page.dart';
import 'package:track_trek/view/home/host/user_details_page.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';

class TrackCardWidget extends StatelessWidget {
  final bool? fromManage;
  final bool? fromUser;
  late final RxBool react;
  TrackCardWidget({
    super.key,
    this.fromManage = false,
    this.fromUser = false,
   required this.react,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12T,
      child: BlackContainerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(dummyEventImgUrl)),
            space12H,
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
            space12H,
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
            space12H,
            fromUser == true
                ? Row(
              mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      ///======================dynamic user profile img=======================///

                      const ProfileCircleImageWidget(),
                      space8W,
                       Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppStaticString.dummyName,style: poppinsLight.copyWith(
                              fontSize: getFontSizeSmall(context)
                            ),),
                            Row(
                              spacing: 4.w,
                              children: [
                                Text(AppStaticString.ratingWithClone,style: poppinsLight.copyWith(
                                    fontSize: getFontSizeSmall(context)
                                ),),
                                Icon(
                                  Icons.star_border_outlined,
                                  color: AppColors.yellowColor,
                                  size: 15.sp,
                                ),

                                ///======================dynamic user rating=======================///
                                Text('4.5',style: poppinsLight.copyWith(
                                    fontSize: getFontSizeSmall(context)
                                ),)
                              ],
                            ),

                          ],
                        ),
                      ),
                      DividerVertical(height: 24.h ,),
                      ///======================dynamic user total slot=======================///

                       Expanded(
                          child: Text(textAlign: TextAlign.center,
                            '${AppStaticString.totalSlot} 10',style: poppinsLight.copyWith(
                              fontSize: getFontSizeSmall(context)
                          ),))
                    ],
                  )
            ///======================dynamic total slot=======================///

                : Text(
                    '${AppStaticString.totalSlot}10',
                    style: poppinsSemiBold.copyWith(
                        fontSize: getFontSizeLarge(context)),
                  ),
            fromUser == true ? const SizedBox.shrink() : space12H,
            fromManage == true || fromUser == true
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
                                    left: (30.w * index).toDouble(),
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
            fromManage == true ? const SizedBox.shrink() : space12H,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///================comments==============///
                OptionWidget(
                  icon: commentIconUrl,
                  function: () {
                    showModalBottomSheet(
                      constraints: BoxConstraints.tightForFinite(      height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width, ),
                      context: context,
                      isScrollControlled: true, // Allows better control of the height and width
                      builder: (context) => Container(
                        // height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // color: Colors.white, // Background color for the bottom sheet
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  AppStaticString.comments,
                                  style: poppinsMedium.copyWith(
                                    fontSize: getFontSizeSmall(context),
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey[300]),
                              ...List.generate(
                                5,
                                    (index) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          const ProfileCircleImageWidget(),
                                          const SizedBox(width: 16.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                /// User name and duration
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: AppStaticString.dummyName,
                                                        style: poppinsRegular.copyWith(
                                                          fontSize: getFontSizeSmall(context),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ' 3d',
                                                        style: poppinsRegular.copyWith(
                                                          color: AppColors.normalDarkWhite,
                                                          fontSize: getFontSizeSmall(context),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 6.0),
                                                /// Comment text
                                                Text(
                                                  'Nice to see, in something elseNice to see, in something elseNice to see, in something else',
                                                  style: poppinsRegular.copyWith(
                                                    color: const Color(0xffD2D2D2),
                                                    fontSize: getFontSizeDefault(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  },
                  text: '120',
                ),
                ///================react==============///

                Obx(() {
                  return OptionWidget(
                    function: () {
                      if (react != null) {
                        react.value = !react.value;
                      }
                    },
                    icon:
                        react.value == true ? reactFillIconUrl : reactIconUrl,
                    text: '120',
                  );
                }),
                ///================map==============///

                OptionWidget(
                  icon: mapIconUrl,
                  text: AppStaticString.map,
                  function: () {
                    _showMapBottomSheet(context);
                  },
                ),
                fromManage == true
                    ? const SizedBox.shrink()
                ///================share==============///

                    : OptionWidget(
                        function: () async {
                          await Share.share('Check out this cool Flutter app!');
                        },
                        icon: shareIconUrl,
                        text: AppStaticString.share,
                      ),
              ],
            ),
            fromManage == true ? space12H : const SizedBox.shrink(),
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
                          // height: 48.h,
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
                                content: Padding(
                                  padding:  EdgeInsets.only(bottom: 12.h),
                                  child: Text(
                                    AppStaticString.areYouSureWantToReactivate,
                                    textAlign: TextAlign.center,
                                    style: poppinsRegular.copyWith(
                                        fontSize: getFontSizeDefault(context),
                                        color: AppColors.whiteLightColor),
                                  ),
                                ),
                                textColor: AppColors.redColor,
                                borderColor: AppColors.marronColor,
                                firstButtonText: AppStaticString.no,
                                secendtButtonText: AppStaticString.yes,
                              ),
                            );
                          },
                          // height: 48.h,
                          title: AppStaticString.active,
                        ),
                      )
                    ],
                  )
                : const SizedBox.shrink(),
            fromUser == true
                ? Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: CustomButton(
                      onTap: () {
                        Get.toNamed(BookTrackJoinEventScreen.routeName);
                      },
                      title: AppStaticString.bookSlot,
                      img: doubleArrowIconUrl,
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void _showMapBottomSheet(BuildContext context) {
    showModalBottomSheet(
      constraints: BoxConstraints.tightForFinite(      height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width, ),
      context: context,
      showDragHandle: false,


      isScrollControlled: true, // Allows full-screen height if needed
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height/2,
          child: GoogleMap(

            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194), // Replace with desired coordinates
              zoom: 10,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        );
      },
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
