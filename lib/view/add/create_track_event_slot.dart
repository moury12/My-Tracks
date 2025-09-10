import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:track_trek/controller/create_track_event_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/global/string_variable.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';
import 'package:track_trek/view/add/widgets/track_event_slot_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/initial/bottom_navigation_screen.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

import 'widgets/select_date_button.dart';

class CreateTrackEventSlotScreen extends StatefulWidget {
  static String routeName = '/create-slot';
  const CreateTrackEventSlotScreen({super.key});

  @override
  State<CreateTrackEventSlotScreen> createState() =>
      _CreateTrackEventSlotScreenState();
}

class _CreateTrackEventSlotScreenState
    extends State<CreateTrackEventSlotScreen> {
  String? type;
  String? id;
  bool edit = false;
  @override
  void initState() {
    type = Get.arguments['type'] as String;
    id = Get.arguments['id'] as String;
    edit = Get.arguments['edit'] ?? false;
    print(CreateTrackEventController.to.weekDays.toString());
    if (type == event) {
      CreateTrackEventController.to.eventId.value = id ?? '';
    } else {
      CreateTrackEventController.to.trackId.value = id ?? '';
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Map<String,dynamic> argument = Get.arguments;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        CreateTrackEventController.to.selectedCurrencyFrom.value = null;
      },
      child: Scaffold(
        appBar: CustomAppbar(
          tile: type == event
              ? AppStaticString.createEvent
              : AppStaticString.uploadTrack,
        ),
        body: Padding(
          padding: padding16,
          child: SingleChildScrollView(
            child: Form(
              key: CreateTrackEventController.to.formKey,
              child: Column(
                spacing: 16.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  type == event
                      ? const SizedBox.shrink()
                      : CustomButton(
                          // isLoading: StripeOnboardingController.to.isLoading.value,
                          title: AppStaticString.selectDate,
                          img: calenderIconUrl,
                          fillColor: AppColors.blueColor,
                          borderColor: AppColors.blueColor,
                          onTap: () {
                            showCalendarDialog(

                              context,
                              onDateSelected: (List<DateTime> val) {
                                CreateTrackEventController
                                    .to.selectedDates.value = val;
                              },
                                preSelectedDates:CreateTrackEventController
                                    .to.selectedDates
                            );
                          },
                        ),

                  ///======================Week Days==================///
                  type == event
                      ? const SizedBox.shrink()
                      : Obx(() {
                          return CreateTrackEventController.to.selectedDates
                                  .isEmpty
                              ? const SizedBox.shrink()
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    spacing: 10.w,
                                    children: [
                                      ...List.generate(
                                          CreateTrackEventController.to.selectedDates.length, (index) {
                                        String day = DateFormat('MM/dd/yyyy').
                                        format(CreateTrackEventController.to.selectedDates[index]);

                                       return GradientContainerWidget(
                                                text: day,
                                                textStyle:
                                                    poppinsRegular.copyWith(
                                                        color: AppColors
                                                            .blackLightColor,
                                                        fontSize:
                                                            getFontSizeDefault(
                                                                context)),
                                              );
                                      })
                                    ],
                                  ),
                                );
                        }),

                  /* ///===================dynamic available slot===================//
                  argument != null && type==event
                      ? const SizedBox.shrink()
                      : Text(
                          '${AppStaticString.availableSlot} 10',
                          style: poppinsMedium.copyWith(
                              fontSize: getFontSizeLarge(context)),
                        ),*/
                  Obx(() {
                    return CustomDropdown<dynamic>(
                      isRequired: true,
                      title: AppStaticString.currency,
                      selectedValue: CreateTrackEventController
                          .to.selectedCurrencyFrom.value,
                      items: CreateTrackEventController.to.currencyList.entries
                          .map(
                            (e) => '${e.key} - ${e.value}',
                          )
                          .toList(),
                      isLoading: CreateTrackEventController
                          .to.isLoadingCurrencies.value,
                      onChanged: (value) {
                        print(value.toString().split(' ').first);
                        CreateTrackEventController.to.selectedCurrencyFrom
                            .value = value.toString().split(' ').first;
                      },
                    );
                  }),
                  Row(
                    spacing: 4.w,
                    children: [
                      Expanded(
                          child: CustomTextField(
                        isRequired: true,
                        title: AppStaticString.slotNo,
                        textEditingController: type == event
                            ? CreateTrackEventController
                                .to.slotNoControllerForEvent.value
                            : CreateTrackEventController
                                .to.slotNoController.value,
                        focusNode: type == event
                            ? CreateTrackEventController
                                .to.slotNoFocusNodeForEvent
                            : CreateTrackEventController
                                .to.slotNoFocusNodeForTrack,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStaticString.slotNoRequired;
                          }
                          return null;
                        },
                      )),
                      type == event
                          ? const SizedBox.shrink()
                          : Obx(() {
                              return Expanded(
                                  child: InkWell(
                                onTap: () async {
                                  CreateTrackEventController
                                      .to
                                      .selectedStartTime
                                      .value = await selectAndFormatTime(
                                          context: context,
                                          initialTime: const TimeOfDay(
                                              hour: 10, minute: 0)) ??
                                      '';
                                },
                                child: CustomDropdown(
                                  title: 'Start Time',
                                  isRequired: true,
                                  hintText: CreateTrackEventController
                                      .to.selectedStartTime.value,
                                ),
                              ));
                            }),
                      type == event
                          ? const SizedBox.shrink()
                          : Obx(() {
                              return Expanded(
                                  child: InkWell(
                                onTap: () async {
                                  CreateTrackEventController.to.selectedEndTime
                                      .value = await selectAndFormatTime(
                                          context: context,
                                          initialTime: const TimeOfDay(
                                              hour: 10, minute: 0)) ??
                                      '';
                                },
                                child: CustomDropdown(
                                  isRequired: true,
                                  hintText: CreateTrackEventController
                                      .to.selectedEndTime.value,
                                  title: 'End Time',
                                ),
                              ));
                            }),
                    ],
                  ),

                  ///=====================input number of people=========================///

                  CustomTextField(
                    isRequired: true,
                    title: type == event
                        ? AppStaticString.totalSeat
                        : AppStaticString.howManyPeopleCanTrack,
                    hintText: AppStaticString.typeHere,
                    keyboardType: TextInputType.number,
                    focusNode: type == event
                        ? CreateTrackEventController
                            .to.uploadEventTotalSeatFocusNode
                        : CreateTrackEventController
                            .to.uploadTrackPeopleNumberFocusNode,
                    textEditingController: type == event
                        ? CreateTrackEventController
                            .to.uploadEventTotalSeatController.value
                        : CreateTrackEventController
                            .to.uploadTrackPeopleNumberController.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStaticString.fieldRequired;
                      }
                      return null;
                    },
                  ),

                  ///=====================input price=========================///

                  CustomTextField(
                    isRequired: true,
                    title: AppStaticString.price,
                    keyboardType: TextInputType.number,
                    hintText: AppStaticString.typeHere,
                    textEditingController: type == event
                        ? CreateTrackEventController
                            .to.uploadEventPriceController.value
                        : CreateTrackEventController
                            .to.uploadTrackPriceController.value,
                    focusNode: type == event
                        ? CreateTrackEventController
                            .to.uploadEventPriceFocusNode
                        : CreateTrackEventController
                            .to.uploadTrackPriceFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStaticString.fieldRequired;
                      }
                      return null;
                    },
                  ),

                  ///=====================input description=========================///
                  CustomTextField(
                    isRequired: true,
                    title: AppStaticString.description,
                    hintText: AppStaticString.typeHere,
                    textEditingController: type == event
                        ? CreateTrackEventController
                            .to.uploadEventDescriptionController.value
                        : CreateTrackEventController
                            .to.uploadTrackDescriptionController.value,
                    focusNode: type == event
                        ? CreateTrackEventController
                            .to.uploadEventDescriptionFocusNode
                        : CreateTrackEventController
                            .to.uploadTrackDescriptionFocusNode,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStaticString.fieldRequired;
                      }
                      return null;
                    },
                  ),

                  ///==================save button================///
                  Obx(() {
                    return CreateTrackEventController
                            .to.isLoadingCreateSlot.value
                        ? const Align(
                            alignment: Alignment.topRight,
                            child: DefaultProgressIndicator(
                              color: AppColors.blueColor,
                            ),
                          )
                        : SaveSmallButtonWidget(
                            onTap: () {
                              if (type == event) {
                                if (CreateTrackEventController
                                    .to.formKey.currentState!
                                    .validate()) {
                                  CreateTrackEventController.to
                                      .createSlotEventCall();
                                }
                              } else {
                                if (CreateTrackEventController
                                        .to.formKey.currentState!
                                        .validate() &&
                                    CreateTrackEventController
                                        .to.selectedStartTime.isNotEmpty &&
                                    CreateTrackEventController
                                        .to.selectedEndTime.isNotEmpty) {
                                  CreateTrackEventController.to
                                      .createSlotTrackCall();
                                } else {
                                  print(CreateTrackEventController
                                      .to.selectedCurrencyFrom.value);
                                  showCustomSnackbar(
                                      title: AppStaticString.failed,
                                      message: AppStaticString.fieldRequired,
                                      type: SnackBarType.failed);
                                }
                              }
                            },
                          );
                  }),

                  CustomButton(
                    onTap: () {
                      Get.offAllNamed(BottomNavigationScreen.routeName);
                    },
                    title: AppStaticString.confrim,
                  ),

                  ///============================dynamic slot list ===========================///
                  type == event
                      ? Obx(
                          () => CreateTrackEventController
                                      .to.singleEvent.value.slots !=
                                  null
                              ? Column(
                                  spacing: 12.h,
                                  children: List.generate(
                                    CreateTrackEventController
                                        .to.singleEvent.value.slots!.length,
                                    (index) {
                                      final slot = CreateTrackEventController
                                          .to.singleEvent.value.slots![index];

                                      return MarronGradientContainerWidget(
                                        child: TrackEventSlotWidget(
                                          needToShowSeat: true,
                                          eventSlots: slot,
                                          onDelete: () {
                                            CreateTrackEventController.to
                                                .deleteSlotCall(
                                                    slotId:
                                                        CreateTrackEventController
                                                                .to
                                                                .singleEvent
                                                                .value
                                                                .slots![index]
                                                                .sId ??
                                                            '',
                                                    isEvent: true);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                        )
                      : Obx(
                          () => CreateTrackEventController
                                      .to.singleTrack.value.slots !=
                                  null
                              ? Column(
                                  spacing: 12.h,
                                  children: List.generate(
                                    CreateTrackEventController
                                        .to.singleTrack.value.slots!.length,
                                    (index) {
                                      return MarronGradientContainerWidget(
                                        child: TrackEventSlotWidget(
                                          slots: CreateTrackEventController.to
                                              .singleTrack.value.slots![index],
                                          onDelete: () {
                                            CreateTrackEventController.to
                                                .deleteSlotCall(
                                                    slotId:
                                                        CreateTrackEventController
                                                                .to
                                                                .singleTrack
                                                                .value
                                                                .slots![index]
                                                                .sId ??
                                                            '');
                                            Navigator.pop(context);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
