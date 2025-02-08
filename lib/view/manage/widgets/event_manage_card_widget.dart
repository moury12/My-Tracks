import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:track_trek/controller/booking/booking_management_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/components/custom_text_button.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/model/booking/event_booking_model.dart';
import 'package:track_trek/core/model/booking/track_booking_model.dart';
import 'package:track_trek/core/model/participants/event_participants_model.dart';
import 'package:track_trek/core/model/participants/track_participants_model.dart';
import 'package:track_trek/core/model/renter/renters_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
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
  final TrackHistoryRunningModel? trackRunningModel;
  final EventHistoryRunningModel? eventModel;
  const TrackEventInfoContentWidget({
    super.key,
     this.trackRunningModel, this.eventModel,
  });

  @override
  Widget build(BuildContext context) {
    final String name = eventModel!=null?eventModel!.event!.eventName??'':'n/a';
    final String bookingId = eventModel!=null?eventModel!.sId??'':'n/a';
    final String selectedCurrencyFrom = eventModel!=null?eventModel!.currency??'':'n/a';
    final String location = eventModel!=null?eventModel!.event!.address??'':'n/a';
    final String date = eventModel!=null?formatDateTime(eventModel!.startDateTime??''):'n/a';
    final String totalPerson = eventModel!=null?eventModel!.numOfPeople.toString():'n/a';
    final String price = eventModel!=null?eventModel!.price.toString():'n/a';
    final String status = eventModel!=null?eventModel!.status.toString():'n/a';
    return Column(spacing: 12.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: poppinsMedium.copyWith(fontSize: getFontSizeSmall(context)),
        ),

        Text(
          '${AppStaticString.locationWithClone} $location',
          style: poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),
        ),

        Text(
          '${AppStaticString.dateWithClone} $date',
          style: poppinsRegular.copyWith(fontSize: getFontSizeSmall(context)),
        ),

        Row(
          children: [
             BlueTextWidget(text:'${AppStaticString.priceWithClone}\$$price',),
            const DividerVertical(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${AppStaticString.totalAllowed}$totalPerson',
                      style: poppinsRegular.copyWith(
                          fontSize: getFontSizeSmall(context)),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
        if(status!='paid')
        CustomButton(title: AppStaticString.payNow ,onTap: () {
BookingManagementController.to.checkoutTrackEvent(
    bookingId: bookingId,
    selectedCurrencyFrom: selectedCurrencyFrom,
    price: price);
        },)
      ],
    );
  }
}

class UserInfoContentWidget extends StatelessWidget {
  final String? seatNo;
  final TrackParticipantsModel? trackPartModel;
  final EventParticipantsModel? eventPartModel;
  final RentersModel? rentersModel;
  const UserInfoContentWidget({
    super.key,
    this.seatNo,
    this.trackPartModel,
    this.eventPartModel, this.rentersModel,
  });

  @override
  Widget build(BuildContext context) {
    final String name = eventPartModel != null
        ? eventPartModel!.user!.name ?? 'n/a'
        :trackPartModel!=null? trackPartModel!.user!.name ?? AppStaticString.dummyName:rentersModel!.user!.name??'';

    final String email = eventPartModel != null
        ? eventPartModel!.user!.email ?? 'n/a'
        :trackPartModel!=null? trackPartModel!.user!.email ?? 'Not Provided':rentersModel!.user!.email??'';

    final String phone = eventPartModel != null
        ? eventPartModel!.user!.phoneNumber ?? 'n/a'
        :trackPartModel!=null? trackPartModel!.user!.phoneNumber ?? 'Not Provided':rentersModel!.user!.phoneNumber??'';
final String startDate = eventPartModel != null
        ? eventPartModel!.startDateTime ?? 'n/a'
        :trackPartModel!=null? trackPartModel!.startDateTime ?? 'Not Provided':rentersModel!.startDateTime??'';
final String createdDate = eventPartModel != null
        ? eventPartModel!.createdAt ?? 'n/a'
        :trackPartModel!=null? trackPartModel!.createdAt ?? 'Not Provided':rentersModel!.createdAt??'';

    final String address = eventPartModel != null
        ? eventPartModel!.user!.address ?? 'n/a'
        :trackPartModel!=null? trackPartModel!.user!.address ?? 'Not Provided':rentersModel!.user!.address??'';
    final String imageUrl = eventPartModel != null
        ? eventPartModel!.user!.profileImage ?? ''
        :trackPartModel!=null? trackPartModel!.user!.profileImage ?? '':rentersModel!.user!.profileImage??'';
   final String formatedStartDate = DateFormat('dd MMM yyy, hh:mm a').format(DateTime.parse(startDate));
   final String formatedBookDate = DateFormat('dd MMM yyy, hh:mm a').format(DateTime.parse(createdDate));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imageUrl.isNotEmpty
            ? CustomNetworkImage(
                imageUrl: '${ApiClient.baseUrl}/$imageUrl',
                height: 45.w,
                width: 45.w,
                boxShape: BoxShape.circle,
                imageErrorUrl: dummyProfileImgUrl,
              )
            : const ProfileCircleImageWidget(),
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
              ),UserInfoText(
                text: '${AppStaticString.startDateTime}: $formatedStartDate',
              ),UserInfoText(
                text: '${AppStaticString.bookingDateTime} $formatedBookDate',
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
                  : const SizedBox.shrink() , rentersModel != null &&
                      rentersModel!.moreInfo != null &&
                      rentersModel!.moreInfo!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        rentersModel!.moreInfo!.length,
                        (index) {
                          final info = rentersModel!.moreInfo![index];
                          return UserInfoText(
                              text: '${info.label} : ${info.value} ');
                        },
                      ))
                  : const SizedBox.shrink()
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
