import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking/booking_management_controller.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_text_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/model/booking/event_booking_model.dart';
import 'package:track_trek/core/model/booking/track_booking_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';

class HistoryContentWidget extends StatelessWidget {
  final bool? addRating;
  final double? ratingVal;
  final TrackHistoryRunningModel? trackModel;
  final EventHistoryRunningModel? eventModel;
  const HistoryContentWidget({
    super.key,
    this.addRating = false,
    this.trackModel,
    this.eventModel, this.ratingVal,
  });

  @override
  Widget build(BuildContext context) {
    final String name =
        trackModel != null&& trackModel!.trackSlot!=null  && trackModel!.trackSlot!=null? trackModel!.trackSlot!.slotNo.toString() : 'no Data provided';
    final String price =
        trackModel != null&& trackModel!.trackSlot!=null ? trackModel!.price.toString() : '0.00';
    final String bookingId =
        trackModel != null&& trackModel!.trackSlot!=null ? trackModel!.sId.toString() : 'no Data provided';
    final String selectedCurrencyFrom =
        trackModel != null&& trackModel!.trackSlot!=null ? trackModel!.currency.toString() : 'no Data provided';

    ///-------- need to fix----------./...
    final String day =
        trackModel != null&& trackModel!.trackSlot!=null ? trackModel!.trackSlot!.day.toString() : 'no Data provided';
    final String status =
        trackModel != null&& trackModel!.trackSlot!=null ? trackModel!.status.toString() : 'no Data provided';
    final String startDateTime = trackModel != null&& trackModel!.trackSlot!=null
        ? formatDateTime(trackModel!.startDateTime ?? '').toString()
        : 'no Data provided';
    final String endDateTime = trackModel != null&& trackModel!.trackSlot!=null
        ? formatDateTime(trackModel!.endDateTime ?? '').toString()
        : 'no Data provided';
    return Column(
      spacing: 6.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 12.w,
          children: [
            ///===================dynamic slot no =============================///
            Expanded(flex: 2,
                child: Text(
              '${AppStaticString.slotNumber} $name',
              style: poppinsSemiBold.copyWith(
                  fontSize: getFontSizeLarge(context)),
            )),

            ///===================dynamic price =============================///

            Expanded(
                child: Text(
              '${AppStaticString.fee} \$$price',
              textAlign: TextAlign.end,
              style: poppinsSemiBold.copyWith(
                  color: AppColors.normalDarkWhite,
                  fontSize: getFontSizeLarge(context)),
            )),
          ],
        ),

        ///===================dynamic week day =============================///
        addRating == true ? RattingButtonWidget(

          ratingValue: ratingVal??0.0,
          trackId: trackModel!.track??'',)
            : const SizedBox.shrink(),

        // Row(
        //   children: [
        //     Text(
        //       day,
        //       style:
        //           poppinsMedium.copyWith(fontSize: getFontSizeDefault(context)),
        //     ),
        //     const Spacer(),
        //
        //     ///=======================rating button=================///
        //     addRating == true ? RattingButtonWidget(ratingValue: ratingVal??0.0, trackId: trackModel!.track??'',) : const SizedBox.shrink()
        //   ],
        // ),
        Text(
          AppStaticString.startDateTime,
          style: poppinsMedium.copyWith(fontSize: getFontSizeSmall(context)),
        ),

        ///===================dynamic start date time =============================///

        Text(
          startDateTime,
          style: poppinsMedium.copyWith(
              color: AppColors.primaryColor,
              fontSize: getFontSizeSmall(context)),
        ),
        Text(
          AppStaticString.endDateTime,
          style: poppinsMedium.copyWith(fontSize: getFontSizeSmall(context)),
        ),

        ///===================dynamic end date time =============================///

        Text(
          endDateTime,
          style: poppinsMedium.copyWith(
              color: AppColors.blueColor, fontSize: getFontSizeSmall(context)),
        ),
        if(status!='paid'&&addRating == false)
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

class RattingButtonWidget extends StatelessWidget {
  final double ratingValue;
  final String trackId;
  const RattingButtonWidget({
    super.key, required this.ratingValue, required this.trackId,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      fontSize: getFontSizeDefault(context),
      onPressed: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => DefaultDialogWithButton(
            title: AppStaticString.rating,
            content: Column(
              spacing: 16.h,
              children: [
                space6H,
                RatingBar(
                  initialRating: ratingValue,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Image.asset(starFillIconUrl),
                    half: Image.asset(ratingHalfIconUrl),
                    empty: Image.asset(starIconUrl),
                  ),
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.sp),
                  onRatingUpdate: (rating) {
                   BookingManagementController.to.ratingValue.value=rating;
                  },
                ),
                CustomTextField(
                  title: AppStaticString.feedback,
                  maxLines: 3,
                  textEditingController: BookingManagementController.to.reviewController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
                space6H,
              ],
            ),
            rowButton: Row(
              spacing: 16.w,
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    fillColor: AppColors.redBrightColor,
                    borderColor: AppColors.redBrightColor,
                    title: AppStaticString.cancel,
                    textColor: AppColors.blackLightColor,
                  ),
                ),
                Expanded(
                  child: Obx(
                     () {
                      return CustomButton(
                        isLoading: BookingManagementController.to.isLoadingRating.value,
                        onTap: () {
                          Navigator.pop(context);
                          BookingManagementController.to.postReviewCall(trackId: trackId);
                        },
                        fillColor: AppColors.blueColor,
                        borderColor: AppColors.blueColor,
                        title: AppStaticString.send,
                        textColor: AppColors.blackLightColor,
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        );
      },
      title: AppStaticString.rating,
      textColor: AppColors.yellowColor,
    );
  }
}
