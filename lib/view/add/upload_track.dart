import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/create_track_controller.dart';
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
import 'package:track_trek/view/add/widgets/delete_alert_dialog.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

import 'widgets/show_custom_calender_widget.dart';

class UploadTrackScreen extends StatelessWidget {
  static String routeName = '/upload';
  UploadTrackScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            key: formKey,
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
                                                  CreateTrackController
                                                      .to.weekDays.length,
                                                  (index) => CreateTrackController
                                                                  .to
                                                                  .weekDays[index]
                                                              ['selected'] ==
                                                          true
                                                      ? CustomButton(
                                                          radius: 20.r,
                                                          marginVerticel: 6.h,
                                                          width: 100.w,
                                                          title: CreateTrackController
                                                                  .to.weekDays[
                                                              index]['day_name'],
                                                          onTap: () {
                                                            CreateTrackController
                                                                .to
                                                                .toggleWeekDay(
                                                                    index);
                                                          },
                                                        )
                                                      : CreateTrackController
                                                              .to
                                                              .weekDays[index]
                                                              .isEmpty
                                                          ? space16W
                                                          : CustomButton(
                                                              radius: 20.r,
                                                              marginVerticel:
                                                                  6.h,
                                                              width: 100.w,
                                                              fillColor: AppColors
                                                                  .blackBackgroundColor,
                                                              borderColor: AppColors
                                                                  .primaryColor,
                                                              title: CreateTrackController
                                                                          .to
                                                                          .weekDays[
                                                                      index]
                                                                  ['day_name'],
                                                              textColor: AppColors
                                                                  .primaryColor,
                                                              onTap: () {
                                                                CreateTrackController
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
                                              isLoading: CreateTrackController
                                                  .to
                                                  .isLoadingUpdateTrack
                                                  .value,
                                              onTap: () {
                                                if (CreateTrackController
                                                    .to.weekDays.isNotEmpty) {
                                                  CreateTrackController.to
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
                                  '${CreateTrackController.to.days.value} Days',
                            );
                          }),
                          space16W
                        ],
                      ),

                ///======================Week Days==================///
                argument != null && argument == 'event'
                    ? const SizedBox.shrink()
                    : Obx(() {
                        return CreateTrackController.to.weekDays
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
                                        CreateTrackController.to.weekDays
                                            .where((e) => e['selected'] == true)
                                            .map((e) => e['day_name']
                                                as String) // Extract the 'day' field as a String
                                            .toList()
                                            .length, (index) {
                                      final day = CreateTrackController
                                          .to.weekDays
                                          .where((e) => e['selected'] == true)
                                          .map((e) => e['day_name']
                                              as String) // Extract the 'day' field as a String
                                          .toList()[index];
                                      return CreateTrackController
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
                                                CreateTrackController.to
                                                    .selectedDay.value = index;
                                                CreateTrackController
                                                    .to
                                                    .selectedWeekDay
                                                    .value = day.toString();
                                                print(CreateTrackController
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
                          CreateTrackController.to.slotNoController.value,
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
                                CreateTrackController.to.selectedStartTime
                                    .value = await selectAndFormatTime(
                                        context: context,
                                        initialTime: const TimeOfDay(
                                            hour: 10, minute: 0)) ??
                                    '';
                              },
                              child: CustomDropdown(
                                title: 'Start Time',
                                isRequired: true,
                                hintText: CreateTrackController
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
                                CreateTrackController.to.selectedEndTime.value =
                                    await selectAndFormatTime(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 10, minute: 0)) ??
                                        '';
                              },
                              child: CustomDropdown(
                                isRequired: true,
                                hintText: CreateTrackController
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
                  textEditingController: CreateTrackController
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
                  textEditingController:
                      CreateTrackController.to.uploadTrackPriceController.value,
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
                  textEditingController: CreateTrackController
                      .to.uploadTrackDescriptionController.value,
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
                  return CreateTrackController.to.isLoadingCreateSlot.value
                      ? const Align(
                          alignment: Alignment.topRight,
                          child: DefaultProgressIndicator(
                            color: AppColors.blueColor,
                          ),
                        )
                      : SaveSmallButtonWidget(
                          onTap: () {
                            if (formKey.currentState!.validate() &&
                                CreateTrackController
                                    .to.selectedStartTime.isNotEmpty &&
                                CreateTrackController
                                    .to.selectedEndTime.isNotEmpty) {
                              CreateTrackController.to.createSlotTrackCall();
                            } else {
                              showCustomSnackbar(
                                  title: AppStaticString.failed,
                                  message: AppStaticString.fieldRequired,
                                  type: SnackBarType.failed);
                            }
                          },
                        );
                }),

                ///========================create slot button=========================///
                CreateSlotButtonSmallWidget(
                  onTap: () {
                    CreateTrackController
                        .to.uploadTrackDescriptionController.value
                        .clear();
                    CreateTrackController.to.slotNoController.value.clear();
                    CreateTrackController.to.uploadTrackPriceController.value
                        .clear();
                    CreateTrackController
                        .to.uploadTrackPeopleNumberController.value
                        .clear();
                    CreateTrackController.to.selectedStartTime.value = '';
                    CreateTrackController.to.selectedEndTime.value = '';
                  },
                ),

                ///============================dynamic slot list ===========================///
                Obx(
                  () => CreateTrackController.to.singleTrack.value.slots != null
                      ? Column(
                          spacing: 12.h,
                          children: List.generate(
                            CreateTrackController
                                .to.singleTrack.value.slots!.length,
                            (index) {
                              return MarronGradientContainerWidget(
                                child: TrackSlotWidget(
                                  slots: CreateTrackController
                                      .to.singleTrack.value.slots![index],
                                  onDelete: () {
                                    CreateTrackController.to.deleteSlotCall(
                                        slotId: CreateTrackController
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
                argument != null && argument == 'event'
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
                    : const SizedBox.shrink()
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
  const SelectDateButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainerWidget(
      onTap: onTap ??
          () {
            showCustomCalenderWidget(context);
          },
      radius: 4.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              AppStaticString.selectDay,
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
