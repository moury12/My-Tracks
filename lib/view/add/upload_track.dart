import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';



class UploadTrackScreen extends StatelessWidget {
  static String routeName = '/upload';
  UploadTrackScreen({super.key});


  @override
  Widget build(BuildContext context) {
    String? argument = Get.arguments;
    return Scaffold(
      appBar: CustomAppbar(
        tile: argument != null && argument == 'event'
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
                argument != null && argument == 'event'
                    ? const SizedBox.shrink()
                    : Row(
                        spacing: 16.w,
                        children: [
                          Expanded(
                            child: SelectDateButton(
                              onTap: () {
                                showModalBottomSheet(
                                  showDragHandle: false,
                                  context: context,
                                  constraints: BoxConstraints.tightForFinite(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  builder: (context) => Container(
                                    padding: padding16,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(8.r))),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                AppStaticString.selectDay,
                                                style: poppinsMedium.copyWith(
                                                    fontSize:
                                                        getFontSizeDefault(
                                                            context)),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: const Icon(
                                                    CupertinoIcons.multiply,
                                                    color: AppColors
                                                        .whiteLightColor,
                                                  ))
                                            ],
                                          ),
                                          Obx(() {
                                            return Wrap(
                                              spacing: 12.w,
                                              children: [
                                                ...List.generate(
                                                  CreateTrackEventController
                                                      .to.weekDays.length,
                                                  (index) =>
                                                      CreateTrackEventController
                                                                          .to
                                                                          .weekDays[
                                                                      index][
                                                                  'selected'] ==
                                                              true
                                                          ? CustomButton(
                                                              radius: 20.r,
                                                              marginVerticel:
                                                                  6.h,
                                                              width: 100.w,
                                                              title: CreateTrackEventController
                                                                          .to
                                                                          .weekDays[
                                                                      index]
                                                                  ['day_name'],
                                                              onTap: () {
                                                                CreateTrackEventController
                                                                    .to
                                                                    .toggleWeekDay(
                                                                        index);
                                                              },
                                                            )
                                                          : CreateTrackEventController
                                                                  .to
                                                                  .weekDays[
                                                                      index]
                                                                  .isEmpty
                                                              ? space16W
                                                              : CustomButton(
                                                                  radius: 20.r,
                                                                  marginVerticel:
                                                                      6.h,
                                                                  width: 100.w,
                                                                  fillColor:
                                                                      AppColors
                                                                          .blackBackgroundColor,
                                                                  borderColor:
                                                                      AppColors
                                                                          .primaryColor,
                                                                  title: CreateTrackEventController
                                                                              .to
                                                                              .weekDays[
                                                                          index]
                                                                      [
                                                                      'day_name'],
                                                                  textColor:
                                                                      AppColors
                                                                          .primaryColor,
                                                                  onTap: () {
                                                                    CreateTrackEventController
                                                                        .to
                                                                        .toggleWeekDay(
                                                                            index);
                                                                  },
                                                                ),
                                                )
                                              ],
                                            );
                                          }),
                                          space12H,
                                          Obx(() {
                                            return CustomButton(
                                              isLoading:
                                                  CreateTrackEventController
                                                      .to
                                                      .isLoadingUpdateTrack
                                                      .value,
                                              onTap: () {
                                                if (CreateTrackEventController
                                                    .to.weekDays.isNotEmpty) {
                                                  CreateTrackEventController.to
                                                      .updateTrackCall();
                                                } else {
                                                  showCustomSnackbar(
                                                      title: AppStaticString
                                                          .failed,
                                                      message:
                                                          'Please select a day',
                                                      type:
                                                          SnackBarType.failed);
                                                }
                                              },
                                              title: AppStaticString.save,
                                            );
                                          })
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          ///=============dynamic days==================///
                          Obx(() {
                            return PrimaryColorContainer(
                              text:
                                  '${CreateTrackEventController.to.days.value} Days',
                            );
                          }),
                          space16W
                        ],
                      ),

                ///======================Week Days==================///
                argument != null && argument == 'event'
                    ? const SizedBox.shrink()
                    : Obx(() {
                        return CreateTrackEventController.to.weekDays
                                .where((e) => e['selected'] == true)
                                .map((e) => e['day_name']
                                    as String) // Extract the 'day' field as a String
                                .toList()
                                .isEmpty
                            ? const SizedBox.shrink()
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  spacing: 10.w,
                                  children: [
                                    ...List.generate(
                                        CreateTrackEventController.to.weekDays
                                            .where((e) => e['selected'] == true)
                                            .map((e) => e['day_name']
                                                as String) // Extract the 'day' field as a String
                                            .toList()
                                            .length, (index) {
                                      final day = CreateTrackEventController
                                          .to.weekDays
                                          .where((e) => e['selected'] == true)
                                          .map((e) => e['day_name']
                                              as String) // Extract the 'day' field as a String
                                          .toList()[index];
                                      return CreateTrackEventController
                                                  .to.selectedDay.value ==
                                              index
                                          ? GradientContainerWidget(
                                              text: day,
                                              textStyle:
                                                  poppinsRegular.copyWith(
                                                      color: AppColors
                                                          .blackLightColor,
                                                      fontSize:
                                                          getFontSizeDefault(
                                                              context)),
                                            )
                                          : BlackContainerWidget(
                                              textStyle:
                                                  poppinsRegular.copyWith(
                                                      fontSize:
                                                          getFontSizeDefault(
                                                              context)),
                                              onTap: () {
                                                CreateTrackEventController.to
                                                    .selectedDay.value = index;
                                                CreateTrackEventController
                                                    .to
                                                    .selectedWeekDay
                                                    .value = day.toString();
                                                print(CreateTrackEventController
                                                    .to.selectedWeekDay.value);
                                              },
                                              text: day,
                                            );
                                    })
                                  ],
                                ),
                              );
                      }),

                /* ///===================dynamic available slot===================//
                argument != null && argument == 'event'
                    ? const SizedBox.shrink()
                    : Text(
                        '${AppStaticString.availableSlot} 10',
                        style: poppinsMedium.copyWith(
                            fontSize: getFontSizeLarge(context)),
                      ),*/

                Row(
                  spacing: 4.w,
                  children: [
                    Expanded(
                        child: CustomTextField(
                      isRequired: true,
                      title: AppStaticString.slotNo,
                      textEditingController:
                          argument != null && argument == 'event'
                              ? CreateTrackEventController
                                  .to.slotNoControllerForEvent.value
                              : CreateTrackEventController
                                  .to.slotNoController.value,
                          focusNode:argument != null && argument == 'event'?CreateTrackEventController.to.slotNoFocusNodeForEvent: CreateTrackEventController.to.slotNoFocusNodeForTrack ,

                          validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStaticString.slotNoRequired;
                        }
                        return null;
                      },
                    )),
                    argument != null && argument == 'event'
                        ? const SizedBox.shrink()
                        : Obx(() {
                            return Expanded(
                                child: InkWell(
                              onTap: () async {
                                CreateTrackEventController.to.selectedStartTime
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
                    argument != null && argument == 'event'
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
                  title: argument != null && argument == 'event'
                      ? AppStaticString.totalSeat
                      : AppStaticString.howManyPeopleCanTrack,
                  hintText: AppStaticString.typeHere,
                  keyboardType: TextInputType.number,
                  focusNode:argument != null && argument == 'event'?CreateTrackEventController.to.uploadEventTotalSeatFocusNode: CreateTrackEventController.to.uploadTrackPeopleNumberFocusNode ,
                  textEditingController: argument != null && argument == 'event'
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
                  textEditingController: argument != null && argument == 'event'
                      ? CreateTrackEventController
                          .to.uploadEventPriceController.value
                      : CreateTrackEventController
                          .to.uploadTrackPriceController.value,
                  focusNode:argument != null && argument == 'event'?CreateTrackEventController.to.uploadEventPriceFocusNode: CreateTrackEventController.to.uploadTrackPriceFocusNode ,

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
                  textEditingController: argument != null && argument == 'event'
                      ? CreateTrackEventController
                          .to.uploadEventDescriptionController.value
                      : CreateTrackEventController
                          .to.uploadTrackDescriptionController.value,
                  focusNode:argument != null && argument == 'event'?CreateTrackEventController.to.uploadEventDescriptionFocusNode
                      : CreateTrackEventController.to.uploadTrackDescriptionFocusNode ,

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
                  return CreateTrackEventController.to.isLoadingCreateSlot.value
                      ? const Align(
                          alignment: Alignment.topRight,
                          child: DefaultProgressIndicator(
                            color: AppColors.blueColor,
                          ),
                        )
                      : SaveSmallButtonWidget(
                          onTap: () {
                            if (argument != null && argument == 'event') {
                              CreateTrackEventController.to
                                  .createSlotEventCall();
                            } else {
                              if (CreateTrackEventController.to.formKey.currentState!.validate() &&
                                  CreateTrackEventController
                                      .to.selectedStartTime.isNotEmpty &&
                                  CreateTrackEventController
                                      .to.selectedEndTime.isNotEmpty) {
                                CreateTrackEventController.to
                                    .createSlotTrackCall();
                              } else {
                                showCustomSnackbar(
                                    title: AppStaticString.failed,
                                    message: AppStaticString.fieldRequired,
                                    type: SnackBarType.failed);
                              }
                            }
                          },
                        );
                }),

                ///========================create slot button=========================///
                /* CreateSlotButtonSmallWidget(
                  onTap: () {
                    if (argument != null && argument == 'event') {
                      CreateTrackEventController
                          .to.slotNoControllerForEvent.value
                          .clear();
                      CreateTrackEventController
                          .to.uploadEventTotalSeatController.value
                          .clear();
                      CreateTrackEventController
                          .to.uploadEventPriceController.value
                          .clear();
                      CreateTrackEventController
                          .to.uploadEventDescriptionController.value
                          .clear();
                    } else {
                      CreateTrackEventController
                          .to.uploadTrackDescriptionController.value
                          .clear();
                      CreateTrackEventController.to.slotNoController.value
                          .clear();
                      CreateTrackEventController
                          .to.uploadTrackPriceController.value
                          .clear();
                      CreateTrackEventController
                          .to.uploadTrackPeopleNumberController.value
                          .clear();
                      CreateTrackEventController.to.selectedStartTime.value =
                          '';
                      CreateTrackEventController.to.selectedEndTime.value = '';
                    }
                  },
                ),*/

                ///============================dynamic slot list ===========================///
                argument != null && argument == 'event'
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
                                      child: TrackSlotWidget(
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
                                                          '',isEvent: true);
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
                                      child: TrackSlotWidget(
                                        slots: CreateTrackEventController
                                            .to.singleTrack.value.slots![index],
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

                /* : SizedBox.shrink(),*/
                /*             argument != null && argument == 'event'
                    ? CustomButton(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => DeleteAlertDialog(
                                  showButton: false,
                                  title: Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: Image.asset(
                                      successIconUrl,
                                      height: 33.w,
                                      width: 33.w,
                                    ),
                                  ),
                                  text:
                                      AppStaticString.eventCreatedSuccessfully),
                              barrierDismissible: false);
                        },
                        title: AppStaticString.publish,
                        fontSize: getFontSizeLarge(context),
                      )
                    : const SizedBox.shrink()*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectDateButton extends StatelessWidget {
  final Function()? onTap;
  final String? date;
  String? selectedDay;
   SelectDateButton({
    super.key,
    this.onTap, this.selectedDay, this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainerWidget(
      onTap: onTap ??
          () {
        selectedDay =selectDate(context).toString();
           ///==========Select date
          },
      radius: 4.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
             date?? AppStaticString.selectDay,
              style: poppinsRegular.copyWith(
                  color: AppColors.blackLightColor,
                  fontSize: getFontSizeDefault(context)),
            ),
          ),
          space8W,
          Image.asset(
            calenderIconUrl,
            height: 24.w,
            width: 24.w,
          )
        ],
      ),
    );
  }
}
