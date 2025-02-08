import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/booking/book_track_join_event_controller.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/common_controller.dart';
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
import 'package:track_trek/core/utils/helper_function.dart';
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
  String inputCurrency = '';
  String unsold = '';
  String totalSeat = '';
  @override
  void initState() {
    argument = Get.arguments;
    type = argument['type'];
    slot = argument['slot'];
    BookTrackJoinEventController.to.selectedCurrencyFrom.value=null;
    BookTrackJoinEventController
        .to.selectedValue.value =null;
    BookTrackJoinEventController
        .to.eventField.clear();
    BookTrackJoinEventController
        .to.savedIndices.clear();
    BookTrackJoinEventController.to.moreInfoControllers.clear();
/*    for (var controller in BookTrackJoinEventController.to.moreInfoControllers) {
      controller.clear();
    }*/
 /*   BookTrackJoinEventController
        .to.eventData.value.moreInfo!.clear();*/

    BookTrackJoinEventController.to.eventData.value =
        argument['event'] ?? SingleEventModel();
    price = slot is EventSlots ? slot.price.toString() : '0.0';
    inputCurrency = slot is EventSlots ? slot.currency : '';
    unsold = slot is EventSlots
        ? ((slot.maxPeople ?? 0) - (slot.currentPeople ?? 0)).toString()
        : '0';
    totalSeat = slot is EventSlots ? slot.maxPeople.toString() : '0';
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
                            Obx(() {
                             /* if (BookTrackJoinEventController
                                      .to.convertPrice.isNotEmpty &&
                                  BookTrackJoinEventController
                                          .to.selectedCurrencyFrom.value !=
                                      null) {
                                price = BookTrackJoinEventController
                                    .to.convertPrice.value;
                                currency = BookTrackJoinEventController
                                    .to.selectedCurrencyFrom.value
                                    .toString();
                              }*/
                              return BookTrackJoinEventController
                                      .to.isLoadingCurrencyConvert.value
                                  ? DefaultProgressIndicator()
                                  : Text('$inputCurrency $price',
                                      style: poppinsMedium.copyWith(
                                          color: AppColors.blackLightColor,
                                          fontSize:
                                              getButtonFontSizeLarge(context)));
                            })
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
                        // space12H,
                        // Obx(() {
                        //   return CustomDropdown<dynamic>(
                        //    /* isRequired: true,*/
                        //     title: AppStaticString.currency,
                        //     selectedValue: BookTrackJoinEventController
                        //         .to.selectedCurrencyFrom.value,
                        //     items: CommonController
                        //         .to.currencyList.keys
                        //         .map(
                        //           (e) => '$e',
                        //         )
                        //         .toList(),
                        //     isLoading: CommonController
                        //         .to.isLoadingCurrencies.value,
                        //     onChanged: (value) {
                        //       BookTrackJoinEventController
                        //           .to.selectedCurrencyFrom.value = value;
                        //       if (BookTrackJoinEventController
                        //                   .to.selectedCurrencyFrom.value !=
                        //               null &&
                        //           currency.isNotEmpty &&
                        //           price.isNotEmpty) {
                        //         BookTrackJoinEventController.to
                        //             .convertCurrencies(
                        //                 selectedCurrencyFrom: currency,
                        //                 selectedCurrencyTo:
                        //                     BookTrackJoinEventController
                        //                         .to.selectedCurrencyFrom.value
                        //                         .toString(),
                        //                 amount: price);
                        //       } else {
                        //         showCustomSnackbar(
                        //             title: AppStaticString.failed,
                        //             message: 'Cannot convert currency!!',
                        //             type: SnackBarType.failed);
                        //       }
                        //     },
                        //   );
                        // }),
                        space12H,
                        Obx(() {
                          return CustomDropdown<int>(
                            isRequired: true,
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
                          return BookTrackJoinEventController
                                          .to.eventData.value.moreInfo ==
                                      null ||
                                  BookTrackJoinEventController
                                      .to.eventData.value.moreInfo!.isEmpty
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
                                            BookTrackJoinEventController
                                                .to
                                                .eventData
                                                .value
                                                .moreInfo!
                                                .length,
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
                                              BookTrackJoinEventController
                                                  .to
                                                  .eventData
                                                  .value
                                                  .moreInfo!
                                                  .length,
                                              (indexOfMoreInfo) {
                                                final more =
                                                    BookTrackJoinEventController
                                                            .to
                                                            .eventData
                                                            .value
                                                            .moreInfo![
                                                        indexOfMoreInfo];

                                                return CustomTextField(
                                                  isRequired: true,
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
                                                  bool hasEmptyField = false;
print( BookTrackJoinEventController
    .to.savedIndices);
                                                  // Loop through controllers to check if any field is empty
                                                  for (int indexMoreData = 0;
                                                  indexMoreData < moreInfoControllersForPerson.length;
                                                  indexMoreData++) {
                                                    if (moreInfoControllersForPerson[indexMoreData].text.trim().isEmpty) {
                                                      hasEmptyField = true;
                                                      break; // Stop checking further if an empty field is found
                                                    }
                                                  }
                                                  if (!isSaved&&!hasEmptyField) {
                                                    BookTrackJoinEventController
                                                        .to.eventField
                                                        .add({
                                                      "bookingFor": index == 0
                                                          ? "self"
                                                          : 'other',
                                                      'moreInfo': List.generate(
                                                        BookTrackJoinEventController
                                                            .to
                                                            .eventData
                                                            .value
                                                            .moreInfo!
                                                            .length,
                                                        (indexMoreData) {
                                                          final moreData =
                                                              BookTrackJoinEventController
                                                                      .to
                                                                      .eventData
                                                                      .value
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
                                                  } else{
                                                    showCustomSnackbar(
                                                      title: AppStaticString.failed,
                                                      message: 'Fill up required fields',
                                                      type: SnackBarType.failed,
                                                    );                                                  }
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
                    final priceValue = double.parse(
                        price); // Fallback to 0 if price is null or invalid
                    final selectedValue =
                        BookTrackJoinEventController.to.selectedValue.value ??
                            1; // Fallback to 1 if null
                    final total = priceValue * selectedValue;
                  /*  bool hasEmptyField = false;
                    for (var element
                        in BookTrackJoinEventController.to.eventField) {
                      if (element is Map &&
                          element.containsKey('moreInfo') &&
                          element['moreInfo'] is List) {
                        for (var info in element['moreInfo']) {
                          if (info is Map &&
                              info.containsKey('value') &&
                              info['value'] != null &&
                              info['value'].toString().isNotEmpty) {
                            // Perform operation if value is not empty
                          } else {
                            hasEmptyField = true;
                            break;
                            // Perform operation if value is empty
                          }
                        }
                      }
                      if (hasEmptyField) break;
                    }*/

                    print(BookTrackJoinEventController
                        .to.savedIndices.length);
                    if ( BookTrackJoinEventController
                        .to
                        .eventData
                        .value
                        .moreInfo!=null &&  BookTrackJoinEventController
                        .to
                        .eventData
                        .value
                        .moreInfo!.isNotEmpty&& BookTrackJoinEventController
                        .to.savedIndices.length!=BookTrackJoinEventController
                        .to.selectedValue.value /*||
                        BookTrackJoinEventController
                                .to.selectedCurrencyFrom.value ==
                            null*/ ||  BookTrackJoinEventController
                                .to.selectedValue.value ==
                            null ||
                        inputCurrency.isEmpty ||
                        total == 0 ||
                        total.toString().isEmpty) {
                      showCustomSnackbar(
                        title: AppStaticString.failed,
                        message: 'Fill up required fields',
                        type: SnackBarType.failed,
                      );
                    } else {
                      // If no empty fields, proceed with API call
                      BookTrackJoinEventController.to.joinEventSlotCall(
                        currency: inputCurrency,
                        price: total,
                        eventId: BookTrackJoinEventController
                                .to.eventData.value.sId ??
                            '',
                        slotId: slot.sId ?? '',
                      );
                    }
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
