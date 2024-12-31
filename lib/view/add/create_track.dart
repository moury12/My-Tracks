import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/create_event_controller.dart';
import 'package:track_trek/controller/create_track_controller.dart';
import 'package:track_trek/core/components/custom_appbar.dart';
import 'package:track_trek/core/components/custom_button.dart';
import 'package:track_trek/core/components/custom_drop_down_button.dart';
import 'package:track_trek/core/components/custom_textfield.dart';
import 'package:track_trek/core/constant/app_strings.dart';
import 'package:track_trek/core/constant/fontsize_constant.dart';

import 'package:track_trek/core/constant/padding_constant.dart';
import 'package:track_trek/core/utils/app_color.dart';
import 'package:track_trek/core/utils/helper_function.dart';
import 'package:track_trek/core/utils/text_style.dart';
import 'package:track_trek/view/add/upload_image_widget.dart';
import 'package:track_trek/view/add/upload_track.dart';
import 'package:track_trek/view/add/widgets/buttons.dart';

class CreateTrackScreen extends StatelessWidget {
  static const String routeName = '/create-track';
  const CreateTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? argument = Get.arguments;
    return Scaffold(
      appBar: CustomAppbar(
        tile: argument != null && argument == 'event'
            ? AppStaticString.createEvent
            : AppStaticString.createTrack,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              CustomTextField(
                textEditingController: argument != null && argument == 'event'
                    ? CreateEventController.to.eventNameController.value
                    : CreateTrackController.to.trackNameController.value,
                title: argument != null && argument == 'event'
                    ? AppStaticString.eventName
                    : AppStaticString.trackName,
                hintText: AppStaticString.typeHere,
              ),
              argument != null && argument == 'event'
                  ? CustomTextField(
                      textEditingController: CreateEventController
                          .to.eventStartDateController.value,
                      title: AppStaticString.startDate,
                      hintText: AppStaticString.typeHere,
                    )
                  : const CustomDropdown(
                      title: AppStaticString.selectCategory,
                    ),
              const CustomDropdown(
                title: AppStaticString.startTime,
              ),
              argument != null && argument == 'event'
                  ? CustomTextField(
                      textEditingController:
                          CreateEventController.to.eventEndDateController.value,
                      title: AppStaticString.endDate,
                      hintText: AppStaticString.typeHere,
                    )
                  : const SizedBox.shrink(),
              const CustomDropdown(
                title: AppStaticString.endTime,
              ),

              ///===============================upload images================================///
              Obx(() {
                return UploadImageWidget(
                    function: () {
                      pickImages(
                          allowMultiple: true,
                          uploadImages:
                              CreateEventController.to.trackPhotosList);
                    },
                    images: CreateEventController.to.trackPhotosList.isNotEmpty
                        ? Wrap(
                            children: [
                              ...List.generate(
                                CreateEventController.to.trackPhotosList.length,
                                (index) => Stack(
                                  children: [
                                    Padding(
                                      padding: padding12,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: Image.file(
                                          File(CreateEventController
                                              .to.trackPhotosList[index]),
                                          height: 70.w,
                                          width: 70.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -5.w,
                                      top: -5.h,
                                      child: IconButton(
                                          onPressed: () {
                                            removeImage(
                                                uploadImages:
                                                    CreateEventController
                                                        .to.trackPhotosList,
                                                imagePath: CreateEventController
                                                    .to.trackPhotosList[index]);
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.multiply_circle_fill,
                                            color: AppColors.primaryColor,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              CreateEventController.to.trackPhotosList.length <
                                      5
                                  ? Padding(
                                    padding: padding8,
                                    child: UploadImageIconTextWidget(
                                        function: () {
                                          pickImages(
                                              allowMultiple: true,
                                              uploadImages: CreateEventController
                                                  .to.trackPhotosList);
                                        },
                                      ),
                                  )
                                  : const SizedBox.shrink()
                            ],
                          )
                        : null);
              }),
              CustomTextField(
                textEditingController: argument != null && argument == 'event'
                    ? CreateEventController.to.eventLocationController.value
                    : CreateTrackController.to.trackLocationController.value,
                title: AppStaticString.location,
                hintText: AppStaticString.typeHere,
              ),
              CustomTextField(
                textEditingController: argument != null && argument == 'event'
                    ? CreateEventController.to.eventDescriptionController.value
                    : CreateTrackController.to.trackDescriptionController.value,
                title: AppStaticString.description,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                hintText: AppStaticString.typeHere,
              ),
              argument != null && argument == 'event'
                  ? const SizedBox(
                      width: double.infinity, child: BlackContainerWithBroder())
                  : const SizedBox.shrink(),
              argument != null && argument == 'event'
                  ? const Row(
                      children: [
                        Spacer(),
                        AddButtonInContainer(),
                      ],
                    )
                  : const SizedBox.shrink(),
              CreateEventController.to.eventNameControllerList.isNotEmpty
                  ? Obx(() {
                      return Column(
                        children: List.generate(
                          CreateEventController
                              .to.eventNameControllerList.length,
                          (index) => CustomTextField(
                            title: CreateEventController
                                .to.eventNameControllerList[index],
                          ),
                        ),
                      );
                    })
                  : const SizedBox.shrink(),
              CustomButton(
                onTap: () {
                  Get.toNamed(UploadTrackScreen.routeName, arguments: argument);
                },
                title: AppStaticString.next,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BlackContainerWithBroder extends StatelessWidget {
  final String? text;
  const BlackContainerWithBroder({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding12V,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(width: 1, color: AppColors.textFieldColor)),
        child: Text(
          text ?? AppStaticString.customerInfo,
          style: poppinsRegular.copyWith(
              color: AppColors.normalDarkWhite,
              fontSize: getFontSizeDefault(context)),
        ));
  }
}
