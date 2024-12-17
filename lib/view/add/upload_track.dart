import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/create_track_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/custom_space.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';
import 'package:track_trek/core/constant/image_constants.dart';
import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';


class UploadTrackScreen extends StatelessWidget {
  static String routeName = '/upload';
  const UploadTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        tile: AppStaticString.uploadTrack,
      ),
      body: Padding(
        padding: padding16,
        child: SingleChildScrollView(
          child: Column(
            spacing: 16.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 16.w,
                children: [
                  Expanded(
                    child: GradientContainerWidget(
                      onTap: () {},
                      radius: 4.r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStaticString.selectDay,
                            style: poppinsRegular.copyWith(
                                color: AppColors.blackLightColor,
                                fontSize: getFontSizeDefault(context)),
                          ),
                          space8W,
                          Image.asset(
                            calenderIconUrl,
                            height: 24.w,
                            width: 24.w,
                          )
                        ],
                      ),
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
              Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10.w,
                    children: [
                      ...List.generate(
                        CreateTrackController.to.weekDays.length,
                        (index) => CreateTrackController.to.selectedDay.value ==
                                index
                            ? GradientContainerWidget(
                                text: CreateTrackController.to.weekDays[index],
                                textStyle: poppinsRegular.copyWith(
                                    color: AppColors.blackLightColor,
                                    fontSize: getFontSizeDefault(context)),
                              )
                            : CreateTrackController.to.weekDays[index].isEmpty
                                ? space16W
                                : BlackContainerWidget(
                                    textStyle: poppinsRegular.copyWith(
                                        fontSize: getFontSizeDefault(context)),
                                    onTap: () {
                                      CreateTrackController
                                          .to.selectedDay.value = index;
                                    },
                                    text: CreateTrackController
                                        .to.weekDays[index],
                                  ),
                      )
                    ],
                  ),
                );
              }),

              ///===================dynamic available slot===================//
              Text(
                '${AppStaticString.availableSlot} 10',
                style:
                    poppinsMedium.copyWith(fontSize: getFontSizeLarge(context)),
              ),

              Row(
                spacing: 4.w,
                children: const [
                  Expanded(
                      child: CustomTextField(
                    title: '${AppStaticString.slotNo} 1',
                    hintText: '1',
                  )),
                  Expanded(
                      child: CustomDropdown(
                    title: 'Start Time',
                  )),
                  Expanded(
                      child: CustomDropdown(
                    title: 'End Time',
                  )),
                ],
              ),

              ///=====================input number of people=========================///

              CustomTextField(
                title: AppStaticString.howManyPeopleCanTrack,
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
              Align(
                alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: GradientContainerWidget(
                    radius: 4.r,
                    textStyle: poppinsRegular.copyWith(
                        color: AppColors.blackLightColor,
                        fontSize: getFontSizeSmall(context)),
                    text: AppStaticString.save,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                  ),
                ),
              ),

              ///========================create slot button=========================///
              Align(
                alignment: Alignment.centerRight,
                child: IntrinsicWidth(
                  child: GradientContainerWidget(
                    radius: 4.r,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStaticString.createSlot,
                          style: poppinsRegular.copyWith(
                              color: AppColors.blackLightColor,
                              fontSize: getFontSizeSmall(context)),
                        ),
                        space8W,
                        Image.asset(
                          plusIconUrl,
                          height: 14.w,
                          width: 14.w,
                          color: AppColors.blackLightColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
               const MarronGradientContainerWidget(
                child: TrackSlotWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

