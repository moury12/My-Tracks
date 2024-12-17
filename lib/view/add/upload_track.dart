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
import 'package:track_trek/view/add/widgets/track_slot_widget.dart';
import 'package:track_trek/view/home/widgets/gradient_container_widget.dart';
import 'package:track_trek/view/manage/widgets/event_manage_card_widget.dart';

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
            :  AppStaticString.uploadTrack,
      ),
      body: Padding(
        padding: padding16,
        child: SingleChildScrollView(
          child: Column(
            spacing: 16.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              argument != null && argument == 'event'
                  ? SizedBox.shrink()
                  :    Row(
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
              argument != null && argument == 'event'
                  ? SizedBox.shrink()
                  : Obx(() {
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
              argument != null && argument == 'event'
                  ? SizedBox.shrink()
                  :  Text(
                '${AppStaticString.availableSlot} 10',
                style:
                    poppinsMedium.copyWith(fontSize: getFontSizeLarge(context)),
              ),

              Row(
                spacing: 4.w,
                children:  [
                  Expanded(
                      child: CustomTextField(
                    title: '${AppStaticString.slotNo} 1',
                    hintText: '1',
                  )),
                  argument != null && argument == 'event'
                      ? SizedBox.shrink()
                      :  Expanded(
                      child: CustomDropdown(
                    title: 'Start Time',
                  )),
                  argument != null && argument == 'event'
                      ? SizedBox.shrink()
                      :  Expanded(
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
               MarronGradientContainerWidget(
                child: TrackSlotWidget(),
              ),
              argument != null && argument == 'event'
                  ?  CustomButton(onTap: () {

              },title: AppStaticString.publish,
                fontSize: getFontSizeLarge(context),
              ):SizedBox.shrink()

            ],
          ),
        ),
      ),
    );
  }
}
