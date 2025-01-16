import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:track_trek/controller/home/host/home_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_network_image.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/init/api_client.dart';
import 'package:track_trek/core/model/track-event-for-userpanel/event_for_user_panel_model.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/model/track-event/single_track_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/host/event_slot_page.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/home/widgets/track_card_widget.dart';
import 'package:track_trek/view/manage/event_user_page.dart';

class EventCardWidget extends StatelessWidget {
  final bool? noButton;
  final bool? fromUser;
  final String? buttonText;
  final String? buttonImg;
  final SingleEventModel? eventModel;
  final EventForUserPanelModel? eventModelForUser;
  final SingleTrackModel? trackModel;
  final Function()? onTap;
  const EventCardWidget({
    super.key,
    this.noButton = false,
    this.fromUser = false,
    this.buttonText,
    this.buttonImg,
    this.onTap,
    this.eventModel, this.trackModel, this.eventModelForUser,
  });

  @override
  Widget build(BuildContext context) {
    final String imageUrl= eventModel!=null?'${ApiClient.baseUrl}/${eventModel!.eventImage?.first}':trackModel!=null?'${ApiClient.baseUrl}/${trackModel!.trackImage?.first}':eventModelForUser!=null?'${ApiClient.baseUrl}/${eventModelForUser!.eventImage?.first}':'n/a';
    final String sId= eventModel!=null?eventModel!.sId??'':trackModel!=null?trackModel!.sId??'n/a':eventModelForUser!=null?eventModelForUser!.sId??'n/a':AppStaticString.dummyEvent;
    final String name= eventModel!=null?eventModel!.eventName??'':trackModel!=null?trackModel!.trackName??'n/a':eventModelForUser!=null?eventModelForUser!.eventName??'n/a':AppStaticString.dummyEvent;
    final String location= eventModel!=null?eventModel!.address??'':trackModel!=null?trackModel!.address??'n/a':eventModelForUser!=null?eventModelForUser!.address??'n/a':AppStaticString.dummyAddress;
    final String startDate= eventModel!=null?eventModel!.startDate??'':trackModel!=null?trackModel!.totalTrackDayInMonth??'n/a':eventModelForUser!=null?eventModelForUser!.startDate??'n/a':AppStaticString.dummyDate;
    final String totalSlot= eventModel!=null?eventModel!.slots!.length.toString():trackModel!=null?trackModel!.totalTrackDayInMonth??'n/a':eventModelForUser!=null?eventModelForUser!.slots!.length.toString():AppStaticString.dummyDate;
    // final String unsold= eventModel!=null?eventModel!.??'':trackModel!=null?trackModel!.totalTrackDayInMonth??'n/a':eventModelForUser!=null?eventModelForUser!.??'n/a':AppStaticString.dummyDate;
    final String time=    eventModel != null
        ? '${eventModel!.startTime} - ${eventModel!.endTime}': eventModelForUser != null
        ? '${eventModelForUser!.startTime} - ${eventModelForUser!.endTime}':AppStaticString.dummyTime;
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
                child: CustomNetworkImage(
                        imageUrl:
                            imageUrl,
                        height: 150.h,
                        width: double.infinity)
                   ),
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
                      name,
                      style: poppinsMedium.copyWith(
                          fontSize: getFontSizeSmall(context)),
                    ),

                    ///==============dynamic event location==============///

                    Text('${AppStaticString.locationWithClone}$location',
                        // maxLines: 1,
                        // overflow: TextOverflow.ellipsis,
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

                    Text('${AppStaticString.dateWithClone} $startDate ',
                      /*  maxLines: 1,
                        overflow: TextOverflow.ellipsis,*/
                        style: poppinsRegular.copyWith(
                            fontSize: getFontSizeSmall(context))),

                    ///==============dynamic event time==============///

                    Text(
                  time,
                        /*maxLines: 1,
                        overflow: TextOverflow.ellipsis,*/
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
                        ///================================dynamic price or seat number=========================///
                        BlueTextWidget(
                          text: HomeController.to.selectedLabel.value == 2
                              ? '${AppStaticString.totalSeatWithClone}120'
                              : '${AppStaticString.priceWithClone}\$${ eventModel == null||eventModel!.slots==null||eventModel!.slots!.isEmpty
                        ?'120': eventModel!.slots!.first.price??''}',
                        ),
                        const DividerVertical(),

                        ///==============dynamic event total slot==============///

                        Text(
                          '${AppStaticString.totalSlot}${eventModel == null
                              ?'12': eventModel!.slots!.length??''}',
                          style: poppinsRegular.copyWith(
                              fontSize: getFontSizeSmall(context)),
                        ),
                        HomeController.to.selectedLabel.value == 2
                            ? const SizedBox.shrink()
                            : const DividerVertical(),
                        HomeController.to.selectedLabel.value == 2
                            ? const SizedBox.shrink()

                            ///==============dynamic event unsold==============///

                            : Text('${AppStaticString.status}: ${eventModel == null
                            ?'12': eventModel!.status??''}',
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
                       Expanded(
                          child: BlueTextWidget(
                        text: '${AppStaticString.totalSlot} $totalSlot',
                      )),
                      const DividerVertical(
                        color: AppColors.blueColor,
                      ),

                      ///=====================dynamic unsold==================///

                  /*     Expanded(
                          child: BlueTextWidget(
                        text: '${AppStaticString.unsold} $unsold',
                      )),
                      space8W,*/
                      space8W,
                      Expanded(

                          child: OptionWidget(
                              function: () async {
                                const String deepLink = '${ApiClient.baseUrl}/';

                                const String fallbackLink = 'https://play.google.com/store/apps/details?id=com.mytracks.track';
                                final String trackId = sId;
                                final String type = 'event';
                                final String fullLink = '$deepLink?trackId=$trackId&type=$type&fallback=$fallbackLink';
                                Share.share(fullLink);
                              },
                              icon: shareIconUrl,
                              text: AppStaticString.share))
                    ],
                  ),

            ///======================dynamic user===================///
            !fromUser!
                ?  ExpandableText(
                    text:
                        eventModel!=null?eventModel!.description??'':'',
                    maxLines: 3, // Number of lines to show before truncating
                  )
                : const SizedBox.shrink(),
            noButton == false
                ? CustomButton(
                    onTap: onTap ??
                        () {
                          Get.toNamed(EventTrackSlotScreen.routeName
                            ,arguments: {'slots': eventModel!.slots, 'type': 'event'}, );
                        },
                    title: buttonText ?? AppStaticString.viewAllSlot,
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
    this.text,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 2,
      textAlign: textAlign ?? TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text ?? '',
      style: poppinsBlueMedium.copyWith(fontSize: getFontSizeDefault(context)),
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
