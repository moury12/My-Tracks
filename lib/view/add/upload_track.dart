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
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';
import 'package:track_trek/view/add/widgets/delete_alert_dialog.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

import 'widgets/show_custom_calender_widget.dart';

class UploadTrackScreen extends StatelessWidget {
  static String routeName = '/upload';
  const UploadTrackScreen({super.key});

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
                                constraints: BoxConstraints.tightForFinite(      height: MediaQuery.of(context).size.height / 2,
                                  width: MediaQuery.of(context).size.width, ),

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
                                            Text(AppStaticString.selectDay,style:poppinsMedium.copyWith(fontSize: getFontSizeDefault(context)) ,),
                                            const Spacer(),
                                            IconButton(onPressed: () {Navigator.of(context).pop();
                                            }, icon: const Icon(CupertinoIcons.multiply,color: AppColors.whiteLightColor,))
                                          ],
                                        ),
                                        Obx(
                                           () {
                                            return Wrap(
                                              spacing: 12.w ,
                                              children: [
                                                ...List.generate(
                                                  CreateTrackController
                                                      .to.weekDays.length,
                                                  (index) => CreateTrackController
                                                                  .to.weekDays[index]
                                                              ['selected'] ==
                                                          true
                                                      ? CustomButton(
                                                    radius: 20.r,
                                                    marginVerticel: 6.h,
                                                          width: 100.w,
                                                          title: CreateTrackController
                                                                  .to.weekDays[index]
                                                              ['day_name'],
                                                          onTap: () {
                                                            CreateTrackController
                                                                .to.toggleWeekDay(index);
                                                          },
                                                        )
                                                      : CreateTrackController
                                                              .to.weekDays[index].isEmpty
                                                          ? space16W
                                                          : CustomButton(
                                                    radius: 20.r,
                                                    marginVerticel: 6.h,
                                                              width: 100.w,
                                                              fillColor: AppColors
                                                                  .blackBackgroundColor,
                                                              borderColor:
                                                                  AppColors.primaryColor,
                                                              title: CreateTrackController
                                                                      .to.weekDays[index]
                                                                  ['day_name'],
                                                              textColor:
                                                                  AppColors.primaryColor,
                                                              onTap: () {
                                                                CreateTrackController
                                                                    .to.toggleWeekDay(index);
                                                              },
                                                            ),
                                                )
                                              ],
                                            );
                                          }
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        ///=============dynamic days==================///
                        const PrimaryColorContainer(
                          text: '15 Days',
                        ),
                        space16W
                      ],
                    ),

              ///======================Week Days==================///
              argument != null && argument == 'event'
                  ? const SizedBox.shrink()
                  : Obx(() {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 10.w,
                          children: [
                            ...List.generate(
                              CreateTrackController.to.weekDays.length,
                              (index) =>
                                  CreateTrackController.to.selectedDay.value ==
                                          index
                                      ? GradientContainerWidget(
                                          text: CreateTrackController
                                              .to.weekDays[index]['day_name'],
                                          textStyle: poppinsRegular.copyWith(
                                              color: AppColors.blackLightColor,
                                              fontSize:
                                                  getFontSizeDefault(context)),
                                        )
                                      : BlackContainerWidget(
                                          textStyle: poppinsRegular.copyWith(
                                              fontSize:
                                                  getFontSizeDefault(context)),
                                          onTap: () {
                                            CreateTrackController
                                                .to.selectedDay.value = index;
                                          },
                                          text: CreateTrackController
                                              .to.weekDays[index]['day_name'],
                                        ),
                            )
                          ],
                        ),
                      );
                    }),

              ///===================dynamic available slot===================//
              argument != null && argument == 'event'
                  ? const SizedBox.shrink()
                  : Text(
                      '${AppStaticString.availableSlot} 10',
                      style: poppinsMedium.copyWith(
                          fontSize: getFontSizeLarge(context)),
                    ),

              Row(
                spacing: 4.w,
                children: [
                  const Expanded(
                      child: CustomTextField(
                    title: '${AppStaticString.slotNo} 1',
                    hintText: '1',
                  )),
                  argument != null && argument == 'event'
                      ? const SizedBox.shrink()
                      : const Expanded(
                          child: CustomDropdown(
                          title: 'Start Time',
                        )),
                  argument != null && argument == 'event'
                      ? const SizedBox.shrink()
                      : const Expanded(
                          child: CustomDropdown(
                          title: 'End Time',
                        )),
                ],
              ),

              ///=====================input number of people=========================///

              CustomTextField(
                title: argument != null && argument == 'event'
                    ? AppStaticString.totalSeat
                    : AppStaticString.howManyPeopleCanTrack,
                hintText: AppStaticString.typeHere,
                textEditingController: CreateTrackController
                    .to.uploadTrackPeopleNumberController.value,
              ),

              ///=====================input price=========================///

              CustomTextField(
                title: AppStaticString.price,
                hintText: AppStaticString.typeHere,
                textEditingController:
                    CreateTrackController.to.uploadTrackPriceController.value,
              ),

              ///=====================input description=========================///
              CustomTextField(
                title: AppStaticString.description,
                hintText: AppStaticString.typeHere,
                textEditingController: CreateTrackController
                    .to.uploadTrackDescriptionController.value,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),

              ///==================save button================///
              const SaveSmallButtonWidget(),

              ///========================create slot button=========================///
              const CreateSlotButtonSmallWidget(),
              const MarronGradientContainerWidget(
                child: TrackSlotWidget(),
              ),
              argument != null && argument == 'event'
                  ? CustomButton(
                      onTap: () {
                        showDialog(context: context, builder: (context) => DeleteAlertDialog(
                          showButton: false,
                          title: Padding(
                            padding:  EdgeInsets.only(bottom: 8.h),
                            child: Image.asset(successIconUrl,height: 33.w,width: 33.w,),
                          ),
                           text:  AppStaticString.eventCreatedSuccessfully
                        ),
                        barrierDismissible: false
                        );
                      },
                      title: AppStaticString.publish,
                      fontSize: getFontSizeLarge(context),
                    )
                  : const SizedBox.shrink()
            ],
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
