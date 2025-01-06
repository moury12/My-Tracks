import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/model/participants/event_participants_model.dart';
import 'package:track_trek/core/model/participants/track_participants_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/host/user_details_page.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';

class MarronGradientContainerWidget extends StatelessWidget {
  final Widget? child;

  const MarronGradientContainerWidget({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainerWidget(
      firstColor: AppColors.blackColor,
      secondColor: AppColors.marronColor,
      borderColor: const Color(0xff3E3E3E),
      borderWidth: 1,
      child: child ?? const TrackEventInfoContentWidget(),
    );
  }
}

class TrackEventInfoContentWidget extends StatelessWidget {
  final bool noArrowButton;
  const TrackEventInfoContentWidget({
    super.key,
    this.noArrowButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStaticString.dummyEvent,
          style: poppinsMedium.copyWith(fontSize: getFontSizeSmall(context)),
        ),
        space12H,
        Text(
          '${AppStaticString.locationWithClone} Rock Hill BMX Supercross Track (USA)',
          style: poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),
        ),
        space12H,
        Text(
          '${AppStaticString.dateWithClone} 5 january ${AppStaticString.dummyTime}',
          style: poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),
        ),
        space12H,
        Row(
          children: [
            const BlueTextWidget(),
            const DividerVertical(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${AppStaticString.totalAllowed}20',
                      style: poppinsRegular.copyWith(
                          fontSize: getFontSizeSmall(context)),
                    ),
                  ),
                  noArrowButton == true
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            Get.toNamed(UserDetailsScreen.routeName,
                                arguments: userPanel);
                          },
                          icon: Image.asset(
                            arrowForwardIconUrl,
                            height: 24.w,
                          ))
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class UserInfoContentWidget extends StatelessWidget {
  final String? seatNo;
  final TrackParticipantsModel? trackPartModel;
  final EventParticipantsModel? eventPartModel;
  const UserInfoContentWidget({
    super.key,
    this.seatNo,
    this.trackPartModel,
    this.eventPartModel,
  });

  @override
  Widget build(BuildContext context) {
    final String name = eventPartModel != null
        ? eventPartModel!.user!.name ?? 'n/a'
        : trackPartModel!.user!.name ?? AppStaticString.dummyName;

    final String email = eventPartModel != null
        ? eventPartModel!.user!.email ?? 'n/a'
        : trackPartModel!.user!.email ?? 'Not Provided';

    final String phone = eventPartModel != null
        ? eventPartModel!.user!.phoneNumber ?? 'n/a'
        : trackPartModel!.user!.phoneNumber ?? 'Not Provided';

    final String address = eventPartModel != null
        ? eventPartModel!.user!.email ?? 'n/a'
        : trackPartModel!.user!.email ?? AppStaticString.dummyAddress;
    final String imageUrl = eventPartModel != null
        ? eventPartModel!.user!.profileImage ?? ''
        : trackPartModel!.user!.profileImage ?? '';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imageUrl.isNotEmpty
            ? CustomNetworkImage(
                imageUrl: imageUrl,
                height: 45.w,
                width: 45.w,
                boxShape: BoxShape.circle,
                imageErrorUrl: dummyProfileImgUrl,
              )
            : ProfileCircleImageWidget(),
        space16W,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                /* eventPartModel!=null?eventPartModel.:*/ name,
                style: poppinsRegular.copyWith(
                    fontSize: getFontSizeDefault(context)),
              ),

              ///===================dynamic email==================///
              UserInfoText(text: '${AppStaticString.emailUser} $email'),

              ///===================dynamic phone==================///

              UserInfoText(text: '${AppStaticString.contact} $phone'),

              ///===================dynamic address==================///

              UserInfoText(
                text: '${AppStaticString.address}$address',
              ),
              eventPartModel != null &&
                      eventPartModel!.moreInfo != null &&
                      eventPartModel!.moreInfo!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        eventPartModel!.moreInfo!.length,
                        (index) {
                          final info = eventPartModel!.moreInfo![index];
                          return UserInfoText(
                              text: '${info.label} : ${info.value} ');
                        },
                      ))
                  : SizedBox.shrink()
            ],
          ),
        ),
      ],
    );
  }
}

class UserInfoText extends StatelessWidget {
  final String text;
  final Color? color;
  const UserInfoText({
    super.key,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: poppinsRegular.copyWith(
          fontSize: getFontSizeSmall(context),
          color: color ?? AppColors.fadeWhiteColor),
    );
  }
}
