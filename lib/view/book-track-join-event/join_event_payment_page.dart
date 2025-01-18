import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking/book_track_join_event_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/model/track-event/single_event_model.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/home/widgets/event_card_widget.dart';
import 'package:track_trek/view/manage/widgets/blue_container_widget.dart';

class JoinEventPaymentScreen extends StatefulWidget {
  static const String routeName = '/event-payment';
  const JoinEventPaymentScreen({super.key});

  @override
  State<JoinEventPaymentScreen> createState() => _JoinEventPaymentScreenState();
}

class _JoinEventPaymentScreenState extends State<JoinEventPaymentScreen> {
  Map<String, dynamic> argument = {};
  String type = '';
  dynamic slot = '';

  String price = '';
  String unsold = '';
  String totalSeat = '';
  @override
  void initState() {
    argument = Get.arguments;
    type = argument['type'];
    slot = argument['slot'];
    BookTrackJoinEventController.to.eventData.value = argument['event']??SingleEventModel();
    price = slot is EventSlots ? slot.price.toString() : '\$0.0';
    unsold =slot is EventSlots
        ? ((slot.maxPeople ?? 0) - (slot.currentPeople ?? 0)).toString()
        : '0';
    totalSeat=slot is EventSlots ? slot.maxPeople.toString() : '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(tile: AppStaticString.joinEvent),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: padding16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: BlueContainerWidget(
                        child: Column(
                          children: [
                            Text(
                              AppStaticString.priceAmount,
                              style: poppinsRegular.copyWith(
                                  color: AppColors.blackLightColor,
                                  fontSize: getButtonFontSizeLarge(context)),
                            ),

                            ///=======================dynamic price=====================///
                            Text('\$$price',
                                style: poppinsMedium.copyWith(
                                    color: AppColors.blackLightColor,
                                    fontSize: getButtonFontSizeLarge(context)))
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        space8H,
                        BlueTextWidget(
                          text:
                              '${AppStaticString.allowedPeople} $totalSeat   ${AppStaticString.unsold} $unsold',
                          textAlign: TextAlign.start,
                        ),
                        space12H,
                        Obx(() {
                          return CustomDropdown<int>(
                            title: AppStaticString.selectPeople,
                            items: BookTrackJoinEventController.to.memberList,
                            selectedValue: BookTrackJoinEventController
                                .to.selectedValue.value,
                            onChanged: (value) {
                              BookTrackJoinEventController
                                  .to.selectedValue.value = value;
                              BookTrackJoinEventController.to
                                  .updateSubSelectedValue();
                            },
                          );
                        }),
                        space16H,
                        Obx(() {
                          return BookTrackJoinEventController.to.eventData.value!.moreInfo == null ||
                                  BookTrackJoinEventController.to.eventData.value!.moreInfo!.isEmpty
                              ? const SizedBox.shrink()
                              : Column(
                                  children: List.generate(
                                    BookTrackJoinEventController
                                            .to.selectedValue.value ??
                                        0,
                                    (index) {
                                      bool isSaved =
                                          BookTrackJoinEventController
                                              .to.savedIndices
                                              .contains(index);
                                      if (BookTrackJoinEventController
                                              .to.moreInfoControllers.length <=
                                          index) {
                                        BookTrackJoinEventController
                                            .to.moreInfoControllers
                                            .add(
                                          List.generate(
                                            BookTrackJoinEventController.to.eventData.value!.moreInfo!.length,
                                            (_) => TextEditingController(),
                                          ),
                                        );
                                      }
                                      final moreInfoControllersForPerson =
                                          BookTrackJoinEventController
                                              .to.moreInfoControllers[index];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 12.h,
                                        children: [
                                          Text(
                                            'People ${index + 1}:',
                                            style: poppinsMedium.copyWith(
                                                fontSize:
                                                    getFontSizeLarge(context)),
                                          ),
                                          Column(
                                            spacing: 12.h,
                                            children: List.generate(
                                              BookTrackJoinEventController.to.eventData.value!.moreInfo!.length,
                                              (indexOfMoreInfo) {
                                                final more = BookTrackJoinEventController.to.eventData.value!
                                                    .moreInfo![indexOfMoreInfo];

                                                return CustomTextField(
                                                  title: more.label,
                                                  textEditingController:
                                                      moreInfoControllersForPerson[
                                                          indexOfMoreInfo],
                                                );
                                              },
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Expanded(
                                                  child: SizedBox.shrink()),
                                              Expanded(
                                                  child: CustomButton(
                                                onTap: () {
                                                  if (!isSaved) {
                                                    BookTrackJoinEventController
                                                        .to.eventField
                                                        .add({
                                                      "bookingFor": index == 0
                                                          ? "self"
                                                          : 'other',
                                                      'moreInfo': List.generate(
                                                        BookTrackJoinEventController.to.eventData.value!
                                                            .moreInfo!.length,
                                                        (indexMoreData) {
                                                          final moreData =
                                                              BookTrackJoinEventController.to.eventData.value!
                                                                      .moreInfo![
                                                                  indexMoreData];
                                                          BookTrackJoinEventController
                                                              .to.savedIndices
                                                              .add(index);
                                                          return {
                                                            "label":
                                                                moreData.label,
                                                            "value":
                                                                moreInfoControllersForPerson[
                                                                        indexMoreData]
                                                                    .text
                                                          };
                                                        },
                                                      )
                                                    });
                                                    print(
                                                        '----------------event field list----------------');
                                                    print(
                                                        BookTrackJoinEventController
                                                            .to.eventField
                                                            .toString());
                                                  }
                                                },
                                                title: isSaved
                                                    ? AppStaticString.saved
                                                    : AppStaticString.save,
                                                fillColor: isSaved
                                                    ? AppColors.greyColor
                                                    : AppColors.blueColor,
                                                borderColor: isSaved
                                                    ? AppColors.greyColor
                                                    : AppColors.blueColor,
                                              )),
                                            ],
                                          ),
                                          space12H
                                        ],
                                      );
                                    },
                                  ),
                                );
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: padding16,
            child: Obx(() {
              return CustomButton(
                isLoading:
                    BookTrackJoinEventController.to.isLoadingBookTrack.value,
                onTap: () {
                  if (slot is EventSlots) {
                    BookTrackJoinEventController.to.joinEventSlotCall(
                        price: slot.price ?? 0,
                        eventId: BookTrackJoinEventController.to.eventData.value!.sId ?? '',
                        slotId: slot.sId ?? '');
                  }
                },
                title: AppStaticString.goPay,
              );
            }),
          )
        ],
      ),
    );
  }
}
